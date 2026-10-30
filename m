Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793378326;
	b=Rk1PjYwIPDex/tc80oP7pAPKtMOVqhNHQebTVhkFcpL3Dj0LYNvWpFe2N9po80uf+7ll
	 Lq1lDo/OcRIi1TO3rJCcrFd79IotjztSdfl4oI6ce0K8GS6CHUru71ZA8cxEi7bsy4puM
	 lYQ+oNTjQwPeuAsIcnM3V6KO6rMXLOtuvUTDIXHpoklpMAdj4KthlmUAUSGZ9w3592Xln
	 SvbDk74Xg3CGECrCM4Jk/fVnFqoKKNphpWxcmRKbk6lF69Bx1yrl553s9v5/26LNXJXsM
	 WSYd7FYVCOarJZUvz1e+fAVtpnMOxQzxlK2sZJM1l6uOkzdGnCcb6YfVmydGXvMnzqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793378326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DW3LrZ9TY6OVm0Qlrn8ToAFMFMyVnz4gdFoUIjmYMeU=;
	b=e8K7EPUJDgA6HnIdLseeFixeSY0dHUx558forcRzmyHEhAHAQ3FHlbenrxTJDdbVA5qg
	 Va4X2YUb8X7nPv4Ibdz2Zfba+XvUWl/FIFicKwLH78zKFUUcsz9uiXZMKa3VCMLQ7d8w1
	 VQK12yoQ8jJdju3llXS5fKeiWsle2KKyU99gisciVT0mD8S+TBCzpZzC0hYbqmejkXZkZ
	 I2+p2tVB/S/fnwZMk5pFiJVape/LtCMqPATPOui5XCTYhxhnK62sQTWn2EbjUvN/iqRzO
	 Phtw5YnFpwqlcXPYYHT2hPpfylVTzwxxaQEJsKER26DJS8/hvHwqD5cMKPSxyYe40FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NSsTdudw;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72785606A31D
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 16:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72785606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NSsTdudw
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c434376dbebso189758566b.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 09:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793378325; x=1793983125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DW3LrZ9TY6OVm0Qlrn8ToAFMFMyVnz4gdFoUIjmYMeU=;
        b=NSsTdudwUBh7DbRWS4a+V9jh8PT3XcycCM+ehukpjmCX6vuB82qyd0f/dYC/IyaJXZ
         5mSzEuezDZvK9zwZb3Q9CM1trnj9IEj2FAZOHRQcwpvKTsTUyL0KzlPzhTYtOuha94Jx
         mswKjQPoC50I65Zsx6avW1u0cRsczb78QXepvdjylF4X1UUmCq0gwkPYRFMz48okGxWj
         +VTohiQEGbu4JR8OB7CE2yoN13AZqNlcFImvpnJbaDSAsLfEBXAW7pGcy7vJ09z1HNW8
         oHM01cBEoxL752PS3oDD7fG0FGgU0YIqDV8o/tdIOGCTN/uvo388ZK5MOhDO5DUwpEIa
         GdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793378325; x=1793983125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DW3LrZ9TY6OVm0Qlrn8ToAFMFMyVnz4gdFoUIjmYMeU=;
        b=U4rY3OY5p3IA/onD4G7PxzbkgAb56I+ypwGZ09g84P0hJ2ldU/8/h78erzCmBjRDoN
         jW15NMgiXhETyoPrvc/YKdjHcGt2M5tdUsrS83VCKa3dSg2EGlrUZqxTZ0AuKF5+twf+
         TuflCjZsHDyrYGglH1CLuIxxlZMQv1KjTrslDRDFH9crrj3skBn02EA4NDlB00Z48Stc
         tzX27Ir/BC5ej7C1WTX5nCJXmV3378+Svyj8yDa7zI7QhTrTvHx2zJxANU9hFluTiwka
         S7OkEPzAR4Yv7hxREmHgHdPY62AFbZaVgECvyuZ8TlBDvPcKKdkPxW8zxrmtQagAAISm
         BqRg==
X-Gm-Message-State: AFq9FYINRBKgrXAqkytCCT+fgW0/v+vWqwfBNOUCUFDgBa6WdUHB40Ut
	vu6GSkBTSuSCY12DZhS41jOQFVMDtyHsDic0U4YaSar3H7evDkclmcSK
