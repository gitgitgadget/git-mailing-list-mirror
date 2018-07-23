Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9C8E1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 22:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbeGWXwC (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 19:52:02 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:41655 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388088AbeGWXwC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 19:52:02 -0400
Received: by mail-yw0-f180.google.com with SMTP id q129-v6so845362ywg.8
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 15:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+pLZ6hr8NfPfjPCHboWfGZnv/aYMnkclQhNXpFhVV0=;
        b=qVYtXfMf3o/K2/fDJJpWb/Yr0u3qLB99/t4R1MUTgEfoA0ZupQTmvfAnHXWwvO8wdR
         PtUI9IT2wsBe9YhDfy9iVGwBDXW1fme5ifZ+KcZ8iEXb8Kq0UBGf6u+DEb0DXn3P7JB7
         NQwVqcZnHQbFEYArS7ei5/b/tzD+QGfzct22T7raXyRCg6ciGu01ROQjs/Sgl72M/KaV
         aixw4pq/0H0Bax/UZZEqjVud50eRHL1rWWw1eZ6w961vYSv6wmhiiljMu7L49jxp8DVV
         LAP4lVKYHh9VHQhFWnbkR2D53PlW6OzWOCveZ+r+tgU8a5V4LE9C9fJdbp7WmB/Alnqi
         jmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+pLZ6hr8NfPfjPCHboWfGZnv/aYMnkclQhNXpFhVV0=;
        b=KYItA7Q5EcSprIa3SGh21VlEa55E2QV4b3g9bSoElJGAPDPBbhCi3mgH4uj9/g0BD6
         I1eoZbkzFSYBJNCF2b1vaEE3WXP4r9W7Wf/p/jkD6O68/wbl17cWvTOaX3R9V5i3M7v3
         3AVxsAiv2dwZUhsHoWaohCgSKx56Zm0wfxY6xP1KEJe7GMx1F/W0VSIeQzkr6nvk0U1s
         HvusmpBb1vqMr9t5aYA9d2ueAFk2DrzAFWyGTJ/xFTJfv/r7Nh8kN/6Gx+q6KddHDQCw
         fCmN5LAci2Y+GR+fXI/cHcCHtyJCdUZQeT9wzF6v+TX/WJHHHiKoHBszVj+0I2cy9w9A
         EuWg==
X-Gm-Message-State: AOUpUlFd2TKDRCPDkXO2u+cRP7VfxLod0ff52KRDTsrZ4frzyfk8cOEy
        SxuawmciRokPIDzfJbv4MdNuMyPgvoPhCYDYHb6kcg==
X-Google-Smtp-Source: AAOMgpcipQO+99xf+tR3PkBq1QOgN5EFz2IUwk1nalLiGbQKyrcxYaCj05g74ELELaHCrOnMLbbisY4b0Ao/KKYzI88=
X-Received: by 2002:a81:3758:: with SMTP id e85-v6mr7902036ywa.340.1532386115615;
 Mon, 23 Jul 2018 15:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com>
 <9de5bd2299eedbc78494cadc9dd8bda59430b2df.1532210683.git.gitgitgadget@gmail.com>
 <xmqqy3e137wd.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy3e137wd.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Jul 2018 15:48:24 -0700
Message-ID: <CAGZ79kZrJRQWPzojjhQJGRZWSNvLnZ0C++9XggMVp2wuFNnnLQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/21] diff: add an internal option to dual-color diffs
 of diffs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > -     fputs(diff_line_prefix(o), file);
> > +     if (first)
> > +             fputs(diff_line_prefix(o), file);
> > +     else if (!len)
> > +             return;
>
> Can you explain this hunk in the log message?  I am not sure how the
> description in the log message relates to this change.  Is the idea
> of this change essentially "all the existing callers that aren't
> doing the diff-of-diffs send a non-NUL first character, and for them
> this change is a no-op.  New callers share most of the remainder of
> emit_line_0() logic but do not want to show the prefix, so the
> support for it is piggy-backing by a special case where first could
> be NUL"?

All but two caller have 'reverse' set to 0, using the arguments as before.

The other two callers are using the function twice to get the prefix
and set sign going, and then the second call to get the rest of the
line going (which needs to omit the prefix as that was done in the
first call) :

+               /* Emit just the prefix, then the rest. */
+               emit_line_0(o, set_sign ? set_sign : set, !!set_sign, reset,
+                           sign, "", 0);
+               emit_line_0(o, set, 0, reset, 0, line, len);

I attempted to clean it up on top, but likely got it wrong as we have
no tests for colored range diffs, yet.
https://public-inbox.org/git/20180710174552.30123-3-sbeller@google.com/
My suggestion would be to first clarify emit_line_0 and have its arguments
and its execution map better to each other, (and as a result only needing to
have one call of emit_line_0 instead of two)

That is my understanding of the situation.

Thanks,
Stefan
