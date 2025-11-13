Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EA12264BB
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053351; cv=none; b=Ja6NftxJLvNftpc1vCH+S+36a4S9zaMD/MdVWfwIQ/Fn6+MQgkiw0L8V7TC/tB/cViiP67jAgUqwFPGZzN8c7LyuxQshk7bFTVEfcFi+E6SAVxJMQzdkyBUQq7sQddLXv5WwCSy1Xt6DlbyXiUjIL96XS5jzhyaeYhZrDoVszRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053351; c=relaxed/simple;
	bh=z1u0bP4NogxrzIpgrg5D4y5DRMOv8P2uZy3pJzP6eJk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DMfk9nCZX3iRzqP8rnTPpf1OEInKhKLR9ewLEtrbWUsr2PkVvU5cSr++CACLWkgtDa/DAPB+coyLpm5+mquBGgvTaUU3u2HGvspRCJcXMR/Ygij5AtJ6FFTHurQ8mf8laPD5yemmG//is4+VgidIyGv3rWvtI0m46Fhs/8qhXvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=cbqMQWOa; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="cbqMQWOa"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-433217b58d9so4728935ab.1
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 09:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1763053348; x=1763658148; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rlIitqFvBgWddO5sbeFjyU+O2I5oYjlObYQqPINvOCY=;
        b=cbqMQWOaN62UHMlwXGOGW7Yv3MVLIetg2vENfw4ovpIji36xhEU48pDDg4t+7da5bG
         bSrswQRZgBLFGnlLcrM/uCBgJxQ9DuPXaB9fkZ5EE0nYiGvVwJsV9X15IDn6MdCzhvJB
         Vd6Zr4AqRJH4GRy1gGeAsPQ4vPDFxMdgOoJyZGm/wuwzUGD/Ut7T3LZbyOvKeU2Dkub/
         kX2DSPVuBykQjnDfwf/Cg1FK+7ItetHZFq+/wehf3JtCZWMQsfJLboEabN/Ah9zZdXHp
         N8VD+2nZjJYeAJjGqTjJA93F/XSPlKk8z9KZWT8iSe3rB/MDBph5OVLd4IYkqt6xfcPy
         tk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763053348; x=1763658148;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlIitqFvBgWddO5sbeFjyU+O2I5oYjlObYQqPINvOCY=;
        b=Itg4okVgVviZjtHMhgNO4Tn3lrTGG/wvS59Da50RUAAgXmNAbyBEeG5fG1/+u72Abr
         sd69DJp9AYF/Tgg1aIOfcodhY3qPwMwS6Fh1dlkS5nPjxPR0eW6x4OUzyD3DQOJvd4jT
         GVKJFpM5SkaLPHYiwGKg08iu5egywoZR+YVCidKseF6UHBuKxSAJj/mAQ0LwpL7kNFNb
         gYHGczWJEPx8OrLfe3zADC2u+0jsXaZBg/bgk/v77HnobKFzKQWaq7cF0fh2fIrwZrSr
         q+EIoaDJBEheTaAwH37b8Goys368C1Zbr0j7QY9Yhj78TFeNAnXl2lY1ueZT04qy8MBR
         GDMg==
X-Gm-Message-State: AOJu0YzO0JzxidsxM1BE2uBKG+qne8bXeRB3reQyDqV0S+XtM6Bj/4Fl
	wf+cjF+0q6l1/uYxFglbqAQJz4LTONbWe4q42mICgpkH26TsmR9EHjKTV7waTG6SfX9KCjatEj5
	OKTWv95U=
X-Gm-Gg: ASbGncs64IBbPtNRDzTV9/qpPtTiQX8YOA/i4utRxJunvbqYv+H/3eWmet4BoGa9olv
	I6nuZ6L3cQakLrSxXsDzUIxpG90ydaOf3tNOqhAJsQxma5WghRP+/Ug6oNw3BaPMAUxAE73z/0C
	XxxM1jukSLHzZNB5twvO7aqao3XOIZSKgURe3FNFJooDpMGehZ70i9PZdx6nASnFf30mhr41w5m
	2l7h+Qf4YHSZ8PSWBn8VP6K4snx1KEPFsfDy2VqMQMFUCwH2qwAvO+3awdc+W2bPvq6+lp+y2sh
	RhNE/XCxSB4teEcx1ljYWUxH8pVTg158ERy+Ve/PjG6jiLKmNZL0TeYBDvwsfnJolFFvZczabcQ
	9pU0O+zoVXZxrjxOQs8X627KvGpG4siPwZ2AWf1D3LXD57mL6dxKeopaUiPo1XRy855XChm6WF5
	mEToDbng7fAODdZEC8jxUdzp4PeSZnpC27CnOPeSoRJP6Pr6k=
X-Google-Smtp-Source: AGHT+IF0s7ik83pm29LJgvT9RiOA0qCcYaygFgMKh5L2mJ+BdQgCwv2dvjNqHDv1xKB2bRndsPO20g==
X-Received: by 2002:a05:6e02:1685:b0:433:78dd:18ed with SMTP id e9e14a558f8ab-4348c93d1dcmr2909095ab.26.1763053348383;
        Thu, 13 Nov 2025 09:02:28 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-434833c5eeasm8704135ab.5.2025.11.13.09.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 09:02:27 -0800 (PST)
Date: Thu, 13 Nov 2025 12:02:26 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] RelNotes: fix typo in release notes for 2.52.0
Message-ID: <495bed768c06a952294cfdb0ea28a0d346677b8d.1763053325.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Introduced via aea86cf00f (The nineteenth batch, 2025-10-14).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
Noticed while reading through the release notes to prepare GitHub's
coverage of the v2.52.0 release.

 Documentation/RelNotes/2.52.0.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.52.0.adoc b/Documentation/RelNotes/2.52.0.adoc
index 45e7f0a244..4df3d5a8a0 100644
--- a/Documentation/RelNotes/2.52.0.adoc
+++ b/Documentation/RelNotes/2.52.0.adoc
@@ -53,7 +53,7 @@ UI, Workflows & Features

  * Configuration variables that take a pathname as a value
    (e.g. blame.ignorerevsfile) can be marked as optional by prefixing
-   ":(optoinal)" before its value.
+   ":(optional)" before its value.

  * Show 'P'ipe command in "git add -p".

--
2.52.0.rc2
