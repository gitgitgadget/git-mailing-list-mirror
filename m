Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE3C181318
	for <git@vger.kernel.org>; Tue, 14 May 2024 19:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716631; cv=none; b=KqVsb2oa3UAvUSQzZgzFoSnLhMafcQDXKx4p1+PDBThoS+y0aaPKMIq0hACkIovhLMDaYPqXd3EZ+4VlYjAIDGCfaujjEEh0quOlPnRoTVAovoDBB9dXYSP6wmvBmDL+3vGUmwVmIrwatJO73RmYfNvPn50cJ01dFYy/mhGxJzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716631; c=relaxed/simple;
	bh=T1NtMAMuReya1kZzMDsEaWvRJdt5rM5vXjCrr0ZDE98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Apsp4BuM6EHtYaEZ3LrUD/06WSaJtNkpKIvxY9UMUV2dXJHM4eJnmf4Zwod6AJGurwea38GbPjoS4tmGA6U9709wnfZod6Zab2EVfpuNQvxmUMN4xMux13d4B8nZJ87KsTU/jwDdXraSynrI/o0LQYncmGIUZe2r7K9R2OqvvmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=2z/aLNmG; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2z/aLNmG"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-69b4454e2f1so19043156d6.0
        for <git@vger.kernel.org>; Tue, 14 May 2024 12:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715716629; x=1716321429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NIxL665DLt7fNGh/Hz5PY1VgAibPgHVSqFosj4OscVs=;
        b=2z/aLNmG5pB33RsEVxnq8ctes98mA1omvU+wX6cLF7++Zjq2+S/prGStrbggdbT0mu
         jUU5zBF/SBqxSaKU0/TBiAp/eVzcWXYyKpMWb8zd+jphLMy06mFkDkzy6f+WVR3leKXu
         lp1Z/UnzeVXg7Cl4fvVo9ImA/b22nX9/mt0d0YV2Tzl3z2OSTX4F5iAflJjyZ39kAAB/
         P0nqHhkoBnzN/yfVg7vmb6xsn4T8Ki0z6qQh209Z5MGK+nx9LizaglY9g0Ko7kLeB2Du
         EaMpevvFbE0ibjAdfjRK6/VkIGMMcFoLvSr5r98JLA4yLE1MTiH1yGIogMPMWEboYcrW
         3bGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715716629; x=1716321429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIxL665DLt7fNGh/Hz5PY1VgAibPgHVSqFosj4OscVs=;
        b=vVW5GwLpP4thC6HsNpsVZNJu42sI3s+PqSP18H8Y6zihZ993fvIiw2jD6tBGV30qE8
         fDACtr+WlvOrJo15ff9oELXOs0sma+IQPnTCN6JBMIAMLcDeDjS8Fyf5VJLFfdnnbANd
         Wuh5Hvpz3U+e07HMn38X9cvi2s8bM/BsJThjL0WsROOQeke7H/GaqaPhM4ZUcT0p1VqK
         6oJqb+yEeSEs/WbNtfi0K9vdO+AbaO6T0npTRvOaNA35BbSxlL6+IQiA13+4KCQWu0as
         rNC5i8qfcWgLQrNlGfEVUmsc52FRUjtO1qk8OaJQDgPw+/c2bmXB2G03A3B6+OEA6OqP
         dc1w==
X-Gm-Message-State: AOJu0YwOJlMzn0IqZZ16M0ii4NHT4nqgho4PAJNLlm3ODjdm5cNJoA37
	ibNt2Pj1sP0l+PWMzTosUFSZK6jmDUJ5T5VmRMBpBTCc5Y61yEIQJYZ0FBQAwDiw62aT8FV97d7
	q
X-Google-Smtp-Source: AGHT+IHnTEF8rMPuPzTok8LQKbS2Dcq4oDMeJTQLIRPY98WBu7dJ2dHNmfrjsGbQdPnr+tTh7aVm7A==
X-Received: by 2002:a05:6214:5988:b0:6a0:4fda:af51 with SMTP id 6a1803df08f44-6a1681b4514mr173170306d6.37.1715716628733;
        Tue, 14 May 2024 12:57:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1cd22dsm56630156d6.100.2024.05.14.12.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 12:57:08 -0700 (PDT)
