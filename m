Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8198C1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 13:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751228AbeFCNaD (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 09:30:03 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42618 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeFCNaC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 09:30:02 -0400
Received: by mail-wr0-f193.google.com with SMTP id w10-v6so40466193wrk.9
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 06:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=36hCjbdwtrTb1aMac+8DrcVxy6jkdPcCn1uFBQdUYAw=;
        b=m+2GTSbAW0/KG+U+1HmeD6pE8hDHhfMIAq3WhwSbFV+Iqj3NwfEB51aGrGYwQR2aMQ
         cBBLMnveCb6gbflu3KoVn3HU0wCnzQpyCZymxdOLtwfSD9eqMsJLm4Gj0g9/CC+u0cCw
         B79+ZAj7QS7OEG8+hyg4gX4cEhENrfmk0hVDOZMbqTAWaMVu0+fSHjAaXR9WSRd/XQXD
         fjPN03cr3U8Ez2eI4NqSaV8GlAxpGuxNJac0pZgpxVrM84t1Zkn5yLGsFKTGjp1/jykl
         NhDZPUgTNeDgVef0NX2M5/KjGPdfIRpx0ip+pYcZT+rYsdnKH1VHYvHQVd5z+JO4IvQk
         6FQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=36hCjbdwtrTb1aMac+8DrcVxy6jkdPcCn1uFBQdUYAw=;
        b=TNiNI9p9Pu3z4OaRUJ8zAOfzOeiUnhgsr5vImUPAYYEkV+BN3+2kTwYaentN6O2p2x
         6ZEEDhBOO8RYOeLny43j8ZbBPXJAyBO8B27mtC+yl5+7x983mQwwbIEqGaynqy4wzWbo
         212ObWirbyCx6XQcch3GOBqkE00L/O0xWFmHSSabwTduR431ti7ab0oaEPdu1BpL7vwt
         MXeR8CvyTNk5qrsEGmUyGx/rqXomCmtHtagSW+w5EH75A+dDoI9odrk12uNhhiE5RGLq
         IYNZCkXw8mxbsTg11LeYqST6on0JhrtjuQDgJJI1xuTASJUMcPQE+d27AWjOjFqp/LW8
         7BTA==
X-Gm-Message-State: ALKqPweT68ozeYNF1IDocceQ4wGpcxCfLGLxX4FdT/1GMvl8DU0FDndf
        S8iF+QUdMeNo3XeCpravEkc=
X-Google-Smtp-Source: ADUXVKK7hri9C1p1ABwcopGrdqUUp3uGZot7xI99ov8FgC9rNHTxoCwlvqCQVhCYXJaMEb211O7Xwg==
X-Received: by 2002:adf:bb10:: with SMTP id r16-v6mr13026873wrg.244.1528032601178;
        Sun, 03 Jun 2018 06:30:01 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id s2-v6sm22664836wrn.75.2018.06.03.06.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Jun 2018 06:30:00 -0700 (PDT)
Date:   Sun, 3 Jun 2018 14:30:39 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] t/perf/run: Use proper "--get-regexp", not
 "--get-regex"
Message-ID: <20180603133039.GF26159@hank.intra.tgummerer.com>
References: <alpine.LFD.2.21.1806030613080.7681@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1806030613080.7681@localhost.localdomain>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Subject: [PATCH v2] t/perf/run: Use proper "--get-regexp", not

micronit: we prefer starting with a lowercase letter after the "area:"
prefix in commit messages.   Junio can probably fix that while
queuing, so no need to resend.

On 06/03, Robert P. J. Day wrote:
> 
> Even though "--get-regex" appears to work with "git config", the
> clear standard is to spell out the action in full.

--get-regex works as the parse-option API allows abbreviations of the
full option to be specified as long as the abbreviation is
unambiguos.  I don't know if this is documented anywhere other than
'Documentation/technical/api-parse-options.txt' though.

> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> 
> ---

It took me a bit to figure out why there is a v2, and what changed
between the versions.  This space after the '---' would be a good
place to describe that to help reviewers.

For others that are curious, it seems like the word "clear" was added
in the commit message.

The change itself looks good to me.

> this is the only occurrence i saw of this in the entire code base, so
> it seemed worth tweaking just for consistency.
> 
> diff --git a/t/perf/run b/t/perf/run
> index 9aaa733c7..fb5753ea2 100755
> --- a/t/perf/run
> +++ b/t/perf/run
> @@ -110,7 +110,7 @@ run_dirs () {
>  get_subsections () {
>  	section="$1"
>  	test -z "$GIT_PERF_CONFIG_FILE" && return
> -	git config -f "$GIT_PERF_CONFIG_FILE" --name-only --get-regex "$section\..*\.[^.]+" |
> +	git config -f "$GIT_PERF_CONFIG_FILE" --name-only --get-regexp "$section\..*\.[^.]+" |
>  	sed -e "s/$section\.\(.*\)\..*/\1/" | sort | uniq
>  }
> 
> 
> -- 
> 
> ========================================================================
> Robert P. J. Day                                 Ottawa, Ontario, CANADA
>                   http://crashcourse.ca/dokuwiki
> 
> Twitter:                                       http://twitter.com/rpjday
> LinkedIn:                               http://ca.linkedin.com/in/rpjday
> ========================================================================
