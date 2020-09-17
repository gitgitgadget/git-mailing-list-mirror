Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD8CC43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 16:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 311B42072E
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 16:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgIQQW6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 12:22:58 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:57333 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbgIQQWu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 12:22:50 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MHWvH-1kEJiJ1EbB-00DTpF; Thu, 17 Sep 2020 18:05:58 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 5B36A1E01E7;
        Thu, 17 Sep 2020 16:05:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cjDg7N8jCKwY; Thu, 17 Sep 2020 18:05:57 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.5.94])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 24DA41E01E6;
        Thu, 17 Sep 2020 18:05:57 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id ED0F68051A; Thu, 17 Sep 2020 18:05:56 +0200 (CEST)
Date:   Thu, 17 Sep 2020 18:05:56 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Config option to set the transport protocol version for
 network fetches
Message-ID: <20200917160556.GH8079@pflmari>
References: <20200916200203.GA37225@coredump.intra.peff.net>
 <20200917132047.GA14771@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917132047.GA14771@pflmari>
X-Provags-ID: V03:K1:jT5AKMG/3cOGkFRKWu4UqcB9mv2REnXbZDoDC8J4tQcOXqPZGPR
 nawMgM14UkSLB0wZSsgFWDxyplAncTPmAGzRCCXHSJCZfa0PxzjzCyjEmUEpcqKpfEpXMaH
 IzTO1anKzv4F9lKc6pJ8G2QzZkf1TAXnh322lIvvXr6l+kiPJkihKZxQIiSAJXjaUw6prTA
 58I+CUkTQ3r49rz8jYcWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kVRpFKDoQzE=:nhyLC023Ow1KJKBEYfjaK7
 qEO+1yAvdIwzUii+SC1hICTGFrP/vWI48mCzP9qoBAPx9kdikhqIc+hMrj/iY4QYfx+5A+IM0
 tNvZcQXvzJeZ/cQW9e8ywgXtbYJzT3+3WhEzWUM3ZHaROHS4wZHsk6l/EZeDHfCmQbz6cuK3C
 79yZJmI+B3pSj9b1r0N5ZpLHOpltzMUjpgLDt18KfEw2AQBRS9WKTiU124JSAM6CnWEp9ZWXV
 Mx9m1HlJ0nAsxxsmALOEzs5OixWFo7kxnG1gQga3REtLA8WM8OSLRpeagUSvo2N5wDkxtS8uF
 5roqB2rTPdt0vITMT9jkLLKEaO3Biu5w6Q6hrWd95kNqyyg2xqTPGND6oCppaeEXogXptHBsH
 OByuT2roDpEtjI/erI1V2K2bXmu4pTomhcyp3tq3Hz18eNRsUSPequ6r1HVE8nR6hn5tz3x7E
 ggh0JZDovWhNMsW5ytkk5OWxlPurURCHmFg10I745EaUKGgSSNDji5TbLhcXwMH+JwVpN7c+/
 WzQhczttbpMcZLaE0vAySf5eHFkoHOyNX4JsdlNpO3XCDU6E0oTqBVcPpFTTvK7lGdi2hI6zi
 S5DoxrnjWwQYEZctCkfglj7CM3JscDwbQdFtITYII3DDBLwJdno7HjAYIW+S4+KyDjdq3+RSD
 +dpfSm+XPikMqqQHKoOa7kEM4y6BOYthSWlxQIQj2AZyyzhELj+lXBdV7ODb1eZXVRuG3V6ZE
 wL1/CwDckZzxgM80sfiRZBoEfrM4gfUlyDkBMxgHVyWCgK3VkW0+QXAMqq7GAcvZq9a+dxN2c
 43aKVeymwJRgT268a31/5OAGPT4bG2fPy7R6o5FbgZKtCiuo9hWnC8MaGpREByj+qYnDJECIe
 swDh5GaQ/mZ0thvCovxA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Riesen, Thu, Sep 17, 2020 15:20:47 +0200:
> diff --git a/transport.c b/transport.c
> index b41386eccb..e16c339f3e 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -922,6 +922,23 @@ static struct transport_vtable builtin_smart_vtable = {
>  	disconnect_git
>  };
>  
> +static enum transport_family default_transport_family(void)
> +{
> +	static const char key[] = "core.ipversion";
> +	const char *v;
> +
> +	if (git_config_get_string_const(key, &v))

Sorry about that. git_config_get_string_tmp, indeed.

