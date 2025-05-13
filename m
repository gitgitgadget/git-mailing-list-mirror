Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AF7226CFE
	for <git@vger.kernel.org>; Tue, 13 May 2025 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747134452; cv=none; b=YT4ks6YIWtLnPJsZqNzu/cdH3/UwPac5PkKtFk4Z9AM6NIOcxAokMHqKE21Hp67VUcY3cl5/rxgJZnvYufU+NmIdIjsRPhGMcHHzWfIFFr4Yu1D9jTNWjHMILrqNt0PS1CtAXd1bi+oBHUguKepzJshDsxRALK6mOk7M0TydsKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747134452; c=relaxed/simple;
	bh=Um0/8LEpxA9E1t3tKb68lDl+x7BGDftmf8iTQP/ypx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUUV853YufbRVzpmzOLxXXRuOowYYEKX8eSogm45+Qej4CfIscXQ1Zp8vweYrHHbj0yBcD3qg+J6w8KXn0SG7zh+TzEovP3wD1j0LgR6ikw36tED98oR+OdUDOuYvQ98VcNQDxHBSVhWtXL/9Lo6ekzOo81rjRD/3ifJ0pKo3Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juS0zZqs; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juS0zZqs"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7423df563d6so4021381b3a.0
        for <git@vger.kernel.org>; Tue, 13 May 2025 04:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747134449; x=1747739249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NwLV+retpTD8WCUZq02IOmw/0oExGsuHgY9JIDv2fEU=;
        b=juS0zZqsgpqPrmOJREvPFxljNL+6LI/lIoBMrdGFVt7L+25w5+mf1jkhqVSRCAc9KB
         3jiRhXrHMS0uzBcp0d8Z8iIzcHBisc5KdMIWNjIuLIja+6eNXcuJ3/EhX9zvxtM1Ju0T
         BxXWI62EnHXQz++GMl5RBGRr3WAWIuSQ69VI7GypMNHa+FqL95tQqW0P8q4x2QLtkJTs
         OAoRb4p4zaEEmkIpWH+jjRm5m6GPWi2MnnqXK79mhj1cvdNhpqoU8uUdIuPKLVAfzbIG
         qmr2a8ZxM1tpGkI4ISK84j14Kgc1tD3b9jZY1WSdAVJNUOezYxs5SD5PAYcwFNxAnYr8
         qTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747134449; x=1747739249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwLV+retpTD8WCUZq02IOmw/0oExGsuHgY9JIDv2fEU=;
        b=EpK38WeW/BiClNgRyQVmhlo+tZkv/iapWkTlqZOzLs3SZdtCdSEsUvxUVLmNR7M5pZ
         yx6N9Uw36ov2EToIOLNvF/AjGzcRz3pJvADSUwuCqxFPRZnRU9KOG4fRg6MaAkUSsKLm
         /o+52k48PAdW1HVn2/MgtRxkIGovP1VWrKC72owZ6fKz6//1FTiDX5sCKrw/6MvkuE1p
         n3Uxwi1EnIXGwyZzU810ZnyPlfaLal1VoGS5ykM42U5JRef5C/ZDHIi4cOu4mHcF5INm
         wj2E3qzOudbg8ZZUZMnZe9MclbOXmhZPE0VnrutR+K3sSjG4pT3xs3DzLM36Mamx/tXk
         hCMg==
X-Gm-Message-State: AOJu0YzwyAxkkNAhNiMELSY4pFOyMtBgqpoPiHhZd9LPsGGGH8A7hWAM
	S7GjZelvU5sfMfWRYQPaiu+rsYWh+SFFAm9kA3IkFVUTT3dsJcwIJrMAwg==
X-Gm-Gg: ASbGnctc6yW0W5z0bll24woi1F7RsPsZ15MQLuk4SoQhTuegS5OLmEIvRHXWLIk5QSY
	HBdjEfDAKGu9hTVMLPqeVKvmlPDqgJfHR7hxiyOP7OUhiYGn/mK8roItfABKlevaTjUBill9FE3
	7AdcMtgg5tJuQvdrDOO5gthYz7/Kt5yfXf4HeluJua591zdaPNQA7fyy1jY5oJRODmoYgNdSFDn
	babxCJP6azEZ4SRw/gOZ/HMQmTnHw8jI4NvKHP/MdbgbNE1VAbC5ufV/dJEQVDWrN01Gb7GD/if
	Zfk6mbtBwXRsodVGn49YPrcRm7rLdM3HOOIQAGd4DsfwM4c=
X-Google-Smtp-Source: AGHT+IGxgZK37ixueeFSB0lkd8neYbwnbdobIW6ePe0fVjOlVli/B+lWfCAr2CJF2kLqX6wG4aSE1g==
X-Received: by 2002:a05:6a20:438f:b0:1f5:889c:3cdb with SMTP id adf61e73a8af0-215ababd7e7mr23970153637.8.1747134449239;
        Tue, 13 May 2025 04:07:29 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b2351b7a6bdsm7055337a12.69.2025.05.13.04.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 04:07:28 -0700 (PDT)
Date: Tue, 13 May 2025 19:07:59 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 3/3] packed-backend: mmap large "packed-refs" file during
 fsck
Message-ID: <aCMoD-c_oHlu0c5c@ArchLinux>
References: <aCMnrwkoJ2WyqGZT@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCMnrwkoJ2WyqGZT@ArchLinux>

During fsck, we use "strbuf_read" to read the content of "packed-refs"
without using mmap mechanism. This is a bad practice which would consume
more memory than using mmap mechanism. Besides, as all code paths in
"packed-backend.c" use this way, we should make "fsck" align with the
current codebase.

As we have introduced the helper function "allocate_snapshot_buffer", we
could simple use this function to use mmap mechanism.

Suggested-by: Jeff King <peff@peff.net>
Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 1da44a3d6d..7fd73a0e6d 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -2068,7 +2068,7 @@ static int packed_fsck(struct ref_store *ref_store,
 {
 	struct packed_ref_store *refs = packed_downcast(ref_store,
 							REF_STORE_READ, "fsck");
-	struct strbuf packed_ref_content = STRBUF_INIT;
+	struct snapshot snapshot = { 0 };
 	unsigned int sorted = 0;
 	struct stat st;
 	int ret = 0;
@@ -2112,7 +2112,7 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
-	if (!st.st_size) {
+	if (!allocate_snapshot_buffer(&snapshot, fd, &st)) {
 		struct fsck_ref_report report = { 0 };
 		report.path = "packed-refs";
 		ret = fsck_report_ref(o, &report,
@@ -2121,21 +2121,16 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
-	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
-		ret = error_errno(_("unable to read '%s'"), refs->path);
-		goto cleanup;
-	}
-
-	ret = packed_fsck_ref_content(o, ref_store, &sorted, packed_ref_content.buf,
-				      packed_ref_content.buf + packed_ref_content.len);
+	ret = packed_fsck_ref_content(o, ref_store, &sorted, snapshot.start,
+				      snapshot.eof);
 	if (!ret && sorted)
-		ret = packed_fsck_ref_sorted(o, ref_store, packed_ref_content.buf,
-					     packed_ref_content.buf + packed_ref_content.len);
+		ret = packed_fsck_ref_sorted(o, ref_store, snapshot.start,
+					     snapshot.eof);
 
 cleanup:
 	if (fd >= 0)
 		close(fd);
-	strbuf_release(&packed_ref_content);
+	clear_snapshot_buffer(&snapshot);
 	return ret;
 }
 
-- 
2.49.0

