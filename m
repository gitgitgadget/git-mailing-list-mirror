Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C2231F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 22:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfACWGN (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 17:06:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51974 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfACWGN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 17:06:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so30513295wmj.1
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 14:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U1u2UG32LmvjM6799lUBHKsPPsV0O1BpqQTxaWTU2Mk=;
        b=QZs9joioPaakSIG1/Ef+e8I1YPpRSAm10W3B3dgST1GMaOXzNm5R8kTYWuibEgxzjm
         Xqrnv4jWXrIyGz53Lio3cz80L9jHgmRWn68PWBhFWSrPpVGEXUuQV7bQ1UuIKQc73Gbl
         zF8Xm5rKbpXZW1IM1eBte9p34IqJh//x9pTbNyGkFNjF9AmU2yCnRB0IHfJRWwZrgMMk
         tABwkmK5rTrSSkoUyYUZeB72K56zY08dzDS2MJMvdaZGeDDu1Hzy8e5fQF+hbFsHcs91
         bTVwL5Ei95vWg0YAtQ3krJsStx+tTrgzWdstGsc01jW7bbUnv562NrsGw75AAmiqCGoi
         fnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U1u2UG32LmvjM6799lUBHKsPPsV0O1BpqQTxaWTU2Mk=;
        b=d4BqHuu8MkKFGO9pKjzdi0pQaSquXh9DtG+aK0bEvHGmlChRntsm/3EH4X/oFDOo0J
         JxWa46jqlxXA5hIde8pms1eAJXfmXyiLwqDwuW/SBk6T/N+7bJTR9p2S6JRlOdIwgwAg
         jVyO8Uc2ESa4H4Cdi9uTzcLzOKc7J7QwCl0H6qJdo58XyTwpS2TwbsEOCnFnseLSliTA
         0iojXstTg0yHyby480kUmfhOvc4CI2FJsVFN1/H9oNsN0yyY9qgvVd8bj466gxxhT4u4
         QvhEdhVJTRz3g1gEqx95Gv3E3fE8c8S7YLbG9d/6sSl/Z/jIvm9fq3jN2CsM9RL+pAVk
         gU/A==
X-Gm-Message-State: AJcUukehWAxZJrovXlqQCbhqUeiWogHHQNKA56pseyt8ONwHzCsuz4oj
        D5coi1MzB8QDrdOsh0BbAWKB74QF97RncTddKrCURA==
X-Google-Smtp-Source: ALg8bN78mJGDctwA8r2I8MUGEMNB0PWbzgffdmKGzjzDb4jnu6QMa5bxmdHVMEvn48j/qsf1rIA9jaYWjdD3m5UeipU=
X-Received: by 2002:a1c:2007:: with SMTP id g7mr38037343wmg.79.1546553170547;
 Thu, 03 Jan 2019 14:06:10 -0800 (PST)
MIME-Version: 1.0
References: <CA+dzEB=DH0irkFaRzkKERSjdZ=EJ+mG3Ri2Xeobx9Yu_eDd+jg@mail.gmail.com>
 <CACsJy8B=-V7XY+=5pwwSzg8B6Goa55DPPU3ErgjOEsSJVni18Q@mail.gmail.com>
 <CA+dzEB=TPxng4YBC4Vfh=ZcctAzRQ+drJ3y2sXwP=JXf+UweSA@mail.gmail.com>
 <CACsJy8C=O=ZDvD0ReSJOyAsNDEb5Yz-iFvs7oV5zAXaFf-dw5g@mail.gmail.com>
 <xmqqef9th4iy.fsf@gitster-ct.c.googlers.com> <CA+dzEB=+ROLVjp36SQjucouc8YUWTvYBrN4QyS5fsStMPtbw_w@mail.gmail.com>
 <xmqqwonlfm0g.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwonlfm0g.fsf@gitster-ct.c.googlers.com>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Thu, 3 Jan 2019 14:05:59 -0800
Message-ID: <CA+dzEB=oeL2oByqiH4FeCHc29yGL2TwhmO1DKmRTDx8Xdhh=NQ@mail.gmail.com>
Subject: Re: Regression `git checkout $rev -b branch` while in a
 `--no-checkout` clone does not check out files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Ben Peart <peartben@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 3, 2019 at 1:51 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Anthony Sottile <asottile@umich.edu> writes:
>
> > On Thu, Jan 3, 2019 at 12:26 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> A "fix" to Ben's optimization for this particular case should be
> >> fairly straight-forward.  I think we have a special case in the
> >> checkout codepath for an initial checkout and disable "carry forward
> >> the fact that the user wanted all the paths removed", so it would be
> >> the matter of adding yet another condition (is_cache_unborn(), which
> >> is used to set topts.initial_checkout) to the large collection of
> >> conditions in skip_merge_working_tree().
> >
> > I think it might be simpler than that even -- the optimization treats
> > the following as equivalent when the current checked out revision is
> > deadbeef (even if the index / worktree differ), when before they were
> > not:
> >
> > - git checkout -b newbranch
> > - git checkout deadbeef -b newbranch
> >
> > If a revision is specified on the commandline it should be checked out.
>
> If it were to be a "fix", the exact same command line as people used
> to be able to use, i.e. "git checkout -b newbranch", should be made
> to do what it used to do.
>
> Forcing users to use a different command to workaround the bug is
> not a usable "fix".  If we want a working workaround, you can tell
> your users to use
>
>     git reset --hard HEAD && git checkout -b newbranch
>
> and that would already work without any code change ;-).
>
>

oh wow, I didn't realize `git checkout -b newbranch` also used to
reset the `--no-checkout` state, yeah you're right the optimization is
way more problematic than I had considered.

I'm working around by not using `--no-checkout` personally

Anthony
