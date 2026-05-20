Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922A636B067
	for <git@vger.kernel.org>; Wed, 20 May 2026 20:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308681; cv=none; b=auerU4CpcidqjYYzE30teoQYrmxob3D1ONl60FuQPvtLhHMuoC5Bqf2pU55K6Qguu6lW5YesLQHAvVrhruGo7pYSlQKbH+aOQlhtPMrsmW5j2aoHuRr/pq5fRw1eSMN6iQ8+256Mkh7maPq1vMJq9lFYT2W3sPmeJloMOElbf3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308681; c=relaxed/simple;
	bh=VkpFVcbBXljsXhY5k/0mbYJf93BqBhQ2Zb6gZZCrps4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jim0bc+x58JvIR3lNT7vLddI1ISoixgGAZxK3klrZmq/aIz97o+UbQb7FWTClRKW0lOTKUHjxfItQSajtcwfJo9Oz/68Ga3jFam/eknfyOh4iK5mlrzQzKBSbPFgvM3kNyLdQ7Pd7B2dalFl4v9zWOeKtn1HYa/AoszSVtbq2XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/iKKlkY; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/iKKlkY"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8acb856a674so67844476d6.0
        for <git@vger.kernel.org>; Wed, 20 May 2026 13:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779308679; x=1779913479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdEvTPio3HU7uxyakmfN3C8oEFo6VpjuYBluYq7lBjg=;
        b=f/iKKlkYI1dRsaCJreHyE+kxjkYvmvNxirL7/gMDziSFfj4qZrLytVk/XrPA/3L8TG
         EgAxQNLdvIX5Kn1MqcjPTUVKaG9NtkT4TCdmhFMKooSGGbyYIL44b2qSudsVOQHC3JGu
         6i1fpCyGeg8CqmSiDGmaw1TZgFCK4XvklVpEDvR4DvAsoKIXrgq+HXG/qHcEFWO5QuI8
         pkZKe/CUZC/iONwUQWfj/cGR723Q59kStIhaezINb+Z3tcbV8TL2OmS4GVy9U5J7UrEJ
         4ChphsyyYDotSUOTFc2xpDXe32Qp0SPMIdzoDHRvF93D/hH7HQgkzJiuZO+8/vWAAARy
         VZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779308679; x=1779913479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AdEvTPio3HU7uxyakmfN3C8oEFo6VpjuYBluYq7lBjg=;
        b=i02WRyImFiW9afPjfrcWskTzY/0fM/sTSzG9rckyxH0FZwPRp/auKvfvxLJ9jaUMAS
         SBSd8nQBMT4hHn6lYbZLgTprDb5EBSwW+974a76hf4VGLuycpIJsLaL/S6nycho/bw37
         U5wibRrYqEQYqO53EjG6yrLxAIVM8BzVGtoNxV6DNqqk+1jZPjP2X/ZUeRpZu9LSk0xW
         hABoAFg2oGdttCY/u1BnJQx991rTHnwxxs9j/ja4LO+0InUZCuUHC9akuHCIlutH7MR/
         NbTSZ93QFF/ANvNkfoj7hzmGivaIYZlPak/w1rwD7CaE0IzcoOZm0xZsvnnNKrrC1CRX
         hLdQ==
X-Gm-Message-State: AOJu0YxHuxMmRp8qRs3cfLvst5vMVZW48GE8//JTxgB1pdyALCw0NEpk
	UlLjt+BkZYlrqcNBBtT/d4qOXpPeTyzyGbGLfDqlGbmrQVUhDq7cJ0a9Kd/ijDma
X-Gm-Gg: Acq92OELvov2bWC8mXA1RCkpI2qEra6OF6Bfte7PeQDtn2VZavPmWtiQWuhpHC13807
	5CY7xLTk1eSRU9fvJFkHYf5ZpfpHcy3ma5nEdW8Fq8eTL0N/ENDY1AtD4WQ3HgMkBhYZt8GEeUO
	yeGcWm/14Sj6iMZnTRyL/wVwv/mBc28I4jEI0iSQCNsK7TyXYhHoc/wjawztzMODPZoSMYNUX5n
	3Ar71tURPLvj5sV9gLQR4k80Btot9wz2PPDNhLEeE1apI9TMw9VwP1rdHWBrWe83fKJ5maj3LT7
	C21oNuFhcPxPt9xOzWPbHI1HTjAe6oW7oZHJXzRhcxol37+PoQpdY4NQvWnKj4PAw+E/3kVLurq
	JLyw7BbZzApjjDZyNuL3SHoWG9zDTTSiwikb7WxOjhnSVQUazRTHpKoW2vsr1jmdNQ6lvhFHYDd
	DCtTUo/CWaC7MdI80pCPo0idQOnuMIxPXPjc3Y
X-Received: by 2002:a05:6214:4109:b0:8c2:7cc5:b5d5 with SMTP id 6a1803df08f44-8cc6ab5eb31mr16957576d6.17.1779308679447;
        Wed, 20 May 2026 13:24:39 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca361905d4sm129891136d6.32.2026.05.20.13.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:24:38 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v2 08/11] git-gui: use HEAD as current branch when detached (bug fix)
Date: Wed, 20 May 2026 16:24:07 -0400
Message-ID: <20260520202411.108764-9-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260520202411.108764-1-mlevedahl@gmail.com>
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit f87a36b697 ("git-gui: use git-branch --show-current", 2024-02-12)
changed git-gui to use git-branch to access refs, rather than directly
reading files as doing the latter is not compatible with the reftable
backend. git branch --show-current reports an empty branch name when the
head is detached, and in this case load_current_branch needs to report
HEAD using special case logic as it did prior to the above commit. Make
it do so.

This addresses an issue with git-gui browser failing with a detached
head.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index aeb7ed3548..a72d8a59ec 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -648,6 +648,9 @@ proc load_current_branch {} {
 
 	set current_branch [git branch --show-current]
 	set is_detached [expr [string length $current_branch] == 0]
+	if {$is_detached} {
+		set current_branch {HEAD}
+	}
 }
 
 auto_load tk_optionMenu
-- 
2.54.0.99.14

