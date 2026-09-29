Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBFA33BBC0
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 05:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790660854; cv=none; b=K32BX5TmKxum9f32mSbwxj/mN1mU4uX03pdw3Rz/gCoFZERJz5QHbNVChkH5hMgeIGAzclLvklZ5PMurobcP/nYEvacesPXdkh6Gy8RvXMCD8RA/WhrJmXd5+60HfJUOXPDnNCIMK0IfZxjowFZ8H9Pol4en6Ejq3x7LIDo3RJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790660854; c=relaxed/simple;
	bh=F130vdXAERPNH/zFsmaO1t8xM1cM8nrmwZBG9NqGLOg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Nb2+Nxc6Vlj4DxHqyPRx7N1dQ4WYmkonUAQMQ5M3vKkc/fYzAVCBf0hu6x4M1pGsn9N6YqxJSWFHZMtZww8zfYj5ROB2sXlnjVYd+hwianPMIx74BupPNHG7jzwikXnzBF15f2twiORqU+USA6WHATDluMnibFI+/DayEYkkxkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=R+gN/0kp; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="R+gN/0kp"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34bb8b31660so293eec.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 22:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1790660852; x=1791265652; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=axvmVI0Gt67FfEJVlamP+XNznuUfpiyg1KHJ7AxXQTk=;
        b=R+gN/0kpeX/G6FCmQHFUfLkJ0jzc6x3bkkquotzE5bs878z8+UXeF5zHfaWhEmGwXU
         eykHDaMNFm5YMVaL9ijCaGxcALxmCBwchx7Hya1YDprWBs+IiNzsF122VaUqyEnjD9A8
         fo77JE1GPQ2M903R0qRN4aZ2fTBZ/6pqSe3SUY0RagpaLoqJCjMbScDpkT3ouitpGNYm
         87JDLuWaWg4VK/IyTuBAmyBbtydsVLWQ1gF2agP2bMSXPezagCHzBucrCahR55GeTL95
         tAtJ286vaWIpFP1VpSGY6Nf/G+khzynLReIDJGrLmt9FGD0WgH8rLgipzHpgT9gpS98i
         5Dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790660852; x=1791265652;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=axvmVI0Gt67FfEJVlamP+XNznuUfpiyg1KHJ7AxXQTk=;
        b=iGPk6XefRuIIWDvJuRsjyhqOy0j186FVgFle2+a1Y7RTGybKYTmzkPrZEZoAqlbSBk
         95PixO507tT0A2qziy/sGyFtc59bPGeyWkniK2a7K+nGeIWli21z7IoIZ6N/bUt9xT/f
         AEd33BbZL7woTZeO5Fb18STCf+NBMM0sNj/qxLqxw7Hav7F6mqzxMtWMe1QKG0hbBlHS
         NheXG2DnnmJk3Ajbc2qD/AcekItbZVHXaKYRd5F5CGKRYPHBBKS/sGBTwePoZbiv/odz
         fH7MUzrNcNT2GFOru/KP7LsAVHfyAZ4aRuChrJcZn02CKmc7x0jR9Rru0R6Rq1Q0vSqu
         Gaag==
X-Gm-Message-State: AFq9FYKR56GJMzlaqjTogyPjbr5Ror4sjkIE70xIRvQ3XWymYu7unSq6
	tIT8HaGOn1HNU59Aa/ZuPh75SEjtZi4hCLEDgcTODt1wZ8hYsz7xzftkZumJjXCm11jgRd+ed0G
	s+M43
X-Gm-Gg: AYBFou0cVgjsLYW6ygBIOIhp+c3WxixLKjH61PhVYu6jgrRGCEQcBhCofbhVzEa6/Yy
	7sF5C+1ih4SVjyRuM4xcsLPKszBRkA0nS0tFaibTaAv7jWENK1QTaQ99/UC2O0KtrYCQGpmb6Bf
	LjzrvpF83+GCP7DaUs0ghFXYCZm6Pcd8BzZu1odSfxalyX2Gk1LY/kUpb9DdH6y/sxIfBVNz8KA
	IZkysHiyjZ3Rj50FhYS2UbnbGlnRAknJHpmMafevjxKUXA6wjH+X9lpvPqvsGmbwJaGZsFXYzk9
	BTFhf6kB0YsGVnAYjHXZau+jNAdpVv1BUmwchKUgQFJvDI3oauamYxgxf0jJns951YfJXFKjfeT
	q8Y6Zo0vom3RYu19x8yv4bKhLFPtTAoNjRw/o6JxDFqHg7TYzo62tmUHvWoZvjY2+t2GUWuXa70
	Ed8nDMHtJhIX3gSPtKLBmX5RpcKY7dqrb5XpAOJ8vuxHGG2BjOZZvTfQpm6jrgvzFR9HJUvaYll
	h26KQnngXvgZfspEm05pNOC4TG+9T+OVU8kO2M=
