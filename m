Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0756F1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 02:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeKIMfZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 07:35:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44016 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbeKIMfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 07:35:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id y3-v6so312973wrh.10
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 18:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2bMsl3EiLZB62vvWceCo0INzT/+eZSO9Fn4FLj/l/RA=;
        b=fssjg9IRTrG1VkEnDxoquZMsiVWksDNwXbcDs6Vpf3SYDL68xjMnKNNrGuRh07gZMg
         +w3jjpSJMhipVv7iB/lLE6eybtZstB1xkEicX7DFj8svvyDGo6Q10xsISV7NLXcnvxuj
         8r4IurkbHp5ss64FHtbuAVywPO+3CX2EgHTTSkt2+Z3V1J1C5Sp7mKucRaZN/GtLqJEK
         0UnM2WDeULcBbXlumBhhpPXLY/cAdkK1UoBq15nO3gWOy7YI/WmGZj70q/bmlCt0lMqe
         IuGrEPV8FguJC8kEv4x4SkAKQApCUSeZHFc/UWOBAl/j0372x7bv5hGoLe/2aTubKQQV
         G2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2bMsl3EiLZB62vvWceCo0INzT/+eZSO9Fn4FLj/l/RA=;
        b=V31MsH2jnGItN6Q4QItyU241FsX0uXX+0JRTR3Qq454S7mVY+OaYtWbhYMo7XZOQAo
         yUmmzqoEou/wD0LOXJAWNAGSj1iZ3noDx+LDnGU8h7mG4ZpBktopYJkQoB64fMn5n3cS
         CdQHTlrD51yr8XBmx+CGIMnmCxB07Nz0ukOxz0OeaXVxhW97UrC4qhth896NXdOyLcSQ
         1qSgwZrMuh0Rwm9pUL5CY31aX3S++gaDWChxZxVii/fjTzQkKEH2o0+QEqUV2rlA0Sga
         9F30NCqvp9e1BoLC763RLVuU+iPLBCIXVSKDoQ0VcKZJmAhi93yCUJMoZz8NrT8s4DCP
         +kUQ==
X-Gm-Message-State: AGRZ1gLyRQxWoISAf6SSK9RdbQ6REmqBJAWdP7L+n2XMJq5BHy9DYHkB
        4UoQo0p3tz8tbSJ7TIb3rbc=
X-Google-Smtp-Source: AJdET5f4rZT7wS05+Y87CAMU7LvrNQde72EgR0qwNhdidc3sVza1fipQt2Z+j2rP7BqEV7rfHXdLXg==
X-Received: by 2002:adf:d101:: with SMTP id a1-v6mr6638226wri.17.1541732209646;
        Thu, 08 Nov 2018 18:56:49 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 65-v6sm733657wmj.1.2018.11.08.18.56.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 18:56:48 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Force Charlie via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Force Charlie <charlieio@outlook.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 1/1] http: add support selecting http version
References: <pull.69.v5.git.gitgitgadget@gmail.com>
        <pull.69.v6.git.gitgitgadget@gmail.com>
        <93fda67198441c159bfcf1dfa467ad76f3ecba76.1541660405.git.gitgitgadget@gmail.com>
Date:   Fri, 09 Nov 2018 11:56:47 +0900
In-Reply-To: <93fda67198441c159bfcf1dfa467ad76f3ecba76.1541660405.git.gitgitgadget@gmail.com>
        (Force Charlie via GitGitGadget's message of "Wed, 07 Nov 2018
        23:00:08 -0800 (PST)")
Message-ID: <xmqqzhuj5574.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Force Charlie via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +#if LIBCURL_VERSION_NUM >=0x072f00
> +static int get_curl_http_version_opt(const char *version_string, long *opt)
> +{
> +	int i;
> +	static struct {
> +		const char *name;
> +		long opt_token;
> +	} choice[] = {
> +		{ "HTTP/1.1", CURL_HTTP_VERSION_1_1 },
> +		{ "HTTP/2", CURL_HTTP_VERSION_2 }
> +	};
> +
> +	for (i = 0; i < ARRAY_SIZE(choice); i++) {
> +		if (!strcmp(version_string, choice[i].name)) {
> +			*opt = choice[i].opt_token;
> +			return 0;
> +		}
> +	}
> +

I wonder if we need to give a warning here about an unknown and
ignored value, by calling something like

	warning("unknown value given to http.version: '%s'", version_string);

here.  We should not trigger noisy warning while reading the
configuration file looking for other variables unrelated to
http.version but this codepath is followed only when we know
we need to find out what value the variable is set to, so it
probably is a good thing to do.  

Thoughts?

