Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316169;
	b=qHmW4dfyRIjptOvGfsHryuFKEsrrzjuTDKKVG69C8WxtQcLpzBR0KaHIgdV5mpPvSu/d
	 Ab9hzOnQbkXLnEg6vlaNNph4jnn2H+W+AosVeDU7cVZIFtJ6qNIaBksXY49SsNFnqH8Da
	 09gWvRM4m+hhhNLStZ+r0i3pw35iGtaQutlkY2NQPkdps1lxrZl5dB4nZSg4zjqUfABCu
	 820eTWWWalrHAmSmDeTjcFbqO/+kFNitFg92EriNsekYgs9UYyKDPlZnIRSm01R0dX/38
	 iy3iaTH9q+JNk4mNhj2EMjMVarX3VvNZtStDAcq8bUuYNCG9UM4M75Vwzm1hJiHgUCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316169;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yXk1vWkutxy2NEI7qhaehqXO7HsvV0ZGl+rs7qlvjNE=;
	b=dKKnTps/w3tuF7QEIrckM878wB0YJmpzzS+I7lGM/hlru8rIbiGQA55sqXd1uPNJa5NU
	 AtRWhlimghNuOoEaMszI3S1LXodN8i7I6ZpDv0GH20Ap0HVgLywqTV8mPg/NuIEAoqH2C
	 /5w4KzUo+uoul/GAiBVCZb8fpz0Ol4Gbgdc5hCEkY+JCKOpxQXaw1l6c9xfcrDWhgOERc
	 8PmzmzvoY3PaD55opO/jOPhZfAp2AnYL37h0d9irrQTWlKpFccCKwDIGpdB1+JtFoq8I0
	 ApOn/6upy3rfxnHAwfDv1qTOEVAryPp1FxezBI9KH4RLTltfH4KJJlLctsQq48L62Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WNr7yFnn;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E08606A339
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 23:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5E08606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WNr7yFnn
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6fe4372c5f3so74853eaf.3
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 16:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793316168; x=1793920968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yXk1vWkutxy2NEI7qhaehqXO7HsvV0ZGl+rs7qlvjNE=;
        b=WNr7yFnnuvGl3mKH2sSwthvq39q9uK0h5xAEm8EokKcedihulhfAjfd6ryzZXrsfMU
         bJFWieHPqp3KJVzCu20bP6eWmUWj+Bj/4YhviXS+oRVCReiRcMT9AZU1VPco6owEvxiq
         62VqpiMI9VsEMgh3IOiBHM5zB2fJo4SGgU+sDQGi4OSQeBz/b0ErEDEYohQV1WIVQBTG
         1wVQuIMdRPbe1HdbL9SQFJyr/FqRFkE0dRwSqPTFYskTbwiy83cZX5IWmF+iueCV3ufm
         s6MsFdD+v+H/sK+wbBTcg2lJdb3Yw7QmN/BYitHCUTp/haVS4Jo3tesXw+6P/G7hqAk7
         SDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793316168; x=1793920968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yXk1vWkutxy2NEI7qhaehqXO7HsvV0ZGl+rs7qlvjNE=;
        b=uF0zgvkdNWBPl4mfVx7mD3zYrqg3Q3smdLp5ZivpIWT9tLBEU3CYFnqtWl+HY76xjk
         rQQV0YLxGuytLXr+mdx/83LqeCnJuGXycW4q+z6ux34c2s6+QYHCT2MUbWfZhHP9VY3E
         KSyHBGwkvJih3DochihmFVnnvNxLF9LNi+iQ6/wpQqehXk/nVEc2g9Eg79RyCOz+DKML
         rT6ffEIOv5kBqPX/HVgC2cxNvYDjLTRr5wIe7lWdOTT1jFmDM37oTLvm3DKdLZ+OJuzV
         lKA8El4P6I6V651AlXKQE2aVazWfMDlsaAWc135/yBifeHJLNE0xEdpilbSXVeS90F6T
         hytA==
X-Gm-Message-State: AFq9FYLX07m8eQS2629ChbAf/fqT2I+96099Grsj2eAWNZyhFyrtMINL
	ci4Bo/kS0rIgPvhbRNVe/NP9cX/wZMEmra4hMZqY+LtAaC3IP83VNyjjtAPjVw==
X-Gm-Gg: AYBFou2kJGo9RmFacIpkbx1aLF72GW4QxouzlxubdeMXdMsKPthsbUA2mR2IjT6BoUs
	U474QRbsvVwmH9CjVBmb3wRCo2CJaQCNCj4pMU3aWfS2Y0tlra3FspX8lVT5+CZ3MWA1QSe3ehy
	kh9TFek4ncrDFjAycgkEFDtW4MJLENAUU0KSM3Lny8eG1vUMJTJ2IzFexDSGkmEVlxsAS00SqNN
	FiXuLp6UjaJ7nji9IYs47JjFy4bfpMEjJ7+3WJnAGrQCpBCpwKOZtMvRmJlxVeiWT/sUQb3CyDW
	KIIGPG3uuHmM7QTIy9ug11g1+NMJFCcrIkskIkEaBaJ4+24qLjJozVXgQhXBrCX6Dcux0BajE6D
	kdbW+X/+xv4ocADQex22F84xppuGBceJzf3NhbmVfF5Fwa8ja9KuZJ9Ec+qpM9wLNU2loRRqblB
	tHkohCR9voJtnYycU35BJgIurMLeT/vEfzb83Z7X8gYgzf3my36YNxaw/u2iJQ4gE4BszB4M0Qy
	D6uWb6dzgdqTsbBpo8Odk2rFuhRh/9+uYVlnNAcfbkHIQZIpu9ggxRo076ilheCvcZtzuRwOTZX
	gkogWcOaROQt8g8RujZFh757MR8VgMaRZsMMFGGV4SxAotG7UKY23UVI+45HrgfF5Az4
