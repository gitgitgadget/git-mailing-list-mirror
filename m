Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5934D214228
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750112923; cv=none; b=RzwZGnLxJ/qVTGLHYM1xfgsNGEWWTkzNfUANHGUFmCJrB6U2bEw2TsN0ZPDrhphVLGHrcDJeONG+Cva7xHBCx0m6tAYcROQeei0LwBFs3y3E9DEipr418L0N3t0vr0Nnx8iEw/+zfiyS0bDg4Pdiibt5xy1OmeT9ny9zBsz/5jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750112923; c=relaxed/simple;
	bh=uonNJ+yK9C34CLpooSDg1oXM54YCNr7k5O+6fUTD+NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lYIBcfYrrj4d6tMixsFXYyxE19V2/6s+hsX/HXrWOYarkfDTJ9YAMe6v9uC05pHgUEA+E3YiS4iblVHHkgy7V5M9i9GlFwxI1Tp931NNCBSwy3mVHubz+ZRiG/X5GWk3xGAV/xZJdVU2n9T3qKZ6zI6I7jKBsJgpMhV8kcHMjw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ebneapni; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ebneapni"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b2d46760950so5246775a12.3
        for <git@vger.kernel.org>; Mon, 16 Jun 2025 15:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750112920; x=1750717720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=04FA7I0N3xSbAUxRdwLI7mwZbkW6u0xv7ov5lvW0Xbk=;
        b=Ebneapni0p7v3FTv7HGZUvYjhP1Htzo4vSa2AZOUr8JLmz+33FBcw8gntRDyNYwTlG
         yr093qGE5vvBsIBbtSlEln70aXl1N1Hy1dw42mUnp7tS28VKM4LtriAcz3TbKRkS5nsP
         kzTvY9HhznnBrUQb95f3YY4ijkG52abqxodSoTxyfdiVsK1Q/GhT5K21zZhp2Z6Hqwbu
         GRY/Zhf78t3Z6crn9fW1bMK/gUZrDj4gFrszcyevKeSk+wzTANn4gHcqBDLwcgh5AcMR
         FBkLzlzxO9NER6R+mAP9mUx/x64+Wpx7DkYyRTOqW7h/gzLVmhioB7UntvENgprEDlTw
         6t7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750112920; x=1750717720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04FA7I0N3xSbAUxRdwLI7mwZbkW6u0xv7ov5lvW0Xbk=;
        b=doGqjLNFFBShqJGDvY0LvKL/FWtSqv8TVuIEIiQgrrh2B61I/i/hZnDenvovhCtcu8
         /oijmjN4Qng/wbq/G5XFxkA2lmTRWUCRxvAedq+a5Ww4GBVmfXt9HVVjzjLoKN3Witwl
         l7od6LGynEZ9fvtAjKj5wWaFfdwcSgHPC7/Yxb9mYq7NIYQhBwKDHoUW7oyYm1+J5rs3
         rSy0EZYVfnFkBau/3GHreSx8V/qRYWq9oYI8o3wr6ivieU+b6spYer2mxPYFfS+5d3KF
         lPSQq7lTSZW7yefplV4y1bQ2NlwOz3J2Bt3CxwOQFfMLKqFPAkRaOHghiAWvG0eDA19P
         MUTA==
X-Gm-Message-State: AOJu0YxarW++gEI07+hShDuwwGVFLGjuwrpxtFQdyPW3Gy/V67PYqJPI
	B1IpbwrHDbosNr5PLazKDQZA0HS+0NnpRUR25CaonN+P5lqId+1ej70NAxEjeA==
X-Gm-Gg: ASbGncs9M/lP9q8RmBi/4Nv2TvsQs+QjwAXx8q7jVVqPkpteb14KQEKw6WrFz90DmGi
	8++0WtMZGHp5p93OUD3HMbaqnch81a0t+e5tUm/904C2szxP3EPS/QHEzFRb82/u21EfJATm16g
	jfCgiLd8sYbxpORMnVARhLn5vNhlD5xh9EIHPmUFCxcXJk025n0f+UFIdMN/6xd0Tq/5tZ4+/ls
	F+iBmLeejVpB3Immkwomh5sqf56EAILZwubkQPjP0K3VSvtZIYU2lp/qCDPgkFgsfalQGsK9Mzq
	JM2Hjc+mJl0/sLDBOfs5RVKCul/8VmhDBaED0KlNPdi/wNQezfV/mVS1xe5n3AsVvgG7Qw==
X-Google-Smtp-Source: AGHT+IFskqtMkG6lhiQXSpW8A5fVYVABQUMXyRw8oPXXU2mVVqLfqKzcY+IQDhtNcAQq+29npxxBIg==
X-Received: by 2002:a05:6a21:3387:b0:216:60bc:2ca9 with SMTP id adf61e73a8af0-21fbd7b57e4mr17830692637.40.1750112920242;
        Mon, 16 Jun 2025 15:28:40 -0700 (PDT)
Received: from dev-phord.dev.purestorage.com ([208.88.159.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1639dffsm6294673a12.3.2025.06.16.15.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 15:28:39 -0700 (PDT)
From: Phil Hord <phil.hord@gmail.com>
X-Google-Original-From: Phil Hord
To: git@vger.kernel.org
Cc: Phil Hord <phil.hord@gmail.com>
Subject: [PATCH] .mailmap: fix email for Phil Hord
Date: Mon, 16 Jun 2025 15:28:17 -0700
Message-ID: <20250616222819.3679053-1-phil.hord@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Phil Hord <phil.hord@gmail.com>

My canonical and old emails were reversed, somehow. Also add
an entry for a new email that may sneak in.

Signed-off-by: Phil Hord <phil.hord@gmail.com>
---
 .mailmap | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 96c2740fbb40..11bc704a47fe 100644
--- a/.mailmap
+++ b/.mailmap
@@ -218,7 +218,8 @@ Peter Krefting <peter@softwolves.pp.se> <peter@softwolves.pp.se>
 Peter Krefting <peter@softwolves.pp.se> <peter@svarten.intern.softwolves.pp.se>
 Petr Baudis <pasky@ucw.cz> <pasky@suse.cz>
 Petr Baudis <pasky@ucw.cz> <xpasky@machine>
-Phil Hord <hordp@cisco.com> <phil.hord@gmail.com>
+Phil Hord <phil.hord@gmail.com> <hordp@cisco.com>
+Phil Hord <phil.hord@gmail.com> <phord@purestorage.com>
 Philip Jägenstedt <philip@foolip.org> <philip.jagenstedt@gmail.com>
 Philip Oakley <philipoakley@iee.email> <philipoakley@iee.org> # secondary <philipoakley@dunelm.org.uk>
 Philipp A. Hartmann <pah@qo.cx> <ph@sorgh.de>
-- 
2.50.0

