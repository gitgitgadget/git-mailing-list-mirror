Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0015A1885B0
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 22:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732229447; cv=none; b=lFgdP12L6x+p0ANkRryZg4Eqcu3gBy5qRJERwHCdO7QdnoBk9nvSlEDLp0+pUIMN4SvJdvqrx0Nyh+fAn6uDEzP6lNriXgPz73d5zBdxRgWzMp+fzDWqBvRkOkcCkxckFsMVVb9lyTTSdKIFuHUAPptMgKCdiRwhI7ymk2JUuuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732229447; c=relaxed/simple;
	bh=khaB235JyMXZawCmyAOoHOfmNoGRMKzAkBFG3FTgKf0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rUcaf3CW6w3IdoV/A2+VqfOgKMCfOc47TBb2Dkz6zqoD/rU4kuMwKUEDC/aGsIdpHaJm57tXH9MVGsqrBAkFR1nEJOi92YnM++oO+l4wsFrK3Yntp93ljw60QALggPOx+qUO5UtQfEDKrYZC0v/tRYkVldufpEDqVQvuyiMKoXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=UhkbDgWP; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="UhkbDgWP"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e38866c8b2dso1317402276.2
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 14:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732229444; x=1732834244; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OPoGRfTYtnUgTOjYL39XQruN4kXs2rU1Vhwjtm8GvQw=;
        b=UhkbDgWP5kYblwudufzrX3izqzH6sUe3K9zvx8/8GwxBTeWqUFLnbfWDMPMENSOBLC
         nyL1TY1IEnWrY/6sVTKe4Xn75h4/e2ej0Wa6lgOBK3Q4G/A5dZzeaWocLWPIQoRaSAIm
         RPUXeN9dS7JBhEyOD8TsnOq4yQboAqKt4WNZo5nUsww6PvwU4t4/b2mfuaW1g3xLNlPh
         3l8dWAqfYMyDA3zvXCCzmntetxHN8KKX79XtfLkn/1lKA72Ko3ZDTFfKxUCM0zN3I53F
         ZZncd8l5v3q4CTlL4nh/G7W8Dx8bdFKJd3VBMmOT/LxIDTv6/Hu0nPz6wtCWYbVPWH9U
         VGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732229444; x=1732834244;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPoGRfTYtnUgTOjYL39XQruN4kXs2rU1Vhwjtm8GvQw=;
        b=oL1bQg4Z08srD5dIhl94T3wplqw6/2Q7zXt3btr/u4cnyPl02zTBnLxKm+UnbwZw58
         9bASH15M9YfWjTrKaIVdktBkoBFE/8KKuWIAG0FF2R4xrNhVGp7w7W63wj6y1RSu4nLl
         AZDPIRAFONDhrwXu38fau8zRJUGcupCnWwCLO2vyQ7uSX7/vzwKLBroTb2bAN5ENr8Fl
         JTZNwsR6DHJR8YlFmyn+BspshkqqwP5v7eDjIShas+wTs0T5uz5X9wTa+jzhyqxAoJ4K
         wC7bKYAzXcgSfmpcaNvDqATtZhaDQrZFT2Kuji+gQ87ZgYbA9uO8hMW8TA3G5vlLSaA+
         OXrg==
X-Gm-Message-State: AOJu0Yw4bx4RHxZEsY8woZCS4am/MB53XAm6jp4jzIrad7uXvb+uvZJx
	JpxIv4VpmIxl0E7FUNEZl3efflHYmUiqy76egVahnh6hJT5Z5BIwH2twJRSMlWpNbOS8CAQV7sF
	e
X-Gm-Gg: ASbGncvy3wC1pFSwJHexerH2vOqEc2iFuRF9UcufbYNfxHRFzqdwmOaeBMUZXhIRAFo
	1m5KOIQOy2k5F+tYEAzgnXn+tvIroeNILqgipg+6EpkpvSO+9xEMij54E64G3tHrnmg8K1Q7RjG
	qUWl22A2QutjLrLgRHqBs/lUMLJMcCRmgaIKdeSmXE0meb8HoMkLaodd4W03ZshnqdEEwI8S0YH
	kZaEMsV5v4Nc60kKvgHn4Fw0XyVJFzTEUitdZbocUgJtbb7loDuy7A4tgv2WG6A10YW7r2O0pKp
	aGw6S6UI4sxVUai/okX58A==
X-Google-Smtp-Source: AGHT+IEMlDQolnLNBvp1hTovAqfC+7nUq9+Ifr5jPoeQF/A6rn5BGuX9H9Jgy0f+j5O9bRwMPvSy3Q==
X-Received: by 2002:a05:6902:c0c:b0:e38:b047:9f57 with SMTP id 3f1490d57ef6-e38f8bff54emr688416276.37.1732229444566;
        Thu, 21 Nov 2024 14:50:44 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38f634d077sm205921276.54.2024.11.21.14.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:50:44 -0800 (PST)
Date: Thu, 21 Nov 2024 17:50:43 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] pack-bitmap.c: typofix in `find_boundary_objects()`
Message-ID: <cf49115db4e8dcd406a17c946659c2eef3ec6045.1732229420.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

In the boundary-based bitmap traversal, we use the given 'rev_info'
structure to first do a commit-only walk in order to determine the
boundary between interesting and uninteresting objects.

That walk only looks at commit objects, regardless of the state of
revs->blob_objects, revs->tree_objects, and so on. In order to do this,
we store the state of these variables in temporary fields before
setting them back to zero, performing the traversal, and then setting
them back.

But there is a typo here that dates back to b0afdce5da (pack-bitmap.c:
use commit boundary during bitmap traversal, 2023-05-08), where we
incorrectly store the value of the "tags" field as "revs->blob_objects".

This could lead to problems later on if, say, the caller wants tag
objects but *not* blob objects. In the pre-image behavior, we'd set
revs->tag_objects back to the old value of revs->blob_objects, thus
emitting fewer objects than expected back to the caller.

Fix that by correctly assigning the value of 'revs->tag_objects' to the
'tmp_tags' field.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
Noticed while I was looking for an example of this pattern somewhere in
the codebase and was surprised when I found this typo ;-).

 pack-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 4fa9dfc771..683f467051 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1270,7 +1270,7 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,

 	tmp_blobs = revs->blob_objects;
 	tmp_trees = revs->tree_objects;
-	tmp_tags = revs->blob_objects;
+	tmp_tags = revs->tag_objects;
 	revs->blob_objects = 0;
 	revs->tree_objects = 0;
 	revs->tag_objects = 0;

base-commit: 4083a6f05206077a50af7658bedc17a94c54607d
--
2.47.0.237.gc601277f4c4