X-Received: by 2002:a05:6820:f00e:b0:6da:453d:7cd4 with SMTP id 006d021491bc7-714f2945a30mr591861eaf.23.1793316167773;
        Thu, 29 Oct 2026 16:22:47 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354d05e0sm694924a34.15.2026.10.29.16.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:22:47 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 3/4] loose: lift loose object index writing logic into helper
Date: Thu, 29 Oct 2026 18:22:19 -0500
Message-ID: <20261029232220.1245827-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261029232220.1245827-1-jltobler@gmail.com>
References: <20261029002413.3291184-1-jltobler@gmail.com>
 <20261029232220.1245827-1-jltobler@gmail.com>
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

Writing the in-memory loose object map to a "loose-object-idx" file is
handled via `repo_write_loose_object_map()`, which always writes the map
into the primary object directory. In a subsequent commit, a separate
"loose-object-idx" file is staged prior to commit and must be
constructed from a loose object map not attached to the primary loose
object source.

Extract the logic for writing a loose object index file into a separate
`loose_object_map_write()` helper function that allows callers to
explicitly specify both the loose object map as well as the file
descriptor to write the entries to. Note that the responsibility of
locking the file being written to is left to callers so that it is
possible for a lock to be held for longer than just this single
operation.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 loose.c | 69 +++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 24 deletions(-)

diff --git a/loose.c b/loose.c
index 5f72c644f9..f2e111c25e 100644
--- a/loose.c
+++ b/loose.c
@@ -146,25 +146,17 @@ int repo_read_loose_object_map(struct repository *repo)
 	return 0;
 }
 
-int repo_write_loose_object_map(struct repository *repo)
+static int loose_object_map_write(struct repository *repo,
+				  struct loose_object_map *loose_map, int fd)
 {
-	struct odb_source_files *files = odb_source_files_downcast(repo->objects->source);
-	kh_oid_map_t *map = files->dirs->loose->map->to_compat;
-	struct lock_file lock;
-	int fd;
+	kh_oid_map_t *map = loose_map->to_compat;
+	struct strbuf buf = STRBUF_INIT;
 	khiter_t iter;
-	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
-
-	if (!should_use_loose_object_map(repo))
-		return 0;
+	int ret = -1;
 
-	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
-	fd = repo_hold_lock_file_for_update_timeout(repo, &lock, path.buf,
-						    LOCK_DIE_ON_ERROR,
-						    LOOSE_OBJECT_IDX_LOCK_TIMEOUT_MS);
 	iter = kh_begin(map);
 	if (write_in_full(fd, loose_object_header, strlen(loose_object_header)) < 0)
-		goto errout;
+		goto out;
 
 	for (; iter != kh_end(map); iter++) {
 		if (kh_exist(map, iter)) {
@@ -173,24 +165,53 @@ int repo_write_loose_object_map(struct repository *repo)
 				continue;
 			strbuf_addf(&buf, "%s %s\n", oid_to_hex(&kh_key(map, iter)), oid_to_hex(kh_value(map, iter)));
 			if (write_in_full(fd, buf.buf, buf.len) < 0)
-				goto errout;
+				goto out;
 			strbuf_reset(&buf);
 		}
 	}
+
+	ret = 0;
+
+out:
 	strbuf_release(&buf);
+
+	return ret;
+}
+
+int repo_write_loose_object_map(struct repository *repo)
+{
+	struct odb_source_files *files = odb_source_files_downcast(repo->objects->source);
+	struct strbuf path = STRBUF_INIT;
+	struct lock_file lock;
+	int ret;
+	int fd;
+
+	if (!should_use_loose_object_map(repo))
+		return 0;
+
+	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
+	fd = repo_hold_lock_file_for_update_timeout(repo, &lock, path.buf,
+						    LOCK_DIE_ON_ERROR,
+						    LOOSE_OBJECT_IDX_LOCK_TIMEOUT_MS);
+
+	if (loose_object_map_write(repo, files->dirs->loose->map, fd) < 0) {
+		ret = error_errno(_("unable to write %s"),
+				  get_lock_file_path(&lock));
+		goto out;
+	}
+
 	if (commit_lock_file(&lock) < 0) {
-		error_errno(_("could not write loose object index %s"), path.buf);
-		strbuf_release(&path);
-		return -1;
+		ret = error_errno(_("unable to write %s"), path.buf);
+		goto out;
 	}
-	strbuf_release(&path);
-	return 0;
-errout:
+
+	ret = 0;
+
+out:
 	rollback_lock_file(&lock);
-	strbuf_release(&buf);
-	error_errno(_("failed to write loose object index %s"), path.buf);
 	strbuf_release(&path);
-	return -1;
+
+	return ret;
 }
 
 static int write_one_object(struct odb_source_loose *loose,
-- 
2.56.0.173.gf57c9a7388

