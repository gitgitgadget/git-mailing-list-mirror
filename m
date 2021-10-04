Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25732C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 03:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF0D61075
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 03:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhJDDb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 23:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhJDDb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 23:31:27 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AD1C0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 20:29:39 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id q23so13296348pfs.9
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 20:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JfHZWJVYxx+FGbMR8Ye0dnlUnVr7KySIq/O4s9lv8jA=;
        b=DYKxouUW3mT8e7SQmE81+tlmgG0U40pObQ3G1lgvhLTUPSqvykplnWRDm7aAwLnVmp
         6e1nF+2Rm6Lz3H9Ax0ElY8oDi+hJGb4olWOo1LmpTebWXXPdVFFrq3pzf2o3qvvtnaVP
         B0TQM3UUgeiAyPyewSHxg4txEz5QkaJIJ4sX1XDlthOonxlXe+6AKPPeNRAkUFm3HFbs
         HIv4SKrxEM7/p/y2a16+O1xAgJC4Ub/ojAm/I+n0KVNkv8O/W60XV0e41kMQA9daydVB
         KOCCd8zD/CcpmLb5AXBwtqsFgZWwclcSlTloGxxPHvZOduznjDDC+qAVlmM3HCpqGSun
         I0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JfHZWJVYxx+FGbMR8Ye0dnlUnVr7KySIq/O4s9lv8jA=;
        b=slYWiNHuZrWZbMgmPrcpnKCTahPW3UeulF5ueEkW8a/6MTkC4p4tigun29nnhTwuyl
         AWv/z3ny291PfYYuk6OW3XghqcQXciNVoX4cN4vb5fOjeFZBJ7VmkmT8AJsi3Y5w7zfw
         SG1Y/ElmFlMAOH9wdSUKqNFsO5l9PW3uHAScJzLVu/jdS7HFs3+JlVVWjpyvmrpPvZTr
         Q7+O2cjMpw1rlhVbXTihlVWFvv0VSE30LZw+ezdFnfj8dzOovfCYJRjwPMKRvX1+N3P6
         L7BIZz/qQpB/H65lxzwhzbB7k9n/TcMZepIXmpVxayMHFpWhrrp8PrQFA3kRuOsvkJTn
         vjlA==
X-Gm-Message-State: AOAM532AJ/xu0Rci1VgyaKgT9uD6W0bv5AF9McGaMUDykIvNLGpDaSqx
        vsmb3mzmGhBEwoNXLEaCVTKvExeKhX72bw==
X-Google-Smtp-Source: ABdhPJyFM15O5QkPULUJ8bCqu/shWmp3W/f0TXbrTxnUKK9Np0CzmfaPIPV7vFvIoI4vX0mHIbfDWA==
X-Received: by 2002:aa7:956a:0:b0:447:96bd:8df5 with SMTP id x10-20020aa7956a000000b0044796bd8df5mr22547669pfq.35.1633318178571;
        Sun, 03 Oct 2021 20:29:38 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-26.three.co.id. [180.214.233.26])
        by smtp.gmail.com with ESMTPSA id s7sm8014433pgc.60.2021.10.03.20.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Oct 2021 20:29:38 -0700 (PDT)
Subject: Re: [INFO] Does Git GUI support Dark Mode on Windows 10 ?
To:     Sashank Bandi <bandi.rao999@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     David Aguilar <davvid@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <CABkJDHFOMkf-Pouaw3rtjtM+KFhPxnYtCiMbqKYCraXFb_9qQw@mail.gmail.com>
 <7b4b59a4-7e58-3db2-d934-d570cdebbf31@gmail.com>
 <CABkJDHHDjwviVmCR=tu3JBx+7BMmbmesOrkymq0fH4PXE5=i1g@mail.gmail.com>
 <135f854b-7975-a6a0-69ea-8697583a87b2@gmail.com>
 <CAJDDKr7itDvy1WPoC=kBPpT4_qm6MKWWfxwt96wQJKnGBGW5ng@mail.gmail.com>
 <CABkJDHFMy6yS40jn-NJ8mwrv6jxdjgNWQ6mJmEK1FYV0gvpLEQ@mail.gmail.com>
 <CABkJDHEZuZSun0spZ8SAcgQQvu-zamnJiqGk7VnS6agU-_KqqA@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <844631f2-58cf-55fb-0514-1def9fed43d5@gmail.com>
Date:   Mon, 4 Oct 2021 10:29:34 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CABkJDHEZuZSun0spZ8SAcgQQvu-zamnJiqGk7VnS6agU-_KqqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/10/21 21.33, Sashank Bandi wrote:
> Hey!
> Is there any way to reach Pratyush Yadav ?
> This thread has been stale for days.

CC'ing Junio for now.

-- 
An old man doll... just what I always wanted! - Clara
