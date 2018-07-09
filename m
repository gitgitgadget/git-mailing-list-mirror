Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 434BD1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 13:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932742AbeGINJE (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 09:09:04 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38468 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932595AbeGINJD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 09:09:03 -0400
Received: by mail-qk0-f196.google.com with SMTP id y4-v6so9634709qka.5
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 06:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jfUxQdhsdAde6vdMYtDR88ykBeYGF1d6KWE4Ne2oiXk=;
        b=NftW4cZ5YozJX3lznQEryI0MkJwiPbLRSApn/Nd9YmCnJTllgp4EvfqKwftXoRfXGD
         3IEfSMUkYeU8DDd7nOAQ1gFY/ZziLIMrXeni9BII7PskB/i5szNNGFMyDCo/bGazqt1D
         rg30PQCJD7cOeBRQ+dOHr9OfoZOyVKAg3UL8MWmwloGwz/4wzXr1A/xKQCh+K+yQizx8
         3z2SmSWpQF5uFGzFsFmiUKa7/LzI9JkzY4TdVYiwU4IbPAiBgF7WQZdLMXEIIYIcosj1
         CVgvNeCYcH1rzjCdHINW/PQc1cAE+jHRCzq/AxrJEXVsH+SFK8xZTJc76oSsnP0hD22Z
         B/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jfUxQdhsdAde6vdMYtDR88ykBeYGF1d6KWE4Ne2oiXk=;
        b=lLlS5k7LacvhnYf74VZ7fthTtxSjssfn8SI8vVNQy7yZkdVD/E5Jk+mo7XMyWfNYpX
         OTeGQq3q4jfU0zDct97vdwGbHUv+osDr9URm2ReOW3auquPqD/ReCLHWv2SGHDI2SCsl
         IP3V6PbrrOxJlgsb6ahsriBVJmbz+jjMhx9FDOuGRI1gQTqSVOvZfglm//CSQVovEVXD
         8I5yN26R8XA9DoLNS38aZUFXbrGGN04vOro3dbI/b1W4GfnIZwiUjVl6dq++U4O418Qj
         66uhBNP3nfOVPRaMAHEgoVNQyHqWUXhUrvUNJaWWV26Pu+f4vFYS74suQpWduqpqwM/L
         sPEg==
X-Gm-Message-State: APt69E2nR9gDoSd8A30AOswqDvSpO00C8cuymDSWbbYRtdTzuFr/vwVH
        mYTKPfllzXq8N0XxcVY9d00=
X-Google-Smtp-Source: AAOMgpcFJh96DsnF/gC7f1gm2Znatf05KnaOePod9CMkQNON1TLNmunBUuupr+OyHs1NbjYXRL/BPg==
X-Received: by 2002:a37:6dc4:: with SMTP id i187-v6mr15031939qkc.34.1531141742588;
        Mon, 09 Jul 2018 06:09:02 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4d64:6d41:6305:74de? ([2001:4898:8010:0:369a:6d41:6305:74de])
        by smtp.gmail.com with ESMTPSA id l36-v6sm483483qtk.12.2018.07.09.06.09.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 06:09:01 -0700 (PDT)
Subject: Re: [PATCH 07/17] commit: increase commit message buffer size
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
 <20180708233638.520172-8-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4eb44f33-ac9c-7ce2-0e53-ec6fcb4560fd@gmail.com>
Date:   Mon, 9 Jul 2018 09:09:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180708233638.520172-8-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/8/2018 7:36 PM, brian m. carlson wrote:
> 100 bytes is not sufficient to ensure we can write a commit message
> buffer when using a 32-byte hash algorithm.  Increase the buffer size to
> ensure we have sufficient space.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>   refs/files-backend.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index a9a066dcfb..252f835bae 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1587,7 +1587,7 @@ static int log_ref_write_fd(int fd, const struct object_id *old_oid,
>   	char *logrec;
>   
>   	msglen = msg ? strlen(msg) : 0;
> -	maxlen = strlen(committer) + msglen + 100;
> +	maxlen = strlen(committer) + msglen + 200;
>   	logrec = xmalloc(maxlen);
>   	len = xsnprintf(logrec, maxlen, "%s %s %s\n",
>   			oid_to_hex(old_oid),

nit: 100 is not enough anymore, but wasn't a very descriptive value. 200 
may be enough now, but I'm not sure why.

Thanks,
-Stolee
