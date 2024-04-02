Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AB215E5C4
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 21:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712093875; cv=none; b=WpFTO8sYvqZh/zpWsL1gZV3qDqd1R8veY0Yesk842MIrkVRHMHKVzAuwjaGoG8ImMEZZYd6EGdW5BXayf62axppOCeXyRkIJRINHMfeYFFsJsSKBgQ/fjhUH7Aooykqkk+/hBfkeL1Lolld/sUaER/slJH8QKivsZJZ6fTMO1ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712093875; c=relaxed/simple;
	bh=MudvVWwiIO7Cr60dHABuE33X757zCL9qgUpQQW3RAIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6+anLRpCz+0t+jARvZ1uinYKP3evpBVL+ABuQrKjfllEfo0WFAvPakpLzmdkPbTTZqvBdNAIwnuhDg0vOKNaXlYZvp+Ryl8UCSy8ym3MK87oQhL1XPrrnGYhHjnxGSzCBPGIHtBELYjzPlhH2cx7by62A7Eb6woOwGGPO7F+SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9G0pBMg; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9G0pBMg"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5dca1efad59so4064671a12.2
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 14:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712093873; x=1712698673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOf+qlppZ+lwmnJglOpbYgVTCDO5wgfYlG1Eu1TckXI=;
        b=U9G0pBMgFgNn+1q+Z83W7RSwvSoujvCCE311JtAEo4GgcQnB22VS265bDFJWVvWf1M
         MWoalqwSdDI9mBsA1ux1++NRfQEh/vTaDpTfCSsKig6nVdj9ZDl+/3+DBEcfaPla3gT3
         VbT95eCrT/HYtteNh2zH/FkHZT3uXJHtGMCAv5f9c92htR6vonV4G1plvhqcrwZfu1aY
         CD+9E3QOCosSE+Mtet9rqigcf3eHN0ia1ONXfH2SOcjp7WnO/jDxTGnczbcnhfv6sBB2
         RbWYKnk210LvSfid5w6MUsfMFGg58EA/VPX7Hd/TvgTvg9fwfNmmeuwHscG6lQtOVteS
         F7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712093873; x=1712698673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOf+qlppZ+lwmnJglOpbYgVTCDO5wgfYlG1Eu1TckXI=;
        b=fw6rwuD01RDnmdo/2qx7X/qJKVdaUDo0CF5kTlRpCozayhrFFSm3LYRfjJeR+jb5YV
         0gn74UpyPYuf64eEYp0t+e27fVSwnLJMAMJQijxOramkMM+EFMduOeh7JdrP8wRJoWS2
         yZBiq81OfIBduwi59UPVffX0BbHtCnfiioh85bN8OoDn4OAaTGmj96CZScV8efm5nedo
         hlM1GpbgncHHeHLMOatAmmPK4Wg3pNTzsMX0jO0RemLt7mCOe2KCVqUZsiN4fx9t9ze+
         W9WSc/M7Wgf9t1SHm5Lw0qQbKYz55dHycyTpvhp1bzuGMmX/fpTrzddyS58tQbEztcU3
         hxVw==
X-Gm-Message-State: AOJu0YxDCVgOKXgetiHHyonhX3UtclHlbXFrNO0ypk5KM2XOEz3KYiBQ
	1x0dQ8uyDuFRXV6TKED1tlsCx7nBOC5eQ09LSTauky8xANYKf2wIxuikhA5x
X-Google-Smtp-Source: AGHT+IFk8hQ6SRJ+0Ibf1mV7zYhBg6rglyLZZJSQxvEUn+kuD0nx9qhyKVDDwJdpYnxzO9noEMdczw==
X-Received: by 2002:a05:6a21:2d89:b0:1a7:2a8b:9c99 with SMTP id ty9-20020a056a212d8900b001a72a8b9c99mr488480pzb.47.1712093873281;
        Tue, 02 Apr 2024 14:37:53 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id az3-20020a170902a58300b001e1071cf0bbsm11641513plb.302.2024.04.02.14.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 14:37:52 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v3 0/3] commit, add: error out when passing untracked paths
Date: Wed,  3 Apr 2024 03:06:21 +0530
Message-ID: <20240402213640.139682-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329205649.1483032-2-shyamthakkar001@gmail.com>
References: <20240329205649.1483032-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This version uses Junio's patch ,which adds a new .ps_matched member to
'strcut rev_info' to record the pathspec elements that matched tracked
paths, as base for patch [2/3] and [3/3]. 

Patch [2/3] remains unchanged from v2. And patch [3/3] is updated
according to Junio's suggestions.

Ghanshyam Thakkar (2):
  builtin/commit: error out when passing untracked path with -i
  builtin/add: error out when passing untracked path with -u

Junio C Hamano (1):
  revision: optionally record matches with pathspec elements

 builtin/add.c                         | 13 +++++++++++--
 builtin/checkout.c                    |  3 ++-
 builtin/commit.c                      |  9 ++++++++-
 diff-lib.c                            | 11 ++++++++++-
 read-cache-ll.h                       |  4 ++--
 read-cache.c                          |  8 +++++---
 revision.h                            |  1 +
 t/t2200-add-update.sh                 | 10 ++++++++++
 t/t7501-commit-basic-functionality.sh | 16 +---------------
 9 files changed, 50 insertions(+), 25 deletions(-)

-- 
2.44.0

