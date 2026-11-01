Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793522704;
	b=yR7g7DQXypQ65HJmPYe/oK4997hVurDHIw+g9xhFwd4DT0K3QRnpQDgLm0FMl3eLVHgN
	 IvySYtwGgaTHjULa9XfKDaGFO41Zn04YPYYVUh9pZxQJ01J0UuhdSeRjgFBaoG/A1QQN9
	 y3qtrg+jXGB+WPfi5fqK301KKg7RpW4S72m/wgTy2p55z0SGSV5vKoQeRk2MAVU5IB4Ls
	 SoN2PKhUcLPKimFxldAcDWA7DBdNMOvaUv6VEXKYfiTOm6uyQVDuXjq331u3n2b+MAq2+
	 s3bITNW9Iew3FNmC1ZacWbk/H6gtlFbszQ/DHuVB2qFi82uP84iomXDpv8kEhcfnYdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793522704;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RsozYUpqCaIZZHHLQlHRioR0q3vuwHk6pMFPXoOWDEM=;
	b=xlQPfTcEPTFbUIH7xKu/pm2f9t38Z5rrHlzR6ij3slhfHBREHXmSbX/v4OvZgGMjW2Oj
	 WiWtwGi+rk65zU+LorAJMlJQwqq6Lhm3Lso4mvGEu5lQBvRvPxDdmDdM1YM77Ga+ZJqRF
	 UjI1ivivcDzxVUOxSSPdDVLLntkiJxdQmKkBp985jI22LxzF/yAkAFIo3c2DvimUu3X/m
	 11DEis8EgzYwKzEhTeERLqUwxU3fh6Vk6htw+6XXX6LUDQuflMtwFE/HpGt2PoKVdJcA2
	 pjh56lndT/36GBG8notVNW4NGBcikt7ROghHbDFBbkOmbIRle83EgB0tXV01VjtTsnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uQMmXc0v;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6564606A329
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 08:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6564606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uQMmXc0v
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a210470b49so15896045e9.2
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 01:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793522702; x=1794127502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RsozYUpqCaIZZHHLQlHRioR0q3vuwHk6pMFPXoOWDEM=;
        b=uQMmXc0va5I+FSw9DqxC6BlXJrA1Bky8d8hmETD37IUT27852l77sJXJtmPKzK0kfO
         XZdlrn5HO4fgL8b5iBsbZ+gdzKs3LHEsb8i35/A7LSUROLSn9aJAGr1j6MeVrvVDOyv3
         2Sd+j6RWDLJXFgi2RO0ew0beN0MEbSutl1Lbnlshl9j61WTdWkkniFS2U6+1zkZHQWnh
         OKYULeJEiLGeL0b7wRDhIecOh53q+BLDevqJLgwNU0Tcn4/7r/AgZbJkL4aToSBZ+1/t
         k6m5vB4f4oyC29SVe5w1nRaxJs8TUtAWxZCuHhuZhdtKSh0AB2gt9zT8Ww1ftblYwdFm
         V5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793522702; x=1794127502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RsozYUpqCaIZZHHLQlHRioR0q3vuwHk6pMFPXoOWDEM=;
        b=eJiHFStzXISXIWiqU16oQocTlXI655Ao0PBT33D7qmUtQPev/kgawdMYymCpLy1wJs
         R44RPTe36Fc+of1UvS3ixhlyHvS1kF5cVxfd+g9tL1W0zcYCV1uCgF3fJoqHAmFg+yi/
         WrDFGyFBonIBRDXluUL18+JczBBCrDZCLMELoIuPI2GL6tvPpCaWq66ogYtdVYj9NWtp
         6JWjP5Tkl6ciIPGWCLA9qGl9iRPuLoZcTpK2kxJd8b14uyT4xS8qRM3+4E/d4JiYAipH
         MUkiLoJzHLmbtUgL27zCojVODtM1olnUTEQB4XFXYUrfX8rSaP0t6i1LoDIwQcpLj20l
         q8uw==
X-Gm-Message-State: AFq9FYIR+2UfX+YWQLQEUONRZIfVy7g1X01cXHr+U6ic2KUHJ1IZqAx7
	arClhOCXfgHQz3w6C4ibqmmMcESd2pU3e9coo15radqP2l6S3r2TMeFNSWGY0qx4
X-Gm-Gg: AYBFou2Ozvw5R2MQosGbq7Qv+8r/owmyOXA7bumv76burU2Pouzm1cQcfra/mzTizyh
	1haxZy44dLMVyvkWRi8xAxIaV+iRPFzhXFOm8EE2jWyFB/aoDpMkY8n09AQFJSJVvFd9kByznOY
	lfV1bFIYs/oeTCW6EkXKIBcfHkzhgpO2uX5n3KGMdClWn3W0ML8WU9tt8AgnMwzoD29QHbnruSH
	JfUlCyFCaUDDmPIPmxGvduu5hfNNevVGzNT4QSj2KTqCvib80hj9Nb/nAlkziiy3wdiejEXT+TM
	bZIsItE2GLZu1AlZ0uti5ZLrUWQnIqYUW+hPyLfuWlruRtUj6/E1FaLhx8B3lV1aLG9PUrFWfAE
	oBUwNpKPA2YKKFS/+a8A63sn882YE5GkIyWbJaKjs+iiOGCjUrk9TSxFdkrij7qIPODaR14QsCr
	FAfwQb7XCk3dQbZlaM6SqRrso92lpdVANGlfvw3NK/6De6gllQF1c1TzKrr+g6UpagwJ9RCPvuo
	TBYP9Qwt5WLloMVAFEJKc5CxF4hFsjlMaJkpFfrZ7Vxy0+d5xRWp3oZqI8bxj5qAyOamyDE3sMu
	8oj5BFM5boCTSWSFlQqmM0RAv5yiKuxCLBvb1rR6nQtnDwj5XcUr0NI7m5MRKiY=
