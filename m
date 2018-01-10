Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48D9C1F406
	for <e@80x24.org>; Wed, 10 Jan 2018 00:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752884AbeAJAKd (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 19:10:33 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45059 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752066AbeAJAKc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 19:10:32 -0500
Received: by mail-pg0-f66.google.com with SMTP id c194so8322389pga.12
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 16:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IN2AUDUKmPYo3zoSRJb1G+Bd0cGRpIyuEeW5puuk+38=;
        b=JdKxGV8eI9Wv3s9nwmFoVyxBxfDDJ99wZ2a+zEu/87w9Mylykr7B+xVwahRq67P+kV
         TkiFE+rWX0WCOREoflGbrRxBaCjnexVEXdmtllOl+G0IW8gRx0JbBq6JnDwc2H4isY8j
         PIY9Lk9q0FRI0iiN6moJF+Ehtp3vuCsf1OKro2iOaDnchmkt1Xd9/q1a7y4/W8UrW4uY
         6wVvX5Z7Ij6p+mTDHWbG2uXLyxiMQOuzsPQUxnIDTJbkMnyWwU3qmatgNlGpQU5Ajyuv
         CeEHAdPP+K8U54ouhDo03Cjj5nLl2bN+Gur2F1hdWZYOAej6eLBW9nS3QO85TdRSxw0P
         kbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IN2AUDUKmPYo3zoSRJb1G+Bd0cGRpIyuEeW5puuk+38=;
        b=i2uUMcbTR+dQXHbMB1Syg4P3gw/8DTGw5pEqEB7fwXRpdkBVQZG+VWp8FdRm8YzNIM
         FAwXiM5Rz1VAR6qKhbtl7dW9VVLKlpmobzoOVWaqqIdR7Rd16uieHszKciDO9WKwI/5h
         LoTWK6ogXsTXmAjyvI6gqFGdRIK+5rJhjXUOo2cNAGiQka2v+MnSdZXAkyvs0OIiq2bN
         PIiU+k923/IJN9YFY8Lg+CZThtSjOyxdKZj4qoNIMjmn/44ovr1TuPuR94B0xIb1FHHU
         STqfU3bVaNJ2mTCPG1b61co+8KXV/aF0GtVE2/UwnVHijydxE6HSAdJ7E3fF4jCfO+ql
         /Ucw==
X-Gm-Message-State: AKGB3mK186nV+Fvntk2ffKKjL9PNxm0AHLlQO1UNyvtEoSmwSzSNvWLG
        tDy3mGh27BkFRKBAnSN+/b4xCg==
X-Google-Smtp-Source: ACJfBov5+AltjbE43IxDjKVWgFqnFh1omwZ8Lqx6rWQYoTSUZ/2chZ8Gf/hrs9AgqGZ1W05WdVHZ5g==
X-Received: by 10.84.254.75 with SMTP id a11mr17436581pln.317.1515543031497;
        Tue, 09 Jan 2018 16:10:31 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:592e:240e:24e2:56aa])
        by smtp.gmail.com with ESMTPSA id v25sm16567278pfg.132.2018.01.09.16.10.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 16:10:30 -0800 (PST)
Date:   Tue, 9 Jan 2018 16:10:30 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, stolee@gmail.com,
        jrnieder@gmail.com
Subject: Re: [PATCH 26/26] remote-curl: implement connect-half-duplex
 command
Message-Id: <20180109161030.e04f0a8d21eb1bdb0f626a83@google.com>
In-Reply-To: <20180103001828.205012-27-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
        <20180103001828.205012-27-bmwill@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  2 Jan 2018 16:18:28 -0800
Brandon Williams <bmwill@google.com> wrote:

> Teach remote-curl the 'connect-half-duplex' command which is used to
> establish a half-duplex connection with servers which support protocol
> version 2.  This allows remote-curl to act as a proxy, allowing the git
> client to communicate natively with a remote end, simply using
> remote-curl as a pass through to convert requests to http.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  remote-curl.c          | 185 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  t/t5701-protocol-v2.sh |  41 +++++++++++
>  2 files changed, 224 insertions(+), 2 deletions(-)

I didn't look at the usage of the curl API in detail, but overall this
looks good. I'm pleasantly surprised that it didn't take so many lines
of code as I expected.

Overall everything looks good, except for the points that I have brought
up in my other e-mails.

> diff --git a/remote-curl.c b/remote-curl.c
> index 4086aa733..b63b06398 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c

[snip]

> +struct proxy_state {
> +	char *service_name;
> +	char *service_url;
> +	char *hdr_content_type;
> +	char *hdr_accept;

Maybe document that the above 3 fields (service_url to hdr_accept) are
cached because we need to pass them to curl_easy_setopt() for every
request.
