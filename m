Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 647EB2018A
	for <e@80x24.org>; Sat,  2 Jul 2016 19:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbcGBTB4 (ORCPT <rfc822;e@80x24.org>);
	Sat, 2 Jul 2016 15:01:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35336 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbcGBTBz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2016 15:01:55 -0400
Received: by mail-wm0-f65.google.com with SMTP id a66so12673009wme.2
        for <git@vger.kernel.org>; Sat, 02 Jul 2016 12:01:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=0+puueIIhBH0/6DugB8C1MElhSXTNWBMwHFz/b8B5uM=;
        b=XsuVpk5IgL8cWzN2tnH2orC0iDa2pvIPBM7Q+ZHIxSvEhugOKbucilKaGId6eMb7Ya
         3uH6YCqAk2e7byjJG0jziqpSIMoFPc3x2anpTqVmGvQ/EX+wwmu/RyD9bXOz5DPPdutv
         rt1JOOS36LFBxRzqWsQFl88V68LRwaSWP0BaASeqqIFZn4/b1Qb7uKPKkhOXmWJF3aCC
         zoniyjIgI6OOlyEYXbuItQpwVXSJ+MNwO2ZPR9gSLBtFHE71mxECeyODdh45mYdagb8p
         M0AZdOm+QhaXaaxXdGiRllW56VMkpS3JsaCLMINX4wnI0vNDUb7zbjN841CIuwWrFf/F
         jZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=0+puueIIhBH0/6DugB8C1MElhSXTNWBMwHFz/b8B5uM=;
        b=HLKQJd/Z/yGMNFWkOq7HCPn9nIcOm4rvJcwwD4Mj23fVnoufAxCoHpgAFtifueVEYd
         hDei3AFFNlokno4Bp2N4xACOFFJVLBqhqFJFrTYB+e7TKmf132HT6Mw4Pa8lstuMG5hd
         B7+emtJyaNHdUmh99hIQF9zhlTFA0RTy6Pozko1IDlQ7Jt6vEBz3p/tNgdYClQUy/Hhb
         oB/H+1zVba/eFta6lfZNV6FGfKFUHsBkEgWYQ6PxQkKIHpvBh/bHDsj6p1NsCMXU3q0m
         n+xuH502dzZ6oYZZCSztwbi4+mQlHy4z5DsTZLcdApD/QTTUKveLgmWmSrbxSXx6I+sO
         o05A==
X-Gm-Message-State: ALyK8tJmovhvMHV0oGRlomkvtwLqEB3kPbP9I6rOKk5gq3vcrluuVlxwNfklObAN1qfvfg==
X-Received: by 10.28.210.83 with SMTP id j80mr3915147wmg.54.1467486113989;
        Sat, 02 Jul 2016 12:01:53 -0700 (PDT)
Received: from ?IPv6:2001:4dd0:f840:0:225:22ff:fe02:19c9? ([2001:4dd0:f840:0:225:22ff:fe02:19c9])
        by smtp.gmail.com with ESMTPSA id c74sm3644685wme.1.2016.07.02.12.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Jul 2016 12:01:53 -0700 (PDT)
To:	Git List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:	Armin Kunaschik <megabreit@googlemail.com>
Subject: [PATCH] t7610 test for mktemp existence
Message-ID: <57780F9F.3050802@googlemail.com>
Date:	Sat, 2 Jul 2016 21:01:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Subject: t7610: test for mktemp before test execution

mktemp is not available on all platforms, so the test
'temporary filenames are used with mergetool.writeToTemp'
fails there.
This patch does not replace mktemp but just disables
the test that otherwise would fail.
mergetool checks itself before executing mktemp and
reports an error.

Signed-off-by: Armin Kunaschik <megabreit@googlemail.com>

---

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 76306cf..9279bf5 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -589,7 +589,12 @@ test_expect_success 'filenames seen by tools start with ./' '
 	git reset --hard master >/dev/null 2>&1
 '

-test_expect_success 'temporary filenames are used with mergetool.writeToTemp' '
+test_lazy_prereq MKTEMP '
+	tempdir=$(mktemp -d -t foo.XXX) &&
+	test -d "$tempdir"
+'
+
+test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToTemp' '
 	git checkout -b test16 branch1 &&
 	test_config mergetool.writeToTemp true &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&

