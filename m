Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EA529993E
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759698730; cv=none; b=gND8qyiJjSR7Q1e3sYU4yOAAUVt37HmBfGER2BmNrEo0xOYtkzHC1e78V/aVkA4p79bo3XDzTOHdIM7SRNOZHPepO5T+N57HhvGwi1Qoz5r4n7uN21Sx8VFeP/dT83GSqaFSQCtnkLQ6IWFrweyUccHZZsCOyr76cwd9108AOw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759698730; c=relaxed/simple;
	bh=rTlybhL0qIDcEl46BiWteMazs04Cr+iGysglGHRm0ws=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=QlqUt0/3KKK5NgdBqNgaR9OxzaagtI2uFhS3SEB6u6+auw7FpX6AAOuSHNY+aF+n+1XNE/syCNwUGP4whAEtb/K4jcPVUWMdKFJ+sgtdbnlkPXwkW14Iv/9AibV+f0lWZxFLBlnXcw5bVXPkWxsX/k+MGN+LQ1mh3Ja3YctM1D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISQcFsZV; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISQcFsZV"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so5669810a91.1
        for <git@vger.kernel.org>; Sun, 05 Oct 2025 14:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759698725; x=1760303525; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9cPoLyVod0KLV8rLzvhSv7ZdpdtQUVL4wfjNU4a0pTY=;
        b=ISQcFsZVtRn413PIa9XZ20bOFcyEAWij2ewWgzUXsA4RpdvZFCwE3M2YEDjkSwt8eJ
         35HtMMosGUSnrVpBpSzsc+JEBPwNSKcZpUcnIjtoC0613CLTvbOug7KR9OJk6eIFxDw8
         YwY+QqZoIrZy/bsmQ8vb6Xpge0tSW4vyrynnLnUmX/rFDyrIVh/8gifHxHqvAiMKU29u
         4wWvxzcqkFXPy+nnXwNWGF7oTU7BlFcTHUEefyYwcrdQB0VvwFsioAN+LuaInty/jT6P
         H27bjjhUNA1b3e/jokt+NaQzCKKrSy3BGdTYOtQWAbaiza26tvSURh/0uMETyh231bZ8
         VFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759698725; x=1760303525;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cPoLyVod0KLV8rLzvhSv7ZdpdtQUVL4wfjNU4a0pTY=;
        b=SKhhQUiJeQJfUZPOLnohdmsCN4g4kKwWm9yXJzpGHA1FrdocEbU730jKQQynLWUtxP
         HHNSdCe5FVhn0Wd9AvGMz9GOqsaFIikwuOKJ9nDKEGKU/J7FH8Nx2YZT2aRRwde06vBJ
         SnPzMPJThAHQRRSig95/6lg4W3XQTnazqZ85lZ4vi1pIW8uBuHcVzvyW1bsW7PWRbS3Q
         NW7e9hZhcWlAIzae/oRroyCxNdBRCaQpdmGAH9dISX5QfyF/ri9eLJKZl27DbUwTVcUD
         vAYrPhvHmi3FN/cv6U28DnOvv/SgUVokubHSFOvzuQ5Cp3Gp9JHr+g99RKG+ktGrj8qN
         NDew==
X-Gm-Message-State: AOJu0YxRV/oOiBqMukbm2xuqoEGOxvdHomNnTZIt8hrj2SOWaMAajr1L
	mt0U2orPfWmNdzI+ZgoQMDHORhefD/Vg+HvvMzaVVqP3sljxaLf2DJhiZjvzzg==
X-Gm-Gg: ASbGncs2rcCVlx/2w++aS+oKpHaIK5zJKaNVckYJGFOJpCLblBD5NW0Hx8hsbl4a7oh
	ICZOCSK7Z/Y/p7OdvUHyM7zugPM4dFaXUBvGIshgIU4Yc366n3gFVMVF1ATft5kWlqCS8nS/Kbc
	iOBMuMVH8EQuMOstqu3x2JUwX+QN5rEcH97xZZMZjx+stxs2M2yQLHiL7foMahmYUiueSXHqvxm
	goVn8nkMXOJNbhmEwTVYeZ8SlYHjRLsI1S2VRPShLzC+PkI9XoJZbu4VGX77uwZSQJavcOsvSab
	Qam/b0Q2tO24BsHHHpNk/m/R4PXtM6SEajwHIiS1Hb1wIZQUt3D11eLCvwV+Kp8lXgIBOfKVH/0
	ueqKzuxhgwbSvNAX0Fdn3FQmtKlZMeNTCb8FxtteGd3GGtuROoHr+9EkAm78a
X-Google-Smtp-Source: AGHT+IHv9ldPpDMpU2GGmzyceCZRScnKHi4dg0Ti9EhC/BtiKd5xX30sQ6S7Y6X1O6zcaOQ8fTZ+4Q==
X-Received: by 2002:a17:90b:1e09:b0:32e:e3af:45f6 with SMTP id 98e67ed59e1d1-339c273db30mr13907762a91.10.1759698725222;
        Sun, 05 Oct 2025 14:12:05 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a19fe4sm8663752a91.8.2025.10.05.14.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 14:12:04 -0700 (PDT)
Message-Id: <pull.1982.git.1759698724134.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 Oct 2025 21:12:04 +0000
Subject: [PATCH] doc: do not break sentences into "lego" pieces
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

The sentence needs to be whole to be properly translated.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
    doc: do not break sentences into "lego" pieces
    
    The sentence needs to be whole to be properly translated.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1982%2Fjnavila%2Fremove_sentence_lego-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1982/jnavila/remove_sentence_lego-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1982

 Documentation/pretty-options.adoc | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/pretty-options.adoc b/Documentation/pretty-options.adoc
index 8aac51dbe7..658e462b25 100644
--- a/Documentation/pretty-options.adoc
+++ b/Documentation/pretty-options.adoc
@@ -61,15 +61,16 @@ and `fuller`).
 ifndef::git-rev-list[]
 `--notes[=<ref>]`::
 	Show the notes (see linkgit:git-notes[1]) that annotate the
-	commit, when showing the commit log message.  This is the default
+	commit, when showing the commit log message.
 ifndef::with-breaking-changes[]
-	for `git log`, `git show` and `git whatchanged` commands when
+This is the default for `git log`, `git show` and `git whatchanged`
+commands when there is no `--pretty`, `--format`, or `--oneline` option given
+on the command line.
 endif::with-breaking-changes[]
 ifdef::with-breaking-changes[]
-	for `git log` and `git show` commands when
+This is the default for `git log` and `git show` commands when there is no
+`--pretty`, `--format`, or `--oneline` option given on the command line.
 endif::with-breaking-changes[]
-	there is no `--pretty`, `--format`, or `--oneline` option given
-	on the command line.
 +
 By default, the notes shown are from the notes refs listed in the
 `core.notesRef` and `notes.displayRef` variables (or corresponding

base-commit: 79ee0dce2a61b7552f9b5c73f0cf2d974a20a029
-- 
gitgitgadget
