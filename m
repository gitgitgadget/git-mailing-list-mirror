Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD2B13B7A3
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 19:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774207092; cv=none; b=t6mPVA/iky9oME8D54svVb4mLGHMhYaVJi/SlTZnRpCBUGm6CMT8WKCwtd5i9tEze7Ka33+i8Uk4QqPkvMPn5xlLZ/U/R3xjUIN/KPrsRjnGwDhLKi6AA6gJ2jC1NmisT5WX7EsosLQXtOVdOugKMUAgyvnO37S35GvSJRzN+4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774207092; c=relaxed/simple;
	bh=liQWu0doGygjiiKkKhcL99w0FUN1tCzDy9W4qQ5Rc+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8KDq6W8yXagtVHKUinMtGB2+pxQBe6AyvBIF5FtzckDE6JSe0unOmDbMsQmZko6Vpy+Xe79Xnotz8OjC4ia/TRI47dqZKc20zkl/CdT5Xnrdya0Sa6CqTMIUd60mbBiGsF7Z3bxKtbupfSDIlMm+fwQ7HQYKULUA5cIk62t5Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkan9/cJ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkan9/cJ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso28113275e9.2
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 12:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774207089; x=1774811889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qrslvx75J4KeY8yOBFiWRR0Vypdy0JZHza06jZ+jQrc=;
        b=dkan9/cJpOHX23xnfRR9QgRo75/+NjghLk1yVQcYaAdrdS1NanlQ1MnKGwfdeYyBaJ
         daN681nl0Rl/jrIqhkkKkYyU6hogtNn9/1GQlnFufJmUkhh1s5k3rHDsSTy2yCp8zOEI
         6ic9D/hxkU95veEGGy2vV1kRNoB5JK/pjwEIh9ABvwHIqSyUtyeOq07wG7tzx7slX6oL
         gM/sP3xGuJ8wNdK0Raeml+2fIyXJRGYLAv1YMvtUyEbMguUq83FE62MukOk+7P886LmM
         VjHJdB+PqjE+XiuDO+KrfbRp0pDDRHBwMvt3wVYGiJ2DEhZZUj+DOCrRxZwCz9jCbJpw
         ybAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774207089; x=1774811889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qrslvx75J4KeY8yOBFiWRR0Vypdy0JZHza06jZ+jQrc=;
        b=ro/4qDvneLO7QW+SubMHDjIKTxNoNRdzgMRIgAjoU+/UGzHv1xoMFUeuYO8rG/Em50
         7AJLq9xGIiqqx0x2qumh7ahatudyfGNGmKkD4fxrgdFH7KeZ5I0FiPfoyWqbKXlSMCwt
         XjAJIEMaQ07vuck06bYIVCV9+Yt72tONR0OGJDqUD9AgOPZ+/reIFHroHO+LKB7nXM91
         H6o/as3bEFnXa3CeeiP/1pIUv40DqxoZzPG+mMiec2IxB/t6V892iQSTZ+D7kIGPma3M
         91GcsPXHobHh8563b5hUUemEsc6uyuMFF5C0yiuG8qieeOSTuzfmKJKHZU8t/3gHB+gw
         /iGg==
X-Gm-Message-State: AOJu0YwwdpoOPNCxv00huej6zUneRjHtJoiDcuyQGzj/mzkKwlfgOFtb
	rowWMG5U32adKjXKZBpkppOOBQ+ACOafASStJ9/azWvSGzynAM7EAQ6cY8i1le/2m0E=
X-Gm-Gg: ATEYQzzkmRsAXQC9JhhVFu7vt0OM5j92DRxIANIPUmxHMDKWN4CzEzwX9pg/axQdkMv
	QGRADEqxgvlXayKvLf9teHlz4Wpqm3CDsQR0HS0OZFOh3Xm7lRSEzhhOFyYoI1LlgU0MeLeXgLg
	biJwNXq3cdn0N0x9sLBaryKt82gdbvuk7Y1DoBkWV7s1+oIvZ3qwww3SYU6f4Ao42KpwvumzqET
	6skbFaMQGlTjaDtIJpIZuAd8Bk7xVmdKU1D+zNZ6z/nHCMekaxhUP7h3JvJUpAUafT/FFP4Vic9
	Pyu/Ww7n2NTAJ6zgeJOTUY1uiEnq+Bo0ZFPiekxE/xJyezaWVHOxewkHcI3lOZRQbFj4X1O+B7Y
	NZ2BIhkMXKWm/iakeW3rLHwcwWfOYY4+mWZ5RYOQiuTrCFc4mS9np5q1EAc9XqhrLb8bq5bRkW/
	H0AeqouaTUdxq4U3GtFaQZWsz/QC/vVxPJ
