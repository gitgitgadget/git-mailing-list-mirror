Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DDFC433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 13:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237943AbiEXNuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 09:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbiEXNuH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 09:50:07 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C0F954B5
        for <git@vger.kernel.org>; Tue, 24 May 2022 06:50:06 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id t13so4979909ilm.9
        for <git@vger.kernel.org>; Tue, 24 May 2022 06:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CcewG82tMH+GXoaerfKanG+UPS9lCWjG8P/KFJCx5SQ=;
        b=BlOs812qW9DvYGn4h7cAhyNu1BSff+IKuVJqrtKsBmfzZhQ8F+LlcWLvCeCCeirn96
         I6S6AGuX4PEPTgz1d7zUNmTJUM83H8p7HJdFO4ZpHo9x3na9afMBnS0EgJvOc75/likQ
         ZpezlGDZgrAWYLQaP+Fu3AMW4/Jc81D8JQyu3JxCsbhYxq4n10x38emCmxzzsApW4S4G
         U0D41Qq1ed0CYOjgSrzARDmrj7M78+xkhyzBnhY0g6Iu/lLU9GBgOQJN8la75rV6xcGP
         OSrea+KdhNdgydtW8WZk8eDSQN5QcMPHu3pSBDAAYNTZXGjMJTLhljWydtfOspJeYNt0
         N9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CcewG82tMH+GXoaerfKanG+UPS9lCWjG8P/KFJCx5SQ=;
        b=YXvQ9n6ka4ko7wnVorlV2wdS7efurbMBgYTCksLGqsEagxF12f/iYiASG412pV2P5L
         1vMrlZHDs4UrSto30okz2Rd35B6M1PeB54X7y1N7Vv1bMANfm20AmUbfA92HdQthIcoq
         n4ETDSoEStWFfjbpvI7q8+0w0s8gQCSvq6l4nkg3WVoUVzD9wQRmSauboOuZhInuYnfo
         w9exIbeWJc1YuFqUXSsCZNKKAsY1M9LS2UF864RWhPID22HbPGllU0SlIeI6/kldmTyH
         +mXQcG5NE+Zm5arPkoUUFS4zpdF1LaK8GLg4usEIyCprnB/Cdl54+Tz12g/o8Te8VkVm
         3HPg==
X-Gm-Message-State: AOAM533l6pUx2C8vL2nCmnQ3NYKEXYbPIZH+G9ypR6v7IV/01zA5rQkT
        WyR7eQB9ilWVsXvPniDIXYd3
X-Google-Smtp-Source: ABdhPJwoOAn0zQct8dNpPjqSS8acZ2uGYDqh4bNCcsBPtstVD7dDCLxgIeZ4Sp3F21feJiLkXfeBsA==
X-Received: by 2002:a05:6e02:190c:b0:2d1:5504:7635 with SMTP id w12-20020a056e02190c00b002d155047635mr14086175ilu.214.1653400205481;
        Tue, 24 May 2022 06:50:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9dd7:2c4b:2dbd:828e? ([2600:1700:e72:80a0:9dd7:2c4b:2dbd:828e])
        by smtp.gmail.com with ESMTPSA id e15-20020a056e0204af00b002d119aed826sm4635818ils.14.2022.05.24.06.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 06:50:05 -0700 (PDT)
Message-ID: <0dc38d46-7c5a-5532-c843-ef3c8b6cfa28@github.com>
Date:   Tue, 24 May 2022 09:50:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] urlmatch: create fetch.credentialsInUrl config
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        me@ttaylorr.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>
References: <pull.1237.git.1653329044940.gitgitgadget@gmail.com>
 <220524.8635gzxr9h.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220524.8635gzxr9h.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/24/2022 4:18 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, May 23 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> +fetch.credentialsInUrl::
