Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395F11F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 23:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeKRJun (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 04:50:43 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54031 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbeKRJun (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 04:50:43 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so1616974ita.3
        for <git@vger.kernel.org>; Sat, 17 Nov 2018 15:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6tTIn59VFshqXoWbopHPFSCSz4sYFT6bwhXeUXKgvvg=;
        b=m5zA08NSmVa5OcgnMmoxKtsZWTN8uGLmzfiFLSQXG3ay5l6ESCzyHCkAQZ19s18Sqd
         ZNtKipIi9ey/3tZ3XjywxLHhh/h/RCjdCRK0xVamgn7hVnwQC1uYyZW7BrGknOY95jF6
         xpY0KNJBZy9jZDHjW/KlDkXpxiZNmbg1JoWNF6hwik2i0Ucf5odT+kBtbC3jflnlVBUk
         saVplQNfV2MDxI1lUoyMomYMqWkOJevWGZ+A/ds6f/nU7DjKFVVZ97p5i7yZuOIpxm28
         cwNIi9pjx9jHdfe9ZHtbpn0ggY5A4DymMB9vboT9mJGAwUGMQAuT+jrDUu2Fd4NFN6ja
         2AiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6tTIn59VFshqXoWbopHPFSCSz4sYFT6bwhXeUXKgvvg=;
        b=W111dFvztp2AwP3iEaNVoLHBiVHfj2uXkN26q9h+Qzx0HzIiKJm0LqsadNpnLGauDi
         X0HzmL36IczkNeHE2LbOtYI1Wf27Hq1g3r37hfWx1GACcC8HONFl2OQrxMVW725t3pnR
         V8EkFgvS8EVrbk0RGWpk7CkIyV0KnPgBlqH8yy8nik/gfaqD9QOlWg0t7zHWIZDW+Pkv
         v/j+k8oaDFv1TdefTBVfHOXZVQGZxafg89VMLvr3jFTofEGLvzKCqSJGrSGyxC1RMJxG
         0aSdCn2PoYdDJIHivGKnNzDp9wkQLim9IamPt/siJGswIUq9jpXGsOaKPEN0jRG1obI2
         SSPw==
X-Gm-Message-State: AA+aEWYRcfYYFcqwMB5DrVqZyUrH+Xe8qnghs8eH6Z4YQoGiZ4z8n1OT
        dmt8to+qgjs7a9Qp5eFhG3OT3a/p
X-Google-Smtp-Source: AFSGD/V5JXh6a/UZTHbEJFCuvYDZAwUB7Ni9dEJnJV4GtUJUS7rOqldhlakBZMjuU5vVUIix7LzUkA==
X-Received: by 2002:a24:2b43:: with SMTP id h64-v6mr3632624ita.115.1542497540142;
        Sat, 17 Nov 2018 15:32:20 -0800 (PST)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id y1sm2219434itb.29.2018.11.17.15.32.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 15:32:19 -0800 (PST)
Date:   Sat, 17 Nov 2018 18:32:17 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v3 0/1] Fix scissors bug during merge conflict
Message-ID: <cover.1542496915.git.liu.denton@gmail.com>
References: <cover.1542380929.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1542380929.git.liu.denton@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 17, 2018 at 05:06:43PM +0900, Junio C Hamano wrote:
> Are we already sometimes adding a scissors line in that file?  The
> impression I was getting was that the change in the step 2/2 is the
> only reason why this becomes necessary.  In which case this change
> makes no sense as a standalone patch and requires 2/2 to be a
> sensible change, no?
> 

My mistake, I guess I went a little overboard trying to split my
contribution into digestable patches.

> > @@ -798,7 +807,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
> >  		struct ident_split ci, ai;
> >  
> >  		if (whence != FROM_COMMIT) {
> > -			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
> > +			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
> > +				!merge_contains_scissors)
> >  				wt_status_add_cut_line(s->fp);
> >  			status_printf_ln(s, GIT_COLOR_NORMAL,
> >  			    whence == FROM_MERGE
> 
> This one is done before we show a block of text, which looks correct.
> 
> > @@ -824,7 +834,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
> >  				  " Lines starting\nwith '%c' will be ignored, and an empty"
> >  				  " message aborts the commit.\n"), comment_line_char);
> >  		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
> > -			 whence == FROM_COMMIT)
> > +			 whence == FROM_COMMIT &&
> > +			 !merge_contains_scissors)
> >  			wt_status_add_cut_line(s->fp);
> >  		else /* COMMIT_MSG_CLEANUP_SPACE, that is. */
> >  			status_printf(s, GIT_COLOR_NORMAL,
> 
> The correctness of this one in an if/elseif/else cascade is less
> clear.  When "contains scissors" logic does not kick in, we just
> have a scissors line here (i.e. the original behaviour).  Now when
> the new logic kicks in, we not just omit the (extra) scissors line,
> but also say "Please enter the commit message..." which is the
> message used with the "comment line char" mode of the clean-up.
> 
> I wonder if this is what you really meant to have instead:
> 
> >  		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
> > -			 whence == FROM_COMMIT)
> > - 			wt_status_add_cut_line(s->fp);
> > +			 whence == FROM_COMMIT) {
> > +			 if (!merge_contains_scissors)
> > +				wt_status_add_cut_line(s->fp);
> > +		}
> >  		else /* COMMIT_MSG_CLEANUP_SPACE, that is. */
> >  			status_printf(s, GIT_COLOR_NORMAL,
> 
> That is, the only behaviour change in "merge contains scissors"
> mode is to omit the cut line and nothing else.

Thanks for catching this. I noticed that the originally behaviour is
buggy too: in the case where we're merging a commit and scissors are
printed from the `if (whence != FROM_COMMIT)` block, the original
behaviour would drop us into the else (COMMIT_MSG_CLEANUP_SPACE)
statement, which is undesired. With this fix, the message about `#`
_not_ being removed is now silenced in both cases.

Changes since V1:
	* Only check MERGE_MSG for a scissors line instead of all prepended
	  files
	* Make a variable static in merge where appropriate
	* Add passthrough options in pull
	* Add documentation for the new option
	* Add tests to ensure desired behaviour

Changes since V2:
	* Merge both patches into one patch
	* Fix bug in help message printing logic

Denton Liu (1):
  merge: add scissors line on merge conflict

 Documentation/merge-options.txt |  6 +++++
 builtin/commit.c                | 20 ++++++++++----
 builtin/merge.c                 | 16 +++++++++++
 builtin/pull.c                  |  6 +++++
 t/t7600-merge.sh                | 48 +++++++++++++++++++++++++++++++++
 5 files changed, 91 insertions(+), 5 deletions(-)

-- 
2.19.1

