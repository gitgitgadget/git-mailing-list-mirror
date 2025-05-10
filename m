Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B69C182B7
	for <git@vger.kernel.org>; Sat, 10 May 2025 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902070; cv=none; b=KX4Lzdn7ckCWtwZPi2LyQzZDLzgEQRchemTzFKN40aDhCIcYijbvH2Qmed3UGsUish0hH5vJ7C0TRHksGoO82QY0D/FN9S+6SSyCABtmvnlYd6wsK+fKhLmu3BDMmmskcqHHre+5606BCIlY79s0dPHiW1sJ2mwa9kHDGIlPAKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902070; c=relaxed/simple;
	bh=CTLdu3Wqz6i4NYdD1aP+u5MteNUC0bOnenn5ddIRiN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baj1hq0PX3lwb/uquEQUdQpoV3wYxts3s80qTkW09N7ZtOs2V2RqjR2l38oOU1oyXqJJnL0gauA7RweYo2LsZZY53bbTZwj4tQkK4BaBGkuKMGLeJlFGR26FxJ0MB3NNsH6Dxh3KT4g2QwbVSmKNQD5lxZwosrrlIUwX9BDGjbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQyAieku; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQyAieku"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso3013125276.2
        for <git@vger.kernel.org>; Sat, 10 May 2025 11:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746902067; x=1747506867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZIXhL0z+EP62ziqOX8F+olttblBbHPs1+ftcoVHvx0=;
        b=UQyAieku966Aw1j+sYG+naZPiy6C/mHanfRTRjtEbKZQg0u94dpBM+k6dCQBdzmhMV
         LGgnEq8EP1nQi1CnO1Qwdpx5XQDWCg5zN5oydDsVBL6u0yV6N+E/3KibMDSrQucpSZeD
         WymHKf4Ikc95Ov/Iv6lZyxJ4fqDsSLbvgfoZuOzcUucUBZ+ecZbmfPPT4sddTX8+GQJg
         5CRXC4NxqvLURFHk7dJU52B3/VKPha2eH27QfQdjdP9q6tFzqH9mruDqOuDZjbRgOAV7
         xV8jmWkdiDVQmT1t7mLEk3QQE1oTAAYl/9CenuwQC6hj1+fwpxeiAjAok2RIx0411y5K
         QgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746902067; x=1747506867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TZIXhL0z+EP62ziqOX8F+olttblBbHPs1+ftcoVHvx0=;
        b=RMCPD18lqEy7jbhMZBf0ZU7ubKLZOrWeyyU4THXCI6UEDp2Y22WpMsJSwjxv1WV9QS
         pU0QDWawx4b/din/C1DxaB/51rzZpj0uvA1JFGAG/h+x+aQUgLbQgY5FcU/iTEBZPcLX
         QaXXFC6QL/rZJBknIltPO381Ezm3i5Ro0SNC3capTzY5kGRJQmPRH0zJRBIhXWULNRkr
         1MzG8uKveAS0LwcxRj61emQMvR8ULK0P4bP1s79sT8Yk7DFS4jgSbecCebsq1CoK5SJZ
         dvRvTrvmRmnRTQba531ZlpSlVrYg8cnuGQelHRhxVRwl0gdvuRuJOOLlBid7qTNT3UG6
         7fgg==
X-Gm-Message-State: AOJu0YyI8ogvNNa5RrDziH4gDnU7+5c952q90mlG+0RNx1z4Kmond8R+
	01L19l2lq7hetVNxgwjbs9y0DlE8aflE9AcORHhtjqn38PTK9GiJ3bUEoA==
X-Gm-Gg: ASbGncsvIeDM9niXECy7yh8Tws+Aw4Nv+1bbPblwU0VL0EAIBo1j1mQF48Ls5t3lfxl
	qmPsrYJvYBemtj2DbLTI7Bfr8DtyAfGotAGDKN5kl7jdUeCNdOjS2cueXARUtN6vNB+pUlpKExQ
	mV+gfSKzxEM519oXHcI0/TBFZiL8vsL+/3N54Hf8N3jS+8MFimbsw84Vbs7BD4hLmBsy3RPPRG8
	bxtTgeg8NPDYibr1n7jv0RRZZViGz2qyT2PCgJy4chDojOLQdB51toM3edKpCYKA6tySB87jMtF
	vHSLaFrE4t+LcMlrtmqk2m5zdbO36ny8BVsP3m9Ac2dw5g1SuH9szGelHo87/44hQfG+UW0tG6t
	WCFsCLaCI3YfVDwGV0/4JCoj8
X-Google-Smtp-Source: AGHT+IEPTjt2LXOgmS6Gw7Y8xL0JD6Q47twA5+Dg81pcAOUfvyanUvUZ9D+cLBMEa8u2E3bdlFisrA==
X-Received: by 2002:a05:6902:728:b0:e79:b0fb:cfc6 with SMTP id 3f1490d57ef6-e79b0fbd114mr2436151276.49.1746902066677;
        Sat, 10 May 2025 11:34:26 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a6:1600:541:bcf5:33bd:f1fc])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e78fd4a72f0sm1191649276.20.2025.05.10.11.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 11:34:25 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/9] BreakingChanges: announce stash {apply,pop} will imply --index
Date: Sat, 10 May 2025 14:33:38 -0400
Message-ID: <20250510183358.36806-4-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250510183358.36806-1-ben.knoble+github@gmail.com>
References: <20250510183358.36806-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some uses may now require --no-index, but remove a footgun that has bit
users over the years where stash {apply,pop} are not the opposite of
stash push because they drop the (saved) index.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

Notes:
    Dscho/Junio suggested it in the original thread [1], but it wasn't
    considered for the release I believe [2].

    [1]: https://lore.kernel.org/git/Pine.LNX.4.64.0707021213350.4438@racer.site/
    [2]: https://lore.kernel.org/git/7vzm20q1l7.fsf_-_@assigned-by-dhcp.cox.net/

 Documentation/BreakingChanges.adoc | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index 61bdd586b9..798e742267 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -118,6 +118,17 @@ Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
 <20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
 <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>.
 
+* The git-stash(1) command now tries to reinstate the index by default in
+  the "apply" and "pop" modes. Not doing so creates a common trap: "git stash
+  apply" is not the reverse of "git stash push" because carefully staged indices
+  are lost and have to be manually recreated.
++
+Now git-stash(1) will behave like "--index" was given in the "apply" and "pop"
+modes. Use "--no-index" to disable this behavior.
++
+Cf. <CAPx1GvcxyDDQmCssMjEnt6JoV6qPc5ZUpgPLX3mpUC_4PNYA1w@mail.gmail.com>,
+<c5a811ac-8cd3-c389-ac6d-29020a648c87@gmail.com>.
+
 === Removals
 
 * Support for grafting commits has long been superseded by git-replace(1).
-- 
2.48.1

