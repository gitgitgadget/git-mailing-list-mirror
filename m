Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAF618B478
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604548; cv=none; b=MZa/A0Svda2ngc3LraIKdU3A9hkPDv7HxzrsB7zBlT1HIBoPEDOlJZP4l7mjz5l2men3gxlitz+a5frnzekzKmOKmAOsGAGEGAc+D0RuUhO+AP9mCNNpJQUWVniYSTp7EeuO4I5OCOm224ep0BFZtb8QWRodGXtMPSSJ+V2OvcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604548; c=relaxed/simple;
	bh=Ya+dOM+CJrEShfDttPbWappCCz/fwz32CUq2vK1Hiuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dxzFlich2//rO2ptNvd1KNMkSwN8OndT8P98jKntHQtWHZ8O2r163vt+EnKhXMtr3NE+kNsBr6Bd7lutg7oBHopNxeTz3O+RoCAosp+nf+1EryJV8N9CgBVJfayE0i2vyz6/6KLcoQjxsdhIz8n0ChMn5RWUMa168kt/F8+qXlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGI8PI8k; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGI8PI8k"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so693267b3a.0
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 09:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731604546; x=1732209346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qq/5ti56TzX4P470KKNev74QgwdqJOxArvI37ZIUNPg=;
        b=BGI8PI8kNYH3qsxzS+BA4nyLcPzw6WEDKmTG4VWwHvSALBf2Rov8tTrTJOwzDmS+h4
         2EHwWHGO3axxGMloxhyx2YxDh6Rz17EhfbvYHAZyt9P9uEttBwB9AiEjRvBpLkJlRhqU
         d7CauFo8lkSBX9vy6gbo7nHjlFU/myTFvx2VmTfE2wi1RFbc2YED49pyH1nsJuEje9jT
         evzO2ldKNv9aRS6pZKkJ8z++P6HHEbv8QF2mdQCeXdp+98ppevQ8/MaSGEN6BBD08+LL
         /+cSHoiW3VcnnmlORvqC+2Xj3w4HQuiNpdOddSx7X2bDoF1x7jmETYBDXkVPCgNmXm7q
         rMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731604546; x=1732209346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qq/5ti56TzX4P470KKNev74QgwdqJOxArvI37ZIUNPg=;
        b=HI0PfbYjIAyzYbLDbR6NNx36+fAw/mzmF5uSG5N9+E9emTH4sqpUceTSwSheh+thAA
         GMMazecW/Tl18y7yS+nTJaxII9tnuDhfkbevQ2fkKl0Y06KG2UslM5lMMbgey7xjdpww
         FQiZqLvBxMuCVVUWFC8fyw76SEJMV3FB4+Tkm/Jk8ED+o62hQDYk5caHe2mcfkBunq7b
         +7At4/b3fr4VQ7mtkTO75W4fgPtgTf/ccqtsRIAmicrB8yB9DG3rkM8k2OVlxXHheBG2
         RJU6QZ3SbuT5AognZjCJ3Eo1/+TaRV4kTMy5cw3eIHjDgA9XCkwo2vnDZb5wy0YMDJUN
         Rzlw==
X-Gm-Message-State: AOJu0YxpODFSpodJwKR1ubPAFXR0B/IHevmlgLEPJL+C2ua3DASuneOs
	sF2buV+bk6l6HvSjWeCcjxpvTafM8ehjn+cIp71QEgd+x1gqISGfkvQytg==
X-Google-Smtp-Source: AGHT+IEUggk101CjKoGI+LWlqt01oca4Ukd6tB+tnCgHRopTT8DZMClVTdsSWkpTPzuRJpcotaaq/Q==
X-Received: by 2002:aa7:88c8:0:b0:71e:1b6d:5a94 with SMTP id d2e1a72fcca58-72469c5df89mr3722624b3a.5.1731604546467;
        Thu, 14 Nov 2024 09:15:46 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7246a9bab91sm1539883b3a.149.2024.11.14.09.15.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2024 09:15:46 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Cc: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH v2 3/6] t5504: modernize test by moving heredocs into test bodies
Date: Fri, 15 Nov 2024 01:15:34 +0800
Message-Id: <1ab87d3b30399200e0fb440378b63e634bdbee2d.1731603991.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>
References: <CANYiYbHGdJsTgdzJj1r4sPdTAcZCf3C-qA538fcXbD1jjB1BUw@mail.gmail.com> <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrick Steinhardt <ps@pks.im>

We have several heredocs in t5504 located outside of any particular test
bodies. Move these into the test bodies to match our modern coding
style.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5504-fetch-receive-strict.sh | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index bf33cc69d0..56b31cf557 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -65,11 +65,6 @@ test_expect_success 'fetch with transfer.fsckobjects' '
 	)
 '
 
-cat >exp <<EOF
-To dst
-!	refs/heads/main:refs/heads/test	[remote rejected] (missing necessary objects)
-EOF
-
 test_expect_success 'push without strict' '
 	rm -rf dst &&
 	git init dst &&
@@ -78,6 +73,10 @@ test_expect_success 'push without strict' '
 		git config fetch.fsckobjects false &&
 		git config transfer.fsckobjects false
 	) &&
+	cat >exp <<-EOF &&
+	To dst
+	!	refs/heads/main:refs/heads/test	[remote rejected] (missing necessary objects)
+	EOF
 	test_must_fail git push --porcelain dst main:refs/heads/test >act &&
 	test_cmp exp act
 '
@@ -94,11 +93,6 @@ test_expect_success 'push with !receive.fsckobjects' '
 	test_cmp exp act
 '
 
-cat >exp <<EOF
-To dst
-!	refs/heads/main:refs/heads/test	[remote rejected] (unpacker error)
-EOF
-
 test_expect_success 'push with receive.fsckobjects' '
 	rm -rf dst &&
 	git init dst &&
@@ -107,6 +101,10 @@ test_expect_success 'push with receive.fsckobjects' '
 		git config receive.fsckobjects true &&
 		git config transfer.fsckobjects false
 	) &&
+	cat >exp <<-EOF &&
+	To dst
+	!	refs/heads/main:refs/heads/test	[remote rejected] (unpacker error)
+	EOF
 	test_must_fail git push --porcelain dst main:refs/heads/test >act &&
 	test_cmp exp act
 '
@@ -129,15 +127,14 @@ test_expect_success 'repair the "corrupt or missing" object' '
 	git fsck
 '
 
-cat >bogus-commit <<EOF
-tree $EMPTY_TREE
-author Bugs Bunny 1234567890 +0000
-committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
-
-This commit object intentionally broken
-EOF
-
 test_expect_success 'setup bogus commit' '
+	cat >bogus-commit <<-EOF &&
+	tree $EMPTY_TREE
+	author Bugs Bunny 1234567890 +0000
+	committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
+
+	This commit object intentionally broken
+	EOF
 	commit="$(git hash-object --literally -t commit -w --stdin <bogus-commit)"
 '
 
-- 
2.47.0.rc1.21.g81e7bd6151

