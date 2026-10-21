Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792607138;
	b=3r8JlmOcW5Us/VOpqXB2/dZ9eE+FgP6hGAIjd3Pj4piuhtydB9yjAs6Zb8x9XrcV5PtQ
	 aOzkmOCP0f7pPZ+0zLxUzgeY/qEBw/81P0TwLVO6oxvUplPwNBI0zpD6xIZCRC2hNGadN
	 nF0uyoHomkf+mZLyFYtsBKSh+GIVpPv1qsEn+eCeMJ7S0OJohZ9WDi4Zj7eK2a3cQY0SQ
	 4+1t11HouOCAuvNhcumh50n/zqvj3G6JvnSmcRJNtDwpJGsQexI1E7FsgkICok4giAgGD
	 erJU5yL18duoOo19tqDHz9X9teNgwilAGr8VJdAX0BBTpr4AayazD9Nq/WHpux9kd1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792607138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9XABZq0Ng24cqCwSe44YEuAdjKVvWaINI5H7fTB73JQ=;
	b=gIAVERFLgkvh2qqbArE2c0Ea+8cfD9TgZMfX4Cn6DssOUXcN2F41E2RITyEz6yXrGdFU
	 5nQ/OA3rgJGeU+EtrUnsf99RG7cPlxPQuzabVWkI9x+uTWMbHL7WQvmZ+k1BTG9da8T+Z
	 JQvLD0ckq113bwcl3yM8sk3IOj+PMOl8XGqtWueIrKMSqnlD7UtQ6OQQ8sKLE5d74sD+S
	 s3uQYEyh2DkiCtG1PJCu7sWvDK34cZ75hH7Hzk2fxjqpnRqojZvTUnN2ZBzY4UIrAez8v
	 SSVSI0lrAZeIkMf94vmQypvXNf0bATmsCUJxz5wCMzM4M9dyYNPu7o4TxArvw6akWYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="sz/DsbyK";
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1F1606A325
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 18:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE1F1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sz/DsbyK
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-825b40f8a26so583972a34.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 11:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792607136; x=1793211936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9XABZq0Ng24cqCwSe44YEuAdjKVvWaINI5H7fTB73JQ=;
        b=sz/DsbyK/ItABr9BuzsCTnlMaL7Ic2MPpSRY5ZK+Vj6Aj1dRPm3SNh4JDn9QcY5hVd
         EsDEm4Ez2OyLMa+5gY+czYdtNyOIoWN6RT3p/DeOI6QDqTDF/yN0VMuDUlQ73p0Ed7Y5
         9S8/KLmf158cj0pMU7HlJqHoYd/gSnKngWUfYE8ggpVJquUWCVu2UUkn9JaDAssTAz+u
         nEWt+MHYbqcBsYB+Yd9lNLTqeZD8Vii+K5ZqKIFqn7cVNNX8VxtstoCU8gVvl+uIBEkf
         qEHuRdwqbSEA/rJJTnJZWCXDU2ud0KNcnm0+0Qgg6gEVuIC04d2sOLYSlP7RDhkhMyQt
         GBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792607136; x=1793211936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9XABZq0Ng24cqCwSe44YEuAdjKVvWaINI5H7fTB73JQ=;
        b=m+ZdxD1t4aSwXB7pcI4KvwW5kRY0q+JkbnXX/pkbHDg+y2hK6Jh6FuyDJ+wnrjQEF7
         BFHNIF8IsR7Zjm7EmN+1iXeA77Rm50gpjlRSYjyhBQZWbtA2NCEjpP98ObL9WIKEnACB
         u4ylp1Agur43ZOtiTB/SkGvDhxDSpOeWY36GIifnilG9nBoLKyps4nu79gymfq0zu/di
         uLa4rhXvDOVj7dw+wDS3b9urNmo/3w6UatccL5zgamYQ1OWbqx6fmo1CwPSPWMmNJWJT
         O+1sUiw3HcULF36IpLySZ2HZ/fqEDxigzZI2tDDeJI6yXGmfSpxiHVq+XLTSqGsILqYU
         qFeg==
X-Gm-Message-State: AFq9FYLqAR20gUm1Op+ufCqiTuIiqZ5PAubMN6+Khskb6vps96Nf1ciu
	ThJIcnjoEmjgv+dHvxL7WAyGOO6Y5VACYDYAW/tyQJDnDbrc+WdXCNEha+zJng==
X-Gm-Gg: AYBFou1ddOwKsg8cusrO5f4QAt1STlgW9tiEUjuRFo4KYKm5bdH7YKy0kPJdfixogDa
	q/1SxAB1UGDDYQ8ac7x87rFuHeNpCPWh3C2mLQSo/WTYq1iojCAYL08C+ApAIOOKzdJe9Sc0vCL
	YCThPUXeK6+6GP8InyQUNMsKZS3Wk7kaN94QRXEyMzQeIGl/S18OPZB7yA/aLzAJdDLddBJKCI9
	XuFwDLgWzKW0WSezJG8dT2oym8zb7i59G1ZQCZsYgCdv0T22riN+58evWy3q0jVC9G/KEgD7gNZ
	qGw6ieFPNj0hp2/iwi4m8z3yKO+SIbBke2+cHsw5Y+ivuOTdTbjSVCnWP0oFIxccq5mYPSLQW7w
	XXrXfJ4hnYd2/wG35Hs3a81wT1eD88iEXTg79zoTEw3TiJFBi24hhvzF8k3u3L86oneXwscsq6T
	fSCwxyd8pXQy6M3uoyww10v7HhPa1QKnZHqeM9cvYkhRQSD0zlgCYPzfKB65OQvM3ZlRDM3PVjF
	/sng1kVioTWLy9Iwe2hujz6lt53wPOM6UuvI59oBldK55OM98Zpybw58fS25LOsc+2/9uCkSJy0
	hrKv/01NqNxotdLCidI=
