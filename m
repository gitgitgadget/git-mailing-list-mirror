Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794078059;
	b=Z2hd3wbT3Q3ZI03N7mJ98IODjGvpWNsML9EPMeEXbHNFACay4yBkbsOvSpOINXDQCSJK
	 DjVqIGs9BEzpYN/9UWuyzTPFdeqKkhj/n/zkNujNYwkwmBu4XXUfjYXVc/ofiJdBhx9Ne
	 yJiWM/mYJrgn/0Uus5blRbozWuQ1bgsy3FtU38EhjLLsURor+xXhxZE7t1sdNvramuZjJ
	 uLoibMZabFbSpUHcVJ61akISYju8GuN9dwZqTpIEU+0501zU8gJvHERlmyAUcUuFmFlFm
	 YxJIuLfZ+l7cEhWN+PeqoGDry0e0SmvRz77T6oUN0OTkfhf8lDjA82YPpKL/dxNDZ3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794078059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=b3FlpY8nvi4G/70CC6/K6fMlvaqdNQNndHrPbZSILu4=;
	b=cRLEAoCgGlPZHOvVtp5PvX6ZC/YpbJh5EuFBDuHCt7Mg/1jLFt6XLOA0BXZtr90K9QoQ
	 G/D9CSQ0TNZTX/lx/8wGe8cqPrHLLoGz8XFTKg55WBir8dh1PffaMbnT/3lK6kZhjv3fW
	 0uy2zSD9zYrW1d7Xc7c2fEPTahOzbMnGQABoxnPiI69E/68K67+DnzvFqGjI0wBkWGdfO
	 2zYr3kQdkw+MXcdg3MN+IvnVewJ5g5xCpbzqENJrRrveSueFnbhgSuL1EcAu16mW+4sL1
	 fE9oJw9z/HRe3QzEeppuZH8/97rB69W+Z+DgMaJxWj67K17lN07nHuBOQaeqNPeUJwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bbBjUOXL;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D5A606A32C
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 19:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3D5A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bbBjUOXL
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33fb4680717so3493595eec.1
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 11:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794078058; x=1794682858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b3FlpY8nvi4G/70CC6/K6fMlvaqdNQNndHrPbZSILu4=;
        b=bbBjUOXLFYqTyoPjt09ATEntX0OtzIl1T8dJA6+VHf7yIfNSESWxuVj36kic44IrqY
         5vrgoLyLJrw74oBsF3Kyr1u/rGS55sVQQRnKVgsgkWBDBxlJtnM7ZQiFvei4Qgm8gW8B
         vgA7e4Zm7sYjYAhf3CDXJODcuL0+SUHzSZeBXCoZbMPf7fJ/7IWmpi2jkykyEZxGqeEy
         wcV61NLyW64ku50SK9bvoC8j34/X7BmBrYLk+lrFiH083E2PQ3y3ImcjAL9XVDPHmUJh
         xNhG7i0cVKh/KO6hYGVQcWsgDGOdsGc/8LCWd5X3M0m83c6KMmLXWeuNJ6jht3vZ/tXC
         IlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794078058; x=1794682858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b3FlpY8nvi4G/70CC6/K6fMlvaqdNQNndHrPbZSILu4=;
        b=0+WH3MSOBd0VObiXyCG5GBbebw/zihRPwX4VHdzjgJ1ODWzfJy/fYecsx+Q9tb1BZ0
         aq7H7GUD63UAkwDyurHl07bXyAOtCGBs96N2ejPgtC2XodMPUNE26dZ8TbLENWbmvi3m
         HngQKPCpHb2ZMcI2mBLlFqV2Qc4dSm363+bewi0i29X5fzOIEjQWXXhn7rE+oNIcGXq+
         F5iAguZRKwfq8Fg/MFDe2vzeOH/J7/8ikqjE7J7PTrmG2Eu/4B51spjkFz99joOSlESS
         ki4IUQh611qxDRnSvBSMeyt1iK1s3WhbAaX6TYpkh7TAOwnR3XG0qbaJypZQesyjoayY
         Sc1g==
X-Gm-Message-State: APuU4Z8cuCwfAyqr6Y9Ee/Pp+Yp+NW3FpGzhGx4TEDZpV379xbxQc5yd
	HTF8xu60kc3a1YA0q6Xhjyo9OTaO6pEVEnNBgsk4p9hAUDFVAbz1aaGKDVollg==
X-Gm-Gg: AYBFou1sBeA+EbyC89W2hsr+NO9PKtBv7SpB0Lc9nEAIGdN6f7PPwozdKLBIteXvTEm
	PacoS9x8Q41KZff9NwuxBNYRJa5OeVk7xF5T4WZ9hGczRPqXmnqkDq+M6brR8oC80mVLnBiATTT
	CXRvDWPcEaCG4P2/faiiL92WmSLCrXDF+3dKY8UWHQgmnDIfjo8LpwccfHh45RbhxhLr5QyDQhe
	nwClSN2I+7j9fYAIfvVI46FNYl1FDR0HH9W6ENjwhcBTomU4I2MiK6xLmR941Qd1h7+muO08Z7V
	CxCR3W8G5vjL6Ss/M1BMZ5HMuix08loQaphLV4y3rcGIRvU4vFNZQLg5OtuDzCYxv4LRGf6W42a
	NCrq3FuORNsq1yvtmDKVk7cu0Ths/6eIxEB0lj9yKa8dbCP6m3LBxl7Hnbd/gymyxH4Jry9pWDD
	kUT+3iXXjletsYPAVTTn9kvHd830HgjZjMmK9NaGrKoy6PgFGeEZz3XbL2DCmojZmgavD+VEaJL
	nli3kBQMAwbTIs+QoxMZcxwSp/rzFcta96V199+759hKX4oKWRzh506z7SbzEGT++OjGOLr7ys8
	EDB/wtvS9GxmC+ju2y4wcsOe5wW7K6ITJe7rS+itauWRAUku72bewA==
X-Received: by 2002:a05:693c:8847:b0:369:21a:dcca with SMTP id 5a478bee46e88-36f75440b8fmr10132404eec.10.1794078057589;
        Sat, 07 Nov 2026 11:00:57 -0800 (PST)
Received: from Anonymous.localdomain ([223.181.59.223])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa5afffasm21572489eec.25.2026.11.07.11.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 11:00:57 -0800 (PST)
From: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
To: git@vger.kernel.org
Cc: Hussain Sitamouwala <husainsitamuwala21@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] doc: fix double period in release notes
Date: Sat,  7 Nov 2026 19:00:38 +0000
Message-ID: <20261107190038.34015-1-husainsitamuwala21@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
---
 Documentation/RelNotes/2.98.0.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.98.0.adoc b/Documentation/RelNotes/2.98.0.adoc
index 0cf02ab475..3982a10b4d 100644
--- a/Documentation/RelNotes/2.98.0.adoc
+++ b/Documentation/RelNotes/2.98.0.adoc
@@ -533,7 +533,7 @@ Fixes since v2.56
 
  * The CI scripts have been updated to fail the build immediately when
    optional dependencies like Perforce, Git-LFS, or JGit fail to
-   install, instead of silently skipping their tests..
+   install, instead of silently skipping their tests.
    (merge 266e43f1f7 hn/ci-fail-on-missing-deps later to maint).
 
  * The sequencer has been fixed to ensure that the 'REBASE_HEAD' and
-- 
2.53.0

