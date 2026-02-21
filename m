Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444EB343D63
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 00:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771718401; cv=none; b=gbBbk4J9xQvdyFeLjEUyt/EKIWZ+LpD6nQDcUBxCXt88pWIsPcMjUBE3VMDoYDYppst0Z6FYTBd8a8FNm1n02sMbLi66wL+ClBjLK42XczLAQdOXRiuehtDjnvRH+gO38QLnSwW3GAi8+vFgRUhOCVSW4JfCIukc0npvVU5Azus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771718401; c=relaxed/simple;
	bh=rY1dNyQ05ucsD3r+ZOXsEFjZlUyo3El50d8dBpkKpT4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=anzaaF30lpNTlMLAqEzJDNauhfCdM6YlZfOyupIGoXiaNXLZZwbfTEvMhMtic5Y+ocewrg2ezb2MzIRPYGJvbRiLX5ne5aQNWFylm/wEbCHvy5lnRlGdqhFcDRpce2frJZVp756RCglIh+ozEkLIJfxg+o/A61QvO/W6bkfjaTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTk44wcw; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTk44wcw"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-506bcb23a78so27728001cf.3
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 16:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771718398; x=1772323198; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imVaQS4mg0IGOEi+VjKJPalwa0xtGXqp0J609gM0RhA=;
        b=QTk44wcwfMq74l59ihv18WC8B1FVAfYwXvUFUNTzFZtSlSTShBY4LEWffVeaqSMkMD
         ua+/b+PgiDariovAgJ06TVJeGJ+b2ojkHGsIHlZ4DoAt+g3nEwaHQlYm+1qcPXqnGGpc
         u/5DTW5wVq62b1X/kFgV8SMPNq8TOFFWH0GNZfAX3yWdlQM8JOfPCZi9aLE2NrKdniUE
         aobZGawTzBQp+0LT+4M34c9HcF9ECHPF8V6qtV1L9f9daAlAu0bI2H+lxeVS7NKwBdGI
         QQyTZ0DoQ9nllvdbxEa1NVFglHqlMEL9q4Vuomh6fjtk8ffQQUgdeOmK+cYnHin0kd5q
         abTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771718398; x=1772323198;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=imVaQS4mg0IGOEi+VjKJPalwa0xtGXqp0J609gM0RhA=;
        b=dnEmWMN71oFlP0a1b4IJ1NAZDZoBC8+g2KhTpdtKKBTRdQYFNjbfFGMThbUbHVwN8V
         Ywn+7BOv7QybEUdcPcjQZM5wRdG1UnoVATpRT279377M6bETDE2kZoDyDb0eXCiR6xRE
         jZDCqhi3zcmGZSurZ8QYVwW1c9TGhgxzevVS2IAulgaFe7v6TCDsouMizAAVFycnLORq
         VAMRqiBJFbher7cCksHfIbco4RmOdBGUCSgPBEuUAuYq568ZyhczGtwtmAyIEzvNrAJy
         7hmWUSsOxDkt1l9RONE+8mK6IDY0sNscdx+8UTuJtiSMRZZjtxBeWCQevLFDzwKrY7XZ
         9VBQ==
X-Gm-Message-State: AOJu0YxRVbmszYHnbwWcjGTgWre1N3f9O3jShUE7cpqvuuung8wAZ9Ch
	ISVq/wmo09l4f6UebPmIgXURpEj4Vc95MvH1BCog/VTvGkh162gWjhtFzltVUkPz