X-Received: by 2002:a05:600c:1f0e:b0:486:5f71:5829 with SMTP id 5b1f17b1804b1-486fedab740mr141387445e9.5.1774207088829;
        Sun, 22 Mar 2026 12:18:08 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff1dd9f1sm92760995e9.8.2026.03.22.12.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 12:18:07 -0700 (PDT)
Date: Sun, 22 Mar 2026 20:18:05 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC PATCH v2 2/4] pack-write: add helper to fill promisor file
 after repack
Message-ID: <0bb031e7443bb53abbbb0afaa347285d6d8cf7b8.1774205661.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1774125871.git.lorenzo.pegorari2002@gmail.com>
 <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>

Create a `copy_all_promisor_files()` helper function used to copy the
contents of all ".promisor" files in a `repository` inside another
".promisor" file.

This function can be used to preserve the contents of all ".promisor"
files inside a new ".promisor" file, for example when a repack happens.

This function is written in such a way so that it will read all the
".promisor" files inside the given `repository` line by line, and copy
only the lines that are not already present in the destination file. This
is done to avoid copying the same lines multiple times that may come from
multiple (redundant) packfiles. There might be another better/cleaner way
to achieve this.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 pack-write.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 pack.h       |  1 +
 2 files changed, 62 insertions(+)

diff --git a/pack-write.c b/pack-write.c
index 6a2023327e..583e40b423 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -13,6 +13,7 @@
 #include "path.h"
 #include "repository.h"
 #include "strbuf.h"
+#include "strmap.h"
 
 void reset_pack_idx_option(struct pack_idx_option *opts)
 {
@@ -621,3 +622,63 @@ void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_
 	if (err)
 		die(_("could not write '%s' promisor file"), promisor_name);
 }
+
+void copy_all_promisor_files(struct repository *repo, const char *promisor_name)
+{
+	struct strset dest_content = STRSET_INIT;
+	struct strbuf read_line = STRBUF_INIT;
+	struct strbuf promisor_source_name = STRBUF_INIT;
+	struct strbuf write_dest = STRBUF_INIT;
+	FILE *dest, *source;
+	struct packed_git *p;
+	int err;
+
+	dest = xfopen(promisor_name, "r+");
+	while (strbuf_getline(&read_line, dest) != EOF)
+		strset_add(&dest_content, read_line.buf);
+
+	repo_for_each_pack(repo, p) {
+		if (!p->pack_promisor)
+			continue;
+
+		strbuf_reset(&promisor_source_name);
+		strbuf_addstr(&promisor_source_name, p->pack_name);
+		strbuf_strip_suffix(&promisor_source_name, ".pack");
+		strbuf_addstr(&promisor_source_name, ".promisor");
+		source = xfopen(promisor_source_name.buf, "r");
+
+		/*
+		 * For each line of the promisor source file, check if it already
+		 * is in the promisor dest file. If not, add it to write_dest, so
+		 * that it will be written in the dest file.
+		 */
+		while (strbuf_getline(&read_line, source) != EOF) {
+			if (strset_add(&dest_content, read_line.buf)) {
+				strbuf_addbuf(&write_dest, &read_line);
+				strbuf_addstr(&write_dest, "\n");
+			}
+		}
+
+		err = ferror(source);
+		err |= fclose(source);
+		if (err)
+			die(_("could not read '%s' promisor file"), promisor_source_name.buf);
+	}
+
+	if (write_dest.len) {
+		strbuf_strip_suffix(&write_dest, "\n");
+		if (fseek(dest, 0L, SEEK_END))
+			die_errno(_("fseek failed"));
+		fprintf(dest, "%s\n", write_dest.buf);
+	}
+
+	err = ferror(dest);
+	err |= fclose(dest);
+	if (err)
+		die(_("could not write '%s' promisor file"), promisor_name);
+
+	strbuf_release(&read_line);
+	strbuf_release(&promisor_source_name);
+	strbuf_release(&write_dest);
+	strset_clear(&dest_content);
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

