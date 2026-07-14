Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BC83644CF
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 22:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069344; cv=none; b=Nc/XzQXpoPgF0LRrNiuJoRms22/AltOLutuPiYaiFUZh3ff1Ry/J3i/5LNnDM43CgvMttE1x/sz4mflRdb/rO5O2oE5j/+NGs8SnZ8HMSQ2Lz9TNb0+MycYGz8Vu1P2paE3xcnI61Z68FYmnl4Ls7mzU6zdyTkueymOH+RO7AJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069344; c=relaxed/simple;
	bh=jb1+5zh525lJx2yTH4w9R1S975YJtAmBtoDENblHSJY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Wlld9CkiuEvhGEH7+3/lQjB3QatjDqqHhhmRLkoq8zJ+GOFe1FV0jllX2U9s/ksEi7Atni3hAUuwfDf+cvm21F8WkyVc/HbRJBUVaR2w1Pl89EfvAv1n2RAYaWnHPCyUhro70vP1xQh99ojePpns/frlj+qkMnXHH0sSXgODW48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFJd8Pxv; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFJd8Pxv"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6a375ba035eso829119eaf.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 15:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784069342; x=1784674142; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fRccCIDR+jTMBT4usvw0ZbAZlpjVniL2pBi2VJhyIow=;
        b=mFJd8PxvKaUPlaKOT8VLmdhutJG9AUsrKrOzGwdZtjUiNwyPgJqc1AhlSN8SQaKLJ2
         lQguGy0D9ox20a/9RuEjgQs4D4pV4q4pw7vzoAQIGfpq9CjqDIXGaFt/icfjZw8kuEJ8
         i4pw7lK0uuZll0nNyYvomz83mT0m4tIbsGc1xyAlt7ly2YpeagTLduRl0GQWmSuHAlEk
         o1vKklo//SG1KPZ0UBOjV8xd794niC7nDO1WMGsuMV61WMOF2oIPxRh77i6SPXqKYzL+
         pMWKNpq2yAQR58uiho1o9Dekz4MNDdmGCVRHpTYJ0FwKrasylcw04doM0+3KEuZcYNTu
         pZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784069342; x=1784674142;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fRccCIDR+jTMBT4usvw0ZbAZlpjVniL2pBi2VJhyIow=;
        b=Vi5zCrY3X17Nn30/QNIWGRtLevxDbbQFANSpzN87y0FxBekAnqQ4QSQ8AlsLG+hLN4
         ltnBI2Map+H2AQA//g8JlLMyq62ZH+YGUjbW8++ER9Rk1rT3bzhx7dusAJhx7BxHsIDz
         BahMcUuw4zaY6UUnzgF3GdrqbmKADTA/djG1VOB7eFPnOEL3tc1BgTVYqglZbIUpr6+X
         X6Nd7GlPCSJo1s0PC6ereVpnrXfLt8wB8dmYAteFsWgtsUiQPxbhvyUcpQJr66q+wx4o
         WwsF8PTC16PX/i222hul+MQcAZ+PndPj7dWvRY9Ze6/rK/qTlZVJPuUdf2dNxzArKTGW
         en1w==
X-Gm-Message-State: AOJu0YzRQQ5flng0MlfJax6r0jcKXlPk0mHQg9gu2J+YJA49h8NgFcE9
	coLx0nibdSxsJ4y2m5w+6GCZ7c9fE5CAR2q1EW1nfGz5GbvZBevxMB2S9GmGeQ==
X-Gm-Gg: AfdE7clpo65eo8GpYTA1pzSbjNZJxpUsGz22vWmIm8rnyEXnnklGGVFirfeaYVT9oH8
	44MBS5CZrC/9fL1sZynvgFbRHP1p7BBa+9sam/l7l7gEMZ2k87zo1bYYPWSwzSwRfgMndz2kxI3
	d7Yf8FUuFYdeQJspihmjWlWUl/SwvQqShDhuakny3nC3CiJPkbU0/QZwkvbc81C+a3V3DrKGThc
	MiIIlX6F23AGEo3c7eljypVxbo4FWQWIjrtVdl+mVf10nbjlXseSjh5OgyjdjHEfAjej644aOTX
	5QlvRo7e6i2NiBpw1aa9s124v29wN+85GdHRyfiWqgBNYGkAsaQbvemKc5XqGeuUR4TQb5iwf0K
	gV0WwwNWo3zaQqC7yhJKczyhXmFJqN8praxYSk6SMWz921jn4XzybCoecZWNwROt2PjGqYFW7Ym
	PlsbDMg5wWSMW/OO/J
X-Received: by 2002:a05:6820:3082:b0:6a1:87d1:4031 with SMTP id 006d021491bc7-6a39a70ea8fmr8835384eaf.51.1784069342531;
        Tue, 14 Jul 2026 15:49:02 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.178.217])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-451916d5cebsm18087924fac.15.2026.07.14.15.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:49:01 -0700 (PDT)
Message-Id: <13ddcce053921d3fc8f97deb0dd884ae4667abd3.1784069325.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jul 2026 22:48:41 +0000
Subject: [PATCH 08/11] transport-helper: warn when export-marks file cannot be
 finalized
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When push_refs_with_export() finalizes a successful push, it writes
the fast-export marks file to a .tmp sibling and rename()s it into
place. The return value of rename() is currently ignored. If the
rename fails (permission denied, full disk, or an antivirus product
locking the destination on Windows), the .tmp file is left behind
and the existing export_marks file remains stale; the next
fast-export operation that resumes from it then silently operates on
inconsistent bookkeeping.

The push itself succeeded by that point, so promoting this to a
fatal error would be inappropriate. Emit warning_errno() naming both
paths so the user can recover manually, and keep returning 0.

Flagged by Coverity as CID 1427723 ("Unchecked return value").

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 transport-helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 31883b244e..ed0543f1ad 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1184,7 +1184,9 @@ static int push_refs_with_export(struct transport *transport,
 
 	if (data->export_marks) {
 		strbuf_addf(&buf, "%s.tmp", data->export_marks);
-		rename(buf.buf, data->export_marks);
+		if (rename(buf.buf, data->export_marks))
+			warning_errno(_("could not rename '%s' to '%s'"),
+				      buf.buf, data->export_marks);
 		strbuf_release(&buf);
 	}
 
-- 
gitgitgadget

