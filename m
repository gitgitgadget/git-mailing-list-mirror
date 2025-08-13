Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC28288C0C
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107484; cv=none; b=ZM4IzWxzV6qwdUtW2LLPMdhYNMfr36JFaVLEApcRLWnMBAF51iWaJUW2pj7njlLbXBB/e09EP7fZd8HbZcnAWqgErWD+ewJfiEGgoVA0cJVXkNyuCljRbhgntkCzbSEhUz5FKZad21WsMCySgSa6aS/D5KPvvOg29OQg7Ev6H44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107484; c=relaxed/simple;
	bh=R+A+D8GH1CUIBcO3tCzA+Ad1UgsCFblx3Z1vqb25XhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4taH8NPRcFnzXdQ6QJY6CYTlWD1PHgllC5fyhuHwBdjy2k02fWZEJmqvbAPuR9y+0kF868lgnnFsGCuaL2MMLQwQcWeXwKqdGboFYBGO8/gLcFx1lzvLXFEM21M+Rt4Fv7bGkEqUs1IW8aR/1TzC2sbumYC0hHLaQXmDTSpQV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmlIvTgi; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmlIvTgi"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e930b0c1546so1124573276.0
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 10:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755107482; x=1755712282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6sg61P5rvK/gTVAaWv4CW8mnhptjH+Jhcx1zwrrTE8=;
        b=OmlIvTgim06v9k9MIpB8djbdCt9VghsxabSksTxZ7npS3Te9urA2u64lLYNvY2Lr1F
         DW/NvlhFFnsgc+EdiRXYKAWjrBKXBmk5ZMbtjsaoMRFlxKfIJ99eft4Z5PCbrBLK3npe
         zeoXTWHEGh9wBw06JUMnfPtF6/JEdsbCaRybk5KO5R1J3tVkfEYWSU1Q9v1b8yWUVHZc
         oEJracG7bjrH5vmDXOv3cE7YkLnvLioKHTL0yyBK4aa/n+Xjgklnf9xxX8CWEjnee8aj
         jZm3CiCA09/dCzvuEpfdUH4hPrxLhvAgt3NFb8+/iJ47B0lqTtqWzi9RFw/3pP7lpcet
         JHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107482; x=1755712282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+6sg61P5rvK/gTVAaWv4CW8mnhptjH+Jhcx1zwrrTE8=;
        b=Qa7xxayJwWDjyiq9lcRoZHBdFaPr2+SA8fZYZz3yDY1STXC0vcr1ulgWHIDwk4XyV/
         sxzmJdyxus13s8ZD33d049bnHSwL+k+0w74MUUcSgc3jYrGctjcFjP3Z6kNYK72Z+IJf
         Iq36+vQ5/J/sJl1rNESvI9id1YFT36gAY8vBnp8mVJHo0rpQH9IlndXabU5HVWmdiOGb
         OqUjbwRLgU6NBuQcs5NYOl6G600jBH1FQUTng+PyDHdanDy2gY8cXF2km8v0ojgEa9p/
         xOOToAdrew1P6aXIfridItAPmzTSd9wVIxRwcuYUdguDXZNnqBKhzZrniKsWgrpBsNsT
         /MPQ==
X-Gm-Message-State: AOJu0YzAsbZ6/7+ZZBe9c78+xap7rq2okEsmtgODSdjOHgTn0Ltg7rrH
	W76xoOGN7emALrzHWih/HrthGMvXMbavA/6Z6PsFrIfSnx07hF0YxM5/hft9bv2A
X-Gm-Gg: ASbGncsfFR0FT/p6G3WqKfkKf3dWJ5+zganJOVvJY4yQjoYFeSoHxbw2GPhNT3s/RoO
	pd8qlIf1snumbkO/VhmIRRIK5nSRe/Ry/uqz5DSrqEZvn15OCwksGb/iqR5b3wNI07b/9M1Z28E
	FkRSb/zrIzwbrUZS8cImZxEdjgvMgKUxdqNXQ6PgwFeurER5z0tudlhdEC/0GMwYCD8rtfVoY2v
	rqYI16OD63JulqaSH04am7a5ilCYMs9ymMAtQHKko5updWCcrgu+edbceWO1+h3csjmYTHNvur/
	8vKIT6t5JOnrAQ5FKNBRek7aWjW3Vc2+aa5rPDL2MeN/Y/wadMGh4yIClVkBpO5FylVDt2nZVXS
	G099plSOUn5bBcyrUBmr9lLIhpqM8YjfOMwEePLNf5LCD96pjO2maHdJtv8RJxZYGSJWpIV6PrY
	mJR+/BuQW4ApTYwnk4Jg==
X-Google-Smtp-Source: AGHT+IFPgzxesB2PS1pR8XRoXONc8V8PVKX95oiLv6jALYGMb+9Pfv/JH4wOi4fCLUwTSnutaLqyqg==
X-Received: by 2002:a05:690c:6e0f:b0:71a:2178:3e70 with SMTP id 00721157ae682-71d6010f2c6mr7288457b3.8.1755107481920;
        Wed, 13 Aug 2025 10:51:21 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:1c37:18b4:a0bf:d7d3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71d60fe1936sm439957b3.38.2025.08.13.10.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:51:21 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 2/3] t7005: stop abusing --exec-path
Date: Wed, 13 Aug 2025 13:50:04 -0400
Message-ID: <20250813175112.88435-3-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250812170256.71751-1-ben.knoble+github@gmail.com>
References: <20250812170256.71751-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want the editors in this test on PATH, so put them there.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 t/t7005-editor.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 791e2a0e74..0a5861b7f0 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -65,7 +65,7 @@
 		;;
 	esac
 	test_expect_success "Using $i" '
-		git --exec-path=. commit --amend &&
+		PATH="$PWD:$PATH" git commit --amend &&
 		test_commit_message HEAD expect
 	'
 done
@@ -85,7 +85,7 @@
 		;;
 	esac
 	test_expect_success "Using $i (override)" '
-		git --exec-path=. commit --amend &&
+		PATH="$PWD:$PATH" git commit --amend &&
 		test_commit_message HEAD expect
 	'
 done
-- 
2.48.1

