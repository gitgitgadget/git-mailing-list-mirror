Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0CF848C
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 00:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729729506; cv=none; b=LIhU+43QKzTDCLF0SE4A4tXDZ1QgW6IDiNb1q7rQF8A2lq3F+/Ub8B+jfzpts4/zK7p5xOEfohYMC8lvk2XzWJO1I/jxatDiBHOzcqV/5E2ogZkWtOrOkOwryHOHpTcTsVnLfnFacBW6470cyr4+cW3fzoKS29vTxO9MugrPnj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729729506; c=relaxed/simple;
	bh=o/XE6+R7b+USfapim0RE9o/+CifsLG2QGh9qfsSo8Ck=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HP9PwllcPTRor2u4Z7RT7k1ITW2015IZre4cZYEUTH4jTNE+3f+M4QEisgvrbPV3oz4c87PshNkX1Q4WLQ4x7S736ov3BSlWrBJ8MDCsNwwJgPXzS/48NntVBlbsYQwrjwOxAJIXPj13AK8y+aWRYO3Nnnn77APsYuZcO0Ms+Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geoFsOyW; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geoFsOyW"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a99eb8b607aso26962366b.2
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 17:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729729502; x=1730334302; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4GPchkQpAaGooAKo0wkCv/IUL9dpaN5Lh71nlKAT0A=;
        b=geoFsOyWUd+GGSor9/9mzOSnKTBWzc6iy8khYHLQjc2ruFn7NiOhcBZD1kh/VyfjZF
         cWh0iMqIxGtknvDG8GIhgP1V2Y+w7tZgeD31EcnwRBGo2Jfyqz7EcHSsSXEZhbYjPaAw
         oNTiR1LeiODVu45xS0Z8Xhab5NcEOiHXC/7akbz+UnetbfStWoOpazkJpMbOwfgU6VV5
         PN9GL7vwrQR5ZcNUvJUmCi144TOUWVzrYe0iGOX1rgo5VfDH5Dvw1jPDco21qLjLmZxf
         OWnNq6adzCyIiRBEMJ871FOLF25yANrfSPJbBUPLPUHDQAL2hxVCIyWB/lCs9XSDqTgF
         2q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729729502; x=1730334302;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4GPchkQpAaGooAKo0wkCv/IUL9dpaN5Lh71nlKAT0A=;
        b=ahbrEV2pMuehCxwbpoNDfph9eq4btKRmqiW06jl49HPPGr85IQGNsY9ra1yrSMEmGs
         3TP0unQlo9Dv1Ujg1RiZ9I466CIhkkwy9uCtJ1K4y3Qye19ngLsxs2I9Swt5/v94F8VC
         wP+qOZszhFjuXtAB4chm/rFySR8T1oAUAs1680hS/ESpBkCEn7ge3nneRfo+mJgyjNFl
         0p7iLpNh6K5zWix9rajHSHmv7o1/r8pw2ItqsrW23W2iK20kwi/Suc8pIrKOToAYemA3
         jo6c8f53gYB+GCsb/tS7NVcDSa7PvDsLYSCVhxiRfVMlbRtsASTwVGRfhPPw4lZYtytz
         t/QQ==
X-Gm-Message-State: AOJu0Yw/EStWYmJY0fcdfASDFvdT4bke1oIkofbUd8mapcIZW6cfZEBO
	TIxuxqmm5mCk0EBDYnMkENOQyj7U39zdkY8meG8OaMl+0/lMrcjPE0+15A==
X-Google-Smtp-Source: AGHT+IHWuRUlNBNAvyG0heD0zWVB8zKsmiW9YBPObCFMRtckjRNzec6VnfwLRwT3iXMR2EcimnlIHw==
X-Received: by 2002:a17:906:da8e:b0:a9a:1e4d:856d with SMTP id a640c23a62f3a-a9ad273096bmr9252166b.22.1729729501890;
        Wed, 23 Oct 2024 17:25:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91306fc0sm539396866b.91.2024.10.23.17.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 17:25:01 -0700 (PDT)
Message-Id: <0ea3b3495609deef8942899b960756d9cab6e25d.1729729499.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.v6.git.git.1729729499.gitgitgadget@gmail.com>
References: <pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com>
	<pull.1810.v6.git.git.1729729499.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 24 Oct 2024 00:24:57 +0000
Subject: [PATCH v6 2/3] merge: replace atoi() with strtol_i() for marker size
 validation
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
Cc: Taylor Blau <me@ttaylorr.com>,
    Patrick Steinhardt <ps@pks.im>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

From: Usman Akinyemi <usmanakinyemi202@gmail.com>

Replace atoi() with strtol_i() for parsing conflict-marker-size to
improve error handling. Invalid values, such as those containing letters
now trigger a clear error message.
Update the test to verify invalid input handling.

Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 merge-ll.c            | 11 +++++++++--
 t/t6406-merge-attr.sh |  8 ++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/merge-ll.c b/merge-ll.c
index 8e63071922b..62fc625552d 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -15,6 +15,7 @@
 #include "merge-ll.h"
 #include "quote.h"
 #include "strbuf.h"
+#include "gettext.h"
 
 struct ll_merge_driver;
 
@@ -427,7 +428,10 @@ enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
 	git_check_attr(istate, path, check);
 	ll_driver_name = check->items[0].value;
 	if (check->items[1].value) {
-		marker_size = atoi(check->items[1].value);
+		if (strtol_i(check->items[1].value, 10, &marker_size)) {
+			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
+			warning(_("invalid marker-size '%s', expecting an integer"), check->items[1].value);
+		}
 		if (marker_size <= 0)
 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 	}
@@ -454,7 +458,10 @@ int ll_merge_marker_size(struct index_state *istate, const char *path)
 		check = attr_check_initl("conflict-marker-size", NULL);
 	git_check_attr(istate, path, check);
 	if (check->items[0].value) {
-		marker_size = atoi(check->items[0].value);
+		if (strtol_i(check->items[0].value, 10, &marker_size)) {
+			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
+			warning(_("invalid marker-size '%s', expecting an integer"), check->items[0].value);
+		}
 		if (marker_size <= 0)
 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 	}
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index 9bf95249347..2dfc9a873d4 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -118,6 +118,14 @@ test_expect_success 'retry the merge with longer context' '
 	grep "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<" actual
 '
 
+test_expect_success 'invalid conflict-marker-size 3a' '
+	cp .gitattributes .gitattributes.bak &&
+	echo "text conflict-marker-size=3a" >>.gitattributes &&
+	test_when_finished "mv .gitattributes.bak .gitattributes" &&
+	git checkout -m text 2>err &&
+	test_grep "warning: invalid marker-size ${SQ}3a${SQ}, expecting an integer" err
+'
+
 test_expect_success 'custom merge backend' '
 
 	echo "* merge=union" >.gitattributes &&
-- 
gitgitgadget

