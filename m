Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 745EF1FAFB
	for <e@80x24.org>; Tue,  4 Apr 2017 01:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbdDDBcO (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 21:32:14 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34768 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbdDDBcN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 21:32:13 -0400
Received: by mail-pg0-f67.google.com with SMTP id o123so33468911pga.1
        for <git@vger.kernel.org>; Mon, 03 Apr 2017 18:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vsOA/tfyXApetd6j3asOwJtZBX6nOsmRISm8F52huyo=;
        b=P22WUn66ntx4jjJ4AJl5uhYvbzIjq/L9GEbCPcAEDSWiX/Iaa0RTl3m7g/B9hTK8Zq
         sG9x9lnfy/JM3jdedrz3wuaDiss6IUWiptXWa+gJesCdf1fqjFuhULGD2r7gGaoKSjGB
         73ZNysgfe8Lf2d2yi4SBGiEvspKECldNlVGaawRJSgNeVuMcD5ftrYiXOVnUTLT0dEqL
         V4Bip/7Ip86Tm7OKiGW4F8OqjqpZmNtqbLITMaaoivheN5/AmgJ9N0UwHVOmTABoX2rM
         7IOUjPnDvEcDuW7etolOZV1OWAYZYN3zhup37IOMzkMem2E72Vspo78usklNHB8KWstE
         qBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vsOA/tfyXApetd6j3asOwJtZBX6nOsmRISm8F52huyo=;
        b=cG3cWi0+cp9P1l0JZ3/hj9lz11ib9sL9tYzn05yAc2qitibsPF0RPBYgaz3VHUIauO
         60b7TARL7ZRxysP2VdsLdLFC8z1HuYpk/l9ZhB3jz1NbP4CMOXG25Nys9LJRUrOkmyhu
         T9WQK8NeNj7meR3Y7wdmnIDg7saWh2xav9Ywthh9Jz0oYkykO2cZLu9Q1RCUVDiOgYOh
         lFMmudODBhRqnRWtFGs99Khvyu3TJdxWf+lrWHkKh2wAn8y1lW9eq1QmjzvDpsZGNuH1
         rNMt6pbz8LLQg6sU20ONkGYpHE7A82Y+g/8SgC9reFXsyFNj+2aP8KGRzbRycsOVQIb6
         rjoQ==
X-Gm-Message-State: AFeK/H17mKMiHDBRFtBY5MJoLXYlDh16JlqYKJSAi3rtYrNNrVRB9jyt14Kd5DLNqPswvw==
X-Received: by 10.98.33.218 with SMTP id o87mr6944282pfj.11.1491269532866;
        Mon, 03 Apr 2017 18:32:12 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:81c9:69b0:17e4:e0f8])
        by smtp.gmail.com with ESMTPSA id d1sm28033669pfa.5.2017.04.03.18.32.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Apr 2017 18:32:12 -0700 (PDT)
Date:   Mon, 3 Apr 2017 18:32:10 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, tboegi@web.de
Subject: Re: [PATCH v5] http.postbuffer: allow full range of ssize_t values
Message-ID: <20170404013210.GD8741@aiede.mtv.corp.google.com>
References: <20170403235308.30102-1-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170403235308.30102-1-dturner@twosigma.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner wrote:

> This means that we need to use CURLOPT_POSTFIELDSIZE_LARGE to set the
> buffer size.

Neat.

For completeness, it's useful to know this was added in curl 7.11.1,
which is old enough for us to be able to count on users having it (in
fact it was released >10 years ago).

[...]
> +++ b/remote-curl.c
> @@ -531,6 +531,12 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
>  	return err;
>  }
>  
> +static curl_off_t xcurl_off_t(ssize_t len) {
> +	if (len > (curl_off_t) len)
> +		die("Cannot handle pushes this big");

nit: other calls to die() here and elsewhere tend to use a lowercase
error message.

More importantly, converting a value to a signed type when the value
cannot be represented in it yields implementation-defined behavior
(C99 section 6.3.1.3 "signed and unsigned integers").  That makes it
fodder for over-eager optimizers.

Would something like the following work?

With that change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git i/remote-curl.c w/remote-curl.c
index b7b69e096a..cf171b1bc9 100644
--- i/remote-curl.c
+++ w/remote-curl.c
@@ -532,8 +532,8 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 }
 
 static curl_off_t xcurl_off_t(ssize_t len) {
-	if (len > (curl_off_t) len)
-		die("Cannot handle pushes this big");
+	if (len > maximum_signed_value_of_type(curl_off_t))
+		die("cannot handle pushes this big");
 	return (curl_off_t) len;
 }
 
