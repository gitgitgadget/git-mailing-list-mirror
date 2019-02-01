Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F32431F453
	for <e@80x24.org>; Fri,  1 Feb 2019 06:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfBAGtX (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 01:49:23 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40592 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfBAGtX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 01:49:23 -0500
Received: by mail-it1-f196.google.com with SMTP id h193so8304049ita.5
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 22:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sIzppIvQ+Qz4/+VUtdh6cwQCLb3VEbbop2D6YVB2EmU=;
        b=e1ntCqZswZVY/juOZ6d4t8zVRFYAd4dkuP8JW0oiLFZCWcNykpBq3e7F3t5jABzFgg
         oXnG+57WgHIFmHC6pStz170eTNLfd9Va4Khn4sfqMHwQXtM9ouYWEIUhwWAWJtV+F6+Z
         F6Gk45gbYms1Av1lz6fcE971EBcoVzS4BN9m6bShiYrWK/7MQtdtPj65v+Nmi6O5j0AW
         Z91+2qmLQqOQ+DRGjShfcFjfD38+v0zX2inQ28e6P+kdawmp6Gqp6Q5mkBgWoEy4PoEP
         3MmJ9Liwm1twFL3eO3q+klwr3cz/kNooKMmIbaJJjvvZF2aa8k+KXYFIzDLAMLkqfN9P
         MBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sIzppIvQ+Qz4/+VUtdh6cwQCLb3VEbbop2D6YVB2EmU=;
        b=IJ+gD+w+N5YdeWYmM5Xl7xa9nzbo7Klk3/OZU4HzCFnaEeb0cD+7in+glTagB+O3se
         JvNKWNsvbq8EHmtKQAm77dW7Ij5t2JtTwcdRCJeP5hOHBDyZLXgnKpnooN6gzG2gBU49
         Vp/Ua2xoKEz2bgVcaLbz7XcuPkdAd3MbjHQ8N4IVbSHDqdhyfM/3yomNIM4TxLfrFRSE
         0a8kAS7YhwvXkEjCXrMZA1afW+XsW4nnvis0p47FZvaQWzU1dmdGQWgVeXXkjEsFjG8+
         V5t8hjwdqBHTfcxL9/hVcLJWoZuzDXc8cxpVhq5ZPjM5ZMwzx4wGECw3LGzhF0I1lBCn
         MnnQ==
X-Gm-Message-State: AJcUukcJQkMjecbKmmKo10qRTVLS5P2vWROozNkYOEdNsS/9OVeyYHTf
        FCg5VC80zhqZoScYos6mmtNe07Yi1ml1gU0NLcI=
X-Google-Smtp-Source: ALg8bN5ECY0rvAqCROv8VDIBi2ky88rG1c3fpMZz8xll7xFw6uCQK2cP1O8/+ibQEB1pcWyTSUit/JtprKzD8MXqKv0=
X-Received: by 2002:a02:183:: with SMTP id 3mr24127721jak.130.1549003762544;
 Thu, 31 Jan 2019 22:49:22 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-7-t.gummerer@gmail.com>
 <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
 <xmqqva40lps2.fsf@gitster-ct.c.googlers.com> <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
 <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
 <CACsJy8Bk=wbgzsE+Vo4w_u0E63PdUxxcvG-7e6Hq-8_jrmSErw@mail.gmail.com> <xmqq7eek3ax7.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7eek3ax7.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 1 Feb 2019 13:48:56 +0700
Message-ID: <CACsJy8CHHT=9e9ti7VA4X4h3FrZcUKvLuzkL56mXLgjk4c5Qcg@mail.gmail.com>
Subject: Re: [PATCH 6/8] checkout: add --cached option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 1, 2019 at 2:05 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > I've changed my mind. I'm not using --index and --cached for "git
> > restore" (formerly "git restore-files"). So how about this?
> >
> > git restore --from=<tree> <pathspec> will update both the index and worktree.
> >
> > git restore --from=<tree> --keep-index <pathspec> will not update the index
> >
> > git restore --from=<tree> --keep-worktree <pathspec> will not update worktree
>
> An action to "restore" with an option to "keep" (i.e. "do not
> touch") smells strongly of double negation.  We are restoring,
> i.e. grabbing something that existed in the past out of another
> place (like tree or index) and depositing it to the working tree to
> recover its previous state, oh, not but not touching the content of
> the working tree (or the index) intact?

It is negation (though not double). The thinking was, since "git
restore" means restore everything, extra options will amend that to
"restore everything except ..." and because the parts to keep are more
important (i.e. data loss), highlighting it on the command sounds a
bit better to me: "ok i'm going to need to restore this thing, but I
want this part and that part to stay the same, let's type the
command..."

> It would be great if you can come up with phrasing that avoids
> specifying what is *not* done, but instructs the command what is to
> be done, perhaps along the lines of "restore --index-only", "restore
> --worktree-only" and "restore --index-and-worktree (which would be
> the default)".

My biggest problem with --*-only is that they cannot be combined.
There must be an option for every valid combination. I'm still
thinking about "git reset" where there are three parts to
reset/restore: HEAD, index and worktree. So at least there's another
valid combination "reset HEAD but not index nor worktree", which would
end becoming another option. This route does not look promising.

Of course we could just do --index and --worktree, each option
restores the respective part. Then it's combinable (and extensible in
the future). But then "git restore" means "git restore --index
--worktree" and typing "git restore --index" effectively removes the
default "--worktree", which seems a bit twisted.
-- 
Duy
