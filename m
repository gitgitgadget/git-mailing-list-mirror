Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6802B779
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VemfruM4"
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFD583
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 08:52:11 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c1c66876aso756065066b.2
        for <git@vger.kernel.org>; Mon, 16 Oct 2023 08:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697471530; x=1698076330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mk1Xz8HpC5YPdnh9VFn70QmpDVyts4uSRAgTs+vUIpc=;
        b=VemfruM4DC79gBfstlALMKQNQAURc3/jcueRvFgOEbcNnk+rc/Dz3gpshJ0TBx/cMh
         pGnd3xu2ggM/GNhRt0+id/t5DNPLRiiC8cbuAEHsIiimNdcYUs2n2+oExI3aKznZUfFu
         bsVh5NbjSBFVSn55wnHdgJNOJHsNNxOhLT8NyzDUQzuiKHxPg/xiSq1s/dYxMpXLL9Sb
         jPXO8vyRkdbliJ7WiCBKytoNYybf3itJMA27DGumiaDvjSOpN9GcV+QbfW9iv0dkUzVE
         okqA0eAbWJVhRHBydf4sGG8oS6M0zHqxnUyETxBrUR5qMc6FfoNY2bN2nAuC3gNy+hCj
         hHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697471530; x=1698076330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mk1Xz8HpC5YPdnh9VFn70QmpDVyts4uSRAgTs+vUIpc=;
        b=PtZM5JKove3Vl0UPqJkflT1sgYTs5iukhf+qUgDyi1MB78VqmV/XqeKLUODrHIEcMX
         Q2uyQyCQzMCbJZVj7HCBttjOs0fBmqRj96prBZWlZzNv2FmRS9v153H+k3bzbmEZqdCv
         JZX/xhNZM7G3BJBvpQSnv94HJy9jipl+lrYF8fNO0iWEcCHrCVHTjtFdtXJUcX0ilht/
         JCo1mX7+AX34HMWxc1pBboyW2VtYFovOjtmfvw0//FzeYGUOIbQ7x+g+8WfRBfsQ+pB2
         Q6zVZyORdRNyfuse7o1U691zy9Jb1U9qlSwRuV0s6ZQJFRXEsCftsGQFEzf8hUyUi26n
         KU/A==
X-Gm-Message-State: AOJu0Yz4l5xAoQaO/RkxfTkwOfbR3fqcGCeJZbrH+P/aAPlCgeHg/9jd
	BQJrvJjhmYfwh8DPR5sfCMhhqDc5Me/LYnc=
X-Google-Smtp-Source: AGHT+IEEPLwjKSt/bDBOR1VoUVJMB9NLDF0ttV4iBgfGwHC+GKWy+9D/VvUfKmiZ8vMzN85ld6+Ejw==
X-Received: by 2002:a17:906:c108:b0:9be:fc60:32d9 with SMTP id do8-20020a170906c10800b009befc6032d9mr5762106ejc.47.1697471529974;
        Mon, 16 Oct 2023 08:52:09 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine.localdomain ([105.163.1.143])
        by smtp.gmail.com with ESMTPSA id z2-20020a170906668200b009adc77fe164sm4267915ejo.66.2023.10.16.08.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 08:52:09 -0700 (PDT)
From: Dorcas AnonoLitunya <anonolitunya@gmail.com>
To: christian.couder@gmail.com
Cc: anonolitunya@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com
Subject: [[Outreachy]PATCH v2] t/t7601: Modernize test scripts using functions
Date: Mon, 16 Oct 2023 18:50:11 +0300
Message-ID: <20231016155059.137057-2-anonolitunya@gmail.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The test script is currently using the command format 'test -f' to
check for existence or absence of files.

Replace it with new helper functions following the format
'test_path_is_file'.

Consequently, the patch also replaces the inverse command '! test -f' or
'test ! -f' with new helper function following the format
'test_path_is_missing'

This adjustment using helper functions makes the code more readable and
easier to understand.

Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
---
Changes in v2:
  - Add Outreachy to subject line

 t/t7601-merge-pull-config.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index bd238d89b0..e08767df66 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -349,13 +349,13 @@ test_expect_success 'Cannot rebase with multiple heads' '
 
 test_expect_success 'merge c1 with c2' '
 	git reset --hard c1 &&
-	test -f c0.c &&
-	test -f c1.c &&
-	test ! -f c2.c &&
-	test ! -f c3.c &&
+	test_path_is_file c0.c &&
+	test_path_is_file c1.c &&
+	test_path_is_missing c2.c &&
+	test_path_is_missing c3.c &&
 	git merge c2 &&
-	test -f c1.c &&
-	test -f c2.c
+	test_path_is_file c1.c &&
+	test_path_is_file c2.c
 '
 
 test_expect_success 'fast-forward pull succeeds with "true" in pull.ff' '
@@ -411,8 +411,8 @@ test_expect_success 'merge c1 with c2 (ours in pull.twohead)' '
 	git reset --hard c1 &&
 	git config pull.twohead ours &&
 	git merge c2 &&
-	test -f c1.c &&
-	! test -f c2.c
+	test_path_is_file c1.c &&
+	test_path_is_missing c2.c
 '
 
 test_expect_success 'merge c1 with c2 and c3 (recursive in pull.octopus)' '
@@ -431,10 +431,10 @@ test_expect_success 'merge c1 with c2 and c3 (recursive and octopus in pull.octo
 	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
 	test "$(git rev-parse c3)" = "$(git rev-parse HEAD^3)" &&
 	git diff --exit-code &&
-	test -f c0.c &&
-	test -f c1.c &&
-	test -f c2.c &&
-	test -f c3.c
+	test_path_is_file c0.c &&
+	test_path_is_file c1.c &&
+	test_path_is_file c2.c &&
+	test_path_is_file c3.c
 '
 
 conflict_count()
-- 
2.42.0.345.gaab89be2eb

