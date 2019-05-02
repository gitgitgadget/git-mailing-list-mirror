Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EAB51F453
	for <e@80x24.org>; Thu,  2 May 2019 13:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfEBNpu (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 09:45:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44640 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfEBNpt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 09:45:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id c6so2210767lji.11
        for <git@vger.kernel.org>; Thu, 02 May 2019 06:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=45PJ8u6ABnnm60hSHCB3gHmT/vhJhayvtpMcaAT89xw=;
        b=vUudZoyoN2Bw80PrihMPAeZ0ttYQsyh87Uys/fBrqF3mM0yKcz9Ti3nOZH5oFogbiz
         5K1+GuIIBLp0z8/uv+xWy9KZg/OCN1vTi3RRIitTFWWMQwwJLFSXCBZMaw5XciQZRBBn
         onlUtYxX+WnFbAB6TC3fVaY84UReWgxbsUjXBMNICOnSWjshzPNOP/mbQLLEvecTvmOW
         wabgOG2V9Yln5z+DZT1vyv5EEk1b4dlidCSz2kXjRdpCagcYVpVbQB/9mCNs0XMpj2Lv
         CJKqQi7WWsilti8VD1utFwVYTZCCF3/HouzDsghvbDTGC20/Ub2j6kCciptsDwfHOYq9
         keug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=45PJ8u6ABnnm60hSHCB3gHmT/vhJhayvtpMcaAT89xw=;
        b=kF2IRkmCs/dZermqDPCyHqeBul4KW0eTFEFXIr41autHWwOSSNH03/Tg/LRvW5mR6+
         NjMgj5oiH4jJRy/Pax+sFkDSuqTfoii4cmRb5VHgbBRpth2pdNeY9nUQiAVQyJ0jsHKW
         JkaSyCKbmWj7lkue600ZntnzdM7M6V1fv9Zft/fLNGKNYPhz6p2IqiJmilzw2j9oQ6ZS
         nL63Lkra6unqYpuUzvyJ756g/fxbl9dGixom5Bui01+ZPkEG3mBnBSZqBbq3PE/cZ/ud
         7pVcxmOgQ0FAX74Q27nUo7Y930QBX6D5NYJbczfQF+AhmlGdlRAZvw7L2mhTB4Q5SvH3
         QTnQ==
X-Gm-Message-State: APjAAAX8mP/DCaZWrg2t9QphSGY0nDw/1wYf4AeWvHkg09itqL+x2OeK
        Y2Xwaf9XR8967+/3GAKEDOEr4B+AB8drkmxEJOk=
X-Google-Smtp-Source: APXvYqx8WO08l0LZyzVQjJVQz0pFz5X3wotcs8yisR2a1SYPGnK/PM6WF7duRIby3WP/9UbShTxzmFZavOVEJQObWLs=
X-Received: by 2002:a2e:5d5b:: with SMTP id r88mr1816031ljb.166.1556804747666;
 Thu, 02 May 2019 06:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAF8BazDu_GqoCPBQ-gEJ+q8n1aWSjf_TOV7bDE5VCQkDgBjyfQ@mail.gmail.com>
 <CAF8BazA-VYFns7o9F7gXfFZCspbM0yQKi+LQ+BnkpGH+EjPC9A@mail.gmail.com>
 <CACsJy8DSW2f3v1KpU-QrAz-EeLwG4mVm9ToDdA2=kXSmtsEAYw@mail.gmail.com>
 <CAF8BazBShg9F2uCuVQ_PM6196kOUNWOA1T9APkCXCoey7as2mQ@mail.gmail.com>
 <20190430174110.GA16729@sigill.intra.peff.net> <CAF8BazBBP53uhh+oOroFuVCEL-FaqJheSYX5Q5_NQxGRt=g_xA@mail.gmail.com>
 <20190501183638.GF4109@sigill.intra.peff.net>
In-Reply-To: <20190501183638.GF4109@sigill.intra.peff.net>
From:   Aleksey Midenkov <midenok@gmail.com>
Date:   Thu, 2 May 2019 16:45:36 +0300
Message-ID: <CAF8BazAK_s89XY8-AAsSSbgOFgP03CLRZ50bLGPsc89bfnN7kQ@mail.gmail.com>
Subject: Re: Bug: fatal: Unable to create '.../.git/index.lock': File exists.
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 1, 2019 at 9:36 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, May 01, 2019 at 10:15:19AM +0300, Aleksey Midenkov wrote:
>
> > > Usually when we see racy contention on index.lock, the culprit turns out
> > > to be another unrelated git process refreshing the index. Do you have
> > > anything else running which might be using "git status" (e.g., magit in
> > > emacs, vim git integration, etc)?
> >
> > kdevelop which is git-aware. But if git fails on concurrent operation
> > this is still not good. I would expect it to wait until lock releases
> > for some time.
>
> Historically Git does not wait for locks because whoever is holding the
> lock is likely to invalidate the changes we're proposing to make by
> taking the lock in the first place. We've softened on that a bit in
> recent years (e.g., ref updates now retry with a timeout to accommodate
> things like reflog pruning), but I don't think the index code does.
>
> If the other entity holding the lock is just updating the stat
> information in the index, that's probably OK. If it's actually
> manipulating the index, I think we'd have to give more thought about
> whether that's safe.
>
> Assuming that kdevelop is just running "git status" in the background,
> though, there's an easier solution. If it uses "git --no-optional-locks
> status" instead, that will instruct it not to take the index lock at
> all.

And can we disable optional locks at git configuration level? Because
changing source code of each application that is not aware of this
option is not an easier solution.

>
> -Peff



-- 
All the best,

Aleksey Midenkov
@midenok
