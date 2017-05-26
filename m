Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C5591FA14
	for <e@80x24.org>; Fri, 26 May 2017 15:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947923AbdEZPZc (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 11:25:32 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34383 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947935AbdEZPZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 11:25:16 -0400
Received: by mail-pf0-f195.google.com with SMTP id w69so3502430pfk.1
        for <git@vger.kernel.org>; Fri, 26 May 2017 08:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UJiBH0UpOhM4+3ylrA1XlRDw1+g7hgsbBaGb1kTXeT0=;
        b=EXUts7UgsxvBBMgY5bpLOyK9f4wZc3pJ/JghPIcLFdf8ExR1+XfmS562hazqGgdl+T
         yJ0pzF0kIn7JG/7W56pTyeNZucdsuhnDWbwoiOmHER0M5mpgo+Dl34SAcxsMbw7IuYd7
         AG2gfi0fEJ7YQthGwFEhT1iBQEE+s17v481xRJTbLzbKU9LH8y7yJrrj1E5SXR9BLk9N
         XRfM1GeY4py403e9xJuW0M5+P0vz1Vg4LF9KIqIjoh1S+OIgGC0XCoEtrh1yeST5NAGl
         VlXLr9CrjnO8xDVAY+I0HT9Ip9zQ+xOW3VS4qz2kyl6Gj1ivEp6zTyp2fE2OjNmIXal9
         TPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UJiBH0UpOhM4+3ylrA1XlRDw1+g7hgsbBaGb1kTXeT0=;
        b=gYRr8UsOytOpcvhfz4MXYvMJg50LxHSfjZoRyiRHyDWdiUUhz5BXPUSk2TosA1/r5g
         FGw2Gr/Mb2D8ORoDe9fhtVVcKsIXWejh4TOU5az7m3wp0af+R6IoFpob3kbhVl8vnOLQ
         wj46QdIXj+q0lHCMDVobBsENCk/Qc8l8KpsJdK1Z43msR0olsZutvjdUJJBxsvt/+3jC
         ek1InHAlblUwawtCzymjlYzWwgMRY/UqX0CK9G9HmNh9DiAEC7CHxCX13xr1T07IrV3B
         eJ/mpYTU2conu4cmVZkCDXLQM8Wjsc+WDmvxUtJJRLDpCqNpgNPkytWkSh3YPyyZFouK
         z3NA==
X-Gm-Message-State: AODbwcC0wROtWN0+ctZ4W4CK2xb0465kfQzbdzuuJ34dla44OkYTrQup
        hc/zOH6n6cRjyn+rmNU=
X-Received: by 10.98.137.93 with SMTP id v90mr2989461pfd.69.1495811850319;
        Fri, 26 May 2017 08:17:30 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.73.225])
        by smtp.gmail.com with ESMTPSA id e24sm3105198pgn.1.2017.05.26.08.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 May 2017 08:17:29 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, christian.couder@gmail.com,
        ramsay@ramsayjones.plus.com, sbeller@google.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH v5 2/3] t7407: test "submodule foreach --recursive" from subdirectory added
Date:   Fri, 26 May 2017 20:47:12 +0530
Message-Id: <20170526151713.10974-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170526151713.10974-1-pc44800@gmail.com>
References: <20170521125814.26255-2-pc44800@gmail.com>
 <20170526151713.10974-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Additional test cases added to the submodule-foreach test suite
to check the submodule foreach --recursive behavior from a
subdirectory as this was missing from the test suite.

Helped-by: Brandon Williams <bmwill@google.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
Additional test added to check the bug fixed in the [PATCH v5 1/3] of
this patch series.

 t/t7407-submodule-foreach.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 6ba5daf42..1c8d132d8 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -197,6 +197,40 @@ test_expect_success 'test messages from "foreach --recursive" from subdirectory'
 	test_i18ncmp expect actual
 '
 
+sub1sha1=$(cd clone2/sub1 && git rev-parse HEAD)
+sub2sha1=$(cd clone2/sub2 && git rev-parse HEAD)
+sub3sha1=$(cd clone2/sub3 && git rev-parse HEAD)
+nested1sha1=$(cd clone2/nested1 && git rev-parse HEAD)
+nested2sha1=$(cd clone2/nested1/nested2 && git rev-parse HEAD)
+nested3sha1=$(cd clone2/nested1/nested2/nested3 && git rev-parse HEAD)
+submodulesha1=$(cd clone2/nested1/nested2/nested3/submodule && git rev-parse HEAD)
+
+cat >expect <<EOF
+Entering '../nested1'
+$pwd/clone2-nested1-../nested1-$nested1sha1
+Entering '../nested1/nested2'
+$pwd/clone2/nested1-nested2-../nested1/nested2-$nested2sha1
+Entering '../nested1/nested2/nested3'
+$pwd/clone2/nested1/nested2-nested3-../nested1/nested2/nested3-$nested3sha1
+Entering '../nested1/nested2/nested3/submodule'
+$pwd/clone2/nested1/nested2/nested3-submodule-../nested1/nested2/nested3/submodule-$submodulesha1
+Entering '../sub1'
+$pwd/clone2-foo1-../sub1-$sub1sha1
+Entering '../sub2'
+$pwd/clone2-foo2-../sub2-$sub2sha1
+Entering '../sub3'
+$pwd/clone2-foo3-../sub3-$sub3sha1
+EOF
+
+test_expect_success 'test "submodule foreach --recursive" from subdirectory' '
+	(
+		cd clone2 &&
+		cd untracked &&
+		git submodule foreach --recursive "echo \$toplevel-\$name-\$sm_path-\$sha1" >../../actual
+	) &&
+	test_i18ncmp expect actual
+'
+
 cat > expect <<EOF
 nested1-nested1
 nested2-nested2
-- 
2.11.0

