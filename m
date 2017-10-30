Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 409181FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 12:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751777AbdJ3MjC (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 08:39:02 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:48697 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbdJ3MjB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 08:39:01 -0400
Received: by mail-qk0-f176.google.com with SMTP id d67so15868160qkg.5
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 05:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gd4OZXmJD77qEDadrZ1vb+LRm1TKEQXt+D7yBhcP0EY=;
        b=jv0qiCTOLWBQz4NnOwZGS4DqanF8lSP1vrxwqzv7EVkePSctyY64sBzRDBEnBMfywC
         ErOc5rK1S8geb5F5Odba2O7h5JC6nvmPNZ7oSbgVsQ6LjHqxpSWqidaYPetRnQJrnov+
         ZT+n5ByjdkxUu9h1IlWoRULH3dvGt2TIjZbxAoEf5PpI0J8cttlI5A0kcBoSx4t7G2ta
         T/AU0Fc9rzZsRMf4bBXHDoFg01laThAhgiZLLz9arRkJg1MXs36JMGpkD72DUGMVb7PG
         flBtwYsxj+bkLklL711m1RV99BcOF+bHpVy0cSpV2XAB+zy/+xap6k9CJkz87H2JC3re
         +w8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gd4OZXmJD77qEDadrZ1vb+LRm1TKEQXt+D7yBhcP0EY=;
        b=hK9WEcZ3LS7DPD1DyIcE3DySQdZhFi73mdw1p+CcZY6vEXwoOtCXnniclN2RTYeJPZ
         KH0HBRAlozAXY22LICn0Uf7QZ/VPm4bRerV0/N1ROWgzZxigEShWDmGDG5GCOlfac9kg
         DY+PXkxgLhqDiNo71MmABtXGlF80eD/fleEhbZUMrPQ0GYzNiU4SoaRK7nECqyeFoxdR
         HG2mjhT/1hugjV3vFOHlIQYYtAOR1StxWIiaUlKl2F9rucvAepyFeC9E4uaXMFq2G2Bx
         vNhU7H5AFdQOrkvZbV4gq0xdJXAnrdvW1fvBORMPSpYRAT1emTLFMRaWSbnRf075kbEK
         WavQ==
X-Gm-Message-State: AMCzsaW3rG8OCLFAWcynyp328ed8Huc3Y7jGqWsOj3SRF+bKXxVLgaHM
        K2OJod6TGOD+iAHArcztELA=
X-Google-Smtp-Source: ABhQp+RItqzHLTIQ3eBT1uqV8KLvEpntPaA6uYfPRRo3yxgChUJl4ak9ETpbZUjPVH4vDgpxdaJOeQ==
X-Received: by 10.233.237.193 with SMTP id c184mr11876741qkg.265.1509367140400;
        Mon, 30 Oct 2017 05:39:00 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id k126sm9217581qkc.69.2017.10.30.05.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Oct 2017 05:38:59 -0700 (PDT)
Subject: Re: [PATCH v3] 0/4 fsmonitor fixes
To:     Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20171027232637.30395-1-alexmv@dropbox.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <7fc39ba0-d1a3-7e96-8585-e82c54dc3e7c@gmail.com>
Date:   Mon, 30 Oct 2017 08:38:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171027232637.30395-1-alexmv@dropbox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/27/2017 7:26 PM, Alex Vandiver wrote:
> Updates since v2:
> 
>   - Fix tab which crept into 1/4
> 
>   - Fixed the benchmarking code in the commit message in 2/4 to just
>     always load JSON::XS -- the previous version was the version where
>     I'd broken that to force loading of JSON::PP.
> 
>   - Remove the --no-pretty from the t/ version of query-watchman in
>     2/4; I don't know how I messed up diff'ing the file previously, but
>     if there are already differences, it makes sense to let them slide.
> 

Thanks Alex, nice improvements.  This looks good to go.
