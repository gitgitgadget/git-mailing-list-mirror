Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A3301F453
	for <e@80x24.org>; Thu, 31 Jan 2019 23:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfAaX25 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 18:28:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36162 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbfAaX24 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 18:28:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so5185444wrp.3
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 15:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IPSS52lbHh9WWDGaH3elY24RNcFyVJlB9l2+zLuMzJs=;
        b=NUiVVKtR35HANCsegJtnT/QqzC/0twKJ8ely5JNyiZFWqWu3Nc26qW7qs9dTiF9BkL
         Z370DZWkNYjAppA75pEagrhSHJcN9n7PsByLEKnfSeQr3prW2PLpDQwxMvLHoEFWS7m7
         jwOCR7EzLXz0Wqv3agDPlVl//Yshe31XKeUgoW9E+yeoKLX0hXZcqIvgiNEnIXjTvStk
         4KDe31iVhwYCPyZ8Eh61QhYIsVkZkHUDEgEH2LpValGy6BC9iFkefCsTjnIsHti6gj1D
         6D9R2mEpDrmKBwcufPgxfaJBycxk4u9nWlawdeo0EUdmm/PkaxcP+8bRGjO5Q6Xx4jmE
         alSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IPSS52lbHh9WWDGaH3elY24RNcFyVJlB9l2+zLuMzJs=;
        b=erXaewcJ20CHzNmwPWSN+WVzSru4ERVM/DgRy8GzslTwNBXS+Z01ssTXPxnzY/cqcr
         3CWn3helV7fWuWEYGez1g9QrKG/YitIkTyAg7tnnaCxU3T38vo5kHmkUr8nQ4R56je5s
         xgumA89bASPoNNcvopGglg5UV5fSJ5M3XHBtSNOzHreC25xjNbIzg3k43TTTIdMcIADI
         cdwt8iOT8p1ECSxgz/ivsIWAikSCUyQNAGwrUic4diwn5iX79+P9vs44r6qCLdcTvAmE
         ewHqvfA4AcKn0YO2JG0Bw5INWYf/u4KJ8UfJlgcttlmJGB5DNEUzLdpGQkmbYBhVRtsZ
         PEDg==
X-Gm-Message-State: AJcUukdAwziCaoSK5O5OmhCRV38DvtIqPjyF8iPNh3tEd0zPJb2De1K0
        om+9OnZ+iEnn+gnYMQa/q0Y=
X-Google-Smtp-Source: ALg8bN6dOPVR4xlZtUHptZVYYWGK0Ln1hIBR9QhjvVFcIYZTTVArLQLwag2UEPOGFzAytBNVqnFFqg==
X-Received: by 2002:adf:d243:: with SMTP id o3mr37462297wri.66.1548977334909;
        Thu, 31 Jan 2019 15:28:54 -0800 (PST)
Received: from szeder.dev (x4db675b2.dyn.telefonica.de. [77.182.117.178])
        by smtp.gmail.com with ESMTPSA id g67sm1284611wmd.38.2019.01.31.15.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 15:28:54 -0800 (PST)
Date:   Fri, 1 Feb 2019 00:28:51 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 14/14] trace2: t/helper/test-trace2, t0210.sh,
 t0211.sh, t0212.sh
Message-ID: <20190131232851.GD10587@szeder.dev>
References: <pull.108.v3.git.gitgitgadget@gmail.com>
 <pull.108.v4.git.gitgitgadget@gmail.com>
 <8d47cd71ede3fd4e932e26756ef8f3f82b41d659.1548881779.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8d47cd71ede3fd4e932e26756ef8f3f82b41d659.1548881779.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 30, 2019 at 12:56:34PM -0800, Jeff Hostetler via GitGitGadget wrote:
> Create unit tests for Trace2.

> diff --git a/t/t0212-trace2-event.sh b/t/t0212-trace2-event.sh
> new file mode 100755
> index 0000000000..517d5514df
> --- /dev/null
> +++ b/t/t0212-trace2-event.sh
> @@ -0,0 +1,234 @@

> +test_expect_success 'event stream, return code 0' '
> +	test_when_finished "rm trace.event actual expect" &&
> +	GIT_TR2_EVENT="$(pwd)/trace.event" test-tool trace2 004child test-tool trace2 004child test-tool trace2 001return 0 &&
> +	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
> +	sed -e "s/^|//" >expect <<-EOF &&
> +	|VAR1 = {
> +	|  "_SID0_":{
> +	|    "argv":[
> +	|      "_EXE_",
> +	|      "trace2",
> +	|      "004child",
> +	|      "test-tool",
> +	|      "trace2",
> +	|      "004child",
> +	|      "test-tool",
> +	|      "trace2",
> +	|      "001return",
> +	|      "0"
> +	|    ],
> +	|    "child":{
> +	|      "0":{
> +	|        "child_argv":[
> +	|          "_EXE_",
> +	|          "trace2",
> +	|          "004child",
> +	|          "test-tool",
> +	|          "trace2",
> +	|          "001return",
> +	|          "0"
> +	|        ],

Just curious about the vertically aligned '|'s: are they there to
circumvent 'git diff's big red whitespace warnings on these deeply
indented lines?

