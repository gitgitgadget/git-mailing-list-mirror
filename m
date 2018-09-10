Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07D1F1F404
	for <e@80x24.org>; Mon, 10 Sep 2018 05:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbeIJKSP (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 06:18:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44783 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeIJKSP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 06:18:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so9836739pff.11
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 22:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aYp1TLbvABw0axDPAiv/NIGfAGUtwqVKf0BcQ1NTsMo=;
        b=K0SEZOljz1A2S4EDOLpq+RegunJA/GEI4oY5bI6FI0qRkoRhtlCbVBRD2BPi4ZmEmI
         DmdtimsWuon8kZ0N6vXqWzYgpowGyR6TuqiIVvwOmLnbLubvoHAxHa7uRnOsscIcSBXA
         faCy2ClHE1OdDoW2D/ph/c2Uo3z3zcSFE2cNHZDYdNcPMXSW4+zBKKIiGx0gu3Zf0HY7
         +Eqpzaejr4V5ETGh2LEe+oqwT7QuTUgY8N1ebkXgOeI1OBwtWoN6OmpeiqzySFefNxlm
         wIaRps661mQWfcfoT4GfTblzLq0U7q/DBPEG1w0aMUxATPXa7s9gdouEEHRZOd1v7p0C
         yVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aYp1TLbvABw0axDPAiv/NIGfAGUtwqVKf0BcQ1NTsMo=;
        b=r4VeiLwmkfazTEqgXxPPTMinq1iHQF+bq9kLgNQPUQ1uB9bhwiYHqfJ1FKB4rH+Nfc
         0wqpG4lCuQXnCL7jDU8HfU5ALtsBvK5M8YtomInYzapLJ+1zEuoFczVbbgGjrHD7O++O
         jTWPZ70M8tfZFOk7pvd1S4gVQg28rpUDcKUibQi7+Tj73oXT2i/qHmCzKWq4YLkuvrDV
         DrLtIuTsP3lO2nLfnFB7/Y3YyHzv7etrbBu3hC5Y4Q9m1Q17ZcdyHJYBB5eRiGgGV7wk
         utg+PFK8+fQcL9963DbguW4/N5axE1IsBkJre83lab6fwlKh0SXnMbqcgl5KVqcvo71S
         2UJQ==
X-Gm-Message-State: APzg51D660fpIAdVAHdNCEzjse4pwz/5LmccUipSey61DoUBd3N79AWC
        sGk5mzXvZzosCMwvoyfe0meA02Bb
X-Google-Smtp-Source: ANB0VdZHW04umVZSax3jDDU10KWiorhVo/VlemBsHertykbslDd7j2jJWZXaeHQoQi7A3S5zWsmrlg==
X-Received: by 2002:a62:2483:: with SMTP id k3-v6mr21925233pfk.195.1536557160308;
        Sun, 09 Sep 2018 22:26:00 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id c8-v6sm22127152pfb.147.2018.09.09.22.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Sep 2018 22:25:59 -0700 (PDT)
Date:   Sun, 9 Sep 2018 22:25:58 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Max Kirillov <max@max630.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Subject: Re: [PATCH v4] http-backend: allow empty CONTENT_LENGTH
Message-ID: <20180910052558.GB55941@aiede.svl.corp.google.com>
References: <20180907033607.24604-1-max@max630.net>
 <20180909041016.23980-1-max@max630.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180909041016.23980-1-max@max630.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Kirillov wrote:

> Reported-By: Jelmer Vernooĳ <jelmer@jelmer.uk>
> Authored-by: Jeff King <peff@peff.net>
> Signed-off-by: Max Kirillov <max@max630.net>

Nit: for this kind of case of forwarding someone else's patch, we put
a From field at the beginning of the body of the message.  "git
format-patch" can produce a message with that format if you commit
with 'git commit --author="Someone Else <person@example.com>"' and run
format-patch with --from="My Name <me@example.com>".  More details are
in the DISCUSSION section of git-format-patch(1).

As with v3, since v2 is already in "next" this should go incremental.

[...]
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -353,8 +353,28 @@ static ssize_t get_content_length(void)
>  	ssize_t val = -1;
>  	const char *str = getenv("CONTENT_LENGTH");
>  
> -	if (str && !git_parse_ssize_t(str, &val))
> -		die("failed to parse CONTENT_LENGTH: %s", str);
> +	if (!str) {
> +		/*
> +		 * RFC3875 says this must mean "no body", but in practice we
> +		 * receive chunked encodings with no CONTENT_LENGTH. Tell the
> +		 * caller to read until EOF.
> +		 */
> +		val = -1;
> +	} else if (!*str) {
> +		/*
> +		 * An empty length should be treated as "no body" according to
> +		 * RFC3875, and this seems to hold in practice.
> +		 */
> +		val = 0;

Are there example callers that this version fixes?  Where can I read
more, or what can I run to experience it?

For example, v2.19.0-rc0~45^2~2 (http-backend: respect CONTENT_LENGTH
as specified by rfc3875, 2018-06-10) mentions IIS/Windows; does IIS
make use of this distinction?

Thanks,
Jonathan
