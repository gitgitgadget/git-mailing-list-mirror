Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FCA34FF55
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420475; cv=none; b=M+0FTctNIGqzYfA5I16NXudO9ZC51Ys0HJH87daN+m0vcRrawOJgEViWL+0T0ODSZdr4DQVJQuj8A1PnLFRRg7CSLB0mQkDZA0MzXaEl5I4xGmK1vwCgPgnksSb0vYp3PGztb+qYBLhz/hb4hSTZ7CuoG8XqDeeZdByM/nGxwp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420475; c=relaxed/simple;
	bh=iGDpmRu7C1Ip9J5i6cOm13yde1FlagEMzujHo7mPynE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMe1j/PbxrT9UKN0Ecb0sk5ZwBgw3SHd4fFH9b9k2zKBJ1EobHf0IHlxiN6SLhgd6RL5eI5xVpSYtgshY08c9hHXwgL2ujzO+I/5IMWrN9Dq6PZlNxZ8Mwyhd2lYyW8TE9bZ3vk1f8SSkS1qca4V/KY/c+7C7gVKxJ9bz9h/PVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=hY/GivC7; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="hY/GivC7"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78d6a3c3b77so15300067b3.0
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 11:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768420472; x=1769025272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DqRHGkPs0XK0MP0P/dJm298eNkTbCflRkWfu1aWYoJ0=;
        b=hY/GivC7EYfw8FiNyhRsl1XM7vewVo/kae2TgeNOlPJD/jdYGmBXcqHSnOhUl9Q2uj
         ZVNlLZNH9aTwv6vP+ThG97nqMWQw7I4tYHU0nRXNiTal9O8y39NsNkrLrfSzhYpYQV26
         FBGJEvdjjwOXbF3hx+GDBK8iGafVtor7enm7CYOWOFhktxMx7dHMrp2P6Lu8ieIIOzaJ
         kfKojdB5IH1/ud5ZAzelmV+Yds0Dla6UloppNzVJwA7F20UAsX/B8suykFMps485TW4e
         LYfO0yE5YDLU/4MCenXGDWZ+ONUg9p9qs9K00DYAOW0Pu3w6V7r5WZIUPrkF1jdIH0BP
         PN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768420472; x=1769025272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqRHGkPs0XK0MP0P/dJm298eNkTbCflRkWfu1aWYoJ0=;
        b=W5nH0grHZFFbsWGbwdGXASk1sHXkwAOIpyPgdk9A5Jed88XMOLnGpnxJJscnOo8tk2
         9yiBzZWT02y3ru93PQALnWdF65fZffT6qv2bgfRFHbTUsTipAmATgyuNv3Ho6t3jtUNY
         V+/3H5Z6vfYiqYozrEKY654w47USu4Fm2NEe2ieC/MA+pk7+cR9q08RVTDf2e4cDxp3q
         W7TN2HYFWVd0UCEO8WlMbWp5Pythznh+zZHViaGU4KhnL8lJ+3xhWUH5MCd/uO4kcpGK
         jnVp1+akn53kGee0JlbswjZUaK4DOe2JP3Aya7calb+c3w9J+5cztxigc64726I1is1S
         IC9Q==
X-Gm-Message-State: AOJu0Yzx1j32TCxe+4keRhCV998H6VMCb8yMkjawvk8nvQ0+Xp1hA1QW
	IHxxRSp7Ma4YnMi7bGosLTQzUHkkpPaBkz1oeC6tRxjU8Dr090KfiO7FjkvveeSDlXM07gDt9H7
	aytFOZPktDw==
X-Gm-Gg: AY/fxX79rGQ6y0Tg0tCPpUyxvt/dxrLaQqptm4Epk761km0IUBHMHcsyqYq7FGrb3cg
	JTbGeOm4QhKnqflG8C4oGoBD5H6yglgRtaBRF78+hebukfjSSrdnIZgGJhcUcQ0Q12MnM82KixZ
	h2vySzLjLwmAFb9Rm3sTcby2Hbgjk3hYukAz7GrLxxx6BiM7iyPekDyXnM+pI7eXwUxcu4AjdJN
	YCzeFa1lY2fP9yX1zd7Lqj0YvEw13k6j15AAKT6sJKvhL2E9F42C634TWGr3FEbaK6p276pYWM/
	0nKu6p/6FPwPqSOy1nAvhKqhgtp5BOYUiO3hEyxXr1bf67MbEm1aBuqhlRbY963roX236XXidlx
	LmntX3XAK3wHY/5ev3wugcNswmA08klceKQMSpBsc/9qEKdWm3rEEymSos348y69hjcLRiPg5ED
	iEDzjvfoeRFnm46F7V02crMf9+TpRJ3pkgQXA/3DPeutctu1KRgNldzaYg3Iiggyox228Aei5Ak
	T0aVEyqP+uApoAp7g==
X-Received: by 2002:a05:690e:1449:b0:63f:b440:7f90 with SMTP id 956f58d0204a3-6490a6259f4mr496228d50.16.1768420471967;
        Wed, 14 Jan 2026 11:54:31 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d89d4fasm10857656d50.15.2026.01.14.11.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 11:54:31 -0800 (PST)
Date: Wed, 14 Jan 2026 14:54:30 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/18] git-multi-pack-index(1): remove non-existent
 incompatibility
Message-ID: <a00598a36a31e3efcf45f35b2cf4fc2e3a4de958.1768420450.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1768420450.git.me@ttaylorr.com>

Since fcb2205b774 (midx: implement support for writing incremental MIDX
chains, 2024-08-06), the command-line options '--incremental' and
'--bitmap' were declared to be incompatible with one another when
running 'git multi-pack-index write'.

However, since 27afc272c49 (midx: implement writing incremental MIDX
bitmaps, 2025-03-20), that incompatibility no longer exists, despite the
documentation saying so. Correct this by removing the stale reference to
their incompatibility.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index a4550e28bed..a502819fc38 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -75,7 +75,7 @@ marker).
 		Write an incremental MIDX file containing only objects
 		and packs not present in an existing MIDX layer.
 		Migrates non-incremental MIDXs to incremental ones when
-		necessary. Incompatible with `--bitmap`.
+		necessary.
 --
 
 verify::
-- 
2.52.0.457.gb599f1ad4b0