X-Gm-Gg: AYBFou3T4nUX35VN0IJDYL2qqhYSXbxXcjdbLZ7UH+IbOV0qz8Enf2aVkigOSGAVPll
	2XbiwxetK0wfGbaTz9QieR5B0+9eYRtDEq0aQxyuRhVfv32opK7dGQmFEvRHwmXN9NtL5mCNKkA
	QyriWfOzIKoaU0nDBEvRxRvYeEMKMDa60TOJDtQMH1C4N4eK0lWixt3I7c5OIN0oioo2mBiNlKY
	vdU4mHM72wDhZdF6h+4CRspfVUNIDFPU0ntnQRgpWnRby0xJwakoMakcrYP2E3cNNDiKsXBCoJb
	0LznVVlY8xDs7ynm01Q0wVk2ueNd5QiIj2Ol/6+RMh6Olb2+SplVW2uKNnw94Uo/28gl8hx50p5
	HPpT9odWcnsKk7sQyA9C3Nll24IwvrzZHxoFKDDllewfAUxNuQ2kcC1hoKoI58hpgaHYfgYmdR9
	YOGcqj6YSGaPWv3btxLbZ4hXKe1VkgowV7pF5uKXOQiYyQGbJtsraQ8vFFoidX40Ax+oSxrOaP2
	vITeGS6qWQ+RZcnWfgqLSKqBaHBF7CizSG3MQsLdb4QSHrqXEN2UQVQ0Vh9HirmzvsuW8foKC3E
	OGCCmH2fP/eKZVHql2SHeVFVC6ZLrA==
X-Received: by 2002:a17:907:6d27:b0:c33:dbe8:290d with SMTP id a640c23a62f3a-c4ca7ae1dfamr260599866b.22.1793378324571;
        Fri, 30 Oct 2026 09:38:44 -0700 (PDT)
Received: from omris-tuxedo ([217.71.1.73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabc1792esm87237666b.1.2026.10.30.09.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 09:38:44 -0700 (PDT)
From: Omri Sarig <omri.sarig13@gmail.com>
To: omri.sarig13@gmail.com,
	taahol@utu.fi
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	julia@jvns.ca,
	me@linux.beauty,
	phillip.wood@dunelm.org.uk
Subject: [PATCH v5] doc: git-rebase: update incompatible options
Date: Fri, 30 Oct 2026 17:38:41 +0100
Message-ID: <20261030163841.31840-1-omri.sarig13@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025110759.204336-1-omri.sarig13@gmail.com>
References: <20261025110759.204336-1-omri.sarig13@gmail.com>
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

A few options in the rebase manual page link to the "INCOMPATIBLE
OPTIONS" section, but they are no longer incompatible with any other
option:
- Commit 1a66d8c6f6 (rebase: remove --allow-empty-message from
  incompatible opts, 2023-01-25) removed "--allow-empty-message" from
  the INCOMPATIBLE OPTIONS section, but did not remove the link to that
  section from the option description.
- Commit a74b35081c (rebase: drop support for `--preserve-merges`,
  2021-09-07) removed the `--preserve-merges` option from rebase, which
  removes all incompatbiilty references to `--ignore-date,
  --reset-author-date` and `--signoff`.

Additionally, since 414d924beb (rebase: teach rebase --keep-base,
2019-08-27) the `--onto` option is incompatible with `--keep-base`, but
doesn't link to the INCOMPATIBLE OPTIONS section.

Update the description of these options, to have correct references to
the INCOMPATIBLE OPTIONS section.

Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
---

Thank you for the review!

Changes in V2:
- Update commit message per the review comments from Phillip (Thanks for the
  review!).
- Add `--onto` to INCOMPATIBLE OPTIONS.

Changes in V3:
- Downcase "Update" in commit title

Changes in V4:
- Update the commit message per review comments.
- Rebase the patch to be compatible with the maint branch.

Changes in V5:
- Update commit message, making it clear that the `--onto` option was only
  missing the INCOMPATIBLE OPTIONS link.

 Documentation/git-rebase.adoc | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index f6c22d1598..f1f675d311 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -217,6 +217,8 @@ OPTIONS
 As a special case, you may use "A\...B" as a shortcut for the
 merge base of A and B if there is exactly one merge base. You can
 leave out at most one of A and B, in which case it defaults to HEAD.
++
+See also INCOMPATIBLE OPTIONS below.
 
 See TRANSPLANTING A TOPIC BRANCH WITH --ONTO above for examples.
 
@@ -332,8 +334,6 @@ See also INCOMPATIBLE OPTIONS below.
 	and this option would override that behavior, allowing commits
 	with empty messages to be rebased.  Now commits with an empty
 	message do not cause rebasing to halt.
-+
-See also INCOMPATIBLE OPTIONS below.
 
 -m::
 --merge::
@@ -487,15 +487,11 @@ applying (in terms of the author date).
 	Instead of using the author date of the original commit, use
 	the current time as the	author date of the rebased commit.  This
 	option implies `--force-rebase`.
-+
-See also INCOMPATIBLE OPTIONS below.
 
 --signoff::
 	Add a `Signed-off-by` trailer to all the rebased commits. Note
 	that if `--interactive` is given then only commits marked to be
 	picked, edited or reworded will have the trailer added.
-+
-See also INCOMPATIBLE OPTIONS below.
 
 --trailer=<trailer>::
 	Append the given trailer to every rebased commit message, processed
