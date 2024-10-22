Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7827013B58A
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 22:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634943; cv=none; b=Z5tXNEaFLkf2cA0jhkyz6ES49cbbUXRFRbizgLUqs8lb9327bPHkme5l14o5jts8EjAWvHDEyQU4A0NcxMsdaPLhRDTTcbpyaGIYTZw4tog4NELGb+HUw3TAyUMiUv5CQGKR0lFv7DTFdQfukGyq4E8NcU8GxwmvqK6+c6TJ9aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634943; c=relaxed/simple;
	bh=Cx57wSbIAiVmMCbOflv53JYTPfUnUYecYnPdOqOxsmU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KAYQ5+wArMJpXViSi54X2H1ybjK4B0z3PxYSgH8elNaSmiiFWbafkWy+HdSqXjrZ5ZTJBga4topwwlJYi+E5kaFTJ33YoZ3Cyfef7Bt10vYeEP6KWZ/5nj9CgSmpiCPlYOrLV7fY2OCwehICXiR4NopydUPxm9dB0zuGFpkct8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sw4Kxn/3; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sw4Kxn/3"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a0cee600aso768188466b.1
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 15:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729634939; x=1730239739; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jxf8ou/QIRMFQ5uBn2OWYpeq4K6Qc+xCF2zKW1AA/Ck=;
        b=Sw4Kxn/3XcyWK2+7wPrjeT8YjpuXrn3N9KSQiOC1KmUbXqk+1lVuljyptbaL7i84JU
         TJWizLPZNwhYDRsk4PWKI9pqI7G/PRY2UZHoqeUpM+C7j8uHvzcWSk4t+DotoBrRQHUV
         R+gqkAkYu5bH3nVxogFdi2u11wpaUN2wpXWNMfeaVD0XZduR+X8AuCDL/UUk9vryV9pq
         E0pVygQx7onN1570MKpKmN+cmpkmIUVTuA7juM1Y328Dj7aUDvSXPuKDPwIL+4vGfPkK
         Wy1fkqt/nEWDza65PRYOKVWijJQ44P7m9biMXJ/wwALjK0VZGi66jPWrgRJG983cSUCc
         sJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729634939; x=1730239739;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jxf8ou/QIRMFQ5uBn2OWYpeq4K6Qc+xCF2zKW1AA/Ck=;
        b=NLIbt/yP+UcDrjAhcA1+1wBGrNSgR1sbMuLGLlB9+TxaHNLILfZWPbdqayc0doEa1F
         UgQR7T2nkJtZPEpvOxU1QS4Vd6udyMc491jCe5uB5LKIQdJ3tp3UwOv/PL1n9g6ogZjX
         7bAsu64RGkpaDhnTqLyZvJrTXW3ra8nuGSzsh8lDvP2+nRod+Bh7TX5CqcNTV2AabUNg
         STVuFGaoHqg+NEEvAJqf+DKcbVSYMkhe1qMJ3BBFzrjnFh9a54+e/RZX59TawUZ8SV49
         F28zM8Ck0qKHjjzJbdPFLz7JEy7ziON+0AkzzNPeWrOMg0JObkUnzTAFzLpU1ryNxrQq
         HN+w==
X-Gm-Message-State: AOJu0Yyd5VP7oSNT2Pt+2tJZew4Xt5ZHYFlvhYtz2LDP7dIGv9DeTZOU
	m3nI+U5V31Wf4sTyn6PvswNpwfjoTXzzTtait9WOgdq/fkhPlPwG0KidQQ==
X-Google-Smtp-Source: AGHT+IEma2yauOP2OtmmDbdj0o8E7OzYs84e9ciGMbNd3Rb9WioDAhD9pec36R5Jfx9I6qU1L6iFVQ==
X-Received: by 2002:a17:907:1c85:b0:a9a:13c2:2b07 with SMTP id a640c23a62f3a-a9abf8b7bcfmr38859666b.31.1729634939254;
        Tue, 22 Oct 2024 15:08:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6307sm392820166b.33.2024.10.22.15.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 15:08:58 -0700 (PDT)
Message-Id: <pull.1810.v4.git.git.1729634937.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.v3.git.git.1729574624.gitgitgadget@gmail.com>
References: <pull.1810.v3.git.git.1729574624.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 22 Oct 2024 22:08:54 +0000
Subject: [PATCH v4 0/3] parse: replace atoi() with strtoul_ui() and strtol_i()
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
Cc: Taylor Blau <me@ttaylorr.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

Changes from Version 3:

 * Mark the error message strings as translate-able.

Usman Akinyemi (3):
  daemon: replace atoi() with strtoul_ui() and strtol_i()
  merge: replace atoi() with strtol_i() for marker size validation
  imap: replace atoi() with strtol_i() for UIDVALIDITY and UIDNEXT
    parsing

 daemon.c              | 12 ++++++++----
 imap-send.c           | 13 ++++++++-----
 merge-ll.c            | 11 +++++++++--
 t/t5570-git-daemon.sh | 26 ++++++++++++++++++++++++++
 t/t6406-merge-attr.sh |  6 ++++++
 5 files changed, 57 insertions(+), 11 deletions(-)


base-commit: 90fe3800b92a49173530828c0a17951abd30f0e1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1810%2FUnique-Usman%2Fr_atoi-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1810/Unique-Usman/r_atoi-v4
Pull-Request: https://github.com/git/git/pull/1810

Range-diff vs v3:

 1:  e292b82d6a1 ! 1:  d9c997d7a9c daemon: replace atoi() with strtoul_ui() and strtol_i()
     @@ Commit message
          Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
      
       ## daemon.c ##
     +@@
     + #include "abspath.h"
     + #include "config.h"
     + #include "environment.h"
     ++#include "gettext.h"
     + #include "path.h"
     + #include "pkt-line.h"
     + #include "protocol.h"
      @@ daemon.c: int cmd_main(int argc, const char **argv)
       			continue;
       		}
       		if (skip_prefix(arg, "--timeout=", &v)) {
      -			timeout = atoi(v);
      +			if (strtoul_ui(v, 10, &timeout))
     -+				die("invalid timeout '%s', expecting a non-negative integer", v);
     ++				die(_("invalid timeout '%s', expecting a non-negative integer"), v);
       			continue;
       		}
       		if (skip_prefix(arg, "--init-timeout=", &v)) {
      -			init_timeout = atoi(v);
      +			if (strtoul_ui(v, 10, &init_timeout))
     -+				die("invalid init-timeout '%s', expecting a non-negative integer", v);
     ++				die(_("invalid init-timeout '%s', expecting a non-negative integer"), v);
       			continue;
       		}
       		if (skip_prefix(arg, "--max-connections=", &v)) {
      -			max_connections = atoi(v);
      +			if (strtol_i(v, 10, &max_connections))
     -+				die("invalid max-connections '%s', expecting an integer", v);
     ++				die(_("invalid max-connections '%s', expecting an integer"), v);
       			if (max_connections < 0)
      -				max_connections = 0;	        /* unlimited */
      +				max_connections = 0;  /* unlimited */
 2:  2ad3b0faa05 = 2:  da9ea10e4e1 merge: replace atoi() with strtol_i() for marker size validation
 3:  d0aa756d2d0 = 3:  8982dca646d imap: replace atoi() with strtol_i() for UIDVALIDITY and UIDNEXT parsing

-- 
gitgitgadget
