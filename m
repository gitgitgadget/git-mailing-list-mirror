Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B43134A0
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 07:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722755548; cv=none; b=TX5dbhM9cOJcivLdIH0kvsh1SkooORkRIXqc4cFXIRZq4nN19MNR8O17quvrrBYJAMdVvcpKD0DtnbzYfWtDcUqT5ScVHWc9wDnteV7qYpwb5fSLT5uuLnjOKvEo87jWHp7P0IVXqz1evi3x9iTy4J33/5BluXH6jsNsOcxOY7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722755548; c=relaxed/simple;
	bh=7hmr9wL+NtllH0aGn10QJlVDUh8xsdj+NmpiKndMhHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=immiAL6Qfe/ObMZTy+JuQg+ict3GXeG0GWyd0eE/GDTXB5mP4zr97Xk5i07A/EmdVHvv+y4tqkZRuSDFwGPvUQg/7WmB/AgGwdkcsbHKzELq6s8JeQqrneJzb8VMSEIR02N+hzxbKoSEba4et0Uksfu+cz1y4cR57/Bcl340ErU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3G399LK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3G399LK"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42808071810so64487355e9.1
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 00:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722755544; x=1723360344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfawsjzsokzRLighIN3rPJT01us+vz5HIg83Gjw/5Xk=;
        b=h3G399LKLQXPpM3OPnkFiN6QEv+NKSRq3cM+m9I+R1sZBqO17BkrE+5NQOMpMIqOZ+
         gfkPjDbcaehrU88dD3nxzbVN0FrOi8EXXs5MyAF8/sURxkm6en/uijZibX+n7BcNFn8d
         DyxCcNaQLOlocfbKxvlvsUrlDk0/Emq0wDtP7wfXMks7drr+A0bPcR2RClI/J76lqLjU
         BK9ezChvkg9buGVLlLEc1hZ+5wMeXlTcKDkPYfifeS5KlByTqgOROHFQuvgKRubaTfhN
         xpfulmkhajJgukm6gofr9jvEFHT7T+KrHCs0KBCMuuguxnJ67COli/dM3o80WIihIFKE
         BoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722755544; x=1723360344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfawsjzsokzRLighIN3rPJT01us+vz5HIg83Gjw/5Xk=;
        b=hfa/Sh5PgUFKeIBqKe+JvdnWCk1LICi9YEdSioIi8RiBzKUx5+Vy2x+RQ8x+vbz6Jn
         tsccfe+41vIDRkluuzN6FzYK2vdSkAzvrorPvioCGyRs1d2bS7cOk12k6MCvlSahk7jy
         x0wl6q8isbms4lgc8E87Ld9CIMwUztuIQ4NONhr+pqFHLcENl7WyKJK637zi7UC8tErP
         jsPxlTw4lt1Qnk16k86PeC+xKsIQuXhVB5HWd2O6Qm68C62eEM1VBf8uRikf1Y7uj71N
         FTgsRuhwPTZDFNMfw5CTZdQ6QH+hSWXACE6AeRbpdvq5bUwWh4fqkVedzYglogZjL/yZ
         hxUQ==
X-Gm-Message-State: AOJu0YwHUCMY2u5kOAI7oaaaLSOXR8Kam5rcBLlyJ3VEe6hQN2bn30mV
	Ks6lTOhb09VkxxaZ3W0tc8DHja0Lr+a8bfAhcHDviPXr/x/zwJRuY3kXXWth/Tk=
X-Google-Smtp-Source: AGHT+IHZ55va5sy5BSxPsGJTc3WbNq108sunVC9ppVRbHXrS45DyAJvvM/X45C3TglryTzqr3Vxh2w==
X-Received: by 2002:a05:600c:1f86:b0:428:1e8c:ff75 with SMTP id 5b1f17b1804b1-428e6b93fd6mr46328645e9.35.1722755544422;
        Sun, 04 Aug 2024 00:12:24 -0700 (PDT)
Received: from abdobngad.. ([197.40.96.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e3c0b7sm88477595e9.23.2024.08.04.00.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 00:12:24 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v3 2/6] [Newcomer] t7004-tag: do not lose exit status to pipe
Date: Sun,  4 Aug 2024 10:11:33 +0300
Message-ID: <20240804071137.30326-3-abdobngad@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240804071137.30326-1-abdobngad@gmail.com>
References: <20240804071137.30326-1-abdobngad@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

split "test-tool ... | sed" pipeline into two commands
to avoid losing exit status from test-tool

Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
---
 t/t7004-tag.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 3100a4c219..1e31f39646 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -97,7 +97,8 @@ test_expect_success 'creating a tag with --create-reflog should create reflog' '
 	test_when_finished "git tag -d tag_with_reflog1" &&
 	git tag --create-reflog tag_with_reflog1 &&
 	git reflog exists refs/tags/tag_with_reflog1 &&
-	test-tool ref-store main for-each-reflog-ent refs/tags/tag_with_reflog1 | sed -e "s/^.*	//" >actual &&
+	test-tool ref-store main for-each-reflog-ent refs/tags/tag_with_reflog1 >actual.body &&
+	sed -e "s/^.*	//" actual.body >actual &&
 	test_cmp expected actual
 '
 
@@ -108,7 +109,8 @@ test_expect_success 'annotated tag with --create-reflog has correct message' '
 	test_when_finished "git tag -d tag_with_reflog2" &&
 	git tag -m "annotated tag" --create-reflog tag_with_reflog2 &&
 	git reflog exists refs/tags/tag_with_reflog2 &&
-	test-tool ref-store main for-each-reflog-ent refs/tags/tag_with_reflog2 | sed -e "s/^.*	//" >actual &&
+	test-tool ref-store main for-each-reflog-ent refs/tags/tag_with_reflog2 >actual.body &&
+	sed -e "s/^.*	//" actual.body >actual &&
 	test_cmp expected actual
 '
 
-- 
2.43.0

