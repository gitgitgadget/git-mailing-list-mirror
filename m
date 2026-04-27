Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4D23B5318
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286865; cv=none; b=cAwyBEOAJqIDFI42li+M3OPW2RcGSVXexzuEkpS6XBMEB8JTCPg0mUWH8yQarXuG7cuKbxJBcePYcVHdOY9syFrrB0H00GKJCp64MJT/CfUnRfn4iDSgQDFKjE+je6Il6+PpgkaPXUIp+vgKLnHfM4+bMs00fpQnyPuY4ZVGuuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286865; c=relaxed/simple;
	bh=MErUZWakGgVzuHX36QCR2pAAeEiUpja1endP+JU64q0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MCo6jtWDjuaoITNECtoKrFxWQMZXrzP98sNt5/VKw1s9hsNxsSbXn4gfeCobVqnEOAu8GBOnIrqXkxPw85gb3gm+Vch0e2KP597Ss0hIm6No47nGqyonuMGBeOEUSNhNHMGj3uK+4KuSkrCpCD0WF6J6ppYW/djjOQZNTjZfriU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHnD5k0N; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHnD5k0N"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a415fd6bceso11053489e87.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 03:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777286862; x=1777891662; darn=vger.kernel.org;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vl0kYW2Fl2mwlVJNWhoEddEdI0AVHR4fY2I8n+p+Scw=;
        b=bHnD5k0N3kAqbCeGIEZB1lZ2qNWCbHMTkxwkyAU+AKT//0kv0XPmaGU5y6+SCNoCGx
         cRqY9QExlxwSbDGeCAY0TrNa6n+fycgir5ykDgsnnWb9zhCZq1JwryBWcu7lHFynqbwT
         MjYvQK8PI8y3JM/eoS137XixnRd9k/dpUSh6G4bTYcE8Hm4Bj0n4qtoWsePDLBuwc6tN
         YbwIWIySknm216yuGd/QkLanv5ADsLzwQRZgbcEn7OmPWzrz55vpX1hK7hBJcf4sYXI9
         OA0O9GCKbfx3rWEIaR49l83oUFiDOdLdF76Ckbql3nCjQUlid4BeM7V16mTr66cW0pWA
         2IpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777286862; x=1777891662;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vl0kYW2Fl2mwlVJNWhoEddEdI0AVHR4fY2I8n+p+Scw=;
        b=aq6jZFYLK4rH4aFaat59ozC6hkvPl11ihD8XBF/P542flrFuee4chJbzGm237J3HTF
         u4K5K5LYeg7t384DiZ3YgoUxycUFpRJpYrN6sZeqN1bS7p8G1dajyoXLsAJg0XMW/JUX
         mEjgI/Gt8vqi3Bq8yUXfWfKWBBQiGHjxWMxUMBr6exptF/sAU1ydnDa+wcoCUQOE8nYj
         V+m5I8W3BK/DaR4p/CednljPAaBaRrn7VR7taFDzCjHX5v0fy1xv83wRFbwRogLZNc7S
         Yc8ThWa8jPwJMEYIGgw0NiebB7r+Va+Z5YfVoW0kra/t+4zQCx+LzcZiFK86rnxAjjMX
         VTOA==
X-Gm-Message-State: AOJu0Yz9XboscsW5bKkecquPkAFKRcopiOVAhY+TQSMcoG9t8FmxjaJv
	/EYsQWwvXPx0dXNbH7keTyt2i5PZ0n+V9Pi4TQY0VivsyZdIMJTDyeZPY7hTAg==
X-Gm-Gg: AeBDiesKKqTnG77BSx/uDGT1MPOFhdu1rzGyYT+k4lfVYoUJ4Etd6cciNN84tyJlYCN
	3C1bUePX8822VOOyD3V3JIdmAUr6lDtCtPDGXNKiZJGcWYq0la/9n8MhzoyD+x26xetgQ/ilEE0
	lFFl3iMjPXhdT4xQX0qte3Zy55BvOs3/TwTATYOCNQw0gXZVSFSwlQijJu9vWlV6Bk68KlWqX7v
	velWdhkXwW4iVsHxhyfulowEy3qpiWJ04Z+9UZ4GZ6/F75w9k7W8xJzgZ14dNwIUhJqJjjsP7Pi
	RkW9b6xbe5K/Vax3fUoVofw/QklaF7mIo951QPrTVPNvKpYHAEJ93/D2t/yGNKCn3iWFTfr7a99
	XT4fREx047fOXF069aMU8EAch7opVMt6ZOLAcPf0otbczcit9vv1xLEykIkYoq+IV1RRojUpH8J
	qHl4XPpfbZTkBGKFQMbjJlqdWR0BbbUEnYHVgG/m1pOg5MSHGNjxCGvs6kj8kMFdy3Vrj60qH3c
	CnCa8N1PAbJmn71oKqSNBkojvpHTRUsXviTJUUSjzEXLiBSKZdjewZHwPviuDNbmhQXq3Rl
X-Received: by 2002:a05:6512:3ba5:b0:5a2:b370:f796 with SMTP id 2adb3069b0e04-5a417287a78mr13791322e87.10.1777286861296;
        Mon, 27 Apr 2026 03:47:41 -0700 (PDT)
Received: from localhost ([2a02:1406:125:95d5:9ddc:9c5e:28cb:9376])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185bc333sm8296578e87.24.2026.04.27.03.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:47:40 -0700 (PDT)
Sender: Erik <erik88@gmail.com>
Date: Mon, 27 Apr 2026 12:47:38 +0200
From: Erik Cervin-Edin <erik@cervined.in>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: [PATCH] Reintegrate: send "Huh?" warnings to stderr, not stdout
Message-ID: <ae896PlyiYeqldFN@mbp>
Mail-Followup-To: git@vger.kernel.org, gitster@pobox.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The "Huh?: $msg" warning in show_merge(), emitted when a first-parent
merge subject does not match either "Merge branch '...'" or "Merge
remote branch '...'", uses

	echo 2>&1 "Huh?: $msg"

The "2>&1" redirect dupes stderr onto stdout's destination; it does
not change where stdout itself points.  Since echo writes to stdout,
the "Huh?:" message lands on stdout regardless -- as would any
command's normal output.  The intent appears to have been ">&2",
which dupes stdout onto stderr.

In the common Reintegrate invocation that captures stdout, e.g.

	Meta/Reintegrate next..seen >Meta/redo-seen.sh

this means the warning is silently embedded in the generated heredoc
body instead of being printed to the maintainer's terminal.  The
resulting redo-* script is corrupted with a "Huh?:..." line and the
maintainer has no diagnostic that something went wrong.

Every other diagnostic in this script already uses ">&2"; this line
is the lone outlier.

Use ">&2" so the warning reaches stderr as intended.

Signed-off-by: Erik Cervin-Edin <erik@cervined.in>
---
 Reintegrate | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Reintegrate b/Reintegrate
index a1e67a0330..6fdc7c5f41 100755
--- a/Reintegrate
+++ b/Reintegrate
@@ -327,7 +327,7 @@ show_merge () {
 		merge_hier=
 		;;
 	*)
-		echo 2>&1 "Huh?: $msg"
+		echo >&2 "Huh?: $msg"
 		return
 		;;
 	esac &&
-- 
2.53.0

