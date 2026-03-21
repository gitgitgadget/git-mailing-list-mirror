Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EBD31328B
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 21:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774128536; cv=none; b=ViwcHAoBUeHgk11A2L8CInfobaRVUTLyd2f3VWYmSSarm42rF+YRSRvLze/FCwjAE++4yW743XDwSDAaERTfQJyydGZoPj9hi9i8G6yTvuIMUgHi2CnusqH4QduWolfHfk6iIkBoI/FsT5LUOCX1fH80kNlNU/LccnEmx/XOh3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774128536; c=relaxed/simple;
	bh=K9dgfX79I0mEW+cClXl6wXJx3ql5MbgPH+lI2jUULzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtVPlD/43eReU8m8QqnZih4vEs1dffbMD7u4eE2DEbxPVOkKXFqMgl4Uhb5gtQ3jm9uJ2gM72eVegZx66hnsUxKuLtMqElDHbcy99OXYR/R3YMbCvWJowMt8G/H7EmhiKOBuQN21zJwn2Xj9l3YyUVfHMFKnSptpUCskiCfaf1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdJRdfSH; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdJRdfSH"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so2252500f8f.3
        for <git@vger.kernel.org>; Sat, 21 Mar 2026 14:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774128533; x=1774733333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2k34e0IwC1UNHVnOwXp3GyC2MjR6BG11sjNHpn9Z2Go=;
        b=SdJRdfSHPSjxFUzHxsYJzmsYVbFmGhy4kSbHb5GoIWKBaZfriAO9kRGYCrNjIqezZa
         hNMWfaVOtWj7JW2IGa0WJpPY11vrc41JF0Q5ZHRvG6nmuKnvrXpwZ+hbppD+1IgZehWs
         r/xrjXfedOY8SV/rjuS1CsDHGFSTaOud9o63vfpTOkzr3JqCli7WvJXIV/P648fj1KUN
         tDLP7GiZgJvsLH1tmMgUnALIAAfb+bZPPI6yzefrXL6IbMEZAhk0FY8ikVeXi4gf0+2E
         wEuoXbLsZ7r30Dc+SGLSs7TKeSpVysiYBZHfRdjtbnKK5JOcRwt9tA6jIbq2ZyvTXhaY
         c1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774128533; x=1774733333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2k34e0IwC1UNHVnOwXp3GyC2MjR6BG11sjNHpn9Z2Go=;
        b=GlOwt9JS+s6r8relb4HAB0gv2YIOS9aY9B2OZXxvc/9JT3XRE8bNw2yikMCQMddk+I
         0c0b90Pya1qVaO+5z+H6SZMCy1P3kJMnE6SRJM2QZDAr28JlcMVrBaFQrIk2Z1TS6Mik
         Q6QnnGSvXVSkJbZe1+EgF7L1HJm8fO4OYIyMHExT16mUOzxJxKaLstzy85As988YFSxu
         5nso7vgZS7qP9WJIzCMeZnOPUd4Lv2UuRJUZ9qMbgnUEcmbPFjFZ5XKqHwnHT9KgCumU
         y29P/xuxSfWHgyJrmtkD0dXrriDUsdjL42YgiqFoXFFuOWSu0b91DzZTAuRPW8FCdQ9O
         SRNw==
X-Gm-Message-State: AOJu0YwWfkEhcjQl8+X8FfVA50bnAC27H/64urP1SyVWwEnpb1hCU4zW
	WXmy3bOHO8Orw3UwH/QVxnoKxR3jiqsqwSLXzXpX4gb3h1qSyLsQDmy8aTX80SkalFM=
X-Gm-Gg: ATEYQzzt4rA7vBs2gHIWLRCwB16aFIlzUoQ+I5zyT2F3ljSuyyp4aAXwex1yv1BT4MC
	rM9TYsBAQXiHe8dO615l4gpT+9iuaOI6QJuoLyl9LRZMKZRoGI9k7Pqffn+39h3rdyDClV0FV6C
	gIhTrmRmu3KzvlH/yHVK175g2oEzAE/nouPonEG23xjOPhvTLToE73JB9aVlXjV0fGSHUUwHmUQ
	2/CydpbUEej7kMDWFwfwgECKpu8EtXHzToFtpPzbGB0rZcKVX7m8/MpFvAfJDFW/9Nh4ODK/uxM
	f4e+Dn+4i6VgSKoBNxaSOH2Gnmff+bw3XlqbeB1o8WKwECTkZk4yhiGlhjQK0mT5iu7ZYBEDGiG
	9MnTVEFn0i4tUuLFWwl6RwEjEoVAP0Y+I6Ke3QTYeCkoFop45ljluvncofzj2isjDylzM6NN63I
	wMy6vgE/Kb1h4WKZjFvkQ9jHpTGtallFX0
