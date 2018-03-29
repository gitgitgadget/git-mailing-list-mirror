Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B0791F404
	for <e@80x24.org>; Thu, 29 Mar 2018 20:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbeC2UyK (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 16:54:10 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:41404 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeC2UyI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 16:54:08 -0400
Received: by mail-wr0-f169.google.com with SMTP id f14so6498958wre.8
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 13:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xg408C3FjDjjn0bGFOdZhBfGJGiQb21jKioQ4pzRXuM=;
        b=pznqdkU27OcfhjJEAm7ZMRQBGSMiwHCMbxbHJDOrtz2BNqVadFNAgSUn1n/YR5pvjQ
         ihbqDNQBVwW5KG3w5b8FGyLF+uN1f6yCbDT71p1OYQY54/iYQTtCXaB8pZH3iJjUJhTq
         6i6SYpiiUOmuRY/zSaxCG6Rsvm8dxoE/5sQJXFWV9ElEg8v0i0+fwKdo7WDEAFkkHwDJ
         u4aAU74AanHXAE3tGRuKFCMHCrZxTw1mjPnCeQQDgjlNEwr2aqg9q88S+EJA7bQYMvVY
         2qVs5kHSe2I3ZV5e/hCSSMUz0ocCNohHpYRAkwAMtJTKuTwJMKuQ+LFnFUtqol7H3jw3
         Um/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xg408C3FjDjjn0bGFOdZhBfGJGiQb21jKioQ4pzRXuM=;
        b=cG3uh64fz1kzGYn2xwLZc05uzkbBmOKaqBYqII9k4GCNp2hKq+M9jM/zk+AgZXdsBV
         sHg1RT8eaIaJiSy/Rq7rft2io2cpzLnnPDytiGhoL68oYtaNLVDMdo2rMLvzi0unf9+F
         9wvzVOFTXHnwfuSfCPBdFB7jvAyV35lKle524g8XrcV2SZPSp0iyb+zQh1L3hbV31mep
         5C5eZUR+a63xg/fUQdu/umYAGjY+QF8RZ0QWfAXYH1Qh3HphFW7Go2DDv4wsBxghFU0U
         K0tt9pUVzBXX32Tomd/V6JBehedAe4gEFa6DFOrJJU5q2sACnUkBOdSQyUCgGzl5vp21
         /i5g==
X-Gm-Message-State: AElRT7FUumTHKkcbKy4hJ154ey4QZWAfIiDeD7x+GnP/Q82BtiniqG0E
        K3fHGP6pzroXKLfOQ9l04X55NAx7LDn0nEo8/TA=
X-Google-Smtp-Source: AIpwx48pyKjOttMJLbZMZF6znDTr/rmTPS1tL5Sj5YFXih/7DXkWgOdTeuyXE3ZdvggfFxfP8iEwh5dLbeZy5WViy3U=
X-Received: by 10.223.220.78 with SMTP id m14mr8164709wrj.174.1522356847041;
 Thu, 29 Mar 2018 13:54:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.208.210 with HTTP; Thu, 29 Mar 2018 13:54:06 -0700 (PDT)
In-Reply-To: <CAK0XTWd7QGtVDwm8FDXejZfbgVH6-1NprGY0xxAnC33QH8aCCQ@mail.gmail.com>
References: <1520366804-28233-1-git-send-email-eddy.petrisor@gmail.com>
 <CAGZ79kb4Ea7t5j9XA0key1f99w5xRDwyRhMder1FMgdiZot3Tg@mail.gmail.com> <CAK0XTWd7QGtVDwm8FDXejZfbgVH6-1NprGY0xxAnC33QH8aCCQ@mail.gmail.com>
From:   =?UTF-8?Q?Eddy_Petri=C8=99or?= <eddy.petrisor@gmail.com>
Date:   Thu, 29 Mar 2018 23:54:06 +0300
Message-ID: <CAK0XTWdxsUwWB7932yqo8+4PQqtEVJ8W_R9b3RK1oLVA6ZWkOg@mail.gmail.com>
Subject: Fwd: [RFC PATCH] git-submodule.sh:cmd_update: if submodule branch
 exists, fetch that instead of default
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

mar., 27 mar. 2018, 02:07 Stefan Beller <sbeller@google.com> a scris:
>
> [snipped the cc list as well]
>
> On Tue, Mar 6, 2018 at 12:06 PM Eddy Petri=C8=99or <eddy.petrisor@gmail.c=
om>
> wrote:
>
> > Signed-off-by: Eddy Petri=C8=99or <eddy.petrisor@gmail.com>
> > ---
>
> Did this go anywhere?
> (I just came back from a longer vacation, sorry for the delay on my site)


Not really. I am still unsure how is best to proceed. Details below.

> > There are projects such as llvm/clang which use several repositories, a=
nd
> they
> > might be forked for providing support for various features such as addi=
ng
> Redox
> > awareness to the toolchain. This typically means the superproject will =
use
> > another branch than master, occasionally even use an old commit from th=
at
> > non-master branch.
>
> > Combined with the fact that when incorporating such a hierachy of
> repositories
> > usually the user is interested in just the exact commit specified in th=
e
> > submodule info, it follows that a desireable usecase is to be also able=
 to
> > provide '--depth 1' to avoid waiting for ages for the clone operation t=
o
> > finish.
>
> Very sensible.


The only change is that I realized that hard coding the depth is not
necessary because the client can fetch more and more from the branch
until the commit hash is found or the entire history was fetched and
it wasn't found.

This is more robust but has a variable performance penalty and is
probably slower than single branch fetching from the start.

> > Git submodule seems to be very stubborn and cloning master, although th=
e
> > wrapper script and the gitmodules-helper could work together to clone
> directly
> > the branch specified in the .gitmodules file, if specified.
>
> Also very sensible.
>
> So far so good, could you move these paragraphs before the triple dashed
> line
> and sign off so we record it as the commit message?


Sure, as long as the implementation and design makes sense.

> > Another wrinkle is that when the commit is not the tip of the branch, t=
he
> depth
> > parameter should somehow be stored in the .gitmodules info, but any
> change in
> > the submodule will break the supermodule submodule depth info sooner or
> later,
> > which is definitly frigile.
>
> ... which is why I would not include that.
>
> git-fetch knows about --shallow-since or even better
> shallow-exclude which could be set to the (depth+1)-th commit
> (the boundary commit) recorded in the shallow information.


I am unsure what that means. Without yet looking in the docs, would
this --shallow-since be better than the try-until-found algorithm
explained above?

> > I tried digging into this section of the code and debugging with bashdb
> to see
> > where --depth might fit, but I got stuck on the shell-to-helper
> interaction and
> > the details of the submodule implementation, so I want to lay out this
> first
> > patch as starting point for the discussion in the hope somebody else
> picks it
> > up or can provide some inputs. I have the feeling there are multiple co=
de
> paths
> > that are being ran, depending on the moment (initial clone, submodule
> > recursive, post-clone update etc.) and I have a gut feeling there
> shouldn't be
> > any code duplication just because the operation is different.
>
> > This first patch is only trying to use a non-master branch, I have some
> changes
> > for the --depth part, but I stopped working on it due to the "default
> depth"
> > issue above.
>
> > Does any of this sound reasonable?
> > Is this patch idea usable or did I managed to touch the part of the cod=
e
> that
> > should not be touched?
>
> This sounds reasonable. Thanks for writing the patch!


OK. Now I need to make it good, which is the hard part :)

> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index 2491496..370f19e 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -589,8 +589,11 @@ cmd_update()
> >                          branch=3D$(git submodule--helper remote-branch
> "$sm_path")
> >                          if test -z "$nofetch"
> >                          then
> > +                               # non-default branch
> > +                               rbranch=3D$(git config -f .gitmodules
> submodule.$sm_path.branch)
> > +
> br_refspec=3D${rbanch:+"refs/heads/$rbranch:refs/heads/$rbranch"}
>
> Wouldn't we want to fetch into a remote tracking branch instead?
> Instead of computing all this by yourself, these two lines could be
>
>      br_refspec=3D$(git submodule--helper remote-branch $sm_path)
>
> I would think.


I wasn't aware of this, will implement I  the next version and see what hap=
pens.
>
>
> >                                  # Fetch remote before determining
> tracking $sha1
> > -                               fetch_in_submodule "$sm_path" $depth ||
> > +                               fetch_in_submodule "$sm_path" $depth
> $br_refspec ||
> >                                  die "$(eval_gettext "Unable to fetch i=
n
> submodule path '\$sm_path'")"
> >                          fi
> >                          remote_name=3D$(sanitize_submodule_env; cd
> "$sm_path" && get_default_remote)
>
> It would be awesome if you could write a little test for this feature, to=
o.
> Look for the tests in regarding --remote in t7406 (in the t/ directory) a=
s
> a starting point, please.


Coming up with a test case is probably a better way to explain what I
want the behaviour to be. Thanks for pointing out the test case area
to look into.

> Thanks!
> Stefan

--=20
Eddy Petri=C8=99or
