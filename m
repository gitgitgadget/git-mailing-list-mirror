Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEB1C1F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 16:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754527AbdFLPfl (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 11:35:41 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34317 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754409AbdFLPfh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 11:35:37 -0400
Received: by mail-pg0-f67.google.com with SMTP id v14so14585195pgn.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zd1R5hm+obpZUa/mnv3TnYJUGgfzzvlQhwijOUED3fU=;
        b=ZOqp5Ljo9X3EKxjwRRZdxrNHwLCgb+KaqDXzEvoD0iifryrhWMxgxUtF4e9/eSj9U4
         WwzDEeKL11k8DRtyD+0xxxWanq2vh1cqAoC5FiBA0lcDyuMnnd/uRRF7LvcicOxh/EWj
         YM/kD4Z28udMxI/+iz6SVpQCuyDo6BWaXldy6jCUIIfBEKl/+UzzxL1BSHgqOr9yH6uu
         hOvLJGHRtRxHTpAGka7ej+xElTx4PGEgZ1ssnzqjSEnwx4VJJ816163ujPxA7KJNc+En
         UseOFkVtEV71cT9Cmw/uxdWCoj7GPhgMV3aVKA+7570zzoMy+btqyWVN4VTI20/fwjk6
         B9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zd1R5hm+obpZUa/mnv3TnYJUGgfzzvlQhwijOUED3fU=;
        b=Ed64oCCoLcUjr0keEPJNlt2iILmaRYyleGoDmgoFxnggCks1/5o99kOmHVzRvvyV59
         6h3ZiT9Z9rYpbAbK9pV2b1IvjSyfSdpETifIxmQQuGblgwCz2DTcNeMKE8yWXSyM0PRz
         70vWrTS23qOp8qwywv0YtBWv8hzGdP8E18yrOQ6X7IeK0IpVJW+GhsEBcZaERh8U+WkQ
         W2kRE4g/3VDsIWnSTy8IEY/xGMrs98UwJZyFHk3+9rKl53bi0QNqK8fy28/J0mm7x5ug
         MRfElF/qlr9USrfZD7ZY8OVOVEGmhc+5ARxANltz4/RL8fmux07fVo9XTG+YQ9RdFVHo
         Xadw==
X-Gm-Message-State: AODbwcD0TPPY5D3ngS6tWQ+9jJ3x2bq4/jJ6U6JzD01BSrRvYPA6tZNS
        258awcmOQfOstA==
X-Received: by 10.98.30.129 with SMTP id e123mr57535963pfe.240.1497281726476;
        Mon, 12 Jun 2017 08:35:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:695d:4129:fb97:59df])
        by smtp.gmail.com with ESMTPSA id x12sm18665055pgc.47.2017.06.12.08.35.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 08:35:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     liam Beguin <liambeguin@gmail.com>
Cc:     Jeff King <peff@peff.net>, Samuel Lijin <sxlijin@gmail.com>,
        Houston Fortney <houstonfortney@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Feature Request: Show status of the stash in git status command
References: <CA+B9myHRahTd+FDgzK5AhXW+hq_Y_czMX9X6MXYBcr9WSPeiDw@mail.gmail.com>
        <20170610082534.6437ifexzly4oqg6@sigill.intra.peff.net>
        <CAJZjrdXCHVKQOxR=+z5cOkieKzE-iSMta--kHVjSYXuansb34Q@mail.gmail.com>
        <20170610102217.vxf6tsrdfp6srupr@sigill.intra.peff.net>
        <1c04d689-6796-17d1-e058-18874768c22a@gmail.com>
Date:   Mon, 12 Jun 2017 08:35:24 -0700
In-Reply-To: <1c04d689-6796-17d1-e058-18874768c22a@gmail.com> (liam Beguin's
        message of "Sun, 11 Jun 2017 13:07:03 -0400")
Message-ID: <xmqqpoe9p6bn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

liam Beguin <liambeguin@gmail.com> writes:

> +static int stash_count_refs(struct object_id *ooid, struct object_id *noid,
> +			    const char *email, timestamp_t timestamp, int tz,
> +			    const char *message, void *cb_data)
> +{
> +	int *c = cb_data;
> +	(*c)++;
> +	return 0;
> +}

Count up, and tell the caller to keep going by returning 0.  That
sounds sane.

> +static void wt_longstatus_print_stash_summary(struct wt_status *s)
> +{
> +	int stash_count = 0;
> +
> +	for_each_reflog_ent("refs/stash", stash_count_refs, &stash_count);

And do so with a counter initialized to 0.  Also sane.

> +	if (stash_count > 0)
> +		status_printf_ln(s, GIT_COLOR_NORMAL,
> +				 Q_("Your stash currently has %d commit",
> +				    "Your stash currently has %d commits", stash_count),
> +				 stash_count);

Conceptually, the contents of the stash are *not* commits, even
though the implementation happens to use a commit to represent each
stash entry.  Perhaps "has %d entry/entries" is an improvement, but
a quick scanning of an early part of "git stash --help" tells me
that

	You have 1 stash / You have 4 stashes

would be the best, as the documentation calls each entry "a stash".
E.g. "list" is explained to list "the stashes", and "show <stash>"
is explained to show the changes recorded in "the stash".

> +}
> +
>  static void wt_longstatus_print_submodule_summary(struct wt_status *s, int uncommitted)
>  {
>  	struct child_process sm_summary = CHILD_PROCESS_INIT;
> @@ -1536,6 +1557,7 @@ static void wt_longstatus_print(struct wt_status *s)
>  	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
>  	const char *branch_status_color = color(WT_STATUS_HEADER, s);
>  	struct wt_status_state state;
> +	int show_stash = 0;
>  
>  	memset(&state, 0, sizeof(state));
>  	wt_status_get_state(&state,
> @@ -1641,6 +1663,8 @@ static void wt_longstatus_print(struct wt_status *s)
>  		} else
>  			printf(_("nothing to commit, working tree clean\n"));
>  	}
> +	if (!git_config_get_bool("status.showStash", &show_stash) && show_stash)
> +		wt_longstatus_print_stash_summary(s);
>  }

Try to get "status.showstash" as a boolean, and only when it
succeeds and the value is true, give this extra info (i.e. when the
variable does not exist, do not complain and do not show).  Sounds
sensible.

Overall the logic looks good to me; just the phrasing is
questionable, relative to the existing documentation.

Thanks.
