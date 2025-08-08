Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5052E36E0
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 01:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754615227; cv=none; b=LhDuMkCwVZqvVHVvnjUUEM0Uvu9Y5A3Ku4Lbs1uZVPPuuKYlQF8kR9+qNx97hW5yMZs6bhHDiL7/xotuYO57gHwpz9gZS4cl+nRbSWdCVqDW+fZM61GYcO9ZJvy8/1+/G91kPs5nhYht3D0eGmbCfxtpN3b9gwMxpRAP/wT5Hi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754615227; c=relaxed/simple;
	bh=sxcHpzyD3bqRwQA1Jm9SGl8R67QR8wciPDckdaETtAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m04phQYsQKM++9OaiUmZkVQnVDg7l0cxUCrIDf/PY+zGFhDqSYM+umzpEkXP7fAFQ8JPAmaQri8iTsxoPihfyiXFcnITSxCvPyaqmeANPUGHPcNEnIvpsYf61b75sXHumxoP5AHWB8UMWhaAeqfGeZ3Ugvu9V3NvuYcHk6ilybw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RllHKAJZ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RllHKAJZ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31ec651c2a1so1449279a91.0
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 18:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754615225; x=1755220025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBDkuzUmPMsoOI99hQPhu6HtYS1NhGOHabuTgpoVolM=;
        b=RllHKAJZXn300WSWwgS4ELizJg74nbZwWMJZLwQCtoEtgcJ1zIlIANFzvPB1r14hQF
         S+H7zlgekY8lZg4c01O1w1hUbSJ0jBc+J6sGHB0VW39Tbw06vwgXvxKrmk73ojxnANgg
         YScU3/dE01xZsmBFNFmhHVaowYVbrr+U5EFNx+6pTUiqktobAvhhxeh9gTNceaDQMz6r
         yNEu8hph9QLnvUkkCWWGeLMjzmJRm277h5OyxZXB1v1SPIWcaUzbxUS+KHYezJbcjUrp
         Klq+MXfl/DwtFTWBnn0/MbHl2vnYCLBK6seQabvlYkHd6JD3jvA0eJp6Im93ECr5aD4J
         Pp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754615225; x=1755220025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBDkuzUmPMsoOI99hQPhu6HtYS1NhGOHabuTgpoVolM=;
        b=Vs8Jaml9RgrObGJ4NSfMEWYlwOUSnyK0eIojdi3p0FS9g4fdPDnd8YhJXZehaiHIeE
         Tk8/2MbVTGK1jZhz7tVZ3YRuW0QGN2wit9TttPZ/pBkNc7ybHXHoUmjz7IRoMGaWbuwH
         g1LymNcFckCjsF47kqu69pC+WLKiBIBupQEPH9fa5loIfndh3EU0BboS35/GvYX8sKgu
         giu52W+JK3/dLibOrIZsBcjepffQRf176eHIqkIInB6yPwetmb4B0Rn7rjV6T7u2N88N
         tMGdggQtFp/UOevweNjMJCTesm9PbfW/TJFZwZ2XP5B6gPSE8FAlUL6CefoyAB6Itmd0
         HPwg==
X-Gm-Message-State: AOJu0YwgOFRSp5LnslUwCP6cG1pSdL2ZIxeDMo6sJ09SkPY18ey5Qg/5
	JNf6DzHPQXoq28YxuXauqKkZSS/l0A3PWJkJlB/FKdHw9o4lDF/H0pOQ5FfSLXixymk=
X-Gm-Gg: ASbGncumsExneWnJhYkVNr0J3fevZr3z36I0smGW5oSnsA077ipskoJVUkX44E3v35A
	rdhBV9PiOAtReDZDrFz84ehp7KqhVRIODDyz2sEjj6PD4Z0szEfPcSTpNJOaUz/7So7bnB5x4/x
	Lq6GoLSK2+3HOlu1IxQnJ9S5dRllqJy85jGFezeZj764ym5mSM4SnH/Yz3Df3KlbdD2szv6wnjG
	Ubv43Y1VD6pE5rXPNxMku/7G7PHK/F1/vG2wsd6ayjzADOtJuNlYqfFpSJeIX3qhaNqWLfBvkRp
	vDXt3DZntF3bA280WJA23dj6lO+70OWDA/qAuVGjZsHOzcqRgAdZJiK+Gt4gY3ymY+JWE9a8mum
	e7kLilVEcmZVmWljJB9NXcSRAfR378SqRNiYFSdcuxJQ2qjcYK1ABaFM0mkm5tg==
X-Google-Smtp-Source: AGHT+IEO+25WRmI/Owksm+/Vqdpx0HK3yZOYYNk7HC34nbsAr025oN60IQJDTI2mdmiFLdcSFEgOsw==
X-Received: by 2002:a17:90b:2e49:b0:31f:d0:95bc with SMTP id 98e67ed59e1d1-32183c4585dmr1407785a91.25.1754615225190;
        Thu, 07 Aug 2025 18:07:05 -0700 (PDT)
Received: from archlinux.tail6959dd.ts.net ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321612596d3sm6610391a91.19.2025.08.07.18.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 18:07:04 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: usmanakinyemi202@gmail.com,
	ben.knoble@gmail.com,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	ps@pks.im
Subject: [PATCH v6 2/3] t5200: move `update-server-info -h` test from t1517
Date: Fri,  8 Aug 2025 06:36:50 +0530
Message-ID: <20250808010651.591906-3-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808010651.591906-1-usmanakinyemi202@gmail.com>
References: <20250803020744.1037392-1-usmanakinyemi202@gmail.com>
 <20250808010651.591906-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

t1517 is now focused on testing subcommands outside a repository.
Move the in-repo `-h` test for `update-server-info` to t5200,
which covers this command.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t1517-outside-repo.sh       | 5 -----
 t/t5200-update-server-info.sh | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index e9f6d03e1b..4eba3f486d 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -107,11 +107,6 @@ test_expect_success LIBCURL 'remote-http outside repository' '
 	test_grep "^error: remote-curl" actual
 '
 
-test_expect_success 'update-server-info does not crash with -h' '
-	test_expect_code 129 git update-server-info -h >usage &&
-	test_grep "[Uu]sage: git update-server-info " usage
-'
-
 test_expect_success 'prune does not crash with -h' '
 	test_expect_code 129 git prune -h >usage &&
 	test_grep "[Uu]sage: git prune " usage &&
diff --git a/t/t5200-update-server-info.sh b/t/t5200-update-server-info.sh
index 8365907055..a551e955b5 100755
--- a/t/t5200-update-server-info.sh
+++ b/t/t5200-update-server-info.sh
@@ -46,4 +46,9 @@ test_expect_success 'midx does not create duplicate pack entries' '
 	test_must_be_empty dups
 '
 
+test_expect_success 'update-server-info does not crash with -h' '
+	test_expect_code 129 git update-server-info -h >usage &&
+	test_grep "[Uu]sage: git update-server-info " usage
+'
+
 test_done
-- 
2.50.1