X-Received: by 2002:a05:6000:184d:b0:439:b203:7711 with SMTP id ffacd0b85a97d-43b642405cfmr11964248f8f.3.1774128533266;
        Sat, 21 Mar 2026 14:28:53 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd0dcsm15334856f8f.11.2026.03.21.14.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 14:28:52 -0700 (PDT)
Date: Sat, 21 Mar 2026 22:28:51 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH 2/3] pack-write: add helper to fill promisor file after
 repack
Message-ID: <3c0702f81b3e4a57cd38284ab90f8277da3fcd40.1774125871.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1774125871.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774125871.git.lorenzo.pegorari2002@gmail.com>

Create a `copy_all_promisor_files()` helper function used to copy the
contents of all ".promisor" files in a `repository` inside another
".promisor" file.

This function can be used to preserve the contents of all ".promisor"
files inside a new ".promisor" file, for example when a repack happens.

This function is written in such a way so that it will read all the
".promisor" files inside the given `repository` line by line, and copy
only the lines that are not already present in the destination file. This
is done to avoid copying the same lines multiple times that may come from
multiple (redundant) packfiles. A better way to achieve this might be (is
definitely) possible.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 pack-write.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 pack.h       |  1 +
 2 files changed, 63 insertions(+)

diff --git a/pack-write.c b/pack-write.c
index 6a2023327e..3620e6bd02 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -621,3 +621,65 @@ void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_
 	if (err)
 		die(_("could not write '%s' promisor file"), promisor_name);
 }
+
+void copy_all_promisor_files(struct repository *repo, const char *promisor_name)
+{
+	struct strbuf promisor_source_name = STRBUF_INIT;
+	struct strbuf read_source = STRBUF_INIT, read_dest = STRBUF_INIT;
+	struct strbuf write_dest = STRBUF_INIT;
+	int err;
+
+	FILE *dest = xfopen(promisor_name, "r+");
+
+	struct packed_git *p;
+	repo_for_each_pack(repo, p) {
+		if (!p->pack_promisor)
+			continue;
+
+		strbuf_reset(&promisor_source_name);
+		strbuf_addstr(&promisor_source_name, p->pack_name);
+		strbuf_strip_suffix(&promisor_source_name, ".pack");
+		strbuf_addstr(&promisor_source_name, ".promisor");
+		FILE *source = xfopen(promisor_source_name.buf, "r");
+
+		/*
+		 * For each line of the promisor source file, check if it already
+		 * is in the promisor dest file. If not, add it to write_dest, so
+		 * that it will be written in the dest file.
+		 */
+		while (strbuf_getline(&read_source, source) != EOF) {
+			if (fseek(dest, 0L, SEEK_SET))
+				die_errno(_("fseek failed"));
+			int is_source_in_dest = 0;
+			while (strbuf_getline(&read_dest, dest) != EOF) {
+				if (!strbuf_cmp(&read_source, &read_dest)) {
+					is_source_in_dest = 1;
+					break;
+				}
+			}
+			if (!is_source_in_dest) {
+				strbuf_addbuf(&write_dest, &read_source);
+				strbuf_addstr(&write_dest, "\n");
+			}
+		}
+
+		if (write_dest.len) {
+			strbuf_strip_suffix(&write_dest, "\n");
+			if (fseek(dest, 0L, SEEK_END))
+				die_errno(_("fseek failed"));
+			fprintf(dest, "%s\n", write_dest.buf);
+			fflush(dest);
+			strbuf_reset(&write_dest);
+		}
+
+		err = ferror(source);
+		err |= fclose(source);
+		if (err)
+			die(_("could not read '%s' promisor file"), promisor_source_name.buf);
+	}
+
+	err = ferror(dest);
+	err |= fclose(dest);
+	if (err)
+		die(_("could not write '%s' promisor file"), promisor_name);
+}
diff --git a/pack.h b/pack.h
index ec76472e49..509e90edba 100644
--- a/pack.h
+++ b/pack.h
@@ -105,6 +105,7 @@ char *index_pack_lockfile(struct repository *r, int fd, int *is_well_formed);
 struct ref;
 
 void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought);
+void copy_all_promisor_files(struct repository *repo, const char *promisor_name);
 
 char *write_rev_file(struct repository *repo,
 		     const char *rev_name,
-- 
2.43.0

