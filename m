Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D24E20248
	for <e@80x24.org>; Sun,  3 Mar 2019 23:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbfCCXiZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 18:38:25 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:40426 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfCCXiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 18:38:25 -0500
Received: by mail-pg1-f180.google.com with SMTP id u9so1680766pgo.7
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 15:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=woLGRtVIs7SQtzauCGqWv7MRux7LU628nvrw9cBy2P8=;
        b=C29VT+DIMHzK2fPTdjreySoBbcQ23IuDTG3SKj95oTCYTBh13Xjpm0AqUN5oZQPXi6
         xWInSNjsY/gkBNVZtMq26gFJYzcFENeIuu9foRdVP/vCj4AYmHGSa7QpH27LeY0I687r
         teXziK2H5NTTAv9O1dipTEFg3Duj+gj8Q4aJV7t1N0rknusYd1YpuvnKoQ0T3OVCUzME
         NXjdUbr2T9g5KYwrXkmbcGFgkxNuhQSFNLE1NC9uhTye6PK+xVsQF9pQSEh418Bu/eXt
         OwgfZ/WDBdj4pndGUfbf2aZy0laNh+B5n+JnCPaHxxbgha6d4sX6Q1l9A68gymog4Ddc
         x6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=woLGRtVIs7SQtzauCGqWv7MRux7LU628nvrw9cBy2P8=;
        b=lVCAnRJ3ier9pJ0g9hPeiQ8+d6H8kzYAVCyZfR35ADqzyQlAqy3VN7yV/5iXrWvmeF
         +eGSZTAPxlnvj52w1qXor+c7aB4XjRFHLoPerPHBbg7cRQf7+0cPwZ4NX2nGGMiKHavI
         yZEXlX0NpXLCnzplA3zk/yFsRbloyUM1DJaJ1QvN9bJVLpCiWHWOa8Yb1erCcFzlW0cg
         iBM+3LHdks7PpP9Pp4fvvaH+lz45FEGr9zBzWerT7KsiGnCz92GpQXp6ff2x+2T+9F88
         avOQa+mBTqrmwcsL+O2htX9jKP3k1bG5TLKm5wDDbwh2YdiviPZM1vhLce+xFcOkSHV7
         RYlg==
X-Gm-Message-State: APjAAAXUkOBJ9aarcoO0TdT16fWbQYLpfGFIC2d3iUdR1Ori6OQGkQGM
        AUlIJY7Lobk+hasSaiPIV6s=
X-Google-Smtp-Source: APXvYqxz04OPhqu5udqECU/ULfM2PrRvD5TPeiH/Udf7ZR32Z0HKN/8+9nRzSqaD1g2gsFQ7yezvvg==
X-Received: by 2002:a63:e40b:: with SMTP id a11mr15748202pgi.259.1551656304713;
        Sun, 03 Mar 2019 15:38:24 -0800 (PST)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id y6sm7284579pfy.87.2019.03.03.15.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 15:38:23 -0800 (PST)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, t.gummerer@gmail.com
Subject: [GSoC][PATCH v2 0/3] Use helper functions in test script
Date:   Mon,  4 Mar 2019 05:07:47 +0530
Message-Id: <20190303233750.6500-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
References: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch ultimately aims to replace `test -(d|f|e|s)` calls in t3600-rm.sh
Previously we were using these to verify the presence of diretory/file, but
we already have helper functions, viz, `test_path_is_dir`, `test_path_is_file`,
`test_path_is_missing` and `test_file_not_empty` with better functionality

Helper functions are better as they provide better error messages and
improve readability. They are friendly to someone new to code.

Thanks
Rohit

PS: `test_file_not_empty` is implemented in [PATCH v2 1/3] of this mail

Rohit Ashiwal (3):
  test functions: add function `test_file_not_empty`
  t3600: restructure code according to contemporary guidelines
  t3600: use helpers to replace test -d/f/e/s <path>

 t/t3600-rm.sh           | 326 ++++++++++++++++++++--------------------
 t/test-lib-functions.sh |  15 ++
 2 files changed, 180 insertions(+), 161 deletions(-)

-- 
2.17.1

