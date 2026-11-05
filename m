Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793865611;
	b=HRzQUu2L26vPdeWAIjGi8BeCPxBH3Yf6RgvL5dnJRPnChfCQK9ryWjiG321TihrMy/qO
	 xKePw1XzvljKrSmFG+SEJAtb/qaehDAAampVZ52eLSDv51F5H7r4DrAmqbeRWHu7iW8ai
	 92FTFls7hk1XW/eQFbEl0GedHLFVFEvXoLwYQFIU6/bsGTZqyuxdHDZay/8WjK3rATh2/
	 87Uv+vYriXljpDX5MDhCWt4SSwpB+O2e0aoIDU5MWFQ7usExQX8yMzYWI66HEfay6zM95
	 R5HkpZ2tDJW6NZbThZUFc6XtFbStiBp6g0o4QWqq+3NISBQ2qxZGd78ISwX4LlbEcFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793865611;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=TFvohMdPSdKdzRoewBUAExjMt13GsmJ4OorWlNwmygI=;
	b=Ob4TH/23/0RLB0i602j+KQp0A5JBkHAvwfGP2jQnl1BIcykSVZGIdSI1rZ+/I8TEXcdU
	 ljmVryVESmRtXqvK+C75vA29HnEfJX2bepcbAnSWI5Dw7j1vvxHRuVIj3mKv2X76A/mpc
	 oITtSCC3R9ZYdyDUtYhUyeouU/ipyG6EnLonSR5/oDH8/X6xY4pNKuQoqbu5D+0Z72PWG
	 WTyNbv2Pq/vrWu6rZllLdMAS2wKoc58rrKzgGrEKax2di0K1shd3RHFz1WAXa5vERFMMs
	 6W96Zw4IYk1kHnvmXDgyNnAbxcne7XJeLWrH/nz5R3b7RhK1/8SvoudzsuLLOrh4B5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b="GJ/ASUkv";
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BA5606A32C
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 08:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15BA5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=GJ/ASUkv
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 6A5802YM016328-6A5802YO016328
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 5 Nov 2026 10:00:02 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xOsOA-004HIo-Gt;
	Thu, 05 Nov 2026 10:00:02 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 10:00:02 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id cc5993d4;
	Thu, 5 Nov 2026 08:00:01 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>, Patrick
 Steinhardt <ps@pks.im>
Subject: [PATCH] ci: delete defunct Cirrus CI configuration
Date: Thu, 5 Nov 2026 10:00:01 +0200
Message-ID: <20261105080001.6101-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-13.utu.fi (130.232.247.53) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhRSBgbKBgDG0YBBUhYSFpIWVxI
 WVtYRlpbWkZaWF9GW1hIUEhYSFhIW0hYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhRSBgbKBgDG0YBBUhY
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:mime-version:content-type;
 bh=TFvohMdPSdKdzRoewBUAExjMt13GsmJ4OorWlNwmygI=;
 b=GJ/ASUkvQov3XFllm72wQ0p+yWST2kp/xqZIYWwVlJMuou8Sw7StOcSlU+lb4Px2uVrvJVLXguUX
	WbbZFq8c6ZKRakjxUULcXszRAAsRfQbEGuCRqjSr14E3kU+TCVIFpty9nRRRmK6oizG0k74D+rYK
	vLErpdJQ7rPoYN9s3opppDSPIwL2pbs/p+o/83XFFwv43VpVcjK17nmebziMvHc7tO/DDHTK16Da
	TGEY1zTLAL3RMHM8lvbxHWFqR9cdIO/WdqHTVe0NfS/EOB/SngCOBsfe2g+r2v291p81zDE+/6Bf
	uPUwCbBZy0MVPVZgyNxrbbkaDGM1xqxsb+Zd1w==

Since b5a9d7afcd (CI: add FreeBSD CI support via Cirrus-CI,
2019-12-20), .cirrus.yml has powered Git's VM-based FreeBSD CI.

However, with the shutdown of Cirrus CI on 2026-06-01, there
don't seem to be any drop-in solutions available to support our
usecase---while there exist tools in general to run Cirrus pipelines
locally, managing FreeBSD VMs doesn't appear to be covered.

That renders .cirrus.yml completely nonfunctional.  Delete it.

Acked-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---

Notes:
    Originally posted at <20261104095752.2rs5_%taahol@utu.fi>.
    
    Changed CI: -> ci: in the subject line.

 .cirrus.yml | 24 ------------------------
 1 file changed, 24 deletions(-)
 delete mode 100644 .cirrus.yml

diff --git a/.cirrus.yml b/.cirrus.yml
deleted file mode 100644
index fef04a3840..0000000000
--- a/.cirrus.yml
+++ /dev/null
@@ -1,24 +0,0 @@
-env:
-  CIRRUS_CLONE_DEPTH: 1
-
-freebsd_task:
-  env:
-    GIT_PROVE_OPTS: "--timer --jobs 10"
-    GIT_TEST_OPTS: "--no-chain-lint --no-bin-wrappers"
-    GIT_SKIP_TESTS: t7815.12
-    MAKEFLAGS: -j4
-    DEFAULT_TEST_TARGET: prove
-    DEFAULT_UNIT_TEST_TARGET: unit-tests-prove
-    DEVELOPER: 1
-  freebsd_instance:
-    image_family: freebsd-14-3
-    memory: 2G
-  install_script:
-    pkg install -y gettext gmake perl5
-  create_user_script:
-    - pw useradd git
-    - chown -R git:git .
-  build_script:
-    - su git -c gmake
-  test_script:
-    - su git -c 'gmake test unit-tests'

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
ta/delete-cirrus-ci

