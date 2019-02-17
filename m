Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC7381F453
	for <e@80x24.org>; Sun, 17 Feb 2019 13:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfBQNkB (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 08:40:01 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40448 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbfBQNj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 08:39:59 -0500
Received: by mail-lj1-f195.google.com with SMTP id w6so7293311ljd.7
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 05:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IzF6wjD0ywMA+TlHIQmnqpyQyGyj8vibkf6gPJqG8Qg=;
        b=rXWaMfsTiVsVwddGuhJWtL2qryBgnmXBxFdLCY8d7Z96+Hqa2h4TS3wuCbF1z2SfNY
         /mZyWMP6qg7+NdAOEuOY79w6F7m0c184mu03JwtrdRXJ0iC/XBNIYx2+IroNr7v6wyi/
         o4vIa0xJBsZFlSZujkU4wiWDnOn/p55C4mmCrdloVGP9UXab77a0gKt8ijzFiFfvzCYw
         9+K2NPtwwiRceMVRauLxeyLQgcDKrqb0S/zWcVC5GIrhYBcu/XIG9WXzZiSdNxcOVm9A
         u9bnrRlNbo72gvU8GoVE+xBzvnsBuc054vGl1cnTWjPesQo1FR6TYdBDnRWJeAHPfoAY
         11Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IzF6wjD0ywMA+TlHIQmnqpyQyGyj8vibkf6gPJqG8Qg=;
        b=jMuwdkP4zIAoTSYwniiIr21EeZw53EQAWfAXkT8AAaXukJxT1hxMXXZ6Ddvemvwns4
         jmEClmffmLwOPoVq7TlHKnRN9OKe4lpGbkKhXlay7eRP3Hx4PcjFBSW7Ltd1ZmAqdsEM
         18uWQVxkdxEZ5F8JkDEkZd0bFCMfXqBQmb/h07mSKcbq2gRGLOpBUaKsU44L7q1DPE9J
         z3izYxcDnebET/knSna7q+rAI0LcafFUIGuUPmYVPP62XX3iO+r5P2SL/Aqi6TBxvh3g
         sJD8IVlLCcbpAJ2KeFrB4dClTawViLeXEoD5dciXj9pZMu4gwAJM/6qHScS4J0G+0Ra1
         Vckw==
X-Gm-Message-State: AHQUAuZ21/t1vS1JmmyYmOwPWS4u++6+la7cQODze+Nqck50CkCWYZY4
        EBwmTLOozdzKR7vb6otBhLQ=
X-Google-Smtp-Source: AHgI3Ib9HkAvj9T+wj9sSCb84xgG3Xv4A5WN+gQCszVpOSMLh64zEfHDv+Ma7aaciYUzpJxL298RCQ==
X-Received: by 2002:a2e:96c9:: with SMTP id d9mr10449720ljj.133.1550410797056;
        Sun, 17 Feb 2019 05:39:57 -0800 (PST)
Received: from [10.42.1.6] ([46.246.123.27])
        by smtp.gmail.com with ESMTPSA id j72-v6sm3058210ljb.36.2019.02.17.05.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 05:39:56 -0800 (PST)
Subject: Re: [PATCH v3 03/21] diff-parseopt: convert --dirstat and friends
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
 <20190216113655.25728-1-pclouds@gmail.com>
 <20190216113655.25728-4-pclouds@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <7cb0cee2-0776-29f3-1904-c5c091c67e79@gmail.com>
Date:   Sun, 17 Feb 2019 14:39:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190216113655.25728-4-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/16/19 12:36 PM, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/diff-options.txt |  7 ++++++
>  diff.c                         | 39 +++++++++++++++++++++++++---------
>  2 files changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 0711734b12..058d93ec4f 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -148,6 +148,7 @@ These parameters can also be set individually with `--stat-width=<width>`,
>  	number of modified files, as well as number of added and deleted
>  	lines.
>  
> +-X<param1,param2,...>::
>  --dirstat[=<param1,param2,...>]::

<param1,param2,...> should probably marked as optional for -X

>  	Output the distribution of relative amount of changes for each
>  	sub-directory. The behavior of `--dirstat` can be customized by
> @@ -192,6 +193,12 @@ directories with less than 10% of the total amount of changed files,
>  and accumulating child directory counts in the parent directories:
>  `--dirstat=files,10,cumulative`.
>  
> +--cumulative::
> +	Synonym for --dirstat=cumulative
> +
> +--dirstat-by-file[=<param1,param2>...]::
> +	Synonym for --dirstat=files,param1,param2...
> +
>  --summary::
>  	Output a condensed summary of extended header information
>  	such as creations, renames and mode changes.
