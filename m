Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2077E20365
	for <e@80x24.org>; Wed,  4 Oct 2017 12:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbdJDMso (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 08:48:44 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:55395 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbdJDMsm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 08:48:42 -0400
Received: by mail-qk0-f173.google.com with SMTP id x82so1372619qkb.12
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 05:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Aryhg2EcfrTRdNs9uv4PUwfYssi7dg4gpAq9EK7rkzE=;
        b=T6Ajk2rv0QjTj9wguXNUdRxE2zF9/JlZX/8B5KEChtKxFwGbZzptolFXwH9ExYrxEJ
         Qxy51f7SHQAwnC/4rGdBqXy8UKxmq8QTWWG20jUXoQI+1EF4ZPrBGDTG9/EqdU4IJdBD
         2rWUcBKvJqgG53U/uXAC96rhhHjHRmczpKCx7BNpwqKXo3ywfy5Nt6+aMkMK/Sw2BEKj
         51Y0hLMTrf1yvv85G8It02Nl5GzbtgtAD1GrD+22LMt6Bomrx6ju91tl5JACNwzmPbb9
         Uqtd1K8vCXDsu6vQhcYL+NBUYXO8aEIt8UXSsYh1tCRpz81WNi8inGCi8tWB1H1q3rGr
         Y4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Aryhg2EcfrTRdNs9uv4PUwfYssi7dg4gpAq9EK7rkzE=;
        b=jIYGTFb4OvmdCHPITV9I/Ifl7MSrTQJyiD1OsZyBVCDgEV9YG525xHeHl4M24+GErn
         jnZH9plszYpk+pzPB26Mf3DeNqj5emkBgWhSyT2Wh3V0IyigPEZYMFSop7Hsma4Gf0IL
         EcGbsDkiaOzr5MZYpLaPPXBVKkHUyjyjvHPlmV4D/oLaVkPY8G9HmbH8kM9LjzSQqLRX
         Z+NSxetZ7xRUxIEuGlk2OwGKVMqqaugAdJsTvP+u762sGGj2lTWQxg9wEGwXuu1UJW57
         xC5DhAdF88GoJ5lno3qJvlEg4+3ouowFkhdY5szyDWCORbA6dUZHVIqz3BF4zkKE6kul
         dWKg==
X-Gm-Message-State: AMCzsaV430kxcRDkKXXdnGhess8C04ADZbg906ZJKJBTmLCVfX3fF6ZZ
        cN7quvDQTXsI86P8PKuuDaE=
X-Google-Smtp-Source: AOwi7QAoArA9k0jyKDnW+8RGuTBtU25APdfX7w4kZM465nAuu42cGgayZ4znmLTZrkYQgiEu63PJOg==
X-Received: by 10.55.197.152 with SMTP id k24mr23343422qkl.178.1507121321894;
        Wed, 04 Oct 2017 05:48:41 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id 9sm6517891qkg.40.2017.10.04.05.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2017 05:48:40 -0700 (PDT)
Subject: Re: [PATCH v8 00/12] Fast git status via a file system watcher
To:     Alex Vandiver <alexmv@dropbox.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        "David.Turner@twosigma.com" <David.Turner@twosigma.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20170919192744.19224-1-benpeart@microsoft.com>
 <20170922163548.11288-1-benpeart@microsoft.com>
 <xmqq7ewiz1mz.fsf@gitster.mtv.corp.google.com>
 <MWHPR21MB0478B8D1C5442B2FCE1ED465F47E0@MWHPR21MB0478.namprd21.prod.outlook.com>
 <xmqqk20fuvg7.fsf@gitster.mtv.corp.google.com>
 <fd972756-4ad3-4b96-23d0-e2c9e59189d1@gmail.com>
 <xmqqzi97fytt.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.10.1710032325310.28521@alexmv-linux>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <583ff3fa-425c-6eb9-ddcb-8b0049d422ea@gmail.com>
Date:   Wed, 4 Oct 2017 08:48:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1710032325310.28521@alexmv-linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/4/2017 2:38 AM, Alex Vandiver wrote:
> On Wed, 4 Oct 2017, Junio C Hamano wrote:
>> Rats indeed.  Let's go incremental as promised, perhaps like this
>> (but please supply a better description if you have one).
> 
> I think you'll also want the following squashed into 5c8cdcfd8 and
> def437671:
> 
> -- >8 --
>  From 445d45027bb5b7823338cf111910d2884af6318b Mon Sep 17 00:00:00 2001
> From: Alex Vandiver <alexmv@dropbox.com>
> Date: Tue, 3 Oct 2017 23:27:46 -0700
> Subject: [PATCH] fsmonitor: Read entirety of watchman output
> 
> In perl, setting $/ sets the string that is used as the "record
> separator," which sets the boundary that the `<>` construct reads to.
> Setting `local $/ = 0666;` evaluates the octal, getting 438, and
> stringifies it.  Thus, the later read from `<CHLD_OUT>` stops as soon
> as it encounters the string "438" in the watchman output, yielding
> invalid JSON; repositories containing filenames with SHA1 hashes are
> able to trip this easily.
> 
> Set `$/` to undefined, thus slurping all output from watchman.  Also
> close STDIN which is provided to watchman, to better guarantee that we
> cannot deadlock with watchman while both attempting to read.
> 

Thank you!  I'm a perl neophyte so have to rely on others when it comes 
to these types of perl issues.  I tried out your fixes and they appear 
to work well.

While testing them, I discovered that your fix of `local $/ = 0666;` 
exposed an existing issue in the test version of the integration script. 
  The fix for that is within my perl capabilities and is fixed with the 
following patch:

-- >8 --
 From 3e3b983a4208a62d166c233a7de3bf045322f6c7 Mon Sep 17 00:00:00 2001
From: Ben Peart <benpeart@microsoft.com>
Date: Wed, 4 Oct 2017 08:33:39 -0400
Subject: [PATCH] fsmonitor: preserve utf8 filenames in 
fsmonitor-watchman log

Update the test fsmonitor-watchman integration script to properly
preserve utf8 filenames when outputting the .git/watchman-output.out log
file.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
  t/t7519/fsmonitor-watchman | 1 +
  1 file changed, 1 insertion(+)

diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
index 51330f8b3d..a3e30bf54f 100755
--- a/t/t7519/fsmonitor-watchman
+++ b/t/t7519/fsmonitor-watchman
@@ -129,6 +129,7 @@ sub launch_watchman {
  	    "Falling back to scanning...\n" if $o->{error};

  	open ($fh, ">", ".git/watchman-output.out");
+	binmode $fh, ":utf8";
  	print $fh @{$o->{files}};
  	close $fh;

-- 
2.14.1.windows.1.1034.g0776750557

