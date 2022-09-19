Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D734EECAAA1
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 16:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiISQmX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 12:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiISQmU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 12:42:20 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8174424BD8
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:42:19 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id s18so18013987qtx.6
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=prpZ4qldCOv0Ia/kuoAqYne/wRFXPkfvM5+xT3d7Ccs=;
        b=PYQp2Jc0XaIzHAl8ZBGbV1ERfAldfk7QRT/hFVXCx+/IdJQ3NipVbdS4qkc71P0zw2
         IJ21EnuWYazeTg3p5OHl0VYIlJ9egHXjNbjDGw+F6mojYdet+dWWktiDFIe1KgFuzxps
         qQ6hbGLu25EOYLSqGALS/aT4Meb9hryYPzTxfT8g01mYjHFWQ7BBDdStoc5m8MNLgyeF
         SnjTKlg2BkPfLZF7w1+QErGVPolDJTSo8jE0+HbFKu5dLNYzC9dE9B88YJR1ryYuP/tQ
         YzJDybSKIMEpI+Ui7EHyI01tfa0V++vtK6APwMD5NInp3aycuVTdz2PAglF7CvuZRwJl
         gb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=prpZ4qldCOv0Ia/kuoAqYne/wRFXPkfvM5+xT3d7Ccs=;
        b=gmzPal+D4lwpjR1X6mfpJptuGRw5H9TRR2tknBWrs0iPfnem5aMCiwhz6wEWVc+zwN
         rk4RBfRmLagDpr0yRvCxN93IlhJuqhuE/GJQEylFq4UlzrcHAYJdtmVrzWOBg7jzu047
         ttuN9Xx0QAQMjOgn8fXzp2BgaArYbH5e+jjxp/I6gcMTrLBaoI1U6A3VZLzLVqMvI1Sk
         ekTKmPJOwqkp0UqaVC6wwqmLCUpjGCNxv9rkqinrjCNs/59nEHkU9eRIBE24gLEyNeGy
         KC4ntCkUNldgqH3I1Qr+NLs8JFXnlLNsQY2pPGJcRTOvuavdE5xNLbCjLhmR/CjY0xJf
         igDA==
X-Gm-Message-State: ACrzQf3SMX9h7dKRF3Hmpar692ZjbjC4UNMvde8Y/LAbRZxsTxl7aqMg
        IgTrCd2IyDj03TRKo+as1gli
X-Google-Smtp-Source: AMsMyM4C1X4sUZaj8tWiIt5AgpKmJXQ2h0pw6z+4bnBOCMvODXTVP6o44bbwAmIYU75QM8JOGbtRRg==
X-Received: by 2002:a05:622a:446:b0:35c:e2c4:7a5d with SMTP id o6-20020a05622a044600b0035ce2c47a5dmr6730311qtx.157.1663605738548;
        Mon, 19 Sep 2022 09:42:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:fd97:43ff:6c00:2cf8? ([2600:1700:e72:80a0:fd97:43ff:6c00:2cf8])
        by smtp.gmail.com with ESMTPSA id u16-20020a05620a0c5000b006bbe7ded98csm12969138qki.112.2022.09.19.09.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 09:42:18 -0700 (PDT)
Message-ID: <0f792d92-62a9-7a4e-787f-7aa39262149d@github.com>
Date:   Mon, 19 Sep 2022 12:42:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 8/8] http: set specific auth scheme depending on
 credential
Content-Language: en-US
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
 <7f827067f55d596284eb2ad764e59d402c75be18.1663097156.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <7f827067f55d596284eb2ad764e59d402c75be18.1663097156.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/13/2022 3:25 PM, Matthew John Cheetham via GitGitGadget wrote:
> From: Matthew John Cheetham <mjcheetham@outlook.com>
> 
> Introduce a new credential field `authtype` that can be used by
> credential helpers to indicate the type of the credential or
> authentication mechanism to use for a request.
> 
> Modify http.c to now specify the correct authentication scheme or
> credential type when authenticating the curl handle. If the new
> `authtype` field in the credential structure is `NULL` or "Basic" then
> use the existing username/password options. If the field is "Bearer"
> then use the OAuth bearer token curl option. Otherwise, the `authtype`
> field is the authentication scheme and the `password` field is the
> raw, unencoded value.


> @@ -524,8 +525,25 @@ static void init_curl_http_auth(struct active_request_slot *slot)
>  
>  	credential_fill(&http_auth);
>  
> -	curl_easy_setopt(slot->curl, CURLOPT_USERNAME, http_auth.username);
> -	curl_easy_setopt(slot->curl, CURLOPT_PASSWORD, http_auth.password);
> +	if (!http_auth.authtype || !strcasecmp(http_auth.authtype, "basic")
> +				|| !strcasecmp(http_auth.authtype, "digest")) {
> +		curl_easy_setopt(slot->curl, CURLOPT_USERNAME,
> +			http_auth.username);
> +		curl_easy_setopt(slot->curl, CURLOPT_PASSWORD,
> +			http_auth.password);
> +#ifdef GIT_CURL_HAVE_CURLAUTH_BEARER
> +	} else if (!strcasecmp(http_auth.authtype, "bearer")) {
> +		curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, CURLAUTH_BEARER);
> +		curl_easy_setopt(slot->curl, CURLOPT_XOAUTH2_BEARER,
> +			http_auth.password);
> +#endif
> +	} else {
> +		struct strbuf auth = STRBUF_INIT;
> +		strbuf_addf(&auth, "Authorization: %s %s",
> +			http_auth.authtype, http_auth.password);
> +		slot->headers = curl_slist_append(slot->headers, auth.buf);
> +		strbuf_release(&auth);
> +	}
>  }

It would be good to have a test here, and the only way I can think
to add it would be to modify one of the test credential helpers to
indicate that OAuth is being used.

The test would somehow need to be careful about the curl version,
though, and I'm not sure if we have prior work for writing prereqs
based on the linked curl version.

Thanks,
-Stolee