X-Received: by 2002:a05:6830:6686:b0:829:9992:2106 with SMTP id 46e09a7af769-84d088fee8bmr2201713a34.22.1792607136639;
        Wed, 21 Oct 2026 11:25:36 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbcdd9d3csm2831887a34.9.2026.10.21.11.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:25:36 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 2/4] pack-write: lift and expose index-pack report parsing
Date: Wed, 21 Oct 2026 13:25:26 -0500
Message-ID: <20261021182528.3055494-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261021182528.3055494-1-jltobler@gmail.com>
References: <20261020132900.1208343-1-jltobler@gmail.com>
 <20261021182528.3055494-1-jltobler@gmail.com>
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

Once git-index-pack(1) finishes writing a packfile, it reports the
hexadecimal name of that packfile on stdout prefixed with either "pack"
or "keep" depending on whether a ".keep" file was also created alongside
it. Callers that are required to manage the lifecycle of ".keep" files
parse this report via `index_pack_lockfile()`, which provides the path
to the temporary ".keep" file.

In a subsequent commit, the "files" ODB transaction begins creating the
pack lockfiles during transaction commit instead of eagerly staging them
in the transaction quarantine directory with the packfile. Extract the
generic parsing logic for the git-index-pack(1) output into
`read_index_pack_report()` in preparation for recording the names of
newly written packfiles.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 pack-write.c | 56 ++++++++++++++++++++++++++++++++++++++--------------
 pack.h       | 10 ++++++++++
 2 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index b1311c9923..2ed33448ba 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -469,11 +469,16 @@ void fixup_pack_header_footer(const struct git_hash_algo *hash_algo,
 	fsync_component_or_die(FSYNC_COMPONENT_PACK, pack_fd, pack_name);
 }
 
-char *index_pack_lockfile(struct odb_source *source, int ip_out,
-			  int *is_well_formed)
+int read_index_pack_report(struct repository *repo, int ip_out,
+			   struct strbuf *pack_name, int *is_keep)
 {
+	const int len = repo->hash_algo->hexsz + 6;
 	char packname[GIT_MAX_HEXSZ + 6];
-	const int len = source->odb->repo->hash_algo->hexsz + 6;
+	int is_keep_ignored;
+	const char *name;
+
+	if (!is_keep)
+		is_keep = &is_keep_ignored;
 
 	/*
 	 * The first thing we expect from index-pack's output is
@@ -482,24 +487,45 @@ char *index_pack_lockfile(struct odb_source *source, int ip_out,
 	 * bytes of prefix, `hexsz` bytes of name, and a trailing newline. A
 	 * "keep" prefix tells us that index-pack has also created the
 	 * corresponding ".keep" file.
-	 *
-	 * In the "keep" case, we need it to remove the corresponding ".keep"
-	 * file later on. If we don't get that then tough luck with it.
 	 */
-	if (read_in_full(ip_out, packname, len) == len && packname[len-1] == '\n') {
-		const char *name;
+	if (read_in_full(ip_out, packname, len) != len || packname[len - 1] != '\n')
+		return -1;
+
+	packname[len - 1] = 0;
+	if (skip_prefix(packname, "pack\t", &name))
+		*is_keep = 0;
+	else if (skip_prefix(packname, "keep\t", &name))
+		*is_keep = 1;
+	else
+		return -1;
+
+	strbuf_addstr(pack_name, name);
+
+	return 0;
+}
 
+char *index_pack_lockfile(struct odb_source *source, int ip_out,
+			  int *is_well_formed)
+{
+	struct strbuf pack_name = STRBUF_INIT;
+	char *lockfile = NULL;
+	int is_keep = 0;
+
+	if (read_index_pack_report(source->odb->repo, ip_out, &pack_name, &is_keep)) {
 		if (is_well_formed)
-			*is_well_formed = 1;
-		packname[len-1] = 0;
-		if (skip_prefix(packname, "keep\t", &name))
-			return xstrfmt("%s/pack/pack-%s.keep",
-				       source->path, name);
+			*is_well_formed = 0;
 		return NULL;
 	}
+
 	if (is_well_formed)
-		*is_well_formed = 0;
-	return NULL;
+		*is_well_formed = 1;
+
+	/* If there is no ".keep" file, then there is no lockfile to return. */
+	if (is_keep)
+		lockfile = xstrfmt("%s/pack/pack-%s.keep", source->path, pack_name.buf);
+
+	strbuf_release(&pack_name);
+	return lockfile;
 }
 
 /*
diff --git a/pack.h b/pack.h
index ada506b5c5..2f2ce97c11 100644
--- a/pack.h
+++ b/pack.h
@@ -106,6 +106,16 @@ off_t write_pack_header(struct hashfile *f, uint32_t);
 void fixup_pack_header_footer(const struct git_hash_algo *, int,
 			      unsigned char *, const char *, uint32_t,
 			      unsigned char *, off_t);
+
+/*
+ * Read the report that git-index-pack(1) writes to its standard output after
+ * the packfile is written. The hexadecimal name of the packfile is appended to
+ * `pack_name` and, if `is_keep` is non-NULL, it is set to indicate whether a
+ * ".keep" file was written. Return 0 on success and a negative error code on
+ * failure.
+ */
+int read_index_pack_report(struct repository *repo, int ip_out,
+			   struct strbuf *pack_name, int *is_keep);
 char *index_pack_lockfile(struct odb_source *source, int fd,
 			  int *is_well_formed);
 
-- 
2.56.0.173.gf57c9a7388

