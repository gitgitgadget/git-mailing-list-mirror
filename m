Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62351DE4ED
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737285592; cv=none; b=JMwYIXXReYAn8OSiZqMuPDtIcX+Fdg2KOLo1dbQDJa2mhUiJ++0pDvzlaLAvAXIzmjChVkw5HAle8av+hTXsBpOe6X0FCOOgetzoQp4+j9U1h41gUrvgitZaBV95JA9eVJRV+YQgNtXzhk2M7yz5X/BW4VYPwz4MTwqIZrWWpZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737285592; c=relaxed/simple;
	bh=NYYOB8qr23T72v97GPr2AHX8A7pEBBq+40d8X95pjoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CsucX41Npr90UXwowaDTemJRxYuQ2IPcAWb8w/I17Qw3qdcmLH6qpytohJY6KMem42KER5Qahu7udGOWkGorCbC7oSmE6BantNn568KElxdrenbUOIfi5mJpO10W7DC3A97NQofBYmkob16OLoACxEBqGM/a2bMPHTd0BwnwNjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2RlaDSh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2RlaDSh"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2161eb94cceso42840695ad.2
        for <git@vger.kernel.org>; Sun, 19 Jan 2025 03:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737285590; x=1737890390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBEM8VBBa8OuBSrBzihOeR/FBs4k7AiHsVpv9+fBfC8=;
        b=k2RlaDShLiSaVKty+aX/vxiYDZfIsqk/ENDMUR0Z0D7TqY5kdnJ3xuEHUKDvPFnlgt
         +5d02xIOam0vV0FHNfB+Ej4VcdZ3gpaIA3toejfd/mTKeM5KMaceG+UdzPK9pQzWurUc
         Tx07NxUtPNGDh67dqtYlnFw19uHzmlwjwXRyhZViBMKm84YzSDePwJxobYzF9qozzWaY
         9sUm/3rwXMCRJXP37DXtvwarFy/kL6lZhq5AZJoH6mnhO9QJOkzGyteLe/5+6SB9jmWV
         q8ap0/WZihD+GDZYIRbt72qpX+FzV/ZClCn3YnP+cru6I5LzV+rN8VA7Am/tqFD6TzdT
         s2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737285590; x=1737890390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBEM8VBBa8OuBSrBzihOeR/FBs4k7AiHsVpv9+fBfC8=;
        b=XAyQU3nkhrGZ4JUmqSal0C9CKwOUI3ZiU4kw+6vKMHCqSBXPenM8cg8PcWpRnsrL6h
         W5T+n3KOvvgMYjmg7Wey26rXMcq2MXikGjKfwTbFYUBRFjr9N9sQugfZ/x0LZ5SsCWWD
         pvnMju9ZJ1cHmy4yO7vLvVED8qGCHZ5k/Ov65UH48PgJ6fmq3E8lDWiT2S2XloejCocH
         z3CUnu7qRuCZjY/bzGMy//eDyRAR8N2+4Pqaryb7jJV4pToBOnckRYQKuIRxfht0BB8K
         8vEhhZ2rvBPOiO6KGIQKMtnC8GJDU2axQecCMmSzR9fMjLqZHjnW5JW+T4siFWbkfc2E
         jIeQ==
X-Gm-Message-State: AOJu0YyfytUI2Gq2eVPvzfiVpKfHGYZ/PLGhyk4ezKA718SzZnhv8SYI
	PfCcDeVINFRbFlchKQ0PFtuQVj+SpGiO/4IqJDmGqgerQnZXQwc9
X-Gm-Gg: ASbGncuAc/bJi9EREUeH1EJaC4+4YpN68x0nMSJC1kJB1HeTZBRHrphwXhOxiskYBqu
	s+5xyryTMJ9gYCsX/qGdd4APRxjzB5OHA0IpXXlSKjodqa61JAxrq8nYRT8x/WnR+qsNl9N82GK
	XN4MmIB22Y3qR3ZWW7XU6HKLtdOHHx1rxwQJjXultTFmuoY7oZyZ3lfQZMSx9pug9qB01J2HpIi
	hrFXBqn7D9QaqFMpyzlr/KPZgx66cl8X0QP5dC19qnWoIwxdWhpmVxHjQUuWDHJaKC794fK
X-Google-Smtp-Source: AGHT+IEs8IzXj4rw5uktNCUkrEoZ1Tk30TrqlIIq4Ndf87jbQCaEMB/hOwSek0qDb4oR3wV+LZcNbA==
X-Received: by 2002:a17:902:f78e:b0:215:a05d:fb05 with SMTP id d9443c01a7336-21c355dcf9emr152731775ad.32.1737285590093;
        Sun, 19 Jan 2025 03:19:50 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cfbd01fsm43031415ad.104.2025.01.19.03.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 03:19:49 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 19 Jan 2025 12:19:30 +0100
