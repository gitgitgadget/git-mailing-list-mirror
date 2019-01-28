Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7C4A211B5
	for <e@80x24.org>; Mon, 28 Jan 2019 13:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfA1NF2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 08:05:28 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53014 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1NF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 08:05:28 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so13919134wml.2
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 05:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d3U72MxOqtvdaanp7QrZD+hdtv6t2+pmqn1Pp0lz11s=;
        b=Aec47+yCZMfbDbwyLWcjxBGbd4+tdUa1xtqDzuX7nfpndzbaDV3eRWDg5XRM04Z+Sk
         plpaaIMWFJ3BeS/eUPpfocSDZJGVgxrSbNQFwlspjPdzFz7R2FnYwWH61GoXikszX6b7
         8aQk3robdE8o6WmlilK0yrhaJCCg067tn3TaC05B9cJGmI+NjcbIoV0S6GeW6pa/J3Mc
         Tl7xmXEw8CBVih3cwMRH4k9mx4RWrPabad8tk6o05NEly0P7X3REdwtfVPWELpsSSDOC
         7T8HyxQIkfj9OvtiVBKJMNMrTbvP8CEZyGLmoRscSLNfRrrRdmrBGfP86su2zgIvxfDj
         axKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d3U72MxOqtvdaanp7QrZD+hdtv6t2+pmqn1Pp0lz11s=;
        b=OyURBKgtjbJRrvEFZDVOvWLsoKb+H5dZTR3wpGeYLmls5YKTOu/QKYVTHl+uPF3ahx
         9jvkE/heGY7aG/5EBUUbQ52e399cIAcrDDn0mRaVTcYTbiZK062sjELeyY7xji6M54S/
         +Ye1I85UVBb+6/gzWizs8xQp9tA88cImwaT0oDdA5p2h2ZkpJJB3gGm7sJDLhF2H5o4m
         dgXxEby68jnlfQjYLXjPUum3XdgcdGI8WV7K1QrDVyU2F8YdXXjhEwN+qvFFSJ/946pS
         5mcGJFerxzIDWxIGfbmvBnhlXR1RxRdXhTLLdaNgTarh4axaQzR1v9ltlXErJh77gGv0
         JLSw==
X-Gm-Message-State: AJcUukeotLrlopP49+/tdAMfd86W8XB1bdpukFNuca/QoZ3+wSMyPEig
        qpysTx+yXsiLAZeeG/sgFK7vj0Uk
X-Google-Smtp-Source: ALg8bN4Jtf75LYEmjRXnMFyypB/rg/W1zSFhE3j3WkmZQ18J5ITl2vbsQ1Tozt26G2cK24urgz4pfw==
X-Received: by 2002:a1c:2e0c:: with SMTP id u12mr17113996wmu.81.1548680725218;
        Mon, 28 Jan 2019 05:05:25 -0800 (PST)
Received: from szeder.dev (x4dbd8aa4.dyn.telefonica.de. [77.189.138.164])
        by smtp.gmail.com with ESMTPSA id t5sm50960392wmg.43.2019.01.28.05.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 05:05:24 -0800 (PST)
Date:   Mon, 28 Jan 2019 14:05:13 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     sxenos@google.com
Cc:     git@vger.kernel.org, Stefan Xenos <sxenos@gmail.com>
Subject: Re: [PATCH v2 2/8] sha1-array: Implement oid_array_readonly_contains
Message-ID: <20190128130513.GA12887@szeder.dev>
References: <20190127194128.161250-1-sxenos@google.com>
 <20190127194128.161250-2-sxenos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190127194128.161250-2-sxenos@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 27, 2019 at 11:41:22AM -0800, sxenos@google.com wrote:
> From: Stefan Xenos <sxenos@gmail.com>
> 
> Implement a "readonly_contains" function for oid_array that won't
> sort the array if it is unsorted. This can be used to test containment in
> the rare situations where the array order matters.
> 
> The function has intentionally been given a name that is more cumbersome
> than the "lookup" function, which is what most callers will will want
> in most situations.
> 
> Signed-off-by: Stefan Xenos <sxenos@google.com>
> ---
>  sha1-array.c               | 15 +++++++++++++++
>  sha1-array.h               |  2 ++
>  t/helper/test-sha1-array.c |  6 ++++++
>  t/t0064-sha1-array.sh      | 22 ++++++++++++++++++++++
>  4 files changed, 45 insertions(+)
> 
> diff --git a/sha1-array.c b/sha1-array.c
> index b94e0ec0f5..071fce7e90 100644
> --- a/sha1-array.c
> +++ b/sha1-array.c
> @@ -26,6 +26,21 @@ static const unsigned char *sha1_access(size_t index, void *table)
>  	return array[index].hash;
>  }
>  
> +int oid_array_readonly_contains(const struct oid_array* array,
> +	const struct object_id* oid)
> +{
> +	int i;
> +	if (array->sorted) {
> +		return sha1_pos(oid->hash, array->oid, array->nr, sha1_access) >= 0;
> +	}

Style nit: unnecessary braces.  According to CodingGuidelines we tend
not to use braces when the body of a loop or if statement is only a
single line.

> +	for (i = 0; i < array->nr; i++) {
> +		if (hashcmp(array->oid[i].hash, oid->hash) == 0) {

Please use oideq() instead.

> +			return 1;
> +		}
> +	}
> +	return 0;
> +}
> +
>  int oid_array_lookup(struct oid_array *array, const struct object_id *oid)
>  {
>  	if (!array->sorted)

> diff --git a/t/t0064-sha1-array.sh b/t/t0064-sha1-array.sh
> index 5dda570b9a..c1bac6fcdd 100755
> --- a/t/t0064-sha1-array.sh
> +++ b/t/t0064-sha1-array.sh
> @@ -32,6 +32,28 @@ test_expect_success 'ordered enumeration with duplicate suppression' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'readonly_contains finds existing' '
> +	echo 1 > expect &&
> +	echoid "" 88 44 aa 55 >> expect &&

Style nit: not space between redirection operator and filename.

> +	{
> +		echoid append 88 44 aa 55 &&
> +		echoid readonly_contains 55 &&
> +		echo for_each
> +	} | test-tool sha1-array >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'readonly_contains non-existing query' '
> +	echo 0 > expect &&
> +	echoid "" 88 44 aa 55 >> expect &&
> +	{
> +		echoid append 88 44 aa 55 &&
> +		echoid readonly_contains 33 &&
> +		echo for_each
> +	} | test-tool sha1-array >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'lookup' '
>  	{
>  		echoid append 88 44 aa 55 &&
> -- 
> 2.20.1.495.gaa96b0ce6b-goog
> 