X-Received: by 2002:a05:600c:4e43:b0:4ab:e27d:e241 with SMTP id 5b1f17b1804b1-4ac180f28f7mr149896655e9.15.1793522701935;
        Sun, 01 Nov 2026 01:45:01 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80ecbsm13330965f8f.35.2026.11.01.01.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 01:45:01 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/2] diff: die instead of truncating sizes of 4GiB or more
Date: Sun,  1 Nov 2026 09:44:57 +0100
Message-ID: <93415b30f2ffdafbd8ce0e615b1ef1aa8bb0ad7d.1793521916.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793521916.git.gitter.spiros@gmail.com>
References: <cover.1793521916.git.gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On platforms where "long" is 32 bits but size_t is 64 bits, such as
64-bit Windows, worktree files, textconv outputs, convert_to_git()
results, and temporary diff files of 4GiB or larger have their sizes
silently truncated when they are stored in an "unsigned long", such as
the size field of struct diff_filespec.

This causes "git diff" to produce a silent incorrect diff based on a
prefix, and commands like "git add -p" to apply a patch that truncates
the file. With the worktree size truncated to 16 bits, "git diff --stat"
reports 1 insertion and 5042 deletions for a one-line change in a
7901-line file, and applying the resulting patch leaves 2859 lines.

Use cast_size_t_to_ulong() in these code paths, matching the blob
side, so that Git dies with a clear error instead of producing wrong
results or corrupted patches. Widening diff_filespec.size is a much
larger change left for a separate patch.

Triggering this requires processing 4GiB or more of input on a platform
where "long" is 32 bits but size_t is 64 bits, so no test is added.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 combine-diff.c  | 11 +++++++----
 diff-no-index.c |  2 +-
 diff.c          |  8 ++++----
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 717d537688..edf0427a80 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -322,7 +322,8 @@ static char *grab_blob(struct repository *r,
 	} else if (textconv) {
 		struct diff_filespec *df = alloc_filespec(path);
 		fill_filespec(df, oid, 1, mode);
-		*size = fill_textconv(r, textconv, df, &blob);
+		*size = cast_size_t_to_ulong(fill_textconv(r, textconv,
+							   df, &blob));
 		free_filespec(df);
 	} else {
 		size_t size_st = 0;
@@ -1069,7 +1070,9 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 		} else if (textconv) {
 			struct diff_filespec *df = alloc_filespec(elem->path);
 			fill_filespec(df, null_oid(the_hash_algo), 0, st.st_mode);
-			result_size = fill_textconv(opt->repo, textconv, df, &result);
+			result_size = cast_size_t_to_ulong(
+				fill_textconv(opt->repo, textconv,
+					      df, &result));
 			free_filespec(df);
 		} else if (0 <= (fd = open(elem->path, O_RDONLY))) {
 			size_t len = xsize_t(st.st_size);
@@ -1086,7 +1089,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			if (!is_file)
 				elem->mode = canon_mode(S_IFLNK);
 
-			result_size = len;
+			result_size = cast_size_t_to_ulong(len);
 			result = xmallocz(len);
 
 			done = read_in_full(fd, result, len);
@@ -1103,7 +1106,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 						   elem->path, result, len, &buf, global_conv_flags_eol)) {
 					free(result);
 					result = strbuf_detach(&buf, &len);
-					result_size = len;
+					result_size = cast_size_t_to_ulong(len);
 				}
 			}
 		}
diff --git a/diff-no-index.c b/diff-no-index.c
index a9151cc27a..dee80eb4ed 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -116,7 +116,7 @@ static void populate_common(struct diff_filespec *s, struct strbuf *buf)
 
 	s->should_munmap = 0;
 	s->data = strbuf_detach(buf, &size);
-	s->size = size;
+	s->size = cast_size_t_to_ulong(size);
 	s->should_free = 1;
 	s->is_stdin = 1;
 }
diff --git a/diff.c b/diff.c
index b4ac17f8ef..9b1c69b378 100644
--- a/diff.c
+++ b/diff.c
@@ -4516,7 +4516,7 @@ int diff_populate_filespec(struct repository *r,
 			s->size = 0;
 			return err;
 		}
-		s->size = xsize_t(st.st_size);
+		s->size = cast_size_t_to_ulong(xsize_t(st.st_size));
 		if (!s->size)
 			goto empty;
 		if (S_ISLNK(st.st_mode)) {
@@ -4569,7 +4569,7 @@ int diff_populate_filespec(struct repository *r,
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
 			s->data = strbuf_detach(&buf, &size);
-			s->size = size;
+			s->size = cast_size_t_to_ulong(size);
 			s->should_free = 1;
 		}
 	}
@@ -4662,7 +4662,7 @@ static void prep_temp_blob(struct index_state *istate,
 	if (convert_to_working_tree(istate, path,
 			(const char *)blob, (size_t)size, &buf, &meta)) {
 		blob = buf.buf;
-		size = buf.len;
+		size = cast_size_t_to_ulong(buf.len);
 	}
 	if (write_in_full(temp->tempfile->fd, blob, size) < 0 ||
 	    close_tempfile_gently(temp->tempfile))
@@ -7838,7 +7838,7 @@ int textconv_object(struct repository *r,
 		return 0;
 	}
 
-	*buf_size = fill_textconv(r, textconv, df, buf);
+	*buf_size = cast_size_t_to_ulong(fill_textconv(r, textconv, df, buf));
 	free_filespec(df);
 	return 1;
 }
-- 
2.53.0

