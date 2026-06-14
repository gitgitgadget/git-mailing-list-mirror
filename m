Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022562E7162
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781465147; cv=none; b=ScovDl0QLEGAhiElfFuSeIh185nbJTlmK1mc2RzAPOywJzw+YQBJFLCGkUPe9LNMeF8lcx4sIOW/oEF/eufKirjbDb5MyC6PvFCVv9MR3WiWaP7//DLPIbYPr/jM9ysAw5lVYVg8es9w29tqj6s7mlBCFGH1/DmA98wcmd0Yr6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781465147; c=relaxed/simple;
	bh=8UBEDtZf1orviEuUoz9qnZNjxwWtHgEwIvXr3XBTK3E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=G/MS37mIHkG2qlTvSwfSiZkx3oZwzWCN8epqpUHVts4Zeidbtzev0wVsYWqsFCQJnEkELmDOp+0JBl9KKwKm7vBrRGeUKlsl/B+fIqm/aEPTI1DlqR935d6ygU3PqzJ3MyVdjKs4FwHvgyqFQlNwEeCkU7sYbt9BQBkbwFzS028=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4zlogxL; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4zlogxL"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-307631dbfedso5810201eec.0
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 12:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781465145; x=1782069945; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdHm7w0zR4/ZoA+Phl7/TI4+ga2sfdV2Mgx1TEtU+y8=;
        b=I4zlogxLblmpITvmnsKpuaJvXVaaOZgwP14NSSt2JR/uCpyZugc2isSUnqnl4oMicT
         jtywqCiYgbbejQyYRgoraX0RBhe7c+tjJuy9mkjjMI41HFxwX7lKlLt3wiCJejPaYjj6
         xeb4DiO1VL/agvIeyu60pXGaWY0QYaP+UnB/EPfuZ6DNm/ITLm3WsiC475bBF31KpA2R
         gk3OmxdsJ2vzqGtXwC43nwsvIGju0gH1p9+ixHGoctH0AvlXh56capL7+LMxkNuH14Md
         gZhTVk8jcs7K31BLEoTtItBnldM6xIpvUH93gCQiguWnQj/QRIreJte1KEGAcRU6zQN2
         1PWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781465145; x=1782069945;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XdHm7w0zR4/ZoA+Phl7/TI4+ga2sfdV2Mgx1TEtU+y8=;
        b=YT8wC3ZG9vPwt0dBYVQlYSWYe9BD8M1t1KOLxg874o8TGUL1MZksFlRlmo9tVCJFuG
         gEnx87PLQKB3/2ex1HtKpDfc+jEofcxHzN4jnLed6zXSJYCV1KlOPbKdCYnl983MuY4b
         9Lf4DFKufFpr0/azthYjso4H5QUSK5WVfDbKz1Iu4yoWGNbz9APlTsZ5a6pUxxqL/cPh
         pTtt1Pe9n7LkyfV24hr/Ul0eV/5Mw0DrGjMbKS9XGGcnxd0ogKLLXnPOQzQ7h5IiX0eZ
         Xcuo9FOG2CcH4uFwwJQqo16K/Ko/dRiPgNr4yyd14PDdWMPJ7SyTMnHX1PFOLG6BAhJO
         NI7w==
X-Gm-Message-State: AOJu0YwLQBnOg8K2TFNvpge2rrXDP0OoUKgUyV/y114mKjE29TD0LHKD
	MMRGus9GYF8OIsPfSm2v+kP2ICnQ05SiqNfQKX+ckiMJSV0z8cCJAXMWLP1JRSMU
X-Gm-Gg: Acq92OG++WFtDaNCk+h4y/z0Ms5N9ToQZHkZLjEB7Yz7ypf85wrzlR/HU2XuvSHJzcW
	JTcq0D78F84fWu3Tcn+3BNBxrPlIY9/ZGUN/eifBinSZUHTOV/56MuTdx3FEFMNP43OjRkuIVPl
	E1BLBNbbr4EvdyvRR4kJ2PYt+DTcjsshWao8yuFJZdqjk077rbg2QaJMsYcEbYDSRUE1XInGRtG
	A07Vk1Bcu/NZtmNXkahqKEibAA8FZEU8CHMFZ852jiDnNsoLW9QvnHo0zFVyWTYymmEFaYpsvib
	AlIO+wingj27QY++kLHTNUJwx34GmrsKcJ5ezzl8bsFWJmVcQC3zDR4LzFi5mm6W9y5H4QmaRCY
	xEpA/QkPL5uvpw9+rTzwhFJgVwuGIDVfu3pXqsgT8HC/3vTZbaiJk6j9eRL5nz6IvSiJoiCh1ms
	LGGE6EnaDATDV6jx8expnXYLI=
X-Received: by 2002:a05:7300:6d22:b0:304:e2a5:689e with SMTP id 5a478bee46e88-3081ff40814mr6400976eec.2.1781465145235;
        Sun, 14 Jun 2026 12:25:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.42.67])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0357sm11117726eec.11.2026.06.14.12.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 12:25:44 -0700 (PDT)
Message-Id: <c55b9cd6f749bf1470dba46e6bfea4c0472d3490.1781465141.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Jun 2026 19:25:40 +0000
Subject: [PATCH 1/2] t3415: remove prepare-commit-msg hook after use
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

The "pick and fixup respect commit.cleanup" test left its
prepare-commit-msg hook in place, leaking it into later tests. Remove it
with test_when_finished.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 t/t3415-rebase-autosquash.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 5033411a43..8964d1cc88 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -490,6 +490,7 @@ test_expect_success 'pick and fixup respect commit.cleanup' '
 	git reset --hard base &&
 	test_commit --no-tag "fixup! second commit" file1 fixup &&
 	test_commit something &&
+	test_when_finished "rm -f .git/hooks/prepare-commit-msg" &&
 	write_script .git/hooks/prepare-commit-msg <<-\EOF &&
 	printf "\n# Prepared\n" >> "$1"
 	EOF
-- 
gitgitgadget

