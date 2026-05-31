Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602F732B122
	for <git@vger.kernel.org>; Sun, 31 May 2026 23:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780268585; cv=none; b=krl1I/byFq+LTK9cWVouVS7vZsDMfSF4JcLdI5h1d/AqlsDlV0O3nKx4yDMa5vcV44UEe9CWjdz5aHS3DaP6ew8BCgjV4648HtKurkFrrIKWvyUp4oHF/ViRzMqRYpewL28lVdpOWigPtd4Tiwvck6L7E2MNNkHDQXlvAd4ZsH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780268585; c=relaxed/simple;
	bh=pKB8xetf83qmGggtDr0+ciYJNzn/jkRDQ7L2ozH/F9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nX3Pe+hdsHWSLQA3IYXjjSRbE2NLSr5xbjz+6mN59fcvqqfm2835IIEOr6kUliGCcJEjPg+oBTDSShR3aCjlhsutj9cRUwnGpXL6abJil4TcZ1J/M41goHk/QBjiUJHKk2wVv6ZI64xoaiChZOxNwPPxm8Z2tGIOaPcyNkREejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q2ILmw2f; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2ILmw2f"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8cce87d7995so32505666d6.0
        for <git@vger.kernel.org>; Sun, 31 May 2026 16:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780268583; x=1780873383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4ZiX4aGzw9ZvDJKKVzFHSx6BVDEWeuBusm4WpxBAgc=;
        b=q2ILmw2fQ7oW42U8/oBCio6vjjI+dP91lYC+3EEtI0c7ZP5wKrVdmGzErMSRMkT2/e
         P05l2FETWpwzqzJTf2rWwAvT4SKux1Zst5pozHMx4RmPopX46Z8D1mw2mMq4cfyRyj/X
         doQTkw/TSgIcYfuSlGXcZWUwUoMZMJsaJM+nhXUQuo51I8xJBs+4brnKHLPNNemG9+Nk
         fZFPZLO7BI8PJTxpiHdRUkiCUUwttQ/zseQ2cxkBh829xEL6l2sPU9AhQScSYwTDTePu
         4Hyi7gy5sM6JIVr6UkgfQjFG30bGy+Xr6PIsTNe3lHJiE5AR0zcdyRDCK7CcJ780MkNv
         6wjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780268583; x=1780873383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q4ZiX4aGzw9ZvDJKKVzFHSx6BVDEWeuBusm4WpxBAgc=;
        b=Oc3KQpWd/Vk/GqWmbuz64VnWe9nSiXz+PN+Hc8ilV+6/YHrbiXJ3rZrwOF5TwppWGP
         uCj3dy5bpK+jSAwF2+IUk1hh4ZZvIXuk88lrZ6J8Nsp1ZYaUnGMX1p4BKg5gnkAgN7Lq
         lEJp+Am3AZpGmVXhW5OLWPGsn2WynTt52E6dlCxLyrU5bwRiFxokUulwWKpfF+thryrE
         3mfHbB0VmWWDwOfC4NJpPTsthl0nTULkzh8GZCDPjHhL6svU5oNGSRfojYiscazDbT9H
         moHMhnRprOn2cj6ZApj0ui5qGqXnvpMdB1wrko4E6vmAmV6gVITUR3urc2YW6NCF89SV
         HwBA==
X-Gm-Message-State: AOJu0Yy7Ny8Kc3uWuY+iZwJs42XhwiYOtP9xNi3iKbmnHAjuded3KUyL
	Tqs9xK54WJQYMyasci33nyk9/ruKF0B6GyU9paYPa7dwOtHM348IooMqWvDmut9T
X-Gm-Gg: Acq92OFAeXOcD56H4OovfjJSrW9m/bBuC63we0KUR7A0IIPpFb2NJsVfJ9+dPOR6fID
	5sst7NKtSAx3KixSx1bXF1fbv1fH6wqhpdzCV7HazRNdo8XCzLp6xkJXz7Kh1t6OHIi6theWnBw
	AGWjvP5qi+Twv4rX8updHVOd5WYLkjS+F6aOZsSkUxOm7AfMgkh5bTEUymcdCj/JjsAaV33///e
	mtJcr7/RM6kaCJ/l4wuPiwpT9BPlI4SIivEphOcn6pC7CAGbG3xiROqBa4EbonyFvhKjqFxHvB9
	3p3QVUayokp3T5+Qx8CdbdyrSHv6puLS/WC1BGBt4WFnWm7kdtFABWWI3TpBssfgj+RKFfEPm0B
	ApUYD4lN7sEqUoFsINfCIGYc0Enq2BF/hggzEGUpnOboo+7XI92iQLEXBbSpwAg2zwExbP/vssR
	M6egoIGZVx27cnRy9coTQwhf+njK5VNAsTxvB3
X-Received: by 2002:a05:6214:48e:b0:8cc:d588:4523 with SMTP id 6a1803df08f44-8ccefb37ab5mr139161446d6.13.1780268583360;
        Sun, 31 May 2026 16:03:03 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea042bb5sm78268426d6.8.2026.05.31.16.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:03:02 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v3 05/12] git-gui: use --absolute-git-dir
Date: Sun, 31 May 2026 19:02:18 -0400
Message-ID: <20260531230225.126817-6-mlevedahl@gmail.com>
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

git-gui uses git rev-parse --git-dir to get the pathname of the
discovered git repository. The returned value can be relative, and is
'.' if the current directory is the top of the repository directory
itself.  git-gui has code to change '.' to [pwd] in this case so that
subsequent logic runs.

But, git rev-parse supports --absolute-git-dir from fac60b8925
("rev-parse: add option for absolute or relative path formatting",
2020-12-13), and included in git 2.31. git-gui requires git >= 2.36, so
this more useful form is always available. Use --absolute-git-dir to
always get an absolute path, avoiding the need for other checks, and
delete the now unneeded code to fix a relative _gitdir.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 44914bddcf..8a5f0bd938 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1145,16 +1145,15 @@ if {[catch {
 		set _prefix {}
 		}]
 	&& [catch {
-		# beware that from the .git dir this sets _gitdir to .
-		# and _prefix to the empty string
-		set _gitdir [git rev-parse --git-dir]
+		# beware that from the .git dir this sets _prefix to the empty string
+		set _gitdir [git rev-parse --absolute-git-dir]
 		set _prefix [git rev-parse --show-prefix]
 	} err]} {
 	load_config 1
 	apply_config
 	choose_repository::pick
 	if {[catch {
-			set _gitdir [git rev-parse --git-dir]
+			set _gitdir [git rev-parse --absolute-git-dir]
 		} err]} {
 		catch {wm withdraw .}
 		error_popup [strcat [mc "Unusable repo/worktree:"] " [pwd] \n\n$err"]
@@ -1175,13 +1174,6 @@ if {$hashalgorithm eq "sha1"} {
 	exit 1
 }
 
-# we expand the _gitdir when it's just a single dot (i.e. when we're being
-# run from the .git dir itself) lest the routines to find the worktree
-# get confused
-if {$_gitdir eq "."} {
-	set _gitdir [pwd]
-}
-
 if {![file isdirectory $_gitdir]} {
 	catch {wm withdraw .}
 	error_popup [strcat [mc "Git directory not found:"] "\n\n$_gitdir"]
-- 
2.54.0.99.14

