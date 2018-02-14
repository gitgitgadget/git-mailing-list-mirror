Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F35181F404
	for <e@80x24.org>; Wed, 14 Feb 2018 21:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031488AbeBNV4o (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 16:56:44 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:36415 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031452AbeBNV4n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 16:56:43 -0500
Received: by mail-wr0-f174.google.com with SMTP id u15so1451229wrg.3
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 13:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jSpyVIJXj4YGEMYk+z8+zAzZuh0vCRP7cHeVbxgUeq4=;
        b=bt4xgl3NXdUtO7SgAbUXNu8sZ7siN3GosLr+CoNS/fGwoHW7rdciQrLtasd0AVBOqE
         a254Fo0OPoYdQ4+FVN2p3iqvaH1U0i9bpjxpFOfGSMtO6m3RhBFC6odCaPAIZ1tkTtOH
         N59IT7YHLuTb01GD25xroi+M63CPKIeff1EQXh9+Qemk6AGPZOylpIjHyCIZ7zilKGd6
         ujQS3bxobaFJ+ktW0M6iA3F6kdxXlj8TdwGqAH+vxK42SDaIXOM02xCUU70na8eCCpTe
         Nmz51EIJWsJqbbJitXgUNVkrCqtKf2N8MIaqzloQGXk5TyMrAatYks9D3h2mGpUoF4s/
         HU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jSpyVIJXj4YGEMYk+z8+zAzZuh0vCRP7cHeVbxgUeq4=;
        b=XzvXyt84cBMM/FhzAW41eFpxy+5gDiWOwN1z/kADRfUXzYHqgIOXiqnKKo3QeU+1D+
         f2GrF39Lr0Vf79j0YMkTn5g5QHpvXv1RAyr61JjR7Ah+yISIt1fzCgep7znLtDn8Jlqc
         Km0s3KGSVWD194zKQBkDN6VnLQFJBJD/OHRsRfDlEDKnhwQ4zNcPMt4nbh3a4bDcWb1N
         2HAbiH1KT5l1Le6xqR/JRsoGbd7EE6JFBGlWc2i2AOLfIGzk8GIA+4zLlOPJTdT08jri
         EFNF/WHJhsrozfc2DQAzQmMcP8dnwR1ngEOSCdY5j3UNGFI+P+KCruJOn9RCAWr3fnYJ
         ZhpQ==
X-Gm-Message-State: APf1xPBc2iQ38tDi2daaMtCr4EBjLqL1jOuYJ5PoHXnF6ayLpHkOnJ7Y
        6rJdAOFRNIiGnYLnOWWAcns=
X-Google-Smtp-Source: AH8x226sfBnj+yzrOwt5zA+C1u1GP2LuOCV65KpqyaDv/+Jcgpi1rsEFBWaV/HzDOrngyu4ktvWXPg==
X-Received: by 10.223.142.3 with SMTP id n3mr505963wrb.151.1518645401714;
        Wed, 14 Feb 2018 13:56:41 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id l2sm13277506wre.6.2018.02.14.13.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Feb 2018 13:56:40 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] t/known-leaky: add list of known-leaky test scripts