Subject: [PATCH v3 5/5] pack-write: pass hash_algo to internal functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250119-kn-the-repo-cleanup-v3-5-a495fce08d71@gmail.com>
References: <20250119-kn-the-repo-cleanup-v3-0-a495fce08d71@gmail.com>
In-Reply-To: <20250119-kn-the-repo-cleanup-v3-0-a495fce08d71@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com, 
 toon@iotcl.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3750; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=NYYOB8qr23T72v97GPr2AHX8A7pEBBq+40d8X95pjoY=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeM38VKI8X7V8GqMIDi8nWpIalyxt5D6VhWS
 qzAnD9zMFz3DokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnjN/FAAoJED7VnySO
 Rox/k+8MAI3URjMt6MDWkku2tq8ppEl//bkHneptjMTc/PUgDQ7OMT22nD/kHz6TDO/jz3k7ZRm
 h7FT2LcgVO3Vz4mGfp+D5O6GG/NE4uTNSrVzRl2wedqi/5lw8OGm6jS6LUjTkSNwpl1enI/EITf
 OQtdJbrNLTlt0k1eNG6x0f8rhb9TqM30OJI0CZN4IbcVUxgVdaUBrP2CbGyJuP4KEvyDhhqUmxi
 JgTe0G1EJNxZhzxz0SGp3v35uevuV+vSgA8wfVBmDyBzx1pAXYB+ArNMdiXbY/rjNE6CjEbd8aY
 F7iMY5+zlSmPvutuDmOcStPoVszQBWnxppmeBzRnJKPK+prDuBf37Z81XsGYN03R8X6LE0TnkUB
 EfHzYaQuIF6Gi4ROm9hS+78GVleVZR5mSg2eHEvLKCmgTrBLXxnMXag45EkXFLrasMpD/b/GJC3
 uQlanVmTGFWqATWGSu9eAJtdLgGvZ17iy27+MzZXcgyZIUtLWZHS4u9sOqbeylIfDkruUm8KpD8
 sI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The internal functions `write_rev_trailer()`, `write_rev_trailer()`,
`write_mtimes_header()` and write_mtimes_trailer()` use the global
`the_hash_algo` variable to access the repository's hash function. Pass
the hash_algo down from callers, all of which already have access to the
variable.

This removes all global variables from the 'pack-write.c' file, so
remove the 'USE_THE_REPOSITORY_VARIABLE' macro.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 pack-write.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index 09ecbcdb069cc9b0383295798ceb49cbdc632b64..a2faeb1895e41f4c17281380478f1f2cabcc6f24 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
@@ -211,9 +209,10 @@ static void write_rev_index_positions(struct hashfile *f,
 		hashwrite_be32(f, pack_order[i]);
 }
 
-static void write_rev_trailer(struct hashfile *f, const unsigned char *hash)
+static void write_rev_trailer(const struct git_hash_algo *hash_algo,
+			      struct hashfile *f, const unsigned char *hash)
 {
-	hashwrite(f, hash, the_hash_algo->rawsz);
+	hashwrite(f, hash, hash_algo->rawsz);
 }
 
 char *write_rev_file(const struct git_hash_algo *hash_algo,
@@ -286,7 +285,7 @@ char *write_rev_file_order(const struct git_hash_algo *hash_algo,
 	write_rev_header(hash_algo, f);
 
 	write_rev_index_positions(f, pack_order, nr_objects);
-	write_rev_trailer(f, hash);
+	write_rev_trailer(hash_algo, f, hash);
 
 	if (adjust_shared_perm(path) < 0)
 		die(_("failed to make %s readable"), path);
@@ -298,11 +297,12 @@ char *write_rev_file_order(const struct git_hash_algo *hash_algo,
 	return path;
 }
 
-static void write_mtimes_header(struct hashfile *f)
+static void write_mtimes_header(const struct git_hash_algo *hash_algo,
+				struct hashfile *f)
 {
 	hashwrite_be32(f, MTIMES_SIGNATURE);
 	hashwrite_be32(f, MTIMES_VERSION);
-	hashwrite_be32(f, oid_version(the_hash_algo));
+	hashwrite_be32(f, oid_version(hash_algo));
 }
 
 /*
@@ -322,12 +322,14 @@ static void write_mtimes_objects(struct hashfile *f,
 	}
 }
 
-static void write_mtimes_trailer(struct hashfile *f, const unsigned char *hash)
+static void write_mtimes_trailer(const struct git_hash_algo *hash_algo,
+				 struct hashfile *f, const unsigned char *hash)
 {
-	hashwrite(f, hash, the_hash_algo->rawsz);
+	hashwrite(f, hash, hash_algo->rawsz);
 }
 
-static char *write_mtimes_file(struct packing_data *to_pack,
+static char *write_mtimes_file(const struct git_hash_algo *hash_algo,
+			       struct packing_data *to_pack,
 			       struct pack_idx_entry **objects,
 			       uint32_t nr_objects,
 			       const unsigned char *hash)
@@ -344,9 +346,9 @@ static char *write_mtimes_file(struct packing_data *to_pack,
 	mtimes_name = strbuf_detach(&tmp_file, NULL);
 	f = hashfd(fd, mtimes_name);
 
-	write_mtimes_header(f);
+	write_mtimes_header(hash_algo, f);
 	write_mtimes_objects(f, to_pack, objects, nr_objects);
-	write_mtimes_trailer(f, hash);
+	write_mtimes_trailer(hash_algo, f, hash);
 
 	if (adjust_shared_perm(mtimes_name) < 0)
 		die(_("failed to make %s readable"), mtimes_name);
@@ -575,8 +577,8 @@ void stage_tmp_packfiles(const struct git_hash_algo *hash_algo,
 				      hash, pack_idx_opts->flags);
 
 	if (pack_idx_opts->flags & WRITE_MTIMES) {
-		mtimes_tmp_name = write_mtimes_file(to_pack, written_list,
-						    nr_written,
+		mtimes_tmp_name = write_mtimes_file(hash_algo, to_pack,
+						    written_list, nr_written,
 						    hash);
 	}
 

-- 
2.47.0

