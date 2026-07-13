Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD134252AD
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948669; cv=none; b=V7ZJhr8Js+49FFbH1dtCyp0EhyRiCM/SOyitGLMF8L9wT7J3i1Ey2oU98Y8kCFDCZ3g0IxdV4F5+vMPOISzL88Daqtd4X1j9VbRKCMQhD84i2njfoj7tHaShIAOEcrO2A0vtsPkISfBs+ky7QJGbr/ndDAaDAZzlUJ0EkP1pGxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948669; c=relaxed/simple;
	bh=Qwlc3l7BzkuDJGciJrPigOk3CF/rzYQ8xlpx7fowgIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcTpAuq4kPgyZQmAe4f1gjjWDpXZ9sOkcojOdCTlPJF4OnBbPb77PABJXQQNdIF3PZs+kki0eiVlm6E09VfWI3PkGwLmCKQbHDDxBprIGUaiwFfl5Px5Bvdd8RkU0i25KhvsFbiVNc33g2nKycSzW/DojsTNWjJcYTdAbU6PgVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgVDajNM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgVDajNM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493f60208a5so27250855e9.3
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 06:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783948666; x=1784553466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ny1c8xlVmQVzaUS2AGqWEulZeKkbb0C1vtO9sHVf4uc=;
        b=cgVDajNMCI9SdAnEjr2LSZeg6yPu34xGFlx7OAai//2J8X7aiaOBs1iN46VjHH7Fb1
         rLgYMTbdc9zuug1d4gxm/dSitrmgfnsZdHJtsCUrkXvlxGOyhBT062i8qRi2C4SnJoBH
         9iFJPVXqMuY2Hr/JfEw3vzAMBvRGR6cjAK8DPVdrrrQlo55w31GLRbBQuJwH3izPwfe+
         kZhv+EZECfVjO+QSf6kek1uJcB6cmj2I6cPc948+gaiD6A8mnLCuQknpXUBibzNquESF
         gCNdEIMegeTYMc7C3V90bdaX6jwyaIGcryPvonSEP29lrB3G/2/a55x7OfQ5NvIi5QVn
         d99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783948666; x=1784553466;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ny1c8xlVmQVzaUS2AGqWEulZeKkbb0C1vtO9sHVf4uc=;
        b=rvnO36MJocsW+QDloMp1qjzDNTykil0jO+NMYg6GPbat60VuTj43DqSwPdkpLE0u6Z
         suO8XzxuM+Q3JO6mym2O72hJcmXSX1b6WXDwOb0N2hTrmp4BzKl6/rVs0BbI9phR7Cyn
         20gBS/RMtSSSdnqqlBBRxRphpThuCe7zIzv3D9rC8r9CNugEiH5Eyr8TXmEmzXQQofhC
         TzTYINJkzdIOdByYaOFdSQBOvZEe/NMAsr0LuJlC1iPfiIxBS0dZE7CGPfG2PkYUaxq1
         yoj9H/V2XNPv13jfkEO+Vp3mF/qU2mHbpTfh5mv1GUywiPMxEBhi0Dvm3wCxxX5rDVDl
         mbhg==
X-Gm-Message-State: AOJu0YyD5nTvDPhZS6AXLuTf0jsc6BxjpakJriQ30hzF+RNcqfgkX+K8
	Q5jSj3vQHgiPPBIToVHysjGgSPx7atuRXY3N+8pwdYLC1u7LbBugG/73XkOUeA==
X-Gm-Gg: AfdE7cmGnmM3D8cxf3Y7ltgaOssJ6i9Xu3EXCfcA7NBZ5tm9OoV4dqe3RcrxCsNahQZ
	a1QPUpDGyRZYmBAcc/SMjsJT9ilivAnY5bp1+bL2E4WMmjp3BpCvhOwpUwMw3Mr+ByUcEH+Nd/N
	ZeyBwRIhSHOsL5O6UzdZXHqTUUHoi3jf7SWl4pr1pA/bVY0mgCq931UNxVyhZJjM9xbIXF4n5Qt
	f9GeQOdIBzmkWn0qCKA+ouLbNNEqKonVbXxC3lQbeip1KsyBAwhb+PV5+82hAc4C4V7rU0A14Vv
	2OXyLDVlozKp1xoMrc35M6B6N2YIBpZrs3OYz9CtJlPuBZ3ZM4irry0NnKEYaOpPyPIrZEqFi/A
	ysxM+8FzEtYu5dQUDnbIT9SuuwQj5YGXJBKnC1T0pXiDY8Tlq+3Y3ZqTwZ30Jqrnoop0/PKaUFt
	xkpYKkWIkglKN0uTBNkQ3gYXd9ZuQ=
X-Received: by 2002:a05:600c:468f:b0:493:df1d:7488 with SMTP id 5b1f17b1804b1-493f87e5b4cmr100207405e9.16.1783948666212;
        Mon, 13 Jul 2026 06:17:46 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4cbc620sm251653145e9.13.2026.07.13.06.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:17:45 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Farid Zakaria <farid.m.zakaria@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 04/10] sequencer: never reschedule on failed commit
Date: Mon, 13 Jul 2026 14:17:21 +0100
Message-ID: <fc89e77c6e890993d314cfedc53b4e4bb5b1ad5f.1783948637.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1783948637.git.phillip.wood@dunelm.org.uk>
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk> <cover.1783948637.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If "git commit" fails to run then run_git_commit() returns -1 which
causes the current command to be rescheduled. This is incorrect as
we have successfully picked the commit and have written all the state
files we need to successfully commit when the user continues. Fix this
by converting -1 to 1 which matches what do_merge() does.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 21dd5ec9799..c97b996bebc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2542,6 +2542,12 @@ static int do_pick_commit(struct repository *r,
 			res = run_git_commit(NULL, reflog_action, opts, flags);
 			*check_todo = 1;
 		}
+		/*
+		 * If "git commit" failed to run then res == -1, but we don't
+		 * want reschedule the last command because the picking the
+		 * commit was successful.
+		 */
+		res = !!res;
 	}
 
 
-- 
2.54.0.200.gfd8d68259e3

