Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9CA91F453
	for <e@80x24.org>; Fri, 28 Sep 2018 13:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeI1UTq (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 16:19:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39964 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbeI1UTq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 16:19:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id s5-v6so4392193pfj.7
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 06:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ih1IRQB5JvPmWOH+vEKjUxz+cWBard8YL+kkvINPMio=;
        b=NsljpP+josPPdXFXyHuXC4NnKP3tdELlDDUExezwzesAANmutLdUErl4p1f/f1L/C7
         EkivKGmwbKAtjJYcXOye9mCJ/6pPuKHcOzT6oZq6WsAP82mECHjRseBj+mPufcrixLf2
         rWGlkHvjSYGnaEix952V4m590cEiN70t29JyB5eA+Lmi6o2yuOEptmiE3uzCnmkPCdLn
         CxMIXq5HTOd9Sct/Z8Vv9JOgA2WesFy91+GY+iK+1djNDXH5V2q7PDIkTWzGlPLrXY8q
         OqJX5RLkTLFHfJYWjfIuXjDLX9ZUowPrBSfe5yDo/0rIrwPzZ5+GitOBQdXcujRmx4tw
         8HaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ih1IRQB5JvPmWOH+vEKjUxz+cWBard8YL+kkvINPMio=;
        b=ucBkikQylYlzY9emyqsz2qi9Av7nrMXE5YMHXL3yuup5LPG6vRXtSPemNyLLnbFKAz
         oxdqQ5aCQrG1FFO8xZ5elwjhLgPuC1/+gF5ISjG+vK6Xhu+EYSiau7revPjwXE9TEbeq
         zFEThgMpy11u0s0JAqc7+PQB1NOiXvw/Xr8C0Sqkb60zQ35i1s+q63kkhx9tG+zK49m3
         dTdwV/toAePS1K2+kD3hik21UEJ1/qS+13+xD9dcTMK8ssTbaxApQAzgmI+OXhGZ+i9R
         LBhIQCfl6pryDC4YaxdZ2M3VyPXoywWNFbk4rQ0kLMjRMcvDQX8hAdX1fNB7JRtwfdZO
         gjsA==
X-Gm-Message-State: ABuFfogJJmUyNyJgi8zGF6k+wdHUfj5lIx3sVaTJS4e+llXmLiEy+Jw7
        +Fl2D/pnEFIfhBoAIqosvsbbqFZ/i76X9g==
X-Google-Smtp-Source: ACcGV61P+af1BBCDSmv48HkKQMcMMFWBgoe7C23vJ0DS/lhRafyV0muU2HPs/W0kHdB0vKyTspcwOg==
X-Received: by 2002:a62:3ac8:: with SMTP id v69-v6mr16923503pfj.164.1538142951749;
        Fri, 28 Sep 2018 06:55:51 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:1924:afac:8279:2210])
        by smtp.gmail.com with ESMTPSA id v83-v6sm13672684pfa.103.2018.09.28.06.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 06:55:50 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Fri, 28 Sep 2018 06:55:49 -0700
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/1] roll wt_status_state into wt_status and populate in
 the collect phase
Message-ID: <20180928135549.GA23652@syl>
References: <xmqqr2i5ueg4.fsf@gitster-ct.c.googlers.com>
 <20180928044936.2919-1-ischis2@cox.net>
 <20180928044936.2919-2-ischis2@cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928044936.2919-2-ischis2@cox.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 09:49:36PM -0700, Stephen P. Smith wrote:
> When updating the collect and print functions, it was found that
> status variables were initialized in the collect phase and some
> variables were later freed in the print functions.

Nit: I think that in the past Eric Sunshine has recommended that I use
active voice in patches, but "it was found" is passive.

I tried to find the message that I was thinking of, but couldn't, so
perhaps I'm inventing it myself ;-).

I'm CC-ing Eric to check my judgement.

> Move the status state structure variables into the status state
> structure and populate them in the collect functions.
>
> Create a new funciton to free the buffers that were being freed in the
> print function.  Call this new function in commit.c where both the
> collect and print functions were being called.
>
> Based on a patch suggestion by Junio C Hamano. [1]
>
> [1] https://public-inbox.org/git/xmqqr2i5ueg4.fsf@gitster-ct.c.googlers.com/
>
> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> ---
>  builtin/commit.c |   3 ++
>  wt-status.c      | 135 +++++++++++++++++++++--------------------------
>  wt-status.h      |  38 ++++++-------
>  3 files changed, 83 insertions(+), 93 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 51ecebbec1..e168321e49 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -506,6 +506,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
>
>  	wt_status_collect(s);
>  	wt_status_print(s);
> +	wt_status_collect_free_buffers(s);
>
>  	return s->committable;
>  }
> @@ -1388,6 +1389,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>  		s.prefix = prefix;
>
>  	wt_status_print(&s);
> +	wt_status_collect_free_buffers(&s);
> +
>  	return 0;
>  }
>
> diff --git a/wt-status.c b/wt-status.c
> index c7f76d4758..9977f0cdf2 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -744,21 +744,26 @@ static int has_unmerged(struct wt_status *s)
>
>  void wt_status_collect(struct wt_status *s)
>  {
> -	struct wt_status_state state;
>  	wt_status_collect_changes_worktree(s);
> -

Nit: unnecessary diff, but I certainly don't think that this is worth a
re-roll on its own.

>  	if (s->is_initial)
>  		wt_status_collect_changes_initial(s);
>  	else
>  		wt_status_collect_changes_index(s);
>  	wt_status_collect_untracked(s);
>
> -	memset(&state, 0, sizeof(state));
> -	wt_status_get_state(&state, s->branch && !strcmp(s->branch, "HEAD"));
> -	if (state.merge_in_progress && !has_unmerged(s))
> +	wt_status_get_state(&s->state, s->branch && !strcmp(s->branch, "HEAD"));
> +	if (s->state.merge_in_progress && !has_unmerged(s))
>  		s->committable = 1;

Should this line be de-dented to match the above?

>  }
>
> +void wt_status_collect_free_buffers(struct wt_status *s)
> +{
> +	free(s->state.branch);
> +	free(s->state.onto);
> +	free(s->state.detached_from);
> +}
> +
> +

Nit: too much whitespace between 'wt_status_collect_free_buffers()' and
'wt_longstatus_print_unmerged()' below. I see that there are two
newlines above, but I think that there should just be one.

>  static void wt_longstatus_print_unmerged(struct wt_status *s)
>  {
>  	int shown_header = 0;
> @@ -1087,8 +1092,7 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
>  }

The rest of this patch looks sensible to me, but I didn't follow the
original discussion in [1], so take my review with a grain of salt :-).

Thanks,
Taylor
