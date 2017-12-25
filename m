Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC9661F406
	for <e@80x24.org>; Mon, 25 Dec 2017 21:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753017AbdLYVtR (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 16:49:17 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:42382 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752910AbdLYVtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 16:49:16 -0500
Received: by mail-wm0-f45.google.com with SMTP id b199so33102784wme.1
        for <git@vger.kernel.org>; Mon, 25 Dec 2017 13:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VxvXkqzEDa7VaXxRzgyUgt94mQI+dl0KEgG9wY77djM=;
        b=cJd0ixO/V/ezDmYC3PkEWXFMHNqMDjlnc/WuMbjLChCPxt8XUNIAZRwppNr28x7L4e
         FUy8dpjAWAJlVQcbYKy3RTL5jiRWbnv92XdNhiFsM/ZPXwFKmJmio8fUt2EGffCnq7dQ
         tNCknP+F1CytI+1jTHNy2RMMmyemsZ5Qxn+Gj2yiEFFkFIXizg9zb/KfB6D1OLEXustZ
         jmKNcBlxZbQYMq6Qa6H2l+FJqKDe61E4ZciwDanHDA7f21Ua25r3vWAVLjz6BBeiv6w/
         eZi+5gz3mD+VZBS7nAln/zaxYx7VHL+4ndHqiCk+xZXC6vq1yeUEC8AvtiPiiU9n6BVR
         Z3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VxvXkqzEDa7VaXxRzgyUgt94mQI+dl0KEgG9wY77djM=;
        b=aKyUTmS6ehJt6m8fXMXuUEM/94V1P10xa1osm5QkC3z+6KWdJKYJ1LMC2JF0xrwpe5
         yKN8Yy0HOldIPCY57KCnXA+udGF3K59btq7jrCRnrNycQD6+TWriAkhWHs38wurYi2ta
         HgtLEmpBu70v1m3ugHo5B8BioREn90cu5bwpVt+pnEJ8hgma/KDYM3dy7i/aBexymX7d
         JSxS6cYcxIHY8xJp651j/rweqgCSd/VVS0DD1ELDHkWUf7ByCgHoqyyl+XOQE0AMDtLY
         SyzFJaaelF56vYHxgxBFIO2zakC/QxZ1LgDus5GMdWF8i0VfZfIzdBdqfmSmwFcz1x/3
         HPvQ==
X-Gm-Message-State: AKGB3mJDNRPbqOixc5dO0pi0grTwTSDalUiRo1I6Tx3/7ExjhYoNgscg
        tsc5SpJ90F0Ox3S0/QkCHBjP5aRV
X-Google-Smtp-Source: ACJfBote8J1vQGeu+d9Vwi4t3kpQ+2KUGJwkm9yMzMC07Ee3l6Y1AvXGishVEm0NfNyuOp1tQJ5/EQ==
X-Received: by 10.28.58.15 with SMTP id h15mr18843308wma.150.1514238555073;
        Mon, 25 Dec 2017 13:49:15 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id f4sm38763921wra.75.2017.12.25.13.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Dec 2017 13:49:14 -0800 (PST)
Subject: Re: [PATCH] status: handle worktree renames
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     alexmv@dropbox.com, git@vger.kernel.org
References: <alpine.DEB.2.10.1712221829430.29746@alexmv-linux>
 <20171225103718.24443-1-pclouds@gmail.com>
 <b3e90960-d743-3299-ba43-150849b591d2@gmail.com>
 <86b4d2af-18ce-36eb-4823-105757a196fc@gmail.com>
Message-ID: <fd0eb127-39b6-94fc-86c7-46fa750ec2e3@gmail.com>
Date:   Mon, 25 Dec 2017 22:49:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <86b4d2af-18ce-36eb-4823-105757a196fc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/12/2017 20:45, Igor Djordjevic wrote:
> 
> I guess an additional test for this would be good, too.

... aaand here it is. Again based on your test, but please double 
check, I`m not sure if it`s ok to compare file modes like that, 
expecting them to be the same (hashes should be fine, I guess).

---
 t/t2203-add-intent.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 41a8874e6..394b1047c 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -165,5 +165,20 @@ test_expect_success 'rename detection finds the right names' '
 	)
 '
 
+test_expect_success 'rename detection finds the right names (porcelain v2)' '
+	git init rename-detection-v2 &&
+	(
+		cd rename-detection-v2 &&
+		echo contents > original-file &&
+		git add original-file &&
+		git commit -m first-commit &&
+		mv original-file new-file &&
+		git add -N new-file &&
+		git status --porcelain=v2 | grep -v actual >actual &&
+		echo "2 .R N... 100644 100644 100644 12f00e90b6ef79117ce6e650416b8cf517099b78 12f00e90b6ef79117ce6e650416b8cf517099b78 R100 new-file	original-file" >expected &&
+		test_cmp expected actual
+	)
+'
+
 test_done
 
-- 
2.15.1.windows.2
