Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C696F1F462
	for <e@80x24.org>; Wed, 22 May 2019 00:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfEVA7C (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 20:59:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41526 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfEVA7C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 20:59:02 -0400
Received: by mail-io1-f68.google.com with SMTP id a17so468940iot.8
        for <git@vger.kernel.org>; Tue, 21 May 2019 17:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zsagz2bQdFZGkLR2nSECAIYGtMyI7jBhaXKXGOePe5E=;
        b=unZL6Cob9h3qwJf34uLtzb6cgZLjP5pMXicVIBZdEiqgGdBo9fbuY8QkEujfq9qWc0
         UDtpeg6G9E7nQrGuTptaSyDuxC+Kqe92o+icZ63Qwcz91JZHDVQtSpJ4/Avyi3AKXEaC
         Q2HlCpkGKuaBHZl/Ji5Zs8pFEXW8fQe5Gd/JXNHxEJptc0P3MGpJbisRsI0rz7p/9059
         1DI4mHY28ZGnOatK6l1jT9yN5eZh8ZblGGb82eIquCEf7YuaHIZqulipnj1jM/cxsGRU
         FjdGnMtAT+5dv13IJXdegYwFRAJi61tYrFBVMniKwxGIiRSQSCxc5aBPpfmQsqNW09I5
         kl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zsagz2bQdFZGkLR2nSECAIYGtMyI7jBhaXKXGOePe5E=;
        b=E9i7MElUV8KtCy+cFDTRy8xRLROslQ0bLwn2GRWBkUEJpXtkdIhl3EWzR5e/xFWXxm
         a9N5faV/8/78BNfic0errSg+s4dsGRxm6NNJWZ7QlbJDO84jtk6aD1equb+GphAqogt4
         LK+jcaebrBVjebI0mYgx3suxIQVQ+y7h7PfKM/1E6HfTGLzH02GJmAxAPETG3jCSu2z5
         RoFK6EAiWwTekyrQb/bRWQegkauyyq+/xVyC9CV8OYGnmh5xgVOq9LVjP/63PzmbKyMM
         H8UBcqsSghbLxDt4gQ15dh/agCK/a/82UKeyY9oNixGg32WPn4zNLf9M6D2mTVXVYh+j
         0U0Q==
X-Gm-Message-State: APjAAAU/8YIAus+sjCtMmJFmTHVNgXDjT/Ap9fdCBjrGC9zinby5DXVv
        Ou5ar/roKtUR72wDCs71lro=
X-Google-Smtp-Source: APXvYqzW1kJ7zxMCssvM2iZgAmtkznRE2L27W5BezXjIsNZ1s+ALKPfKHIg8qA00sNeza1uZNZs+cA==
X-Received: by 2002:a6b:7a49:: with SMTP id k9mr30868839iop.73.1558486741057;
        Tue, 21 May 2019 17:59:01 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id q24sm7593952ioh.31.2019.05.21.17.59.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 17:59:00 -0700 (PDT)
Date:   Tue, 21 May 2019 17:58:58 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] grep: provide sane default to grep_source struct
Message-ID: <20190522005858.GB219159@google.com>
References: <20190516214444.191743-1-emilyshaffer@google.com>
 <20190522003402.77767-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522003402.77767-1-emilyshaffer@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:

> Subject: grep: provide sane default to grep_source struct

This subject line doesn't describe what the patch does any more.  How
about something like

	grep: fail early if call could print output and name is not set

?

> grep_buffer creates a struct grep_source gs and calls grep_source()
> with it. However, gs.name is null, which eventually produces a
> segmentation fault in grep_source()->grep_source_1()->show_line()
> when grep_opt.status_only is not set.

This is the place to describe the motivation behind the patch:

- what is the current behavior?
- what is the motivation behind the current behavior?
- in what scenario does it fail?
- how does it fail, and what is undesirable about that failure?

Perhaps something like

	grep_source, the workhorse of Git's grep library, allows passing in an
	arbitrary grep_source representing the haystack in which to search for
	a needle matching a pattern.  In most callers, the grep_source::name
	field is set to an appropriate prefix to print before a colon when a
	result matches:

		README:Git is an Open Source project covered by the GNU General Public

	One caller, grep_buffer, leaves the 'name' field set to NULL because
	there is not enough context to determine an appropriate name to put in
	such output lines.  In practice, this has been fine because the only
	caller of grep_buffer is "git log --grep" and that caller sets
	status_only to disable output (and only check whether a match exists).
	But this is brittle: a future caller can call grep_buffer without
	status_only set, and as soon as it hits a match, grep_source will
	segfault in the process of trying to print

		(null):Git is an Open Source project covered by the GNU General Public

> This seems to be unreachable from existing commands but is reachable in
> the event that someone rolls their own revision walk and neglects to set
> rev_info->grep_filter->status_only. Conceivably, someone might want to
> print all changed lines of all commits which match some regex.

Focusing on the use case instead of the details of how it is implemented,
we can simplify this to

	For example, such a future caller might want to print all matching
	lines from commits which match a regex.

> To futureproof, give developers a heads-up if grep_source() is called
> and a valid name field is expected but not given. This path should be
> unreachable now, but in the future may become reachable if developers
> want to add the ability to use grep_buffer() in prepared in-core data
> and provide hints to the user about where the data came from.

Here we can concisely describe the improved behavior with the fix:

	Futureproof by diagnosing a use of the API that could trigger that
	condition early, before we know whether the pattern matches:

		BUG: git.c:832: grep call which could print a name requires grep_source.name be non-NULL
		Aborted

And then what it makes possible:

	This way, the caller's author gets a quick indication of how to fix
	it, by ensuring that either grep_source.name is set or that
	status_only is set to prevent printing output.

And how it came up:

	Noticed while adding such a call in a tutorial on revision walks.

> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
[...]
> I also moved the BUG() to grep_source_1() to keep it close to the error
> itself and reflowed the commit message.

Makes sense.  Thanks for these summaries of what changed between each
revision of the patch --- they're very helpful.

With whatever subset of the above suggested commit message changes
make sense,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

[...]
> --- a/grep.c
> +++ b/grep.c
> @@ -1780,6 +1780,10 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
>  	enum grep_context ctx = GREP_CONTEXT_HEAD;
>  	xdemitconf_t xecfg;
>  
> +	if (!opt->status_only && gs->name == NULL)

optional: can use !gs->name here.

> +		BUG("grep call which could print a name requires "
> +		    "grep_source.name be non-NULL");
