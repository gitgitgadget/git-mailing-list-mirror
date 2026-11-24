Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543558;
	b=LH6iqGlThwL+KRTtlYJrAYyO7cgzKkQdXp2EHUv379zbgd3mCA7f6fDuA0M4Ac3h7Res
	 jMXCclxzx5DM30X31+/nkdToHMCWTUvkZ5G3ZdUMY7BuWwhoOzoJVzC8GiNgSPGz/NNHl
	 G/fr3joSVuXco3kbM6L8je0htsyO/C7ojHv/yGjtRW9+gvwer1C5bH7xSEhXONeMwY47B
	 y44t/Caads/hIIc81Qw/H7A6N7VWKLJbFAIVPzmPZcDKuv2G5Vqysof2s/npc13L6pGvd
	 zYC2fjS+Ne55QhSx49dHO6KrE8TScCEbaBb5YDjKeX/+DYo0DYpXYIMKrZ4JQoPQZQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=fvYl3MLfjv/gDr9vUPZXIoC3DjMyB2H4BYVV2GF8/Rg=;
	b=o5bIHNwYYyDC7/1u94dcEOucGuH2qQ/OsGf3bPyBO9iXwI49Lu2LVU+U+LoHn5/XpEan
	 oiZO0mfQYmTUnuo8IS4vr+zQCr0huNnyF3mpPAN77slAiEtmtHYq7X6BQGmn1h4AeA8/W
	 keC7ckxRXkI4hHyWQ9gsb5P54rVHPBnbKLkDJ4uKgfcgCy8JHYkDESoHjP3oq7wKFbO7B
	 Xi03JFMFybNBz3VWRGWAM9r2McOxpXS3nYfxFUvekXvKFxdDW7aNaQ2gKHCXQ+v/+DCEB
	 7wIM0W3BLx1IeNV1q9AganY2rSXuoZC0O5EOEKQnh7MFFlLZzVBgI1lijs3sSFxxKSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ge7Jbqqf;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C4C606A33E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 18:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74C4C606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ge7Jbqqf
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1f03f2e8aso41605695e9.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 10:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795543555; x=1796148355; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fvYl3MLfjv/gDr9vUPZXIoC3DjMyB2H4BYVV2GF8/Rg=;
        b=Ge7JbqqfVbs1bkJLdaV0jsuUbxlEJ1j/YG18cvPykP/jutDhmzTN/EVOv1LipEL2z1
         RAJ64P6V2+g7sL/7xYjTSIAPWdNhyGJ5SHUhT2ySsiS3Z82X8t0lDCfbgYey1acUdLI0
         /N82VUG7v3cqxtMtnCBgYzMMkoV/92zz7gUgIzr66AYTWDsLeTJ+hdvFrIYirYyGjwEZ
         nrpuEL1IOahrXxQ3Ou4g7dVZeSn97ct31eE9mOOjBFEcFtu9Nwvq7F0rusbVH3IR8+TL
         xkuworW+UVlOpoSs3iAImfpFBC4fAav4jdln1wPPp5PViVCXgH0TS55Be62vL/PtelZJ
         0ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543555; x=1796148355;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fvYl3MLfjv/gDr9vUPZXIoC3DjMyB2H4BYVV2GF8/Rg=;
        b=nhCE9zzZHU2lgjtS/Y9VRHbR47U49TW5TCgHHvDe6uTQ9YWktD69z6263BvoVcvIxl
         rL3HVM7dFrs2VymfrMKFkqsT2t5HZvMRz/7YrhylUjRd3vB/C759n0EJ+AE2TNcGKbGt
         IifHqVz5OCmn+2NG+WsEntAHKHRR5MwFWyG+sAILryQds3UeAbauQR8py3c9NSHVazKp
         oIx/3FfbsZlP2aC9VvwqnE7bWsgZR2QhXolZG5GwM3RxXaC+EaezMt2vFbyctmoplkV/
         0gpdlKEZGMoq4kG4PPhJ4CYF+A7JMj+Fs+5BZ9qK+jKquF3fUJLu/b5x5C3zPSsvoEb1
         ieFw==
X-Gm-Message-State: APuU4Z/7JBV6AXeFTZBE2Jt95vnJMSfhcq2mq21LzP4C6h0iI1hGBvtp
	6ZT1ZGexnH+R9t5k+U4zZCwXfGy6/H4eXzlnMFr1bOvf3uQkY2X2PHCyV8QDN174sUqcsBiY0cn
	WGn7f43dko/uoheEsp4NZK0OfWaKHGySlKB1QLIxgi/5zftET/U6xcoad6aw/vjaRt25bLywvoN
	02a2Qlqw9mtTlCuglkwUdmQA==
