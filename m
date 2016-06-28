Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D48972018A
	for <e@80x24.org>; Tue, 28 Jun 2016 18:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbcF1SYi (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 14:24:38 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33757 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbcF1SYh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 14:24:37 -0400
Received: by mail-pf0-f171.google.com with SMTP id i123so9170507pfg.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 11:24:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=IbkXN8JJ8+56z1EczzM9SnlZm04bFlr2BI1aSMpLBPg=;
        b=K6FiOZb0AK4T1h/fQdiQttQEAPZndh8qdhYwS/ZCgM4mrnkQhEkpdH2/SJeyMd+vWN
         sAcC+/1uJt80Sm7Z7ZY03ZiELfd/+HIxKUBFLdtE2BKpldcZd7QH6v6N/sLbvw19srx3
         q3mevtsBcrUqS9AigvFyTVrgD8jRydhD1irJ4WTTnzN9mJTkwesJjqT3lMNmF71pXph7
         FWxDwEYASO5EvZLxQKMV5arMmVu0xh4pJpkrksRvmUhoWTJFwcbdorcq3p5eD6yz2Xig
         ehoNO1u7ad+e4lc03Ai5Er8ypabysJB2bGqsAdvNXtudQZFu9KWwX/qTC0mgBtNDVZRC
         36Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IbkXN8JJ8+56z1EczzM9SnlZm04bFlr2BI1aSMpLBPg=;
        b=adf3yHKjqxDdImmUF5T/+2Ykn6fplOKh2nA7hwOGRKqF5rahZwzOo7l0b1ejTy0vJ8
         VvHJ+Iwiyl8Ur/0qi3L9oq8Y8Bj+QHRTilsXSYHLicfbngCo5zLmMaFHLgpxW9gThZpl
         b4NwOgaIEH2MdlGmvPAaKfef3zfAs8MDjA9wax0w+Y4iUP+Tykz427TxILajW+oHEIp/
         hb9g3izOyC1q+nk+vuhoCmNN03+rXE07oRsEqmqHU2iPPyQKN9p6781OWe7PAexZpT5q
         ouwUmMYiR6N/YmEBXPq8dcep//WmjctTHzwhLYzYGE9hBc64cLSvdxapDSO2IwAz98KF
         x/ww==
X-Gm-Message-State: ALyK8tKQIBRA91d4IyQluFPVmyKcUYrWGC8xlCKs43SJVRIRz1+f/ZSkVj2M2PQZBRDm+6H+
X-Received: by 10.98.55.1 with SMTP id e1mr4125177pfa.107.1467138263890;
        Tue, 28 Jun 2016 11:24:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:dcf7:dd57:931a:7d23])
        by smtp.gmail.com with ESMTPSA id i8sm1309807pao.26.2016.06.28.11.24.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Jun 2016 11:24:22 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	bartbogaerts@gmail.com
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] submodule: test moving recursive submodule
Date:	Tue, 28 Jun 2016 11:24:19 -0700
Message-Id: <20160628182419.8023-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.138.g8a4fcb8.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This reproduces the error as pointed out in [1], but the fix is not easy,
so punt on it for now and just document what needs to be done.

[1] http://stackoverflow.com/questions/32782382/git-moving-submodules-recursively-nested-submodules

Signed-off-by: Stefan Beller <sbeller@google.com>
---

  Bart,
  
  I don't have the time fixing this properly,
  so this is the best I can come up with for now. 
  
  Thanks,
  Stefan

 builtin/mv.c  |  4 ++++
 t/t7001-mv.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/builtin/mv.c b/builtin/mv.c
index a201426..36dd2fd 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -264,6 +264,10 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				connect_work_tree_and_git_dir(dst, submodule_gitfile[i]);
 			if (!update_path_in_gitmodules(src, dst))
 				gitmodules_modified = 1;
+			/**
+			 * NEEDSWORK: We need to recurse into the submodule
+			 * and fix the nested submodules as well.
+			 */
 		}
 
 		if (mode == WORKING_DIRECTORY)
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 4a2570e..fe933f1 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -295,6 +295,28 @@ test_expect_success 'setup submodule' '
 	mkdir -p deep/directory/hierachy &&
 	git submodule add ./. deep/directory/hierachy/sub &&
 	git commit -m "added another submodule" &&
+	mkdir inner_sub &&
+	(
+		cd inner_sub &&
+		git init &&
+		test_commit initial
+	) &&
+	mkdir outer_sub &&
+	(
+		cd outer_sub &&
+		git init &&
+		test_commit initial &&
+		git submodule add ../inner_sub &&
+		git commit -a -m "add an inner submodule"
+	) &&
+	git submodule add ./outer_sub ./deep/outer_sub &&
+	git commit -a -m "add outer sub" &&
+	git -C deep ls-tree HEAD |cut -f 2 >actual &&
+	cat >expect <<-EOF &&
+	directory
+	outer_sub
+	EOF
+	test_cmp expect actual &&
 	git branch submodule
 '
 
@@ -488,6 +510,18 @@ test_expect_success 'moving a submodule in nested directories' '
 		git config -f ../.gitmodules submodule.deep/directory/hierachy/sub.path >../actual &&
 		echo "directory/hierachy/sub" >../expect
 	) &&
+	test_cmp actual expect &&
+	git commit -a -m "mv a submodule in nested dir"
+'
+
+test_expect_failure 'moving a submodule with a nested submodule' '
+	git submodule update --init --recursive &&
+	git mv deep/outer_sub outer_sub_moved &&
+	# git status would fail if the update of linking git dir to
+	# work dir of the submodule failed.
+	git status &&
+	git config -f .gitmodules submodule.deep/outer_sub.path >actual &&
+	echo "outer_sub_moved" >expect &&
 	test_cmp actual expect
 '
 
-- 
2.9.0.138.g8a4fcb8.dirty

