Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A961640B
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 06:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706079309; cv=none; b=rRhM4EVLm6BxG1+KVa6+Yeyyuv+aSBSir5smf2tuqPyk3noMSEe/NscxrzpJK+1ulZUoV+n2Io9PxDnsfEeFLH1yOpVWG0bcZiPn8tjoeIL2Q0oe2/13cih+ysHAcLcf6R4RPOzXBba3ShkXnPpsFXBiaL0puHRpiDeVk3wJ8pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706079309; c=relaxed/simple;
	bh=HNdNQRDTFsDsDqyC1DGwAgRTr4ABm1QY1g99fmnrJsM=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ur450Bh+B+A+NmBZLzhnzRI5+iQM+tlIUh8woYxcS/9mqn/Iy3VziYqoJOQAsCuMsMFU6mTPEGSft8BWA/Y1NZwJa0bHqquWdcb7PbNm17tKe99IwFd0kiOMRPNjFDTHSrWM2zIPnfesL6DHdJOfHVIChlcQMLTmADlc/FMQWx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNDL6KcR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNDL6KcR"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40ea5653f6bso49634055e9.3
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 22:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706079305; x=1706684105; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoVbkQ1DgW9kWL00S0Y1q8MzWHcZx7gfXVM/JMe+ccc=;
        b=KNDL6KcRUWXTmsxQOXAWcH0Nn0ifqzgem8wiTHrp54o1faE136D5tMl1mLCP4H+5ne
         FXKVUHYU/vjbteS9QunK0z2vA3gfSnaoU/usCkCK+/S4t53xzLkErXTSLtcWz7Wb6E4F
         MWje8tXekXArL17txyLmK6AmfujJ5QAgRA7ZUGs4tHfEYhrFNONHpNDCBAnNQcaJ/gLK
         CZKYY1LUCXjuo5172I2/bhzs4cg8F0/XXUi70UgSBfON8ikRNCojnmYQVWJAmulzKSt+
         RAmSvavi7HZwOopM8YZo93wAN129gLCz3deRbR5AL52Qh0YR8qwn3T9VlCt9rAlSK/zv
         iPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706079305; x=1706684105;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DoVbkQ1DgW9kWL00S0Y1q8MzWHcZx7gfXVM/JMe+ccc=;
        b=fnZh57iEVh1K9MylVKlNrIC/+Y+LhxQHP3FH60wzaT6gD64j8cB5UHA3z01h9bPdhb
         8f/HBcKIXwPa+I/Q9n+iKBS1C3mpEgawhSDlnUzvXPWcTbhzR0pluhOGMopotPyz73Xv
         jvrzP/j/L+uFeJTbxy8zA3gdGv450/zhnJzYA+zERP0REWD+thqAB7Hy78wBL6WjUykI
         Vypx6ka4klsmXG8WdguHjO/cSzgFcsw3vB0oCvXgLpm+R6tG59RwAiTted/o/SZfhd/y
         uVDtnPG4o59Nl1nm9+5Ex4s0ot/gdc8E5ARZmFCHArtv3zC56Af7n7gqoQR5UfgRnfiW
         fKvA==
X-Gm-Message-State: AOJu0YzDZ2Zn367Ndoc6TDBCrt16pyUR80V4ltBFX6hiSU/B1PAwLZhn
	X0e6+xY6MWc5A0V5oz4WmtT+ZL1m/HzFODhd5ddgp31e8deBfTXI87VlDyT7
X-Google-Smtp-Source: AGHT+IF9eZLB8olNkFODmWwXCZ0yDx+WGlrQXPDNoOqli3K5CJmN+16NXRAC25ynyWseTOShX2K5yA==
X-Received: by 2002:a05:600c:3b82:b0:40e:89ad:8ba9 with SMTP id n2-20020a05600c3b8200b0040e89ad8ba9mr808075wms.17.1706079305314;
        Tue, 23 Jan 2024 22:55:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc15-20020a05600c524f00b0040e6b4925b8sm37817601wmb.20.2024.01.23.22.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 22:55:05 -0800 (PST)
Message-ID: <pull.1646.v4.git.1706079304.gitgitgadget@gmail.com>
In-Reply-To: <pull.1646.v3.git.1706078885.gitgitgadget@gmail.com>
References: <pull.1646.v3.git.1706078885.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jan 2024 06:55:02 +0000
Subject: [PATCH v4 0/2] Replace atoi() with strtol_i_updated()
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
Cc: Mohit Marathe <mohitmarathe@proton.me>

Hello,

This patch series replaces atoi() with an updated version of strtol_i()
called strtol_i_updated (Credits: Junio C Hamano). The reasoning behind this
is to improve error handling by not allowing non-numerical characters in the
hunk header (which might happen in case of a corrupt patch, although
rarely).

There is still a change to be made, as Junio says: "A corrupt patch may be
getting a nonsense patch-ID with the current code and hopefully is not
matching other patches that are not corrupt, but with such a change, a
corrupt patch may not be getting any patch-ID and a loop that computes
patch-ID for many files and try to match them up might need to be rewritten
to take the new failure case into account." I'm not sure where this change
needs to me made (maybe get_one_patchid()?). It would be great if anyone
could point me to the correct place.

Thanks, Mohit Marathe

Mohit Marathe (2):
  git-compat-util: add strtol_i_updated()
  patch-id: replace `atoi()` with `strtol_i_updated()`

 builtin/patch-id.c | 12 ++++++++++--
 git-compat-util.h  | 23 +++++++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)


base-commit: e02ecfcc534e2021aae29077a958dd11c3897e4c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1646%2Fmohit-marathe%2Fupdate-strtol_i-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1646/mohit-marathe/update-strtol_i-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1646

Range-diff vs v3:

 1:  60ea85a701a = 1:  60ea85a701a git-compat-util: add strtol_i_updated()
 2:  0e117198d01 ! 2:  17f2dda4907 patch-id: replace `atoi()` with `strtol_i_updated()`
     @@ builtin/patch-id.c: static int scan_hunk_header(const char *p, int *p_before, in
      +		if (strtol_i_updated(r, 10, p_after, &endp) != 0)
      +			return 0;
       		n = strspn(r, digits);
     -+		if (endp != q + n)
     ++		if (endp != r + n)
      +			return 0;
       	} else {
       		*p_after = 1;

-- 
gitgitgadget