Date: Tue, 14 May 2024 15:57:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/6] pack-bitmap: introduce `bitmap_writer_free()`
Message-ID: <bf65967764f34adc2ca00d4c8195840ad3e4e127.1715716605.git.me@ttaylorr.com>
References: <cover.1715716605.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1715716605.git.me@ttaylorr.com>

Now that there is clearer memory ownership around the bitmap_writer
structure, introduce a bitmap_writer_free() function that callers may
use to free any memory associated with their instance of the
bitmap_writer structure.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c |  3 ++-
 midx-write.c           |  1 +
 pack-bitmap-write.c    | 23 +++++++++++++++++++++++
 pack-bitmap.h          |  1 +
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 10e69fdc8e..26a6d0d791 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1245,7 +1245,6 @@ static void write_pack_file(void)
 	uint32_t nr_remaining = nr_result;
 	time_t last_mtime = 0;
 	struct object_entry **write_order;
-	struct bitmap_writer bitmap_writer;
 
 	if (progress > pack_to_stdout)
 		progress_state = start_progress(_("Writing objects"), nr_result);
@@ -1315,6 +1314,7 @@ static void write_pack_file(void)
 		if (!pack_to_stdout) {
 			struct stat st;
 			struct strbuf tmpname = STRBUF_INIT;
+			struct bitmap_writer bitmap_writer;
 			char *idx_tmp_name = NULL;
 
 			/*
@@ -1370,6 +1370,7 @@ static void write_pack_file(void)
 				bitmap_writer_finish(&bitmap_writer,
 						     written_list, nr_written,
 						     tmpname.buf, write_bitmap_options);
+				bitmap_writer_free(&bitmap_writer);
 				write_bitmap_index = 0;
 				strbuf_setlen(&tmpname, tmpname_len);
 			}
diff --git a/midx-write.c b/midx-write.c
index 78fb0a2c8c..7c0c08c64b 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -853,6 +853,7 @@ static int write_midx_bitmap(const char *midx_name,
 cleanup:
 	free(index);
 	free(bitmap_name);
+	bitmap_writer_free(&writer);
 
 	trace2_region_leave("midx", "write_midx_bitmap", the_repository);
 
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 420f17c2e0..6cae670412 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -32,6 +32,29 @@ void bitmap_writer_init(struct bitmap_writer *writer)
 	memset(writer, 0, sizeof(struct bitmap_writer));
 }
 
+void bitmap_writer_free(struct bitmap_writer *writer)
+{
+	uint32_t i;
+
+	if (!writer)
+		return;
+
+	ewah_free(writer->commits);
+	ewah_free(writer->trees);
+	ewah_free(writer->blobs);
+	ewah_free(writer->tags);
+
+	kh_destroy_oid_map(writer->bitmaps);
+
+	for (i = 0; i < writer->selected_nr; i++) {
+		struct bitmapped_commit *bc = &writer->selected[i];
+		if (bc->write_as != bc->bitmap)
+			ewah_free(bc->write_as);
+		ewah_free(bc->bitmap);
+	}
+	free(writer->selected);
+}
+
 void bitmap_writer_show_progress(struct bitmap_writer *writer, int show)
 {
 	writer->show_progress = show;
diff --git a/pack-bitmap.h b/pack-bitmap.h
index b2d13d40eb..3091095f33 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -139,6 +139,7 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 			  uint32_t index_nr,
 			  const char *filename,
 			  uint16_t options);
+void bitmap_writer_free(struct bitmap_writer *writer);
 char *midx_bitmap_filename(struct multi_pack_index *midx);
 char *pack_bitmap_filename(struct packed_git *p);
 
-- 
2.45.1.151.g7cc3499008c
