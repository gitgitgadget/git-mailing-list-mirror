Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6885D3009E2
	for <git@vger.kernel.org>; Sun, 31 May 2026 23:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780268582; cv=none; b=XZzV/B1pExvZ6V1VANoAox0j22nTZ1J+bGwVlGfGBlGqh5zHJ49X698CncojgTN1JoDCAAYR4VzLpf8Qc7UVzDe6jAk5847jJuQxFT+mMHDhcOXnneD0XGVHXRWlNwQOsSj5EppRpHL0S2Xg+1MR0njV1QT16Ni6om5pXHLZtdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780268582; c=relaxed/simple;
	bh=r+QWbyXLKl1quS/O1RSLURQeybeklCV4+4hhsFIRdlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbnN+jRclYAXkJI31qLmn8AQV0uSZRcTVCoOfGP30XXjm6plT6HACD9foBazFUyEaqchWe9Fh/oUjKm4qE4xyGh6yqYWIAGARHarsmZB6yvhHt/T/XCLahk3V+luB1AH8JWS7T7rpijvP/D7xGGSDcgpQBKdr38Cac9OrIdVS5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hbt0F0Gm; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hbt0F0Gm"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-516e1525aa3so95419621cf.3
        for <git@vger.kernel.org>; Sun, 31 May 2026 16:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780268580; x=1780873380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQn5egJV9kLtRI2tU/8kzlYQlUharjLZpRAXrXn475g=;
        b=Hbt0F0GmHRWj9JyIQ5XlcUY5TO6NidUHgcHtUiGNkzcV99w/+wQCxy3ktNXGyCMaBQ
         EJQ2k4PZnuzDslVCqScxhDnd+TXX/YdrBP4QZU8MC5hbP+XGf8YKl6TBgddCStAM6jh0
         v2kELg6QRKY1pRMnAffrBfjfKMTB/Z3cM40jyOjFPku/29SX+nrvKrroQgrZkaIhZPoC
         sFkU03ZWhub9AX5221RjfcEkzf1mgnfmQ5XLgeSvHUM1E8p6uH2QkCHC3ZrXfBU7KPA7
         YsuRPAdj9w0Ix47WHYr28wPmR4iXnDoIpjmBwcfXWbEJUJ0y7Sfy/UXYfJLApaz5zWPb
         +RGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780268580; x=1780873380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wQn5egJV9kLtRI2tU/8kzlYQlUharjLZpRAXrXn475g=;
        b=hjkbrCIJM/iIrIa05LxIypSdMXfprvfzHynwJTawIGCBZNFmw+y3zBKrB7jk18/eC5
         u/2SEdDti02PruaTkXUxKf5Ae5jWUMeUNDk+RHQGKLdY0RXg7257aoKwpMf48CQ76vc9
         +VlBYp2JZxDFWkFpaeM9RvS2SbdhyrJwTT6XqLxPxuLlqWwKzVmyZYPNIeAsgY6oqCmd
         vDDCKT93PWcQPdAW/j7mVfm7wZq29lp1BRgebCo2Yn6OXwWiEINtMX5DDD+JSvfO5hNQ
         RJ4eidqKVPcUQSgQLBRKgmfDjopDxw0reudf2hSJ62trN9oYJleE177empwcl4GGG383
         VMaw==
X-Gm-Message-State: AOJu0YxnlVGgphG/31Ba9UQpRBvyE5G0BCy0sYkSNjax8ogo5Rc4PasX
	D131aVOyReXindJwu1CPt7SfA8HhjgW7JUohRz1bNDMsopAJhICrqd9pz420bu3S
X-Gm-Gg: Acq92OFb+PMKGqR0YKcTM7u+MGY17cjeBbS2A+1vN0b287f8thqHtZt/tUWAawyeGkZ
	ab/ojxBxNjA+BLL91a1nV4mM06GQ4ftNIO4Gzs1Oj5M1htWXu868znD+eE50mkfD04yhZLKl83v
	07HRWhlgMVFaWbYKIzpCBK9M/e8UC7Nci3W6vWAkAxqSsKI8aDOiJRlCyferTKfEsENExcrGAsg
	8SoRsb2N0ge6ImrcoMLm/IF31j5jUG/DlIZ2RpuBixc7yN9rkWMsa0KF3VOMk3vEjv9wm2zsBcr
	CF4tgwak2AtGQJ1SbNFP1VpBqW16EyQXVY/4UXMXm+S/hH0garjmhpFbJknpTE5/BHoXfiMfneR
	gSR9QWG+hqfjXUVnjwp9n5aT4tO46NQd1LBNn0Eoeyn1X5uoIr25FvHy84M3OThB0Y9jVjyw67j
	elmoP/bziAIpsgHhfCFj4Ut91YoBVIOp0i8D93
X-Received: by 2002:a05:622a:4a8f:b0:517:5827:331 with SMTP id d75a77b69052e-51758273de6mr8148771cf.6.1780268580429;
        Sun, 31 May 2026 16:03:00 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea042bb5sm78268426d6.8.2026.05.31.16.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:03:00 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v3 02/12] git-gui: remove unnecessary 'cd $_gitworktree' from do_gitk
Date: Sun, 31 May 2026 19:02:15 -0400
Message-ID: <20260531230225.126817-3-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260531230225.126817-1-mlevedahl@gmail.com>
References: <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260531230225.126817-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Sixt <j6t@kdbg.org>

In the procedure that invokes Gitk, we have a 'cd $_gitworktree'. Such
a change of the current directory is not necessary, because

- if we have a working tree, then the startup routine has already
  changed the current directory to the root of the working tree, which
  *is* $_gitworktree; or

- if we are in a bare repository, then there is no point in changing
  the current directory anywhere. (And $_gitworktree is empty.)

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index f70a54a61b..52897fbd09 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2024,11 +2024,7 @@ proc do_gitk {revs {is_submodule false}} {
 
 		set pwd [pwd]
 
-		if {!$is_submodule} {
-			if {![is_bare]} {
-				cd $_gitworktree
-			}
-		} else {
+		if {$is_submodule} {
 			cd $current_diff_path
 			if {$revs eq {--}} {
 				set s $file_states($current_diff_path)
-- 
2.54.0.99.14

