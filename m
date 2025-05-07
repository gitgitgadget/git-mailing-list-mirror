Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3851184524
	for <git@vger.kernel.org>; Wed,  7 May 2025 03:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746587253; cv=none; b=JmTvY7SMgXy5NyoI+Ra8IUj8xW3PbZ8GGA6RxrYNVVsQHGE3XQioo1L7fWvhAjB1353ubElrxAY9yopaWZ7pIc2myCG4ZQCXiOMjCznBbD57Abh6b3w+wOf5WpSV2t4sj7RoM+SKRQEWuyfb6je11vAsqST7QgjRnraeB/ENT94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746587253; c=relaxed/simple;
	bh=MT/Pf3iOswiU3q2hGl/EYsD1nW51m8TOp3xISl422Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2wNXQ6JDYHOe3LXs84nqux7cNHREYZdfIjBzo2s4/LU81RLMPIKTsr5YmjHh0Mvf9+srCZ0aY3nTZ7euzmjOoG/GD5rEPcl8/HYJbPnjbeAvI9G52pZGmi0eUomfcyybjpLnJh74M5NQqYvUMmvwcztUlIttY2DAZwcYx7Us/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wzul4K3O; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wzul4K3O"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72c14138668so1534268a34.2
        for <git@vger.kernel.org>; Tue, 06 May 2025 20:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746587250; x=1747192050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zs5z0MkS0aTzkZTZGttxzIQ3f57njK7qZhAScEWeClY=;
        b=Wzul4K3O/3LR0IpX3ECSHAd1PC9aBfKUML097fHBlPWIYQ5dv04s42SULCbxZPX1fD
         nUkKqiF83uAefQM8Y8G6Yetoch4oe1bx/B8WZsPjTlQ7vsACXbpidMDAaoeiIPsP6UAH
         m1ARigOxSd+XUOnKXJN8bwwWmNLbj1KBJCSojnjiwTQVwJ74kcJBxyRZ8BNbTGAF6YW8
         gCugJQiPvWOIVSqRcUIKl6yYTlOnqa+6x6B4x+9xtIMVpsmbJEvDs8rDoUSNLIIeE6x1
         SlcYbnXrnCwIE0rGPa7jcDZfltbBbVvP7P+Vc89ErCjOcDMd4qrB5CzqpWkaDiA7PlNz
         Yi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746587250; x=1747192050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zs5z0MkS0aTzkZTZGttxzIQ3f57njK7qZhAScEWeClY=;
        b=d0HzWcyNUX2f9GDLbhmQ6X6a20OziUu49afWyN9T6r8gOfDsprZHfAe11lS4T9L1TE
         Q4pBqncNWZoVIabr1IXC/aitKVug59njpsgjiJ+6dmwYe+oiZfUWL1cTmmin1cWb9x6U
         1kTh/v2gz5WstVzZmAbXGsVv+1fYlzqnC52ZsUrP8qJptHwwh0waH9WE14i7U6JdrIj4
         qb5rVt5ezQUzFmIjbhTVUT3FXZ00i5a98w/wFQAp0alUtrTBQQpbXaAYfD5IJr8YjUgn
         BYB7Z0dcOgJVGV5IAoLDOmsscxnWTtxQoVIlCxrM4smTu2FcW8X01euJLkO2HrPCI5v8
         LOzQ==
X-Gm-Message-State: AOJu0YyrsOBjOpZPyZmqA8KJRTvicxUtq2OzodZUxtvKgI3USS/Nt6Cv
	1MjntMlNK6cyC/VeSQ9rRgNQLR+cIqbZJng/kDhDUePMBgati5umwRc/durw
X-Gm-Gg: ASbGncullAZuZmrsAebUS9+c1flChBbo17pHwAchDBba6grSxIrIZShvVsXh8MzuoKg
	LLYQ9Eta4zsGj04CTjfK8GtqV0XiYYK1XJeF90ouFjsY5s5fTpJvRvDqFE9iINaR9WE47FfJt7q
	FdYzZXVpgKJ70y1tSs7XqI443vF47IO4hpm0L/bLfWsxC8QyOEE8P4m5S7g45BSANwz/+snQO4N
	XBLlJr61xRP+YbJE1DJMycpAa9zngDkoNl4+kpNMgy0sOoxUQf2JmmIJTmpeGlB68rLeAT5vuEd
	+ceEmcRsfS74qHhDYVhn+XZx6uIndmRHuiy4dNDDQJlqvgJD
X-Google-Smtp-Source: AGHT+IGvAeANjBbmvd7CeVPtr5GXajNU5G/caz47CM2B6mE9FUbvWHZSVGi7rM+4YhWqH/32LpQ6eg==
X-Received: by 2002:a05:6830:6409:b0:72a:327:eed3 with SMTP id 46e09a7af769-73210a6ec1fmr1080344a34.5.1746587250285;
        Tue, 06 May 2025 20:07:30 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73210aaab9asm268260a34.53.2025.05.06.20.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 20:07:29 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [RFC PATCH 1/2] t5412: test receive-pack connectivity check
Date: Tue,  6 May 2025 22:02:48 -0500
Message-ID: <20250507030249.4802-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.111.g5b97a56fa0
In-Reply-To: <20250507030249.4802-1-jltobler@gmail.com>
References: <20250507030249.4802-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of git-recieve-pack(1), the connectivity of objects is checked.
Add a test validating that git-receive-pack(1) fails due to an incoming
packfile that would leave the repository with missing objects.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 t/meson.build           |  1 +
 t/t5412-receive-pack.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100755 t/t5412-receive-pack.sh

diff --git a/t/meson.build b/t/meson.build
index 43c9750b88..81066668b9 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -630,6 +630,7 @@ integration_tests = [
   't5409-colorize-remote-messages.sh',
   't5410-receive-pack-alternates.sh',
   't5411-proc-receive-hook.sh',
+  't5412-receive-pack.sh',
   't5500-fetch-pack.sh',
   't5501-fetch-push-alternates.sh',
   't5502-quickfetch.sh',
diff --git a/t/t5412-receive-pack.sh b/t/t5412-receive-pack.sh
new file mode 100755
index 0000000000..190c7d3624
--- /dev/null
+++ b/t/t5412-receive-pack.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+test_description='git receive-pack connectivity checks'
+
+. ./test-lib.sh
+
+test_expect_success 'receive-pack missing objects fails connectivity check' '
+	test_when_finished rm -rf repo remote.git setup.git &&
+
+	git init repo &&
+	git -C repo commit --allow-empty -m 1 &&
+	git clone --bare repo setup.git &&
+	git -C repo commit --allow-empty -m 2 &&
+
+	# Capture git-send-pack(1) output sent to git-receive-pack(1).
+	git -C repo send-pack ../setup.git --all \
+		--receive-pack="tee ${SQ}$(pwd)/out${SQ} | git-receive-pack" &&
+
+	# Replay captured git-send-pack(1) output on new empty repository.
+	git init --bare remote.git &&
+	git receive-pack remote.git <out >actual &&
+
+	test_grep "fatal: Failed to traverse parents" actual &&
+	test_must_fail git -C remote.git cat-file -e $(git -C repo rev-parse HEAD)
+'
+
+test_done
-- 
2.49.0.111.g5b97a56fa0

