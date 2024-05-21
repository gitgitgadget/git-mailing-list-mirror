Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02AD149C76
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318150; cv=none; b=itjh1NYSP/iSUqZ98kqLeJkhAy9OHWkUns67uVnTdX6LG1x2ORlSd6aKN9BmGTDjf8AdLiBW5RHTgZigGxXKnVYF72pVX+BleDS36xeH8BRZaKglWRUkoYQKMn6Q3Ur43Mv60tqKnEVCsHAuS2pUIW+6V/vOTq9CPXMvjqW+D+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318150; c=relaxed/simple;
	bh=zL05U430trYyComy5YdiFkSKQLavhhq4cnAd8gCqg8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/82JiX+TyUebUvDn+2oomwIt78BO1K1+luMv3/akwsoWweMtbVDrIf/7yCnudRr8AO01Sj20D7o0u5mfHr+FFPAyUA78v1rF2Ob7Y8+QR5MUSbYtLPNZZvMRAFiigZuADNSIZTz8WIVSIolBXObAyrWndYKWZyfvIoK9n3CPyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cpAp8WOH; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cpAp8WOH"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-792b8ebc4eeso327781685a.1
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318147; x=1716922947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5LVBX3huhz0FjivVPIfYgyVZqnbwrn+QLqnbungBDDY=;
        b=cpAp8WOHD08Axn2DBD15qpzMx/c8Q5epLWXd7Y5WfM/950pc8BSD7nr0ayFN4aEAkY
         JiM5Z8nPPwJNNHRuYnVF4ugwDNnculKP/fmySruB/IttAPkIwj5q9SyH3yjPiNZo+i6L
         arjAjXpa1x2IcjcR4XXMORQFRImOSL7avWynovrfQOLzGGX6hk9+i3CBZV8D7Ef/Uc/l
         z5r+U+Y623bbzkmu1AN46V+VoCTcJz8fqo81ouSmEUBu3LK1ShnPKOiRro+JfZIZph0M
         Zz05W8N4dleukzpshwhheVTmHBmaLMBpN8sK7X0UPL3+NLxhyojuA1cAqu77/vOuGgFr
         0mQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318147; x=1716922947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LVBX3huhz0FjivVPIfYgyVZqnbwrn+QLqnbungBDDY=;
        b=FgMhmvduDuX2lr3zL8Bg7PaIh51eNLdyy/wzW8ta4o9L+nGPVafv7AaAky73tJfYKj
         Glr/fG/s5ngrt1t1nakzOQT8NqmeeVzzYxQ3Y87dNbjL5MOQ0Yd3V+NpkKfAo8JKN2Ge
         UryAn8mnyTgM7lw6GLQqSbas7vpX6O6TtJaRe3tU/zqxusZnyym2M9X+6nHAOP79LRQc
         srw7AXDMvMRARjfhsIAVr1WRJGkW3WT/RNB+AgEa0OjCfuh0f/D+hnaUEv69XkDf+Jkr
         73NXxt1FFPUW8j0HsYkqs1Hb1i2kVCLuC7FAUPjhUpGPveAFYkMuTa67fl6U+JN5z60d
         Py4Q==
X-Gm-Message-State: AOJu0Yy+yTHFnSO37W0lN0hgDKfbKnH8BmCcawtLPRZYsa5QmPCL5NVk
	dqQ/mDiem/UrB2y+eHM2iCHI53h1gvbioF2x8fBUFDfXZ0ofyn3ZQX240qYzB4KoZAiJiZw5mlL
	U
X-Google-Smtp-Source: AGHT+IF6Ur8LVPX6MP40q9VCIxjlrLCZTtg95Si4aZspDnikJI5elZcYYVk111qQEWW/TKpzYrPRug==
X-Received: by 2002:a05:620a:118a:b0:790:6aa4:d068 with SMTP id af79cd13be357-792c75763b0mr3498910785a.15.1716318147490;
        Tue, 21 May 2024 12:02:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf27fdf8sm1313638385a.44.2024.05.21.12.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:02:27 -0700 (PDT)
Date: Tue, 21 May 2024 15:02:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 15/30] pack-bitmap: make
 `bitmap_writer_push_bitmapped_commit()` public
Message-ID: <e7209c60fa546230bacd169cd28710651b19c39d.1716318089.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716318088.git.me@ttaylorr.com>

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
2.45.1.175.gbea44add9db