X-Received: by 2002:a05:7301:2224:b0:341:2466:2d68 with SMTP id 5a478bee46e88-3427304d4e6mr11653194eec.38.1790660851549;
        Mon, 28 Sep 2026 22:47:31 -0700 (PDT)
Received: from brighamcampbell.com ([73.3.69.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34ba464d6c8sm654247eec.27.2026.09.28.22.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 22:47:30 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH v5 0/2] git-contacts: allow inputting patch via stdin
Date: Mon, 28 Sep 2026 23:47:11 -0600
Message-Id: <20260928-git-contacts-stdin-v5-0-e9becaebc47e@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33PTW7CMBAF4KsgrzHyf3FXvUfFwh4PiRFJkO1GV
 Ch3rw2bLEKXT5r53syDZEwRM/ncPUjCOeY4jTXo/Y5A78YOaQw1E8GEYZYr2sVCYRqLg5JpLiG
 OlONRWCsZcutJXbwlPMf7E/0+vXL+8ReE0qQ20cdcpvT7bJ15m/u3YOaUU+vAiCOacxDsy6fY9
 W4AN9w8Xq8HmAbSqmaxxvQmJiomGNPM8GDZh3uPyRUm5CYmK6ZNCEqCUUGb95haY9uXqfamV6g
 8eG85bGPLsvwBbPOMZrcBAAA=
X-Change-ID: 20260914-git-contacts-stdin-1e829930e19b
In-Reply-To: <20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com>
References: <20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
 Brigham Campbell <me@brighamcampbell.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1672;
 i=me@brighamcampbell.com; h=from:subject:message-id;
 bh=F130vdXAERPNH/zFsmaO1t8xM1cM8nrmwZBG9NqGLOg=;
 b=owGbwMvMwCUWLsWS0KCyxZPxtFoSQ9bugI97Vkiz36+fXGol13rS3W3ygvjcsC6DLMFaGamNl
 nErjDk7SlkYxLgYZMUUWVRuzVK/ONn60cEI/gkwc1iZQIYwcHEKwEQM7jEyHD33L9vTfl8n2zST
 mnfTZ+l3Zl5cHxDk+z3Eco9C1ERdoIqfbld47xirPq3kKjY9W8Tws/t+vu6plzVXOmY6pEZ0V3E
 CAA==
X-Developer-Key: i=me@brighamcampbell.com; a=openpgp;
 fpr=24DA9A27D1933BE2C1580F90571A04608024B449

Make git-contacts accept patches via stdin. Multiple patches may be
concatenated together before being passed into git-contacts;
git-contacts recognizes the mbox `From ` header inserted by
git-format-patch to separate concatenated patches.

Update git-contacts and its corresponding documentation.

---
Changes in v5:
- Add a patch documenting stdin support
- Link to v4: https://patch.msgid.link/20260925-git-contacts-stdin-v4-1-9b4e4bcbb91c@brighamcampbell.com

Changes in v4:
- Don't imply that git-contacts processes input in any particular order
- Link to v3: https://patch.msgid.link/20260923-git-contacts-stdin-v3-1-56dd43c64d56@brighamcampbell.com

Changes in v3:
- Make user pass '-' instead of an empty argv and non-TTY stdin
- Link to v2: https://patch.msgid.link/20260915-git-contacts-stdin-v2-1-2005061d907a@brighamcampbell.com

Changes in v2:
- Minor variable cleanup / un-spaghettification
- Include update to usage comment
- Remove Cc trailers from commit message
- Link to v1: https://patch.msgid.link/20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com

To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>
---
Brigham Campbell (2):
      git-contacts: allow inputting patch via stdin
      git-contacts: add stdin functionality to docs

 contrib/contacts/git-contacts      | 9 +++++++--
 contrib/contacts/git-contacts.adoc | 3 ++-
 2 files changed, 9 insertions(+), 3 deletions(-)
---
base-commit: 0f8e75abebff0877cae681a3d5ff31ac47f54220
change-id: 20260914-git-contacts-stdin-1e829930e19b

Thanks!
-- 
Brigham Campbell
https://brighamcampbell.com