Date:   Wed, 14 Feb 2018 22:56:37 +0100
Message-Id: <20180214215637.6462-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a
In-Reply-To: <xmqqo9kro4oq.fsf@gitster-ct.c.googlers.com>
References: <xmqqo9kro4oq.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's what a list of known leaks might look like. It feels a bit
awkward to post a known-incomplete list (I don't run all tests). Duy
offered to pick up the ball if I gave up, maybe you could complete and
post this as your own? :-? Even if I (or others) can't reproduce the
complete list locally, regressions will be trivial to find, and newly
leak-free tests fairly easy to notice.

I'm not sure if the shamelessly stolen shell snippets warrant their own
scripts, or how make targets overriding various variables would be
received. At least they're in the commit message.

-- >8 --
We have quite a lot of leaks in the code base. Using SANITIZE=leak, it
is easy to find them, and every now and then we simply stumble upon one.
Still, we can expect it to take some time to get to the point where
`make SANITIZE=leak test` succeeds.

Until that happens, it would be nice if we could at least try not to
regress in the sense that a test tXXXX which was at one point leak-free
turns leaky. Such a regression would indicate that leak-free code
turned leaky, that a new feature is leaky, or that we simply happen to
trigger an existing leak as part of a newly added/modified test.

To that end, introduce a list of known-leaky tests, i.e., a list of
tXXXX-values. Now this will be able to find such regressions:

    make SANITIZE=leak test GIT_SKIP_TESTS="$(cat t/known-leaky)"

The list was generated, and can be updated, as follows:

    # Assume we're using prove, which will keep running after failure,
    # and will record the results for us to parse (using "--state=").
    # Otherwise use "make -k" and grep in t/test-results.
    GIT_TEST_OPTS=-i make SANITIZE=leak test
    cd t
    prove --dry --state=failed |
    perl -lne '/^(t[0-9]{4})-.*\.sh$/ and print $1' |
    sort >known-leaky

The list added in this commit might be incomplete, since I do not run
all tests (I'm missing svn, cvs, p4, Windows-only and
filesystem-dependent tests, as well as "writeable /"). The majority of
these do not primarily test our C code, but all of them might trigger
leaks, in which case they would belong in this list.

Suggested-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/known-leaky | 539 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 539 insertions(+)
 create mode 100644 t/known-leaky

diff --git a/t/known-leaky b/t/known-leaky
new file mode 100644
index 0000000000..80a0af4d09
--- /dev/null
+++ b/t/known-leaky
@@ -0,0 +1,539 @@
+t0002
+t0003
+t0006
+t0008
+t0009
+t0012
+t0020
+t0021
+t0023
+t0040
+t0050
+t0056
+t0060
+t0062
+t0064
+t0070
+t0090
+t0100
+t0101
+t0110
+t0203
+t0300
+t0301
+t0302
+t1001
+t1002
+t1004
+t1005
+t1006
+t1007
+t1008
+t1011
+t1012
+t1013
+t1020
+t1021
+t1050
+t1051
+t1090
+t1301
+t1302
+t1304
+t1306
+t1308
+t1350
+t1400
+t1401
+t1402
+t1403
+t1404
+t1405
+t1406
+t1407
+t1408
+t1409
+t1410
+t1411
+t1412
+t1413
+t1414
+t1430
+t1450
+t1500
+t1502
+t1505
+t1507
+t1508
+t1510
+t1511
+t1512
+t1514
+t1700
+t2007
+t2008
+t2009
+t2010
+t2011
+t2012
+t2013
+t2014
+t2015
+t2016
+t2017
+t2018
+t2019
+t2020
+t2021
+t2022
+t2023
+t2024
+t2025
+t2026
+t2027
+t2030
+t2103
+t2106
+t2200
+t2203
+t2204
+t3001
+t3004
+t3005
+t3007
+t3010
+t3020
+t3030
+t3031
+t3032
+t3033
+t3034
+t3040
+t3050
+t3060
+t3200
+t3201
+t3202
+t3203
+t3204
+t3205
+t3210
+t3301
+t3302
+t3303
+t3304
+t3306
+t3307
+t3308
+t3309
+t3310
+t3311
+t3400
+t3402
+t3403
+t3404
+t3405
+t3406
+t3407
+t3408
+t3409
+t3410
+t3411
+t3412
+t3413
+t3414
+t3415
+t3416
+t3417
+t3418
+t3419
+t3420
+t3421
+t3425
+t3426
+t3427
+t3428
+t3429
+t3500
+t3501
+t3502
+t3503
+t3504
+t3505
+t3506
+t3507
+t3508
+t3509
+t3510
+t3511
+t3512
+t3513
+t3600
+t3700
+t3701
+t3800
+t3900
+t3901
+t3903
+t3904
+t3905
+t3906
+t4001
+t4008
+t4010
+t4013
+t4014
+t4015
+t4016
+t4017
+t4018
+t4020
+t4021
+t4022
+t4023
+t4026
+t4027
+t4028
+t4030
+t4031
+t4036
+t4038
+t4039
+t4041
+t4042
+t4043
+t4044
+t4045
+t4047
+t4048
+t4049
+t4051
+t4052
+t4053
+t4055
+t4056
+t4057
+t4059
+t4060
+t4061
+t4064
+t4065
+t4103
+t4107
+t4108
+t4111
+t4114
+t4115
+t4117
+t4118
+t4120
+t4121
+t4122
+t4124
+t4125
+t4127
+t4131
+t4135
+t4137
+t4138
+t4150
+t4151
+t4152
+t4153
+t4200
+t4201
+t4202
+t4203
+t4204
+t4205
+t4206
+t4207
+t4208
+t4209
+t4210
+t4211
+t4212
+t4213
+t4252
+t4253
+t4254
+t4255
+t4300
+t5000
+t5001
+t5002
+t5003
+t5004
+t5100
+t5150
+t5300
+t5301
+t5302
+t5303
+t5304
+t5305
+t5306
+t5310
+t5311
+t5312
+t5313
+t5314
+t5315
+t5316
+t5317
+t5400
+t5401
+t5402
+t5403
+t5404
+t5405
+t5406
+t5407
+t5408
+t5500
+t5501
+t5502
+t5503
+t5504
+t5505
+t5506
+t5509
+t5510
+t5512
+t5513
+t5514
+t5515
+t5516
+t5517
+t5518
+t5519
+t5520
+t5521
+t5522
+t5523
+t5524
+t5525
+t5526
+t5527
+t5528
+t5531
+t5532
+t5533
+t5534
+t5535
+t5536
+t5537
+t5538
+t5539
+t5540
+t5541
+t5542
+t5543
+t5544
+t5545
+t5546
+t5547
+t5550
+t5551
+t5560
+t5561
+t5570
+t5571
+t5572
+t5573
+t5600
+t5601
+t5603
+t5604
+t5605
+t5606
+t5607
+t5609
+t5610
+t5611
+t5612
+t5613
+t5614
+t5700
+t5801
+t5802
+t5810
+t5811
+t5812
+t5813
+t5814
+t5815
+t5900
+t6000
+t6002
+t6003
+t6004
+t6006
+t6007
+t6008
+t6009
+t6010
+t6011
+t6012
+t6013
+t6014
+t6015
+t6016
+t6017
+t6018
+t6019
+t6020
+t6021
+t6022
+t6024
+t6025
+t6026
+t6027
+t6028
+t6029
+t6030
+t6031
+t6032
+t6033
+t6034
+t6035
+t6036
+t6037
+t6038
+t6040
+t6041
+t6042
+t6044
+t6045
+t6050
+t6060
+t6100
+t6101
+t6110
+t6111
+t6112
+t6120
+t6130
+t6131
+t6132
+t6133
+t6134
+t6200
+t6300
+t6301
+t6302
+t6500
+t6501
+t7001
+t7003
+t7004
+t7005
+t7006
+t7007
+t7008
+t7009
+t7010
+t7011
+t7012
+t7030
+t7060
+t7061
+t7062
+t7063
+t7064
+t7102
+t7103
+t7104
+t7105
+t7106
+t7110
+t7111
+t7112
+t7201
+t7300
+t7301
+t7400
+t7401
+t7402
+t7403
+t7405
+t7406
+t7407
+t7408
+t7409
+t7410
+t7411
+t7412
+t7413
+t7414
+t7500
+t7501
+t7502
+t7503
+t7504
+t7505
+t7506
+t7507
+t7508
+t7509
+t7510
+t7511
+t7512
+t7513
+t7514
+t7515
+t7516
+t7517
+t7519
+t7520
+t7521
+t7600
+t7601
+t7602
+t7603
+t7604
+t7605
+t7606
+t7607
+t7608
+t7609
+t7610
+t7611
+t7612
+t7613
+t7614
+t7700
+t7701
+t7702
+t7800
+t7810
+t7811
+t7814
+t8001
+t8002
+t8003
+t8004
+t8005
+t8006
+t8007
+t8008
+t8009
+t8010
+t8011
+t9001
+t9002
+t9003
+t9004
+t9010
+t9020
+t9300
+t9301
+t9302
+t9303
+t9350
+t9351
+t9500
+t9502
+t9700
+t9902
+t9903
-- 
2.16.1.72.g5be1f00a9a

