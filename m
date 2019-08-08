Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70ABC1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 12:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbfHHMxq (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 08:53:46 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46906 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfHHMxq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 08:53:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id z15so62492125lfh.13
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 05:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lE+Rna5pm4KnNYq6lgsLMPmy9FQO5dWbaneMde7iBQ0=;
        b=ogSNmJUeNVDUj9zzMtUAl+TkjT2IRf3hkXOMykUiug3Gwnrx0epIaXbecTfjFHxYlU
         RI1Pa0r1pkSFfVfK4IQqFeeqWDhkHFUT1QpacqtkTGOMTTUrfDaul+auekYFntS+cXHa
         B3UWvxYkyi82V21CMoFtv2yCekTfn1IS3OTaf15MMHazDj1H3tnvdykM8BO+SPfM/sj5
         C2BGrORPtvA82i9GRwvDW0mEfSFiqTuJE/LkG97iu1Z7l6f9Wgle6l3Wu9tYaw0XGaK5
         PiXY2+vpaT0ripwxe2XlVRAJDRl+IW76zdW3ECI6IoLKP7cTODqu0aWsB1eJ+B9sM4Dz
         kr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lE+Rna5pm4KnNYq6lgsLMPmy9FQO5dWbaneMde7iBQ0=;
        b=o18fAgQZ++kzAQeVbX38XJTYCL1/h3H3he5a8413i5t2xZKFdHw1Fyr7qIk+iJ/Hh5
         FeHf8gFnM/lhfB9H/nxMkJ3dSJdmEykhr6wXqwSSFT++6MmI+nLtJ8sbwsSPMA+0sLNA
         VT7tmB24h3T72c0lbeSc/xwt6nRBlHLC+QdLl7ooukGbnwMLZsAb5WLZgBZsDMjDz5a7
         UzIF4pduRa5SWa+dTnNhl0tF/40+3LDgNNqp7AFqCezW5drFmgJQJvdp/2fzxSQmkxlG
         EXje7iG1rZMWDNAttcTygb6dkS9Hu/nuQuXCuRLVWOHK5hiHf8dMIdf3sYW7gcqdwJs+
         Kfww==
X-Gm-Message-State: APjAAAXuKaBpLIvnMGL6+aRbXZhgANzdCg27nSRUOV6AhLgMlWqG7o6t
        TzJsbBn/HRB1lvDX5LS2l85wOwrA
X-Google-Smtp-Source: APXvYqwJQHCj+yxEwoqv2Arh4L24IbMpyfcipjymElCf+ciilAUF+MZqC51UlingRL7kZRWa6S/WGA==
X-Received: by 2002:a05:6512:70:: with SMTP id i16mr9140110lfo.26.1565268823840;
        Thu, 08 Aug 2019 05:53:43 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id b192sm16831509lfg.75.2019.08.08.05.53.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 05:53:42 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] t7004: check existence of correct tag
Date:   Thu,  8 Aug 2019 14:53:30 +0200
Message-Id: <20190808125330.3104954-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc0.30.g51cf315870
In-Reply-To: <CAN0heSptKHL8mrU9DTXT9T7HDN56a3+DAGczxkEtbGxp9sB8hg@mail.gmail.com>
References: <CAN0heSptKHL8mrU9DTXT9T7HDN56a3+DAGczxkEtbGxp9sB8hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We try to delete the non-existing tag "anothertag", but for the
verifications, we check that the tag "myhead" doesn't exist. "myhead"
isn't used in this test except for this checking. Comparing to the test
two tests earlier, it looks like a copy-paste mistake.

Perhaps it's overkill to check that `git tag -d` didn't decide to
*create* a tag. But since we're trying to be this careful, let's
actually check the correct tag. While we're doing this, let's use a more
descriptive tag name instead -- "nonexistingtag" should be obvious.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---

 > Probably worth inspecting the output of that `git tag -d` a bit in
 > t7004, to make sure we just claim to delete one tag, and have errors.

 Here's something I noticed while looking into this test. If you do
 expand on this test, feel free to pick this up, either as a preparatory
 patch or squash it into your "expand test" patch (if you do one). If
 you don't pick this up at all, I'll pursue it separately, later.

 Martin

 t/t7004-tag.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 80eb13d94e..e4cf605907 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -227,10 +227,10 @@ test_expect_success \
 test_expect_success \
 	'trying to delete two tags, existing and not, should fail in the 2nd' '
 	tag_exists mytag &&
-	! tag_exists myhead &&
-	test_must_fail git tag -d mytag anothertag &&
+	! tag_exists nonexistingtag &&
+	test_must_fail git tag -d mytag nonexistingtag &&
 	! tag_exists mytag &&
-	! tag_exists myhead
+	! tag_exists nonexistingtag
 '
 
 test_expect_success 'trying to delete an already deleted tag should fail' \
-- 
2.23.0.rc0.30.g51cf315870

