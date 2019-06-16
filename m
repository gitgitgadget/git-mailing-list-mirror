Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33F241F462
	for <e@80x24.org>; Sun, 16 Jun 2019 07:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfFPHFy (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 03:05:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45392 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfFPHFy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jun 2019 03:05:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id bi6so2768344plb.12
        for <git@vger.kernel.org>; Sun, 16 Jun 2019 00:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LPDht/tokuW+sIM8Yt+0yQX3N7QKuh/9hzyNW4eEYHM=;
        b=noauhlJ3/RGL7Il3LxfsiXIV4Ig0YpEQ5Gg64d+BIr7dBL3p2RMNJzrXWRje87HffN
         fgh2n6MJE7FuwbcOhihZQdJeAHglcv3M6A98GpdWctdWYdreO5dnUV5Og03+WDT956B7
         e399hnDAUKzS0QY/ONbzbg5wZIJPMRsYroYOG/9ytfSrGA49zcBrFmKSMdFj0MjcwcQt
         jiKq8mRXQW9JIhANWDj+gqid767ozKugG7OLt8cuk7qUhcN1aWTQF/5eQzQ4iephFmwm
         Dyj03VvOVSxWfKtuWMmnO8blLCqtpZTUTQcLFBeMrsPv/X9c9Gu1MVJT8GR34IMMgOmA
         Tb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LPDht/tokuW+sIM8Yt+0yQX3N7QKuh/9hzyNW4eEYHM=;
        b=VMuapctiMHKlcxUKQCVhFF+ekS5xLeLxxxTSQUtCgb0+A11pmYacVY/1F/a4XD1p8/
         YROWlbmiZxrtsgonQdxXpwjYwrvPt44zSPUElr+jGqxEiXuEevqzGekb5edmyE565zgg
         Wcn6AauQpyjYy3ZlcLHbvNjvzwSXUtFykSkvPRLKUj4g+H3k7tpFVzbF3lIGa2eqt8q2
         oIoI0RDA/T160y+KJCHKLWmlMiJNrRMg7YJAq/B2lvrTSd9ecNtfD8mQWfdkdGDvzSeX
         2C8iAxOaB7n8Qft462QIjUDAWKenpjO+/qWS8PtDKZGTPwloxRRdHdpyC/rtHmRNqI1P
         AX+w==
X-Gm-Message-State: APjAAAWTHkpYoAaRjqt+4j9b2yZ0NVkDfmqLrrSlCKRpyh8FDey4oZKk
        mcX3rpEaCzgp6a7V6qu2MqU=
X-Google-Smtp-Source: APXvYqw6fWl7WBMKiH+tLOwxgNF8KIvXCj1KxgmYSOBhUDw7dehkHnYdGnZWwHXuOGGTs16ZHrsNyw==
X-Received: by 2002:a17:902:222:: with SMTP id 31mr47721546plc.55.1560668753545;
        Sun, 16 Jun 2019 00:05:53 -0700 (PDT)
Received: from ar135.iitr.local ([2401:4900:3105:6dd7:dda4:73f9:64d1:d043])
        by smtp.gmail.com with ESMTPSA id u20sm7338877pgm.56.2019.06.16.00.05.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 00:05:52 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, newren@gmail.com, phillip.wood123@gmail.com,
        rohit.ashiwal265@gmail.com, t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH v3 2/3] cherry-pick/revert: add --skip option 
Date:   Sun, 16 Jun 2019 12:33:34 +0530
Message-Id: <20190616070334.8834-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <xmqqa7elwer9.fsf@gitster-ct.c.googlers.com>
References: <xmqqa7elwer9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

I am sorry, I missed to reply to these.

On 2019-06-13 17:56 UTC Junio C Hamano <gitster@pobox.com> wrote:
>
> > +int sequencer_skip(struct repository *r, struct replay_opts *opts)
> > +{
> > +	enum replay_action action = -1;
> > +	sequencer_get_last_command(r, &action);
> > +
> > +	switch (opts->action) {
> > +	case REPLAY_REVERT:
> > +		if (!file_exists(git_path_revert_head(r))) {
> > +			if (action == REPLAY_REVERT) {
> > +				if (!rollback_is_safe())
> > +					goto give_advice;
> > +				else
> > +					break;
> > +			}
> > +			return error(_("no revert in progress"));
> > +		}
> 
> This part probably deserves a bit of in-code comment.
> 
>     The Git subcommand (i.e. opts->action) tells us that we are
>     asked to "git revert --skip".  When REVERT_HEAD is not there, we
>     look at the last command of the sequencer state and make sure it
>     is 'revert'; all other cases we barf.
> 
> That much we can read from the code.  But what are "all other cases"?
> Do we cover a single-revert case (i.e. "git revert <commit>" got
> conflict and the user is saying "git revert --skip")?

Yes, we actually cover the single-revert case. Let's say there were
some conflicts then either .git/REVERT_HEAD will exist allowing
`git revert --skip` it's way or the user has already dealt with it
and committed his way in which case .git/REVERT_HEAD will be removed
and reverting ends (as it should).

> Was the user
> in the middle of "git rebase -i" and the last command before we gave
> the control back was 'pick'?

rebase -i creates different directories so, we are sure that --skip
does not skip in middle of a rebase. Am I right?

Hope these answers your questions
-- Rohit

