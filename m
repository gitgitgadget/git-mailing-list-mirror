Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156B81F09B3
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769901243; cv=none; b=V1bITfZHG2Gahjtg/fDF8PtGfjn2rRP1yHun3KYzRqD8h8RSh04u5DaRmHCjRXR2BIWGIn1J0nthMFMZbx2BRALWQCaNO+bySp61JWiNH7rk4BYyguNuSf51zY89sYt6YRwfIbV84K5q5/uyOjgLvN8bjSi26tiKJ6HC0irkW48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769901243; c=relaxed/simple;
	bh=2rJ5ogleWqO+Pv9wOkcJBd6IsR5B9h1cxuWJkkTYNAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSzJQGe+p6t9AHCCY7gBY7955lfxM95QL3q9f3tr1A8ZztZ0zyasVAW8WwBz+SDhs4kQY2QL/As6qDMdLlBmvodw0N0tpxuXP2er5DA8O92hL1enJM1y/MGd8dKJ6WNPH6RDk4ORa61fpbMXit3+ogYD99niH8w1q3HWi5JKQdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtVEAikm; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtVEAikm"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-11f1fb91996so3050558c88.1
        for <git@vger.kernel.org>; Sat, 31 Jan 2026 15:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769901241; x=1770506041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuvcbHXjsULPjxB1ZUiPkMzf+ZnvoF0nGvQuDvluwMA=;
        b=GtVEAikmWebbWzomqkCqkYZ9z2Sw0WjDS+EDle6EeBb6JLRSZGLsSX8TGsgP6gPz6Y
         F2jUDs1IBHGc0ebAv+xTb0ovJVaxn07MgvYNpvif4zzVQH8DR8u816xCCq2YeYmbrI++
         hGRra8CRpVeHUltICgTlfyxz4w1sWVzBNZNg2m23AnGS9NtGy4EN3WQQggKwC4PplpQM
         fOPpSlwdAQVJhev0TqBrNo/Dob9ewNRlhvSY+hdQPMViP/zQLZmMQ9pXwRCseCgo0R8C
         n5NMkhocKEgzIq0K8sjSe95WjSrutD567TsNf1jlayqhghMZ76Ul0JEWvnN5ULf8UimV
         tAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769901241; x=1770506041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yuvcbHXjsULPjxB1ZUiPkMzf+ZnvoF0nGvQuDvluwMA=;
        b=YDmhydTzE3pimkFhct/ecLWAr4oz3KqEo8sUs4eP03fNdbhEyMxRQJykiSMufBEGMt
         yXlmEM8uqKiD+enLcksHZji3B2XVVVJUYMvAYD2Jg52nC+buB34nUAuCb2QN6PlpNAnB
         P1uI9zbA3iKoFb4CQB3rfPyhMmL6RCeB+a/ezxx6v5cxSiDUuJPANJeB/LpUxilgRgVU
         FEVvETu3T7H6kYebbw3HP3wAUDzGNhQzVoHjb7+wywyGA6G1Y0wzSk3oJKSVsehlOFrs
         5CDKjtM//nKqb8ClA3AMUNqOvtXXM/tdCjdRAACrUUG+7RAK/A71yf6rtz2iQsmZmuWo
         L1Yg==
X-Gm-Message-State: AOJu0YwjpjbhMZV9Kjq7vPn1C6AYeqekhVoiLTbaSvBkQGCs650FlQ//
	xh0QEZ1/ovl0dLsSTi/SnJ6ITgi1xNeetXaK0Fy86sFQCpewbb9z7G413pRtGw==
X-Gm-Gg: AZuq6aJkDEpoumEr49Y2eSTwl7j5h7Gj1vq1b9lWL7wQN2wa8p9cqZckwDf4jofSM8v
	OiZpcKlcEzF8AvkKLYPZdmJVf8aGhuQK/a7kxqxNvl1RsZFH50Sq9QNB/YuENXxcROQAqU1UD1l
	a6F9/aV7StwECIgSRdHJFjUwoqrbHkSckU9wcxQyOJQz05PIJ+uANhJbWZ6LGHun3JUePuGFXXn
	R4M+unNrwQ42aocEmM176lj3TLE1wHcGsFhliXNksLx9FE0+YCtSLTWwRIoXRzmkFCAy5IdHvbE
	KCatwxen3u/lkWB59MCgonAIXdDaFx/2Wo9RuGUNlALyMXkoUiOtpGYe7DS5yTqkIcv1K7iIG+u
	EPn0M6Xvo+CTP0y2wTrQIpYgejrbMOxgd8xh1Bxdc3zHVtfF1OOtaCOEtqd8v539CQ2kxkS7rD8
	rhFqonlVIb5qK2eKjQ1g2m9JVbrk78nbkR4J5fZUhCkvorRTCeU1DFdl/VSVPKvDTfD3oJlUYMI
	MEY0CwL
X-Received: by 2002:a05:7022:501:b0:11d:c91e:3b58 with SMTP id a92af1059eb24-125c1036184mr3289969c88.39.1769901240708;
        Sat, 31 Jan 2026 15:14:00 -0800 (PST)
Received: from mac.lan ([135.180.175.184])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9e0304bsm15320411c88.14.2026.01.31.15.13.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Jan 2026 15:14:00 -0800 (PST)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH] RelNotes: fully spell negation
Date: Sat, 31 Jan 2026 15:08:48 -0800
Message-ID: <20260131230848.4790-1-carenas@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <xmqqpl6vezt3.fsf@gitster.g>
References: <xmqqpl6vezt3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Documentation/RelNotes/2.53.0.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.53.0.adoc b/Documentation/RelNotes/2.53.0.adoc
index d3f6d18199..2668c2e996 100644
--- a/Documentation/RelNotes/2.53.0.adoc
+++ b/Documentation/RelNotes/2.53.0.adoc
@@ -138,7 +138,7 @@ Fixes since v2.52
    (merge 42ed046866 jk/attr-macroexpand-wo-recursion later to maint).
 
  * Adding a repository that uses a different hash function is a no-no,
-   but "git submodule add" did nt prevent it, which has been corrected.
+   but "git submodule add" did not prevent it, which has been corrected.
    (merge 6fe288bfbc bc/submodule-force-same-hash later to maint).
 
  * An earlier check added to osx keychain credential helper to avoid
-- 
2.50.1 (Apple Git-155)

