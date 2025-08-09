Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5D727602D
	for <git@vger.kernel.org>; Sat,  9 Aug 2025 01:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754702067; cv=none; b=o46veeue3ufw92n5QRPGeYhildPuOEodtcvdWxkpVeESPkQT2obgJFC2WrmUrBft4h09MdxFqKYaieGIWGM0bfaWkyfvODlQszYNlJ0eydgTcmYTPWA7tioP1M7xYcrINQaUbLHjkXSdvlrUMWw6BZrBTzA+4T6ibz3M0jf/7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754702067; c=relaxed/simple;
	bh=rrojWOavHqVu2d8LX0vdS8j5EoZ0XoEMEX9xSVnNfE4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JzymkrGcXSZZ3wlWWgAbhU2+x2Ohpzbq+NZ56eqWbEPdtFyRX21xjqxl3Qeati0ZTv4slEtr5DN6Vj1itaW3K/A5ssp7QhYtjZE4yyPlZW/E9D57onpwsRtJWGRt0+iko7HgC6/nuVXfnvDpXHvHZt7M5R7qpAsbsP+McG0UkPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ni9V8yVc; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ni9V8yVc"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b7910123a0so2374756f8f.1
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 18:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754702063; x=1755306863; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rbr7ejI/t2PcKhGj17Cw2yzBwj/skHgSkbORMLeULIY=;
        b=ni9V8yVcBcKyZQhk4oMLETXlBj5AqmM1hTtAov4VDl4AyqK2slmAzI2HcvzQCxMof0
         1f/7LszfWJy1LndUjpMlKoZuYsfBhy8ccKndC3e0+tCoHpRY9o9gbt2JSoA6Sy8ORoyD
         vmjMTSv6bUEOilAVbZMOLkqI7grzlgoUEtDhpl1DVIr1SWow1D/2/gJdmTvgo8Tg0N2d
         4VKEjwEgQ7TLBkPLg9iv51BhNWG6SEDIV+yuJKy1ljuppAOJsr1iQ7KZNPj7g5/Hun+h
         9ofsYbUoQWnovwLN1CvmdfLAk7RC21N6mit3nxcI+te6tDh+OggTJvNyl5x2FK/SwCO8
         eWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754702063; x=1755306863;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rbr7ejI/t2PcKhGj17Cw2yzBwj/skHgSkbORMLeULIY=;
        b=BoxkqQfCKZuABAOtkUrkjz0D26E+vI2pldIxj60ga/uVHQ6h6Ya1oFvEIcdzqRrhjY
         pmyzx5lbsV31XOJsMru/bL2jeNCFAP7/GSZ8+7iHjjxvW6B2BRtXetmUUuoozlA9ICPZ
         V3rqhhFGLARqPa3DcP7wRktx10nHHiwkt9TXUwkjf/cK36o1LhGssiO/xnMEUBQEoezc
         iwgJDEVDj/vActX5cuAvPPRfxzxtWCgR06BlF62V+acfZveaqFAIXOLNE7IcFWOeRMnI
         ddbd5HHeZqR8IX5immlVBlmt5Y4KSqWaSO8QmuZ3PUPDIDTL/px1pYAtt7s3Ane6+2tk
         LzCw==
X-Gm-Message-State: AOJu0YymjtTf8BpAJcG6gRBlz6Z3THzNeNuMlv3yLddoDsZJv9z6e2zM
	W1ino6Iiiy15VLxdNXKLyra+kReceP4AJ/Gj31EoHznbZpIL9XqsxVWSDzgcpA==
X-Gm-Gg: ASbGncuW1uaBio0lfuon4JOV4P1SxUpYi4rAYC/9NX1OJUbq1OAiZGHvWBsjhpbxe5u
	62yfdw8UcW1isyHDF8Ggtw9fpE1gRDcxnwFdcnGeZNjvGaz/0+MjE3fBq8EHusbIB9fyUHzgCvz
	hrDyJJGsL+B79WHLIb5+UvJyEfiQfmeCCeJen2qvViWXpWfAR5jqKAwgnrqhQxAC9ULAXZWxYPi
	GGs9GpnLh/VfjZn7SZf3jAoBHIRqfqAqtwj7AgeJPqVImISS8hBsHxwrchxrIK72xi7dWI9LPYA
	2A0HlZPtViLv7RL6sbm7v+ba0+uwHxQZLjDavLZlHxdgrqvEaok1ExKyYY3PRP3F6X7V39w20lq
	7aozDE1nn6+rI13hOBt4giNo=
X-Google-Smtp-Source: AGHT+IE+RJ1/Gb+EPyAkKc3xM17nbWh8nECSEeVUc0BvOsvNXNhj/M5M6JhrGnAfLRjpNvRSJd/AGw==
X-Received: by 2002:a05:6000:2483:b0:3b7:8146:463c with SMTP id ffacd0b85a97d-3b900b8bde2mr3994039f8f.59.1754702063286;
        Fri, 08 Aug 2025 18:14:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459c58ececdsm145370845e9.1.2025.08.08.18.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 18:14:22 -0700 (PDT)
Message-Id: <fe9e161a51b2c514287762ea841e5fee7f578ffc.1754702057.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
References: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
	<pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 09 Aug 2025 01:14:15 +0000
Subject: [PATCH v4 3/5] doc: git rebase: clarify arguments syntax
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Remove duplicate explanation of `git rebase <upstream> <branch>` which
is already explained above.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index e30b9535fff1..914f743ae00f 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -59,12 +59,7 @@ one of these things:
 
    git rebase --skip
 
-
-If `<branch>` is specified, `git rebase` will perform an automatic
-`git switch <branch>` before doing anything else.  Otherwise
-it remains on the current branch.
-
-If `<upstream>` is not specified, the upstream configured in
+If you don't specify an `<upstream>` to rebase onto, the upstream configured in
 `branch.<name>.remote` and `branch.<name>.merge` options will be used (see
 linkgit:git-config[1] for details) and the `--fork-point` option is
 assumed.  If you are currently not on any branch or if the current
-- 
gitgitgadget

