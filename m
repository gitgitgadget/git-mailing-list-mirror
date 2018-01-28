Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4949E1F404
	for <e@80x24.org>; Sun, 28 Jan 2018 19:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbeA1T5Z (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 14:57:25 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34547 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752329AbeA1T5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 14:57:24 -0500
Received: by mail-lf0-f43.google.com with SMTP id k19so7006188lfj.1
        for <git@vger.kernel.org>; Sun, 28 Jan 2018 11:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e59vqgHiPGBuL3gxOiaWnF0/ZdusJXhU9BO2a29K5go=;
        b=EIxNbSsFl4eQpfeDHRF4zn9OVMt2PU79lSBp9ByN0m8OB9jFKh1y88BSbG1yLoSy0J
         GBZLnM2R0H+NALYtFls1IhX8G3PmSFXpzUobb/vSfv0Wvx8JKKuVM1Z+I6TB6hpJu/KU
         V/hHLjaih+SadxjDeYV/8mow5jZQ6zHjdyDv3GeN91lNkGibBPCL1uQjDxY/M1BNWO/1
         LDCCTAVR3ghQAszUgGYAggcFpLrLHfvuWlUU4/XQdhZSGMa6V8YhgOXNrkPEOdS1jS5o
         IRqJNiy17OVEfIdq6WR2JfECfbT+2YoTnygld4YMTryLc7oO8l8+tPflgfxuPtSWr+Qa
         xD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e59vqgHiPGBuL3gxOiaWnF0/ZdusJXhU9BO2a29K5go=;
        b=KOVMi+Mu0IKnGqD2MTDFJoDPFt9DjBMh9h264K6V9k0JxuvdObK8dhG/RKF6ztDLGF
         wM5M+DmeBsEe26zxZIl5RnJraL9hgMHc80hKptveJYiNWJU4pAGccRdm5AHPJrk213Su
         Ov7isnthrR1qhdHyNTzjT/z8wthHvtDCi0KOFrIlRFGarbwsB7OstdyF1/U6NzZS1OS4
         kpxliLnJ+1OT5+K5/8WingOPPWdpmD/wzHT6/lSYL/4SFGJy6ZkR6iITrRtN8gDJeg54
         k68WGNk9SVEeg7Efm2t/dz5bS+1STciNIjfpIeM5EKzjjm3dE8DEk7RmrcyJbjFJ4a/e
         utEg==
X-Gm-Message-State: AKwxyte6MdzK0t+eQ/0OtfDQd2/HtPXSOqg8/EZ8pxAxUik+Cr6vcE6D
        8OSoqAvSsK3rgegqoZgGda4=
X-Google-Smtp-Source: AH8x225HDwBXZbIxI8QwiEGSpgpBuJgsaO5hy+SXKEIrotdLxZDc2ND2/x5j9rCegSSCf3cmHr5W3A==
X-Received: by 10.25.195.134 with SMTP id t128mr3699900lff.60.1517169442969;
        Sun, 28 Jan 2018 11:57:22 -0800 (PST)
Received: from [192.168.1.138] ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id r89sm1017771lje.59.2018.01.28.11.57.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jan 2018 11:57:22 -0800 (PST)
Subject: Re: [PATCH 02/12] hash: create union for hash context allocation
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
References: <20180128155722.880805-1-sandals@crustytoothpaste.net>
 <20180128155722.880805-3-sandals@crustytoothpaste.net>
From:   Patryk Obara <patryk.obara@gmail.com>
Message-ID: <54b29396-d994-7afd-9c18-83fca8e4ad6f@gmail.com>
Date:   Sun, 28 Jan 2018 20:57:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <20180128155722.880805-3-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/01/2018 16:57, brian m. carlson wrote:
> In various parts of our code, we want to allocate a structure
> representing the internal state of a hash algorithm.  The original
> implementation of the hash algorithm abstraction assumed we would do
> that using heap allocations, and added a context size element to struct
> git_hash_algo.  However, most of the existing code uses stack
> allocations and conversion would needlessly complicate various parts of
> the code.  Add a union for the purpose of allocating hash contexts on
> the stack and a typedef for ease of use.  Remove the ctxsz element for
> struct git_hash_algo, which is no longer very useful.

Overall, I am OK with this approach (it's straightforward change and 
cleanest way to replace direct calls to git_SHA1_* functions), but just 
to play devil's advocate: OpenSSL decided to sway users into heap 
allocated contexts, citing binary compatibility issues if they change 
the size of context structure. [1]

I think we might need to revisit this design decision in future - 
perhaps as soon as we'll transition away from calling git_SHA1_* 
functions directly.

> +/* A suitably aligned type for stack allocations of hash contexts. */
> +union git_hash_ctx {
> +	git_SHA_CTX sha1;
> +};
> +typedef union git_hash_ctx git_hash_ctx;
> +
>   typedef void (*git_hash_init_fn)(void *ctx);
>   typedef void (*git_hash_update_fn)(void *ctx, const void *in, size_t len);
>   typedef void (*git_hash_final_fn)(unsigned char *hash, void *ctx);

I think it would be appropriate to replace "void *ctx" with 
"git_hash_ctx *ctx". This way we can avoid unnecessary casting in 
git_hash_sha1_* functions.

[1] https://wiki.openssl.org/index.php/Manual:EVP_DigestInit(3)#NOTES

-- 
| ← Ceci n'est pas une pipe
Patryk Obara