>> +	A URL can contain plaintext credentials in the form
>> +	`protocol://<user>:<password>@domain/path`. Using such URLs is not
>> +	recommended as it exposes the password in multiple ways. The
>> +	`fetch.credentialsInUrl` option provides instruction for how Git
>> +	should react to seeing such a URL, with these values:
> 
> Re the previous discussion about this (in the v1 patch /
> https://lore.kernel.org/git/pull.945.git.1619807844627.gitgitgadget@gmail.com/):
> In what ways?
> 
> That's rhetorical, the point being: Let's adjust this documentation to
> discuss exactly why this is thought to be bad, what we're mitigating for
> the user etc., are there situations where running git like this is
> perfectly fine & not thought to be an issue? E.g. no password manager
> and you trust your FS permission? Let's cover those cases too.

This documentation is not the proper place to tell the user "do this
and you can trust your plaintext creds in the filesystem" because that
is asking for problems. I'd rather leave a vague warning and let users
go against the recommended behavior only after they have done sufficient
work to be confident in taking on that risk.
 
>> ++
>> +* `ignore` (default): Git will proceed with its activity without warning.
>> +* `warn`: Git will write a warning message to `stderr` when parsing a URL
>> +  with a plaintext credential.
>> +* `die`: Git will write a failure message to `stderr` when parsing a URL
>> +  with a plaintext credential.
> 
> You're implementing this with strcasecmp, so we also support DIE, DiE
> etc. Let's not do that and use strcmp() instead.

Sure.

>> +static void detected_credentials_in_url(const char *url, size_t scheme_len)
>> +{
> 
> Just generally: This is only 

Did you intend to say more here?

>> +	char *value = NULL;
> 
> This init to NULL should be removedd, as we....
> 
>> +	const char *at_ptr;
>> +	const char *colon_ptr;
>> +	struct strbuf anonymized = STRBUF_INIT;
> 
> nit: Just call this "sb"? The's at least one line below over 79
> characters that's within the bounds with a shorter variable name, and in
> this case it's obvious what we're doing here...

I will not change this name to be less descriptive.

>> +
>> +	/* "ignore" is the default behavior. */
>> +	if (git_config_get_string("fetch.credentialsinurl", &value) ||
> 
> ...initialize it here, and if we didn't the compiler would have a chance
> to spot that if we were getting it wrong.

We do not necessarily initialize it here. The compiler doesn't notice
it and the free(value) below segfaults.

>> +	    !strcasecmp("ignore", value))
>> +		goto cleanup;
>> +
>> +	at_ptr = strchr(url, '@');
>> +	colon_ptr = strchr(url + scheme_len + 3, ':');
>> +
>> +	if (!colon_ptr)
>> +		BUG("failed to find colon in url '%s' with scheme_len %"PRIuMAX,
>> +		    url, (uintmax_t) scheme_len);
>> +
>> +	/* Include everything including the colon. */
>> +	colon_ptr++;
>> +	strbuf_add(&anonymized, url, colon_ptr - url);
>> +
>> +	while (colon_ptr < at_ptr) {
>> +		strbuf_addch(&anonymized, '*');
>> +		colon_ptr++;
>> +	}
> 
> Could we share code with 88e9b1e3fcb (fetch-pack: redact packfile urls
> in traces, 2021-11-10), or for consistency note this as <redacted>
> instead of stripping it out, as we do for that related URL-part
> redaction?

I'm happy to replace the asterisks with <redacted>. Otherwise, I don't
see anything we can do to share across these methods. Specifically,
the test in that commit seems to indicate that the redacted portion is
only the packfile name (the $HTTPD_URL is not filtered).

>> +	strbuf_addstr(&anonymized, at_ptr);
> 
> Maybe not worth it, but I wondered if we couldn't just use curl for
> this, turns out it has an API for it:
> https://curl.se/libcurl/c/libcurl-url.html
> 
> But it's too new for us to rely on unconditionally, but we could add
> that to git-curl-compat.h and ifdef it, then we'll eventually drop this
> custom code for ryling on the well-tested library.
> 
> I think doing that would be worth it, to show future authors that curl
> can do this, so maybe we can start relying on that eventually...

Since we can't rely on it, I'll leave that to another (you, perhaps?)
to do that ifdef work. I don't think it's worth it right now.

>> +	if (!strcasecmp("warn", value))
>> +		warning(_("URL '%s' uses plaintext credentials"), anonymized.buf);
>> +	if (!strcasecmp("die", value))
>> +		die(_("URL '%s' uses plaintext credentials"), anonymized.buf);
>> +
>> +cleanup:
>> +	free(value);
> 
> I think you can also just use git_config_get_string_tmp() here and avoid
> the alloc/free. That's safe as long as you're not calling other config
> API in-between, which you're not.

OK. And that also avoids the need for initialization you mentioned.

Thanks,
-Stolee
