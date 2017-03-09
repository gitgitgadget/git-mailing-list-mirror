Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B35B7202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754118AbdCIWcC (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:32:02 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34818 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753981AbdCIWcB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:32:01 -0500
Received: by mail-pf0-f179.google.com with SMTP id j5so33843608pfb.2
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 14:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=SGolGIq195w+u6MgDWxBEFv/o2uEUFLb/8ChAA0/iPA=;
        b=cYQgwz80GvLVQfOczbF2tP3BJPZjJzZ39msN0WkVDGohv6HupEJY7dWY4fgaNnSc+a
         ZiXikIGwwg9FtfzK8YivXogHe1JwIkKX2TZ5KL+0J6dVMn/1qg4e55x7Bs5EZlfMaErv
         amNUoHj1hIVnyKn2Vsr7DN4J2bCm8zN1oApfAvRo2lc+/BmfVw+dDytMfhhe77rO85hy
         5twPcUinQ0kOdE/C1bM+2IG829Eh2zcBwKRkucfoVnp6yc/G2szI2GO9mpJrle3ruLi7
         u9nHCnh8Rq4O2yxVq0T0cAtY0s1BqpK3plBxT6GbkPxr18hsyBOebg/ft5m7A1obk8Qn
         BA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=SGolGIq195w+u6MgDWxBEFv/o2uEUFLb/8ChAA0/iPA=;
        b=U8bZppOrO2rKR6uIotOBB3cbYWEYu9tZPVrY+XQtWCk8JRpeMl3WHSvnXc+wmNrGb8
         FaUztLyR0I37PyqOpKYQX2PZ/mRZPMrIqL6sa7sSTzUhgsc3Xnadkfh6Faxjrq9glMv1
         F49nU16aqzAzTzbtf6TizdP5aWcENbJQ2OOwxmebe9N5yczOTNkGy9Dl5kASQXFcBh31
         WmCi74WhV3Dj1L5eShBPWVQNeKJSIU0e7oIqW4lMFnDmPDGCVM0c/j8g5INWJUW+uP5u
         96z1BTziIXEpBUtWrX9FerWRxfJc2JQLOzsIBj/IGicsRrM7w/3ubZPsz9mxHJpXS4rw
         JlxQ==
X-Gm-Message-State: AMke39k5Oc502ilbQyNKwjVu9+Er0JLVrWfDTmvoXbP+VMe4U1P0GgCdDHPdfJ+qsZHe8bjd
X-Received: by 10.98.71.149 with SMTP id p21mr16582778pfi.94.1489098720491;
        Thu, 09 Mar 2017 14:32:00 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:bdfe:9271:5e21:646a])
        by smtp.gmail.com with ESMTPSA id e129sm14406158pfe.8.2017.03.09.14.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Mar 2017 14:32:00 -0800 (PST)
Subject: Re: [PATCH 2/2] pathspec: allow escaped query values
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
References: <20170309210756.105566-1-bmwill@google.com>
 <20170309210756.105566-3-bmwill@google.com>
Cc:     sbeller@google.com, pclouds@gmail.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <a81ad8b5-3b49-8232-1656-66b2e9d78569@google.com>
Date:   Thu, 9 Mar 2017 14:31:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170309210756.105566-3-bmwill@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09/2017 01:07 PM, Brandon Williams wrote:
> diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.sh
> index b5e5a0607..585d17bad 100755
> --- a/t/t6135-pathspec-with-attrs.sh
> +++ b/t/t6135-pathspec-with-attrs.sh
> @@ -178,4 +178,13 @@ test_expect_success 'abort on asking for wrong magic' '
>  	test_must_fail git ls-files . ":(attr:!label=foo)"
>  '
>
> +test_expect_success 'check attribute list' '
> +	cat <<-EOF >>.gitattributes &&
> +	* whitespace=indent,trail,space
> +	EOF
> +	git ls-files ":(attr:whitespace=indent\,trail\,space)" >actual &&
> +	git ls-files >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_done

Is there a way to verify that `\,` is not escaped by the shell into `,`?

Maybe also add tests that show \ as the last character and \ escaping 
another \.
