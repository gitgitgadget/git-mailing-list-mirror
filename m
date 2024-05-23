Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7795112838A
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499602; cv=none; b=IPhhWzJRds9MwpsEie4M2KQKzj69lKaR3CzNmuQwdU2gbNWgZTHkrZRX/zEeZ5bXr6ioALdOx47q0zlYEq7yX9u95MP3tEQqwOIJYJdAlpl9QCraYzx/uv4hlbZ3QkBFMR7l1nEj4DotXWsUrvwZ+JAR3NAQ2LuB/khgHYN+MCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499602; c=relaxed/simple;
	bh=NPL66ipPMX3pZf+Tixy3UFnkh2ViQXjsQT4AO9glGko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fr+qO7sCJ7WibePP1fDTXhPyPSeh2k6+KyAxUAq1SyVC+e59fazlwrj4AJFbdHzKOXCKeK8x69lTnZsTy7EDqwNx50Ubx5ELis1reaC77WvkbbBNRK6LF2JRMU1oS5/UOv3HrPyoRld9sXeCKKQf92CCPg92wk3TAVjTdttUlRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=F0yyE0bQ; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="F0yyE0bQ"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4e4efcc3d8fso96286e0c.0
        for <git@vger.kernel.org>; Thu, 23 May 2024 14:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716499599; x=1717104399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DJRNfrGp2DYNvDbMSycjUfC871UBePymvHeFswB5tXQ=;
        b=F0yyE0bQZORWiJF2tvk9AXo/QG0KMeq1v5A5eWue04wPRe8t0BOu/A3RlFTRZMbjjp
         D0ClOwmMcy5FCMKUlRSxYkUpYNKJnA9ou7pb1h0zYXFLHVXNy/s4Xf5tk5x2mknIK3pp
         hVQya+NCD2njtwPGY0rNzPR+slFk+aU1t1qUtNFVXIcQaQWe6oFYSwPcLxXll9UIxL05
         OG0ASbSyJw5sWqEvwUDu7DzlKitHCVhNq+xXbVsz0cMrmktApVRnJu0L3pZ0VRXlWqAc
         bVjBLFIN6/eZc7wWN/5kL+ylGj3pkJRCm2zlpCqLt+ry/7DGOPeOLU3vzB0uSKzs8a0j
         26gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499599; x=1717104399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJRNfrGp2DYNvDbMSycjUfC871UBePymvHeFswB5tXQ=;
        b=Rt7dfxmJDeer9q5fzFDQ7xX6+RzpeJ5npa65RvHoDDMZMIDj/auNxpnMVDExU+gz3c
         JLnYuBXkCvKdSf2dT0jIa5N4SxfCUOFcUjZzqviHFcRvHOefy8ZYbf/EqJ19zV+teQBC
         rs92WT8g9/qBktfQC2Wmei/2G/R4NBXk8MWRLJlfzSG9hGF6KFy/ipd/AkiG6tZJd++v
         LI8yKutCR1NPBPtc7nfn18s4SPCgmTL8bP7G97VJPxvI+th1A0Zxj1S/o1mk0WsP98ZP
         EAiKqq/Sy/pndYA2Ha8VTNiWUx7EU0WMNx2mp1R9oPwru99gKprmifbM/BrwpqbkhgBl
         LPVA==
X-Gm-Message-State: AOJu0YwnoXj/VR+rB+Frk5IrrqGg31Ds+/+RnfmXANHhCNa8qGsyJZeZ
	LT8brne2RqYjkm9hcLxummibRVUuTmINz1/ioOmougprzwU4eGNLceZwBkwjUxkLPQDwFY8Hetr
	0
X-Google-Smtp-Source: AGHT+IG3wBO6V9nhe+zs/WsA27Lcyr7jQt8eyJ3+kXGv+6ogqDy/+SpJ0ML5bW4aH9JAnNAcljERcQ==
X-Received: by 2002:a05:6122:4692:b0:4e4:ee6b:1783 with SMTP id 71dfb90a1353d-4e4f0233ad2mr415052e0c.5.1716499597699;
        Thu, 23 May 2024 14:26:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd303c1sm2321185a.101.2024.05.23.14.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:26:37 -0700 (PDT)
Date: Thu, 23 May 2024 17:26:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 09/24] pack-bitmap: make
 `bitmap_writer_push_bitmapped_commit()` public
Message-ID: <6bf372f4020dda272ab4f69cb42333465475dd91.1716499565.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716499565.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716499565.git.me@ttaylorr.com>

The pseudo-merge selection code will be added in a subsequent commit,
and will need a way to push the allocated commit structures into the
bitmap writer from a separate compilation unit.

Make the `bitmap_writer_push_bitmapped_commit()` function part of the
pack-bitmap.h header in order to make this possible.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 9 ++++-----
 pack-bitmap.h       | 2 ++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 299aa8af6f5..bc19b33ad16 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -140,9 +140,8 @@ int bitmap_writer_has_bitmapped_object_id(struct bitmap_writer *writer,
  * Compute the actual bitmaps
  */
 
-static inline void push_bitmapped_commit(struct bitmap_writer *writer,
-					 struct commit *commit,
-					 unsigned pseudo_merge)
+void bitmap_writer_push_commit(struct bitmap_writer *writer,
+			       struct commit *commit, unsigned pseudo_merge)
 {
 	if (writer->selected_nr >= writer->selected_alloc) {
 		writer->selected_alloc = (writer->selected_alloc + 32) * 2;
@@ -664,7 +663,7 @@ void bitmap_writer_select_commits(struct bitmap_writer *writer,
 
 	if (indexed_commits_nr < 100) {
 		for (i = 0; i < indexed_commits_nr; ++i)
-			push_bitmapped_commit(writer, indexed_commits[i], 0);
+			bitmap_writer_push_commit(writer, indexed_commits[i], 0);
 		return;
 	}
 
@@ -697,7 +696,7 @@ void bitmap_writer_select_commits(struct bitmap_writer *writer,
 			}
 		}
 
-		push_bitmapped_commit(writer, chosen, 0);
+		bitmap_writer_push_commit(writer, chosen, 0);
 
 		i += next + 1;
 		display_progress(writer->progress, i);
diff --git a/pack-bitmap.h b/pack-bitmap.h
index e175f28e0de..a7e2f56c971 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -127,6 +127,8 @@ void bitmap_writer_build_type_index(struct bitmap_writer *writer,
 				    uint32_t index_nr);
 int bitmap_writer_has_bitmapped_object_id(struct bitmap_writer *writer,
 					  const struct object_id *oid);
+void bitmap_writer_push_commit(struct bitmap_writer *writer,
+			       struct commit *commit, unsigned pseudo_merge);
 uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 				struct packing_data *mapping);
 int rebuild_bitmap(const uint32_t *reposition,
-- 
2.45.1.175.gcf0316ad0e9

