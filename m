Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66E6148830
	for <git@vger.kernel.org>; Sat, 17 May 2025 03:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747453002; cv=none; b=uZNPYhVrSkmtQch9tt2xKgGsdgRqRtDxGtgUfFmOm8dzd2iOqAsMYIDvwXT+KUvIzLIVm6Hw5RsRcCZvtxJ6kT0/WfS46UACggaN/gl++KX99S26bAHRkGqJfEQm6joxz0XkHm4W+jRRF//T8HCCXe8IB2xDdLeHazpJJD6byi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747453002; c=relaxed/simple;
	bh=2Wy6NrjBv5zCbWBYXQr0FKqwpbU7rmsPwreRSPdtwms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7Gk0vsrANU51l0MSEP/gaNMcC/vo7F/9amFOcbV/n4pY+29LEkDpAn1d+k747nL61DLhWPt2YiSmHcvgtdeMzHkwLChOASEtceqTlBaVCrzn73iA2/d2vETJnF4xvYtPnMaZyTgOLTQdnTdX/HmnXWxJBj/TRS8n58Bh7aFeeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcatkGPx; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcatkGPx"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7376e311086so3437394b3a.3
        for <git@vger.kernel.org>; Fri, 16 May 2025 20:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747453000; x=1748057800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aX5o07nZuVZbUt2/FBlkWRGkepZGq+W2qgBlQpwpGRA=;
        b=TcatkGPxxT7nrhhJoAD3ya/Zo9XdVhuypsjreW2XaZLBOj55RIwQLNemovkXzR4Y+D
         IqpFly1++9o0Hdm+kSXJfzUCSJpaQKpFTf7/s/BL5CEoQNGuejE0qf/eZLM3h586W8LF
         yy9JDhuLKXsgxSb9nwcWOGCPrSr3uc9GIS8AW4V9BnyrZvoyT0uG7bceHlbGLa2GQLyI
         AvAEZjqrHcouiFWoPRiDnrCVQqNf+PScAjR0YgpkeweYDWLbn1EcLskm7rpPAeR7G8rk
         vBdvK4xSFtQsKWJO+13N14PPQCENrGZbjXK/r3VPt6IdUXpRsU6hhB/PtxJPC3nos0Nj
         RCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747453000; x=1748057800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aX5o07nZuVZbUt2/FBlkWRGkepZGq+W2qgBlQpwpGRA=;
        b=CCoV3tC46uvoUXtfTxZyA6HjjrmjIE4n3fPFrnRg/n0TrQfa45zPDqZ/Ji6dKBZkrW
         m5+oGChkJ+tDvlpW1hAJia9fLkUA+VipoiYqtss5uRHnv5npEEZF8u0+oiy2NHTV3mnh
         060WKvANRIrLGGR5vp8hM3JaclS7p/tzEqadmvKZvsdgfYqP78D+Gepe4iRSz0Ac2C4X
         WyJWhkmPuSiYiPGkW3EHtznPHQi9L1BqSdtFsp/dSNIGuBN22PsSBJWSDEBfdWlpxPcR
         gjv3Z80ZAWwGhinPtTReTcn6Ysuawvb3nzbujNwXfNRiYO3y4EGcdUl2yWhXlMpOVamv
         A6xw==
X-Gm-Message-State: AOJu0YxU1CD6x2CXNVDinsl3/dZUKHQQfB2hlojpXFTSmcylO3gozP7q
	oOfVo9r2BeRiw2w2I7tTaAacpOSxldy3ftbrVU2hlX+BQ/Va52sFWbNL
X-Gm-Gg: ASbGncv1OLqGT/66id9oVHXoGRBq5QgfivE2hsAHLgJCxXxqFCX0iMYf2C0L5jMauwz
	jlhCauRlRvxI22AdTUNz5W2vwOqp00NoARyzUDkgtHQ3JWiATZcxPHh50QLoFLvvkB2AiHuLTD8
	b0s9BrPz+VwMuMEXrQ4GEJhclU60CqnDd/aMBAMS9SzpggW5Ulqjq/WPQE0IKqfG1o+R/K7wjyB
	1xpNKLQqP00vQp/DXwoycvUy5+lzeRuCVtEtCDnkPz8OZyerli0t8LIoQv6oTqyX0g7r6alXG0I
	STLhM326qGgNgzlPJU4FN2zAAnE4u8fj4CN4S+N4fUk582TCXHyBaBwN3hdgFfmb9kEnjkibmH7
	TWQ==
X-Google-Smtp-Source: AGHT+IFYcrVpZhqu9k2SVtD2wLNyOAUqajjAfMQ0bpCt9bqdi43hEs73fJJeXombHU8agiBnRJg/tw==
X-Received: by 2002:a05:6a00:22cd:b0:740:6f80:f855 with SMTP id d2e1a72fcca58-742a97de157mr7067175b3a.9.1747452999912;
        Fri, 16 May 2025 20:36:39 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829ba8sm2285500b3a.110.2025.05.16.20.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 20:36:39 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	jayatheerthkulkarni2005@gmail.com,
	nasamuffin@google.com
Subject: [PATCH v3 2/3] docs: clarify cmd_psuh signature and explain UNUSED macro
Date: Sat, 17 May 2025 09:06:25 +0530
Message-ID: <20250517033626.8052-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20250517033626.8052-1-jayatheerthkulkarni2005@gmail.com>
References: <xmqqecworq39.fsf@gitster.g>
 <20250517033626.8052-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation previously omitted the UNUSED macro,
which often led to confusion for new contributors
when they encountered compiler warnings related to unused parameters.
This commit adds a brief explanation to help clarify its
purpose and common usage in the Git codebase.

Additionally, the function signature for cmd_psuh has been updated
to include the struct repository *repo argument,
align it with standard practices.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index ef190d8748..f4320d8869 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -142,7 +142,15 @@ command in `builtin/psuh.c`. Create that file, and within it, write the entry
 point for your command in a function matching the style and signature:
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix)
+int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo)
+----
+
+We will use the UNUSED macro to make sure we don't recieve compiler warnings
+for unused arguments from the function cmd_psuh.
+
+----
+int cmd_psuh(int argc UNUSED, const char **argv UNUSED,
+	    const char *prefix UNUSED, struct repository *repo UNUSED)
 ----
 
 We'll also need to add the declaration of psuh; open up `builtin.h`, find the
@@ -150,7 +158,7 @@ declaration for `cmd_pull`, and add a new line for `psuh` immediately before it,
 in order to keep the declarations alphabetically sorted:
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix);
+int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo);
 ----
 
 Be sure to `#include "builtin.h"` in your `psuh.c`. You'll also need to
@@ -166,7 +174,8 @@ Throughout the tutorial, we will mark strings for translation as necessary; you
 should also do so when writing your user-facing commands in the future.
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix)
+int cmd_psuh(int argc UNUSED, const char **argv UNUSED, 
+	    const char *prefix UNUSED, struct repository *repo UNUSED)
 {
 	printf(_("Pony saying hello goes here.\n"));
 	return 0;
@@ -279,8 +288,9 @@ on the reference implementation linked at the top of this document.
 It's probably useful to do at least something besides printing out a string.
 Let's start by having a look at everything we get.
 
-Modify your `cmd_psuh` implementation to dump the args you're passed, keeping
-existing `printf()` calls in place:
+Modify your `cmd_psuh` implementation to dump the args you're passed,
+keeping existing `printf()` calls in place; because the args are now
+used, remove the `UNUSED` macro from them:
 
 ----
 	int i;
-- 
2.49.GIT

