Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C751F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388098AbeGWOYw (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:24:52 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40934 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387883AbeGWOYw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:24:52 -0400
Received: by mail-qk0-f196.google.com with SMTP id c126-v6so362346qkd.7
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zD9u4RMs4G4Ccl8wZqtubL1IO4YV5WeNx74Qz0dIHNs=;
        b=qbCfZ7WcCqtZOoQq/W/xaI6gHfkSDPFSob/Uu+KMYz5eXgLz0H+FEC9uh1p9Lshtjd
         NdZCOdMG+2BIwfIwwhqpzJOZOO0t2TNuWb+zD/pRIeWKLhVt6Z37LhRwP262Yr8+vTOZ
         rSDKFLh7u+CZuvbwyxulOGpoRlXMn3lMTOIGTlnv32XSw1UhUwnyPVBSJ/hoWGJ/5DEP
         dM5D7lK/EQh4pEk5upE0VAGAMm411JdyCXEcstV7h/hFKFwIXbvfUoFdSsZR8ftKrWzy
         g4egbLNROVEbrxPf0Lm+W7l9oaXAAmcOAI0ZLFEQr1b+u4o7cGyx/s9DtvDat8DWTuKQ
         5mNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zD9u4RMs4G4Ccl8wZqtubL1IO4YV5WeNx74Qz0dIHNs=;
        b=YzpB/GxcSPIXl+3ZcfXAUVTZLVm5ofzLtWCIO2zYqkhUzcLnKxZLKvrxshnmJnp8in
         J98EWqXYFHQbGEY94infNOtZ9JxPEmZ+e6H8xh6sAkMibeWDWNfmnFIRA4lb9BRmcLKA
         naw5KDKqZdr3Y9Bsa1kKq+4IIk9QLNsXzw+wxFXLYExh93X0KwbAcVtNcSNSCeYi7Ey1
         IRYSZcMHpZrusPVzoiXymPLtVc9jyUQZywSKAjSA63syLX8oNi/xdr6ACEslTeruEhar
         TA7RWbAubf9rxKHwNATB43D02I6Ii1hpMgU/7hNr57Pl3CWHq0s3Ctx63lSX08wU+cYz
         KM8A==
X-Gm-Message-State: AOUpUlF0866BNmbpWSLrIFTCN1zBP00hDl9IFSyF8lfEJsRmuniavoB8
        J6tNH7esZA6lwmiYR53Sh2YoRNpH
X-Google-Smtp-Source: AAOMgpea61IT/hnrMSAij3KaIboSqq02J9mUB/cgyk56HGClf6WNsKVFSNCa4sDeuclLtwzSrvHT8g==
X-Received: by 2002:a37:8f06:: with SMTP id r6-v6mr11451293qkd.409.1532352217443;
        Mon, 23 Jul 2018 06:23:37 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:79ea:539c:969d:bb3c? ([2001:4898:8010:0:6320:539c:969d:bb3c])
        by smtp.gmail.com with ESMTPSA id z1-v6sm10821209qta.19.2018.07.23.06.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:23:36 -0700 (PDT)
Subject: Re: [PATCH 2/2] travis-ci: fail if Coccinelle static analysis found
 something to transform
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20180723130230.22491-1-szeder.dev@gmail.com>
 <20180723130230.22491-3-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2266ffb0-b4b6-26bd-9ea8-76aaa325bcc6@gmail.com>
Date:   Mon, 23 Jul 2018 09:23:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180723130230.22491-3-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/2018 9:02 AM, SZEDER Gábor wrote:
> Coccinelle's and in turn 'make coccicheck's exit code only indicates
> that Coccinelle managed to finish its analysis without any errors
> (e.g. no unknown --options, no missing files, no syntax errors in the
> semantic patches, etc.), but it doesn't indicate whether it found any
> undesired code patterns to transform or not.  To find out the latter,
> one has to look closer at 'make coccicheck's standard output and look
> for lines like:
>
>    SPATCH result: contrib/coccinelle/<something>.cocci.patch
>
> And this only indicates that there is something to transform, but to
> see what the suggested transformations are one has to actually look
> into those '*.cocci.patch' files.
>
> This makes the automated static analysis build job on Travis CI not
> particularly useful, because it neither draws our attention to
> Coccinelle's findings, nor shows the actual findings.  Consequently,
> new topics introducing undesired code patterns graduated to master
> on several occasions without anyone noticing.
>
> The only way to draw attention in such an automated setting is to fail
> the build job.  Therefore, modify the 'ci/run-static-analysis.sh'
> build script to check all the resulting '*.cocci.patch' files, and
> fail the build job if any of them turns out to be not empty.  Include
> those files' contents, i.e. Coccinelle's suggested transformations, in
> the build job's trace log, so we'll know why it failed.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>   ci/run-static-analysis.sh | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
> index fa719c9ef9..5688f261d0 100755
> --- a/ci/run-static-analysis.sh
> +++ b/ci/run-static-analysis.sh
> @@ -7,4 +7,23 @@
>   
>   make --jobs=2 coccicheck
>   
> +set +x
> +
> +fail=
> +for cocci_patch in contrib/coccinelle/*.patch
> +do
> +	if test -s "$cocci_patch"
> +	then
> +		echo "$(tput setaf 1)Coccinelle suggests the following changes in '$cocci_patch':$(tput sgr0)"
> +		cat "$cocci_patch"
> +		fail=UnfortunatelyYes
> +	fi
> +done
> +
> +if test -n "$fail"
> +then
> +	echo "$(tput setaf 1)error: Coccinelle suggested some changes$(tput sgr0)"
> +	exit 1
> +fi
> +
>   save_good_tree

This looks like the right way to report a failure. It provides as much 
information as possible. I agree that we should have this as part of CI 
so we find issues more quickly.

Thanks!

-Stolee