X-Received: from wmbfl25.prod.google.com ([2002:a05:600c:b99:b0:4b2:2ec5:89f8])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8b11:b0:4a1:df52:3e36
 with SMTP id 5b1f17b1804b1-4bb8881d194mr324775455e9.27.1795543554474; Tue, 24
 Nov 2026 10:05:54 -0800 (PST)
Date: Tue, 24 Nov 2026 18:05:49 +0000
In-Reply-To: <cover.1795543448.git.dmnk@google.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119192311.2685319-1-dmnk@google.com> <cover.1795543448.git.dmnk@google.com>
X-Mailer: git-send-email 2.56.1.663.g77904e546d
Message-ID: <72c0d0c0a43cadcc61f0187c86b9bd9361079a42.1795543448.git.dmnk@google.com>
Subject: [PATCH v2 1/2] archive-zip: fix prefix stripping for extra and
 virtual files
From: Dominik Maier <dmnk@google.com>
To: git@vger.kernel.org
Cc: "=?utf-8?q?Ren=C3=A9_Scharfe?=" <l.s.r@web.de>, Junio C Hamano <gitster@pobox.com>, dmnk+artist@google.com
Content-Type: text/plain; charset="UTF-8"

write_zip_entry() unconditionally computes path + args->baselen before
passing path_without_prefix to entry_is_binary(). That matches tracked
tree entries, which always begin with the final --prefix stored in
args->base.

Extra files added via --add-file use the per-entry prefix recorded when
the option was parsed (info->base), and entries from --add-virtual-file
do not carry --prefix at all. When a later --prefix is longer than the
extra or virtual file's archive path, path + args->baselen steps past
the end of path (and for --add-virtual-file, looks up worktree
gitattributes along an arbitrary virtual path).

Update args->base and args->baselen to each --add-file entry's recorded
prefix before calling write_entry(), and clear args->base to NULL for
--add-virtual-file entries so entry_is_binary() falls back to content
inspection instead of path attribute lookup.

Signed-off-by: Dominik Maier <dmnk@google.com>
---
 archive-zip.c          | 5 +++--
 archive.c              | 4 ++++
 t/t5003-archive-zip.sh | 5 +++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 279c3a2d72..db4a96553b 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -271,7 +271,8 @@ static int has_only_ascii(const char *s)
 static int entry_is_binary(struct index_state *istate, const char *path,
 			   const void *buffer, size_t size)
 {
-	struct userdiff_driver *driver = userdiff_find_by_path(istate, path);
+	struct userdiff_driver *driver = path ?
+		userdiff_find_by_path(istate, path) : NULL;
 	if (!driver)
 		driver = userdiff_find_by_name("default");
 	if (driver->binary != -1)
@@ -301,7 +302,7 @@ static int write_zip_entry(struct archiver_args *args,
 	struct odb_stream *stream = NULL;
 	unsigned long flags = 0;
 	int is_binary = -1;
-	const char *path_without_prefix = path + args->baselen;
+	const char *path_without_prefix = args->base ? path + args->baselen : NULL;
 	unsigned int creator_version = 0;
 	unsigned int version_needed = 10;
 	size_t zip_dir_extra_size = zip_extra_mtime.len;
diff --git a/archive.c b/archive.c
index 59790be986..2348ab12ed 100644
--- a/archive.c
+++ b/archive.c
@@ -351,6 +351,8 @@ int write_archive_entries(struct archiver_args *args,
 		put_be64(fake_oid.hash, i + 1);
 
 		if (!info->content) {
+			args->base = info->base ? info->base : "";
+			args->baselen = strlen(args->base);
 			strbuf_reset(&path_in_archive);
 			if (info->base)
 				strbuf_addstr(&path_in_archive, info->base);
@@ -365,6 +367,8 @@ int write_archive_entries(struct archiver_args *args,
 						  canon_mode(info->stat.st_mode),
 						  content.buf, content.len);
 		} else {
+			args->base = NULL;
+			args->baselen = 0;
 			err = write_entry(args, &fake_oid,
 					  path, strlen(path),
 					  canon_mode(info->stat.st_mode),
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index c8c1c5c06b..75e3b331af 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -229,6 +229,11 @@ test_expect_success UNZIP 'git archive --format=zip --add-virtual-file' '
 	)
 '
 
+test_expect_success 'git archive --format=zip --prefix longer than --add-virtual-file path' '
+	git archive --format=zip --prefix=very-long-archive-prefix/ \
+		--add-virtual-file=a:hello $EMPTY_TREE >short_virtual.zip
+'
+
 test_expect_success 'git archive --format=zip --add-file twice' '
 	echo untracked >untracked &&
 	git archive --format=zip --prefix=one/ --add-file=untracked \
-- 
2.56.1.831.g720f3f5937-goog

