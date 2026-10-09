Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A99F4D597E
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547238; cv=none; b=l1IMIPnmAH3zFfkklTnTv9cdDXQb4eWnBYSdBxRmVXvmLhvrQmlPVteCqSqUDbxFb0XQMWzCgk+A+Fa0teK2rc706SsLu9bhb08TGEkLMT+QgZEfwJMRTGM24Y9PcE41ETNnQn239ofSB4oEGhVmpXytfuh5xCCLkMTksaStkfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547238; c=relaxed/simple;
	bh=IR5y2bb9qJKd8ZYZa9evukbWwH+fsO5y/2fn3Xr/JAs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pBGS0igvBlB8kY5EnTu/KR2FogcV/pP37r+l3OkbbEjknqS6lNpO20uZ+DIPKpLjPWuupBIXdm9LCbCbzhPZXfgfynIvwwug1jnoFQqvfaqsj5mkDcCJklAMleGHrqRG/PhpDROyyNs975qeIAqu3+PnoPIBOIhnZ0rsXHC9QCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKUkplnb; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKUkplnb"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7f84a55e31aso2953171a34.2
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 05:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791547231; x=1792152031; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i7UtQAgeuRUauy3KMMSNxJt0RKio+IZ/Pu8OmZgQjx0=;
        b=NKUkplnbhdLapYR3VU9UDEIekdRU6QXK46BrF52IsGo+cDs8pGmSyGijwdtAnMDK2o
         I85SzJZktJ7Lz47uzcd7aZZFqGF+okgTJbi1UE1nbIha/s1v2jRvJSpsBbYfjLdt6y7Y
         IhCcdQCCgJRtQ2xqYw9EFSb3csz/tqEIjoIlQWl+Cwft0VCGlRoN2p1Q3RskD2Dw2zBq
         6dxQOVxIMQqOxGGy7U7RolTYgvLTH15vrSRJD0vT21XbDzzZafQ3rvhvCTnPRcpXpshv
         sbffqPinlUK2fsFmL8MJzr1czRooLUCRXs4Qp6LVihU3FvFT059uCIjZJjiEHR/mSJaF
         GONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791547231; x=1792152031;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i7UtQAgeuRUauy3KMMSNxJt0RKio+IZ/Pu8OmZgQjx0=;
        b=pR0n6daGUwOpet3jEG7hXUs3X4q7RfAUJ8hluQhruOEvXnEUCDRrESDLEu3HJy6pHq
         if3S+xP5Ky4lChtKgL6Fu3O43RCsu/5jtxlM3KEINBlzPZvWn2wUVC/gA2xIHVVa2nvX
         kpA7G45w8xOt2omeKBiie+tg7s6D+SVnVFUY2L3EU3x0yLsY1hVLbAaH4y7Lq2dUcJCW
         1fX6WaqsyOOHsnEMqiET9kKAK4Iv3ZsLJETjbiDA8m1RpBb2rYGdCdzZcPw/T9NnmdNo
         lznf6N1HOsoilRh78eS3MtG+HEbM6XYOqLsEomFSF1rA7Q6WOdr5BBrmyMx5XaRK6ddj
         5Hhg==
X-Gm-Message-State: AFuF++mLkAzZghIbNHAIa685WBmDybfmV1XIXogYmY4eYFfNPvkCU0wJ
	xD0DWRS0DFqreiQjVScFvGYzAoSDsxz9JR29wZOjDRC4DPSuNcrukQHHnVzhxw==
X-Gm-Gg: AYBFou333runV1CKdqHwyezDHo/mPOwVkXNzUQpoAlFxFSyFbpjbA7cAjHysDKvG9vy
	v/Mdo0uSEWELzjBSA24Z0vr/J8L9l5nRm2DN5stNb8CFcBeJ14HSXk7QlLmtwatn8evdlGhs05p
	dJrmuIbRK1mi2eHvyUCpkQbuo2BstimLHyU6Yg86x9oBnbAKp7YsFyuJ1fSPWgcPtyyesf/udwu
	+uwrOjDCEJH1hKvcaxIzM7Xlyi0CzRCayjbQXGO3wHgBrOPHiUBeG/heyoQ8OjppUcrgsTl34MX
	o6w1xDfHcxQX6RULmk38NVeBlG/OFds7xXXVkA8dz1DCPaR/OMAaBmCVy+uFjOtgubPar6OnA/y
	KzBCMknCnf09kOlvxjVC4tYa3qsMmagLWGahP/xxBEQ9pgy4/KSaSBWkVif/KQgUoMOBCvXo+jg
	LMF1kX8NzdvVr53cawo2ZmHaIxq4sFK5CMo50mSuuhnAcnAPCnX9d98NjaImvw2R+0+5QLuNTku
	Ko=
X-Received: by 2002:a05:6830:2105:b0:7fa:5c49:523e with SMTP id 46e09a7af769-8309748ec47mr1164661a34.23.1791547230386;
        Fri, 09 Oct 2026 05:00:30 -0700 (PDT)
Received: from [127.0.0.1] ([172.171.13.148])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303916e485sm1723764a34.15.2026.10.09.05.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:00:29 -0700 (PDT)
Message-Id: <cfa0a8254ad88aa954af9cc3c4151993e07fe91c.1791547213.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 12:00:11 +0000
Subject: [PATCH v2 4/6] doc: git-revert: link to new merge conflicts guide
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
Cc: ps@pks.im,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-revert.adoc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git-revert.adoc b/Documentation/git-revert.adoc
index ffba365e63..1edf98b9aa 100644
--- a/Documentation/git-revert.adoc
+++ b/Documentation/git-revert.adoc
@@ -31,6 +31,10 @@ both will discard uncommitted changes in your working directory.
 See "Reset, restore and revert" in linkgit:git[1] for the differences
 between the three commands.
 
+If there have been new commits since the reverted commit, there may
+be a merge conflict. See linkgit:gitmergeconflicts[7]
+(or `git help mergeconflicts`) for a guide to handling merge conflicts.
+
 OPTIONS
 -------
 <commit>...::
@@ -162,6 +166,7 @@ include::config/revert.adoc[]
 SEE ALSO
 --------
 linkgit:git-cherry-pick[1]
+linkgit:gitmergeconflicts[7]
 
 GIT
 ---
-- 
gitgitgadget

