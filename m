Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9851D14EC56
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 21:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755710; cv=none; b=oPcccQeTNLqhSBPS/0fDOY4+yvugUcsNOuy/6zlDtqwc9te5PaXNwBvZ8QbISe7pY60IJUHIkHa6vgDWMgPEYpsldD9W9Tkjbrk3NNxLfO4CF3RJmMFicj8hWIz4gJGGdNrmnqBYC0+OMHkirCIewKSNehXJeSLpfwaLyCt4rAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755710; c=relaxed/simple;
	bh=xbAiuQVR2y0u+YecTIG0A9Ny9UIZNKKG2WfRFXFmB4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=is3ZlhukxRl+liQLjrposHsoh8QXpwkfr4VlrIuUAcute6pdyBCMa2M3hS5t3L/Z3MtzRVmEbrfEUWIT4yZzXXOZ4FSL9lJ4lXYLtWva1/38Fw95eBHTZjYxuxeRCzYwNjYhLCOdOncR+BTVJiQX5AzQLvwDeqMgDEB4APENI7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=c9jJQNz9; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="c9jJQNz9"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso1324531276.1
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 14:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723755707; x=1724360507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PDRQ3hj8CqCqfbToN7r6VpfC6iQIyqXSQfZOlsjQc/M=;
        b=c9jJQNz98m08UalK2YlrJVK4SoYaQ0Evzo4X4bMZ45GZ8NeCrBMFQp0FSWOZoIx/bb
         nJTrXtmguV6UbpGrQPTnVzOoDVIhixujF0oHP7GXTvs9Kp/+6aokby1Gb13/6HEcNFiQ
         1dPWg++L9E7z7xY2kBgAgCy/qlL9dQRdp6HVa5gKuSeRvaIXgkCelbXl/YoOwuAiabQl
         Zl7k9qB6znpZ5Lsn0W+EBYQfutvD/BeWfwgD79aiKCvA267gc3LK/0qW8ircpgDO+TcC
         xby5s+7kfpmfnI2420HtXvzYPXUXt02xJp3XAJWeFcYMx4M7RsudBgfU9h1VCZSHecML
         xYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755707; x=1724360507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDRQ3hj8CqCqfbToN7r6VpfC6iQIyqXSQfZOlsjQc/M=;
        b=Fr6ww9rblrpdYe/bNiwVEzDBxb3CTpZps05X0iQSvXVkfx9sR7S3aiLEtkOIFA+BhO
         ZyqZX2L/usSLww82qz8gmp8iHnlVcySjEHIVGzP6Y6JNeC/GnsEd2YWmv85Iq1rW8U9Q
         EE9+FomP2zUDbFkJz26p/S5U1h7OJNRWWp07Dc5QjqaWRUWp3B6/Ti39ikrfewfrJEp8
         IFtlIa5WBdSj9mLZyMRV4mli1togDbsuO5L/wyvbheg3kVNGzymze1JdJOfu7rToJFay
         O35G0WeLQNpanHItnArQGAfRdYYD3Nto52AIO12XoKdNMsOD/g3mPuvNH/hHAHnS6Q9R
         l6yw==
X-Gm-Message-State: AOJu0YwcQNY9AQIU9XFK/9BFPS78A24p5g+YVJKihIBae4u4YSpTti4/
	PApr70hwvBdS4N04lfpqOtU7/uGDe0D5RvX7HH/8VzF6mb1I5JL9obMM+D/+MoHp0fV2cWGNlLv
	U
X-Google-Smtp-Source: AGHT+IHtdaDfg8eXPN8bR6pAVcamYBwhLMFaxERNPahGKHQh7gMmBBgJ01wsZrbXVlXYCCbO9WC5/g==
X-Received: by 2002:a05:6902:150e:b0:e0b:d8ae:caca with SMTP id 3f1490d57ef6-e1180ef21f7mr1470340276.29.1723755707255;
        Thu, 15 Aug 2024 14:01:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1182fac3acsm92400276.9.2024.08.15.14.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:01:46 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:01:45 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 09/13] pack-bitmap.c: apply pseudo-merge commits with
 incremental MIDXs
Message-ID: <81839fc1d1a60b467b7de61222795a3a0a7423aa.1723755667.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723755667.git.me@ttaylorr.com>

Prepare for using pseudo-merges with incremental MIDX bitmaps by
attempting to apply pseudo-merges from each layer when encountering a
given commit during a walk.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index d3bb78237e..1fa101bb33 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1087,10 +1087,15 @@ static unsigned apply_pseudo_merges_for_commit_1(struct bitmap_index *bitmap_git
 						 struct commit *commit,
 						 uint32_t commit_pos)
 {
-	int ret;
+	struct bitmap_index *curr = bitmap_git;
+	int ret = 0;
 
-	ret = apply_pseudo_merges_for_commit(&bitmap_git->pseudo_merges,
-					     result, commit, commit_pos);
+	while (curr) {
+		ret += apply_pseudo_merges_for_commit(&curr->pseudo_merges,
+						      result, commit,
+						      commit_pos);
+		curr = curr->base;
+	}
 
 	if (ret)
 		pseudo_merges_satisfied_nr += ret;
-- 
2.46.0.86.ge766d390f0.dirty