X-Gm-Gg: AZuq6aLVT6kQsGVi5juGgx0hpp++UjtsyTzkuoyGWRdQ0rwJAsGMXmMEe5CtBRWyCva
	JzHUtMzdk8TodI4euk6SjgXIrUB4WhObYOOqB0oPYpZz0YzvVE1o063lfP8S7SplGC79kYvmkFG
	Ab3nGWsB78cRJaytOKJB6ldkofZznJPJ3tRxW+bWo11u2Y8iM03H2roS1+RSYF/0KdJP2HyAdSq
	Fs5QImeJtYudwwqtuXa5YL/ydVjLZjqRS96rjEU6HInBRhg7Y+1PWf785TzHY3SEg9r4gpvreyH
	JESJ+Cy3UvK6N7xTA5C0k2tcDfW7ff6nNhrBk8fv4pXJPQX60TcTzn+AGT7iT7+NCBn8m9/tQgZ
	JInUoRJATMLDJ49AZrZF/GTFYdtfb9qks0A4iCgjAA+SRTKCtVJTmPns/y5r+4GMKPjLk7y1+9M
	Q3iH4bHRxP6QW4Y9C+5XCDCnhEVtSIM/oxGsc=
X-Received: by 2002:a05:622a:353:b0:4ee:2984:7d93 with SMTP id d75a77b69052e-5070bba299bmr61241971cf.17.1771718398532;
        Sat, 21 Feb 2026 15:59:58 -0800 (PST)
Received: from [127.0.0.1] ([20.55.213.115])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6d505csm29171761cf.27.2026.02.21.15.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 15:59:57 -0800 (PST)
Message-Id: <a9a9d422a35de63916c8529545a22870b3a1d508.1771718393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v3.git.1771718393.gitgitgadget@gmail.com>
References: <pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
	<pull.2048.v3.git.1771718393.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Feb 2026 23:59:49 +0000
Subject: [PATCH v3 2/6] merge-ort: pass repository to write_tree()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

In order to get rid of a usage of the_repository, we need to know the
value of opt->repo; pass it along to write_tree().  Once we have the
repository, though, we no longer need to pass
opt->repo->hash_algo->rawsz, we can have write_tree() look up that value
itself.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 27a58a735d..289a61822f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3822,15 +3822,16 @@ static int tree_entry_order(const void *a_, const void *b_)
 				 b->string, strlen(b->string), bmi->result.mode);
 }
 
-static int write_tree(struct object_id *result_oid,
+static int write_tree(struct repository *repo,
+		      struct object_id *result_oid,
 		      struct string_list *versions,
-		      unsigned int offset,
-		      size_t hash_size)
+		      unsigned int offset)
 {
 	size_t maxlen = 0, extra;
 	unsigned int nr;
 	struct strbuf buf = STRBUF_INIT;
 	int i, ret = 0;
+	size_t hash_size = repo->hash_algo->rawsz;
 
 	assert(offset <= versions->nr);
 	nr = versions->nr - offset;
@@ -3856,7 +3857,7 @@ static int write_tree(struct object_id *result_oid,
 	}
 
 	/* Write this object file out, and record in result_oid */
-	if (odb_write_object(the_repository->objects, buf.buf,
+	if (odb_write_object(repo->objects, buf.buf,
 			     buf.len, OBJ_TREE, result_oid))
 		ret = -1;
 	strbuf_release(&buf);
@@ -4026,8 +4027,8 @@ static int write_completed_directory(struct merge_options *opt,
 		dir_info->is_null = 0;
 		dir_info->result.mode = S_IFDIR;
 		if (record_tree &&
-		    write_tree(&dir_info->result.oid, &info->versions, offset,
-			       opt->repo->hash_algo->rawsz) < 0)
+		    write_tree(opt->repo, &dir_info->result.oid, &info->versions,
+			       offset) < 0)
 			ret = -1;
 	}
 
@@ -4573,8 +4574,7 @@ static int process_entries(struct merge_options *opt,
 		BUG("dir_metadata accounting completely off; shouldn't happen");
 	}
 	if (record_tree &&
-	    write_tree(result_oid, &dir_metadata.versions, 0,
-		       opt->repo->hash_algo->rawsz) < 0)
+	    write_tree(opt->repo, result_oid, &dir_metadata.versions, 0) < 0)
 		ret = -1;
 cleanup:
 	string_list_clear(&plist, 0);
-- 
gitgitgadget

