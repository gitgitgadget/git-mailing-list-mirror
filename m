Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 540EE1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 07:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeLTHK2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 02:10:28 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46907 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeLTHK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 02:10:28 -0500
Received: by mail-qk1-f195.google.com with SMTP id q1so374190qkf.13
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 23:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z2LiFthU6KR/YRyrk2bgnPBMOSdqT3u/d1lHLd5tKBE=;
        b=sfSRH79pZ3s2/UUErjyHZWyhaPJO5ixRKYADDwFTlWj9Vm3giMex4yHXohSDXL9kwh
         jflRD7QH/MB/CaCRtJn23XzT/H349regeRwFCL++WcIckcItGYA11UQsGUTDNs6rlWa6
         orkgRhGsM2+KofhtWBbMj0eo9ySO5fsJIxpSvqaaXMWr79PrKONzcfui7oNxgAKhgIC7
         FGBNFqCX6B1AfshQBTs6KfceT37gJHgMrHhB+LMSw4GnFg9KMynDREXZCMVi5SCewUef
         HFs+zgzrZLkMPaj5/M7vvxT+dCaHt+H0CYtbrWP9Y8L3zeYs+7oOES/wNqouuz3QGL24
         6XIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z2LiFthU6KR/YRyrk2bgnPBMOSdqT3u/d1lHLd5tKBE=;
        b=ENL+JbgNZ6ZT89OPE3EtPbaPwbW9U482KiyACXbUnEUotAgJhe5naScuFmjNlMJnr6
         cm2omAf4/HtFITcP9LU3RwOdE9X0/rhs2q+I9g5QHYvc3Z8VUisS/NqF3HLBhcIEcBrd
         DB6XwhaTmyv97RJSrrru4n7FDsp5aJ39u2C5PDwtcUmlS+MYsTKepZ0VP7kkRzxXqLvy
         i6NhLC/rbdYuJyVVDIvBx4sERL8l2EaQH9yKb4yjDzDouBL0AydyMqwww/EG6djmwcmG
         d+25UpAbWsDVQZLwjF2r1BdbPJasuAhFQTtp0xMoK4vPXMPxSWhHrdNT0pCsutT8tvzu
         Zh3Q==
X-Gm-Message-State: AA+aEWaXg+CzHYHOZMKQTPdfeMsE1OUMQmZKsX86WQvkqL8mLsC06MNn
        GzrNBE2G2Fvde4iuGc3k3lAxSBpeaGGgjR3pQbZxWw==
X-Google-Smtp-Source: AFSGD/UhIlxnFoJ1OuEv8xe4gskNu51hgArD70WkC5sg1x86GD3UWflqz53haY4XwScjxxzIJ19iqPDsh4fXWOvvyk8=
X-Received: by 2002:a37:6e43:: with SMTP id j64mr22021051qkc.278.1545289826596;
 Wed, 19 Dec 2018 23:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20181111235831.44824-1-nbelakovski@gmail.com> <20181216215759.24011-1-nbelakovski@gmail.com>
 <20181216215759.24011-2-nbelakovski@gmail.com> <20181218172236.GA28455@sigill.intra.peff.net>
In-Reply-To: <20181218172236.GA28455@sigill.intra.peff.net>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Wed, 19 Dec 2018 23:09:59 -0800
Message-ID: <CAC05384H1LgsGMO=ggUyfFTXrXAFcjUXDSdcmev9ActPt5081A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ref-filter: add worktreepath atom
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 18, 2018 at 9:22 AM Jeff King <peff@peff.net> wrote:
>
> On Sun, Dec 16, 2018 at 01:57:57PM -0800, nbelakovski@gmail.com wrote:
>
> > From: Nickolai Belakovski <nbelakovski@gmail.com>
> >
> > Add an atom proving the path of the linked worktree where this ref is
> > checked out, if it is checked out in any linked worktrees, and empty
> > string otherwise.
>
> I stumbled over the word "proving" here. Maybe "showing" would be more
> clear?

Oops, providing

> > +worktreepath::
> > +     The absolute path to the worktree in which the ref is checked
> > +     out, if it is checked out in any linked worktree. ' ' otherwise.
> > +
>
> Also, why are we replacing it with a single space? Wouldn't the empty
> string be more customary (and work with the other "if empty, then do
> this" formatting options)?

I was just following what was done for HEAD, but overall I agree that
empty is preferable to single space, will change.

> Minor style nit: we put the "*" in a pointer declaration next to the
> variable name, without intervening whitespace. Like:
>
>   static struct worktree **worktrees;

Gotcha, will do, thanks for pointing it out.


To sum up the hashmap comments:
-I hadn't thought to re-use the head_ref of worktree as the key.
That's clever. I like the readability of having separate entries for
key and value, but I can see the benefit of not having to do an extra
allocation. I can make up for the readability hit with a comment.
-Actually, for any valid use case there will only be one instance of
the map since the entries of used_atom are cached, but regardless it
makes sense to keep per-atom info in used_atom and global context
somewhere else, so I'll make that change to make it a static variable
outside of used_atom.
-Will change the lookup logic to remove the extra allocation. Since
I'm letting the hashmap use its internal comparison function on the
hash, I don't need to provide a comparison function.

> What's this extra strncmp about? If we're _not_ a worktreepath atom,
> we'd still do the lookup only to put nothing in the string?

Leftover from an earlier iteration where I was going to support
getting more info out of the worktree struct. I decided to limit scope
to just the info I really needed for the branch change. I left it like
this because I thought it would make the code more readable for
someone who wanted to come in and add that extra info, but I think
you're right that it ends up just reading kind of awkwardly.

>
> > @@ -2013,7 +2076,14 @@ void ref_array_clear(struct ref_array *array)
> >       int i;
> >
> >       for (i = 0; i < used_atom_cnt; i++)
> > +     {
> > +             if (!strncmp(used_atom[i].name, "worktreepath", strlen("worktreepath")))
> > +             {
> > +                     hashmap_free(&(used_atom[i].u.reftoworktreeinfo_map), 1);
> > +                     free_worktrees(worktrees);
> > +             }
>
> And if we move the mapping out to a static global, then this only has to
> be done once, not once per atom. In fact, I think this could double-free
> "worktrees" with your current patch if you have two "%(worktree)"
> placeholders, since "worktrees" already is a global.

Only if someone put a colon on one of the %(worktree) atoms, otherwise
they're all cached, but as you say moot point anyway if the map is
moved outside the used_atom structure.

>
> It's probably worth testing that the path we get is actually sane, too.
> I.e., expect something more like:
>
>    cat >expect <<-\EOF
>    master: $PWD
>    master: $PWD/worktree
>    side: not checked out
>    EOF
>    git for-each-ref \
>      --format="%(refname:short): %(if)%(worktreepath)%(then)%(worktreepath)%(else)not checked %out%(end)
>
> (I wish there was a way to avoid that really long line, but I don't
> think there is).
>

Yea good call, can do.

Thanks for all the feedback, will try to turn these around quickly.
