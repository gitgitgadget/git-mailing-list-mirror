Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709C2C6FD1F
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 05:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjCYFYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 01:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCYFYR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 01:24:17 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE262101
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 22:24:16 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id bi31so2765187oib.9
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 22:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679721855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64hUphgnILE+oxNkc2KU4VfdSZaoYkeYJ3VP5ZTSJX4=;
        b=Lqw50rXgdsjtyEbtaDFHjtKU+vEb5AL2np9gnxr4dnGXxu9yfRTbR4aeT/yjVEJjCi
         HQeEDqyyslbbv5sG2cCuaiBTrP0mBTgghkK3lJ0XFBInhgJa09D2c6QfnJeejsz2xtUA
         c4dlTv0ZffPdf8FRcE0NQTqx/2eM1fG2ZVij8xOhaAU/dhpvGQby3X5ZlhFtjSlsabZU
         OCXg+NPr32H64Of2p/CSGRnpsNmeaRtPweKGh7Yv/OvYpiKaRCHlxo/7G6HlPl/io/M5
         GKyy+kYcdX49tlYap9RVptqQ0CoJeDbgHLTksEWNX7SyZaEXqoNcL3q8q0xuxMBb76xn
         eysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679721855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64hUphgnILE+oxNkc2KU4VfdSZaoYkeYJ3VP5ZTSJX4=;
        b=vWRI9WL3praln9HhBPCOeg/p8/onlk+xwPkk+U+9RSwCo2e+VdkYmoidDSe4+B8WGC
         tpR2/NJ8kCw4ChqpeyIKe4Ipp4WYzJ53hK2It77xQJGPa/QZu72GXMGyNR5pAYNkSg4q
         pee2TCOliEGkO170/bmZkiTHnYqFjWNObqwlXnbj+7MlW9XYRID/D47RnaXxl+WxDC/J
         uhwq23uCDHKlop2cYIu6f8CAcFD+NL4rIHP8TGzRw1iagpWxiADlVmrNdKaRWGiNXmlq
         JoD3b6q4B0goc+WU9tU4Bk1NdonQI7pU/GP07qTACv55UhUjAdJYKZe30BVLyIzFdRTR
         I4iw==
X-Gm-Message-State: AO0yUKXMqMWGFRQYzJjR484pSOiMcELQjrMzH/oCOIhrvRu+pTTPgN1n
        5rRc56iORz0JsxM8E8NwLdyvFU8pRaSPeDCDow0=
X-Google-Smtp-Source: AK7set9Vg8F7lOWumocexwPEhlfLjxovKCFZZiOBnzGJoAKWIDjvj6RObW0FerxzcEgUVa7M0xx+pgmNcFifdeqni4c=
X-Received: by 2002:a05:6808:3c1:b0:386:b836:2ace with SMTP id
 o1-20020a05680803c100b00386b8362acemr1436123oie.9.1679721855461; Fri, 24 Mar
 2023 22:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230312210456.92364-1-alexhenrie24@gmail.com>
 <20230320055955.461138-1-alexhenrie24@gmail.com> <20230320055955.461138-4-alexhenrie24@gmail.com>
 <f062165f-2e59-67b5-ebff-b029c29dd4d6@dunelm.org.uk> <xmqqttyb8fxw.fsf@gitster.g>
In-Reply-To: <xmqqttyb8fxw.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 24 Mar 2023 23:23:39 -0600
Message-ID: <CAMMLpeRC5s80meD5mB0rmHRYR7iCa_WH0qOTaXvppw2ZHMriWQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] rebase: add a config option for --rebase-merges
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, newren@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com, chooglen@google.com, calvinwan@google.com,
        jonathantanmy@google.com, felipe.contreras@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2023 at 12:45=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> >> @@ -1514,13 +1542,15 @@ int cmd_rebase(int argc, const char **argv, co=
nst char *prefix)
> >>                              break;
> >>              if (i >=3D 0 || options.type =3D=3D REBASE_APPLY) {
> >> -                    if (is_merge(&options))
> >> -                            die(_("apply options and merge options "
> >> -                                      "cannot be used together"));
> >
> > This isn't a new change but having thought about it I'm not sure
> > moving this code is a good idea. If the user runs
> >
> >       git -c rebase.updateRefs=3Dtrue rebase --whitespace=3Dfix --exec =
"make test"
> >
> > then instead of getting an message saying that they cannot use apply
> > and merge options together they'll get a message suggesting they pass
> > --no-update-refs which wont fix the problem for them.
>
> Hmph.  Instead of dying here, ...
>
> >> +                    if (options.autosquash =3D=3D -1 && options.confi=
g_autosquash =3D=3D 1)
> >>                              die(_("apply options are incompatible wit=
h rebase.autoSquash.  Consider adding --no-autosquash"));
> >> +                    else if (options.rebase_merges =3D=3D -1 && optio=
ns.config_rebase_merges =3D=3D 1)
> >> +                            die(_("apply options are incompatible wit=
h rebase.rebaseMerges.  Consider adding --no-rebase-merges"));
> >>                      else if (options.update_refs =3D=3D -1 && options=
.config_update_refs =3D=3D 1)
> >>                              die(_("apply options are incompatible wit=
h rebase.updateRefs.  Consider adding --no-update-refs"));
>
> ... we get caught here, and the next one is not triggered.
>
> >> +                    else if (is_merge(&options))
> >> +                            die(_("apply options and merge options "
> >> +                                      "cannot be used together"));
> >>                      else
> >>                              options.type =3D REBASE_APPLY;
>
> What's the reason why "cannot be used together" is moved to the last
> in the chain?
>
> The first two new conditions in this chain try to catch an
> invocation with some apply-specific command line option
> (e.g. "--whitespace=3Dfix") when used with configuration variables
> specific to the merge-backend (e.g. "rebase.merges") and suggest
> overriding the configuration from the command line, and I suspect
> that the motivation behind this change is that their error messages
> are more specific than the generic "apply and merge do not mix".

Phillip specifically asked for `git -c rebase.rebaseMerges=3Dtrue rebase
--whitespace=3Dfix` to print "error: apply options are incompatible with
rebase.rebaseMerges. Consider adding --no-rebase-merges".[1] I could
have sworn that "if (is_merge(&options))" had to be after "if
(options.rebase_merges =3D=3D -1 && options.config_rebase_merges =3D=3D 1)"=
 to
make that happen, but now it works without that change. I must have
been debugging with some intermediate version that still had
'imply_merge(&options, "--rebase-merges")' before this if chain. I'll
send a v9 that puts "if (is_merge(&options))" back at the top.

Thanks for your attention to detail!

-Alex

[1] https://lore.kernel.org/git/7ba8a92d-8c94-5226-5416-6ed3a8e2e389@dunelm=
.org.uk/
