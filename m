Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE08924E4A1
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771552794; cv=none; b=HMqZmc9JYqBdi9wo9GPvD1uCIBxxQujwzlM6Q0mULRQY+dH21PPFHsRxhneT3hcUKZb3hTz9r390/2FKBDEqy9QiS1o7lksEOnyR2aQZeJ2XtSDJnlNbCHrtdCE9KidxPdAtCJWHe5iz9cLKNtklTKGV3YGhIIgKyaXKxzWjdqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771552794; c=relaxed/simple;
	bh=puhXSK2xsIDey+7bIk60FxGksi4zKJf7+pj2+NhFCKc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WlsmiUqImLkBFq6i+eEa3I1bsEbqwU/nHZ+ADRKHs1YtbDNMzrfY7lBql6mrojZBFYVx5iWJ4+ELFT+n45XkEUEZMQoQ2FS6K22KkbD6FVAqidVeFJ3d0zV0/1SwpntmR+cXhMUYza08egLtXZBGfSd+qKTwzoXlR8RDOQOovDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU0MU4v1; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU0MU4v1"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2bd3b0bc201so3694800eec.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 17:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771552792; x=1772157592; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzJwPBLdf9HwlWUObNI7tyitFeYoJJcHs63N13mm46Y=;
        b=UU0MU4v1Cv97CW2nE9ErjTJnLWDr/oPChjwM0IZsqdKPYn855AukXG81rbCphJColb
         YFhykyc+n8ksb+AURLP+L6IjVh+tzoJWPGW/m2CTiQq9HexK0y97sEuep8hYORt25Q4y
         pM1xVKELN9gjG3PL+ocWnOoN0Fv4mn0U6Ua7dWsTbNVK+MTX5GxiNQnpGWP+IFigd1xT
         wBU8GBFGb9SfPBh4X0cdGXNEecNTmuEF9dVyhBcDJK/SLEyLWZZjbu+d9ZTW8UtXbX5N
         CkY0r4T8vybgudkzA7js85C06Icyb0FAhVx2sLCZaFifBpM9Bz5nRlMUy8dwwyL4GjpS
         ALRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771552792; x=1772157592;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dzJwPBLdf9HwlWUObNI7tyitFeYoJJcHs63N13mm46Y=;
        b=IxblrRlSi9Zugy6ui9Krmv95HG2r6KVAaKJjer6aTFqjhGhN11ITE9nok336D1Y0ju
         0rnoXRdPvTO+jTaAo4KtSzu+u0E+vEne5EZJSH98fYGGzGNzY8HERK+iSHtBD1RUrm3s
         lXvBtaJsOEwezKLWyPT/ZiWMB+DVH16DO9PKjeXJETageTHo8qiDZGj+KeMfAkDoVTPo
         nkNKopiaduVJ4rRJc5DL/gdDRdR+cAaxIEsooiPwh9QNVbQuxdQ9en5xwix8aABcHY1p
         UAeubpE59Z36SjIEdL1mcClQSUb4zjlwSh6xeORoVw7bopIO0QurNLZXf3/kn1Y4gajJ
         lXPw==
X-Gm-Message-State: AOJu0YzkEQr46ouvKswAWtvI8dv8xikRsip/qPjB0qHLTgPa0qHxwo1u
	DOW5toVbA7cjGEfn6disAiCT7xkr/a1nDvQff5wfHveeGnkNVXXwS0sbckyjUOa8/f4=
X-Gm-Gg: AZuq6aId/Rc6IgXU5R02laWnNn5N6pZBUvvFSKjtF5nrfj2bO75ItJbFQHKU+EketgJ
	Zzi+18IY4HUeI/eyI7T5xnFKNgPlDmcaqbeOO2zNQfDuZKAL0oSQmMo2oxydCmDcT45t+bATL6k
	KIpqXpKU7uJqyyXPiWYO545Dz2rrEFlr1d6QFN6ouzexdPkpf6QCVi4/IhMklYULYn4ldi3qUc4
	lseVdQIlH5m4Im9q4UO3LyAL/lCkLnsHjyGeAUIr1ZIn3cqEwFUWOtNmpVfaRfwql3j1OzmFXdz
	md1V4ViX2HmY8JMHMnS+Tzd8fHGrMuD6q3TH71tsnuJrqv/Oi9dFrOD8sV3hhkfEd8btO7WCV2A
	1l4PU80h1TNPnY4zJw/N9wj0vmqplAKl5NS2JrOihxhZguCWhInk24sGdhAvrw0BhkMJKJbTfio
	PLISNThbwspHmzSajdnXMKQx8JPQ==
X-Received: by 2002:a05:7300:e80c:b0:2b9:1375:b546 with SMTP id 5a478bee46e88-2bd5b2b226emr2430026eec.16.1771552792375;
        Thu, 19 Feb 2026 17:59:52 -0800 (PST)
Received: from [127.0.0.1] ([172.215.211.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb66b746sm26891781eec.25.2026.02.19.17.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 17:59:51 -0800 (PST)
Message-Id: <911cba991b0017aa3723961c7db73fafd6031b15.1771552788.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
References: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
	<pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Feb 2026 01:59:44 +0000
Subject: [PATCH v2 2/6] merge-ort: pass repository to write_tree()
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
index 593e3a2087..3535fc676f 100644
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

