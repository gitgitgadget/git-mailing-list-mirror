Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2F7B20281
	for <e@80x24.org>; Tue, 31 Oct 2017 03:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbdJaDXa (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 23:23:30 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:52546 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751615AbdJaDX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 23:23:29 -0400
Received: by mail-pg0-f65.google.com with SMTP id a192so13445855pge.9
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 20:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=9SGfkCZGn/H0sr36yiWK3ss112f48m5afWOknFxcHbE=;
        b=dXtoDXz+latKp+95goT4un6Hv7A7q8p6aR8Y+qtqINpl0ISW5m5BDLilyZiYyllAf4
         X2FRjZ1xVZmcuvc8STV7zrKI9cqi/te08i2khM7fqlnjMejE/phNurssmQJb9Rf26CvN
         FoYh6zro5tfekc0Fld3a7hBfv/6XaGalzB2HPSCh2mMNPxH8aEp2QjCvaoXi8OKRPAB2
         i6bxb9V5EZl1Y4iPn4iDFoKNz5i799sEMB6i00B3Dnh3u8F653nX2VJkz80LTtvIXzIQ
         ZJ1ZKek/XMZvL0E6aYIYZsXIlPvArHU12xM8DkRgeEx+tdfVT927fQ7+Fq2kNbre4P81
         KHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=9SGfkCZGn/H0sr36yiWK3ss112f48m5afWOknFxcHbE=;
        b=Pwqk+9KbIafuHln6LxFZmroTz2kFyFVLPNziG+FqdzUywKaIiOotWjFvYdevQywwoB
         hGeI3vGm35B+Ck13FH5pQKDWJucQ0dpVbDnBKHcyf8Qr+5pu5rfN/0GmX0yv2dcQFp8k
         dWn5tH3OclPtxOWkTChFLy2QbzVP6adwUDDbn0oj7z/5+XIc4rqT2DgTeaf2aIibf7Dd
         4VWPjT6xVLcTONhWrQCn5fRpvbliZYg3tDCHWtkzt/uu/qGQDPvSqRxh6PnDbhrDJO/Y
         otrdEtFVFTSXJ8ZQXs6BHzgR05lq0+Y54GNHP3ZNzrOukSrCtFHhjA+FtTh70udlV+ZB
         vnZQ==
X-Gm-Message-State: AMCzsaXGauZNXeFvE21LUaJsqiu8km9B+1a5GI27k31CFukZ40TnKOoG
        EwCTylbOL066m8RkLzroNw==
X-Google-Smtp-Source: ABhQp+SM1Xx5+eZ5gCiykiXcwaBZ0iurzbY86l+js882bJUNo9DXaO5nlkWXRmSffDFaeLv/VOr0aw==
X-Received: by 10.98.147.156 with SMTP id r28mr536400pfk.325.1509420209539;
        Mon, 30 Oct 2017 20:23:29 -0700 (PDT)
Received: from [127.0.0.1] ([144.48.7.118])
        by smtp.gmail.com with ESMTPSA id x9sm513099pfk.120.2017.10.30.20.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Oct 2017 20:23:28 -0700 (PDT)
To:     git@vger.kernel.org
From:   Yubin Ruan <ablacktshirt@gmail.com>
Subject: Meaning of two commit-ish hash in git diff
Message-ID: <ab9b5c63-ca38-6157-6732-78aa5d5f291f@gmail.com>
Date:   Tue, 31 Oct 2017 11:24:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Can anyone tell me what does the "f8886b4..a1c96df" mean in a git diff output,
as below?

diff --git a/path/somefile b/path/somefile
index f8886b4..a1c96df 100644
--- a/path/somefile
+++ b/path/somefile
<snip>

This is output by a `git diff` between two adjacent commits but they are
not any commit hash. I grep through the whole $(git log) but still cannot
find those hash.

And BTW, are there any special meanings for that .. ?

Thanks,
Yubin
