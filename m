Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448A2370AD6
	for <git@vger.kernel.org>; Wed, 20 May 2026 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308682; cv=none; b=jFDH8J7+n+GEws9LTMhdkYK3Yn4hfo/BL/NaqOvzu3omlO5fGpCn8tyJGmY73nKwJN1wb/8MHl0/pycK7bacv7sKta3JEsuMRrtHJTWJCUxm8S7jBBeOdyrKppGqkcf1fwQ5l3dWI/XNVU7reMDXhmp+coTTfjkxBFB2oLX3/AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308682; c=relaxed/simple;
	bh=O+TcYr4gDlLB/JqzZ99c3IZVbRxJ/U//kaLrUUyijgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDKXViAJ2Y+sEXhROiI9L7TpXaDSoQx/Wa3wn8t9uGwcunbLv2nP0a1KkR9JrXgryTj2XFBbn7GOI0kkHM35JHzydP9/Z7ARfMaIgsqlTbo+s97diX0queierOHXsdxEYdG+C5VEZg8vTL8GYJKHF0nvXm71CEox+b5KJGMjChk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvBKLy7S; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvBKLy7S"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50d6ab4476eso57530281cf.2
        for <git@vger.kernel.org>; Wed, 20 May 2026 13:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779308680; x=1779913480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1o9CbCEIKiYTFhy5aNLlZhocv1LcDA30kK5X3IxfjJk=;
        b=IvBKLy7SRtyDLZn4kNSeDu29AjDmEHBbVnDzgaMtC65SLxlSqYza07cqzKOEeOHYLZ
         i49a75WBCTMb3dSXaj6MbJuxetvZoWXg9r2HsU2HE2GDF2TjflZ+g64uPdO0Ztub9qM9
         7AFFUbVfVZyuLiuZ9+wUEGkRtmPk0QoiNcppu3//Cl5xjpRsIxMehJmb+I1Yi2OhSLKP
         tcBgq1BYWC32lSLSewz5A/yVxP4AuwK6+LTfFW7XW391UPbRK4o+GeShQwLhS27AKZQx
         Llx47V0i76qs4039SBhs5xnb3eZxNkGfIyO1EwrcJrUf9AAu04urP6XHvReXvW7+7IhP
         prig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779308680; x=1779913480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1o9CbCEIKiYTFhy5aNLlZhocv1LcDA30kK5X3IxfjJk=;
        b=lZ44JYhtxVDfbHM/WMlHzauzePQJamCSHxU+/rP3SUuceiu7QIQ/IO3/tULyts4gEl
         EFVqJsw59fm7ijrLWMXhorxg4MXvkenl3h2oWhAO3pvoLtp64wvSdwQXP4WxrwKd1kBn
         W9H0et3K3L0XXbPSGsmSwH95Z57n4eglfe6ya2fixX4DBHlrLz8+PwOgDKnCsm/LTx5o
         pTgRSdWFQ+4eX0T/3BnXlnLcwWOnm/BR5W4+Y+6EA7syxzu2Ubs2yS2VMN7fd1gMmw7E
         ccVfiNAeILihtkPoeTd5HUsCdfAC/L7fOqcQKeDDF3bwBYBRo1L31yJxIHTYzJCU6XbU
         ITKQ==
X-Gm-Message-State: AOJu0YwZfdGk6iX0CLkFUue9wAYNw5Ajq7IVMk7SEQoRkDgQ0SuAQKMq
	V/tVKJkpa/6tr0AQfl7mi0Ce+5G0zDKn70AD46mO39AQ/OJv/NmeVsFQD1l6AoCh
X-Gm-Gg: Acq92OHPMkDrEJB+h6cLmBR1uhGRr/gAPzlZHIOoWvw5ysaUDO7JntGWBswiYOG3WbH
	35g/p+G3gYcTuo1eo9u/grflUIjHRVpsSRbHqyfVr3QRiWHoNvTfOtYwmSdDhYhQStISjlMsQLY
	hflxMoZILZiIvH4xQS4fJ3vgwhSztXdBYFnjdnSW45WUSwiqdRrw8LX+eQjycgzAkbrs0uszRxq
	vIHjN7WX1MSrL2CkZxdNYnfAXeO67hu94F2OzwfxvK0Ea7+Ta9cfuhdXLwN+HlYwEhlWkY5uOlS
	a3dVG7EDex4h5k9NLX8+xBFD83InkhhUbwFvzGQSUGU0cXssNKRHccM2UkR27eH2QLIvk9nEfU1
	Nx2wWCAzYU43k7Hhy9jqrifIsBBmKp0ESYi6aqWP3zJRVHCfV9fGk/442F2vab/WFnog2NvHOW9
	wsXplL5zH3axS3dVRnjpeI/8ZsVw==
X-Received: by 2002:ac8:5fc6:0:b0:509:26f4:64e9 with SMTP id d75a77b69052e-5165a23b2a2mr341515311cf.51.1779308680260;
        Wed, 20 May 2026 13:24:40 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca361905d4sm129891136d6.32.2026.05.20.13.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:24:39 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v2 09/11] git-gui: allow specifying path '.' to the browser
Date: Wed, 20 May 2026 16:24:08 -0400
Message-ID: <20260520202411.108764-10-mlevedahl@gmail.com>
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

Invoking "git-gui browser rev ." should show the file browser for the
commitish rev, starting at the current directory. When the current
directory is the working tree root, this errors out in normalize_relpath
because the '.' is removed, yielding an empty list as argument to [file
join ...]. The browser function demands "./" in this case, so make it
so. (./ works on Windows as well because g4w accepts posix file
naming).

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/git-gui.sh b/git-gui.sh
index a72d8a59ec..d373457901 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3007,7 +3007,11 @@ proc normalize_relpath {path} {
 		}
 		lappend elements $item
 	}
-	return [eval file join $elements]
+	if {$elements ne {}} {
+		return [eval file join $elements]
+	} else {
+		return {./}
+	}
 }
 
 # -- Not a normal commit type invocation?  Do that instead!
-- 
2.54.0.99.14

