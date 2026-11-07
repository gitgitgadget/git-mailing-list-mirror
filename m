Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794026666;
	b=vLH2ZhCj0S/hbYwjJDVUMEbuSZ8uLMOlJWU7GnVgYZJzFAFp2WbeH0pldUZlUrLRu6MM
	 a71ATcirj6j5Dr2mig+VlkhQr7PHsFkaBpJKtm0guwragJq/azQpfHUj89lLkRuIQsulR
	 PNtGZC+b2Nl+XFqjRiFp8lNN9cb9wMumkikAncpdz8JmLMrUMRut2G7FtErdbsgq/mcSy
	 gAthGcS8SrVUr3yXKdUFbQBMxbd1mYOQ+5XtOxKgmcIzTRGlxESXAvG2n11IIapfFqTKB
	 glulcryO/qV9AZnETgy2GFYt9lUvFAncIN9oVe0o/FWxFJKYxbuYWPtNLwL34ccRY9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i2N803mCYNoqV0f/UzaUxFpsGml85Pa3jKto2s8kcZM=;
	b=ci5PMlxlFSZmaxcT7BhZFVNgAYRIaqk/uYJkjc818rQqZoavnToJbSMjpx0Vww+Q1rvL
	 PFr71e1slun5UdWPSRoh8Z0FvSHl3NH0Qpyq91C746e2ls1CQctpbXGUQhNjQOIuGb43b
	 IuTMqceOHrY5l+ogPFoQ8yfDtmHmxNzkqRJtcUgZhmf+XQjSf8Gqtm+S5wh7jBAAohP2Y
	 Mboa07lZXRZjkBnraXVKj3GzrPFtppoLf5DOzN/RItLiD5Shuj1v0eLt2IBBfAyJYTXZ9
	 Tr8HbApanZn1W9eV7EL4Bw/MQSVGTGOP5Lk/KmM4in+bwJ6m2rMhy4iLo6oaa9GpS1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qVn5cr2m;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68825606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 04:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68825606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qVn5cr2m
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35829219da8so340500eec.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 20:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794026665; x=1794631465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i2N803mCYNoqV0f/UzaUxFpsGml85Pa3jKto2s8kcZM=;
        b=qVn5cr2md6xBusWGYTyHkR7AgBtY60lIZ6v5WHTBQk/yDpVX+oufBtWX3YK6lirR3F
         90u4isghNaEo+ic7AFhS78RDXTCT2fnsKGAshcFRPszIp53RBDrFJ006oxTDsk4kkTVl
         AHPIdcYL2rZfwFy9O2UBJ9yyJh811Une+5GzcgQHpENPkoMc3xaUq0snaVK4J+sbjl4B
         mLjnz1jTudpi7eDcFWCURouNLRt4lhayH7yPR0SVHw2Q1+RzR/F0BxziMvwp9xNE8ARe
         gHBR0n9ihh2f3/tQ8p/mYKwWFoMeVcqvddeChMRDi+3iHSquDAjYSEnoCFX7vMa1sTLB
         YrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794026665; x=1794631465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i2N803mCYNoqV0f/UzaUxFpsGml85Pa3jKto2s8kcZM=;
        b=s94vaQRRpyfgeOEqml3rIdCiDZSM28HjwwZTxAFO2qopmmyNsCl0BqeWOV5/x/b27q
         ONO7KljHQe2EW4+V0jIt9QRfQplVRGpOFEzZ7hhLcsYn4xaBEbIQqZmmG/sBdVz+l+Gz
         bVbXUUqwt2aF6BbWhAak+nqZjHaln+kn5eS/M0MsuaWUa9tZnMr6EDwVb5p9fBjUd4ja
         0KTiYZPQBOuKjJFxeNkXsK5hR9SoM8IZx8WKTBa4sg/SiQ8luIAqStK7gdN/s1O9uAkN
         XD1LqdsNzSa+0EfqUP8Tfqh5B6B9f7rcloKpHF8eqXTKEfpCISCcG4qpIVOSLP7VaFd2
         rgag==
X-Gm-Message-State: APuU4Z/7dvOLWZwctsLzJ9lozqag7MC91GFnuQVDjne6t+1MRLg6oCiJ
	c7sfXFE9QFsJb0dzvnBSe5lvLTymPlxTIQMtcRAXkkS2uCyJarO2cMN3rRviWGYY/fU=
X-Gm-Gg: AYBFou0FxVqurx8Gwx3RQLjhHS+/XMpOrfzkhXoPjE/ExtOqJaqY7XHsj1U9P8p1WHb
	2GvdANsRwXM0+2qEntFGU9sIyIuGKVVnqGI5Sk97Kn634U7CwmaXmnvUssYKjbcUhvTt3Fkey15
	X4pjiHrH+TVeq6okkzw10ZAKgxOM+maGISPuwABR+e8Iuu3oQyXeQJI5fysTL4kNBRMPEfE3UEp
	vSvvJx0BO0IJH+BsU54m8cFpvBvrnLFueopW6lPkeHX3aOhuP1AEHyID98ZHDFmlZG3SPiW3nKs
	GrL6fBtXjQAlBi8sX5KY3NwcioJHl1mjasYhaDz3lpdN3wtMy6l6Rwzxt2ASz29CfN16cDzBtOz
	EqTSfRpj+CEnTX5aXKNGDtrlEq/w8oQcEuNoZ1YkrZ7jYdCUCCWMP0WP0WW7I1hwOANP3jcFf+Z
	2+LOYCGCVi2GduRGEqRUCK5jeNgBuWgPxDn/haxFJBSU40iWjlJky5hjvSk1T6LH+YfXjYJ8oE9
	BmuziW4hv4bYpOKXO79Bpc18BrGd7nlut8b15F0Oe/UgU47f9j2f65SazXO9z6odnZFDYnZ5mT3
	3LYjhL6f1dIRySkuenOTE5zh8h+uJ1ML6EWS9FzD7jeibgiYSocikRdKocd+4YHM9fcomF1C3A=
	=
X-Received: by 2002:a05:7301:d810:b0:36a:37:1404 with SMTP id 5a478bee46e88-370f6018313mr1859364eec.13.1794026665286;
        Fri, 06 Nov 2026 20:44:25 -0800 (PST)
Received: from LAPTOP-PVRSMPQK ([223.190.82.143])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa4b8aacsm11317465eec.23.2026.11.06.20.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 20:44:24 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Coy Geek <coygeek@gmail.com>
Subject: [PATCH] merge: honor --no-overwrite-ignore for real merges
Date: Sat,  7 Nov 2026 04:44:19 +0000
Message-ID: <20261107044419.209119-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.344.gfa103ac04e
In-Reply-To: <CACgTecNrMKHGexWTkm1bqpVzL7SVWD5Hwo17wVokVGe3_Rnx0A@mail.gmail.com>
References: <CACgTecNrMKHGexWTkm1bqpVzL7SVWD5Hwo17wVokVGe3_Rnx0A@mail.gmail.com>
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

"git merge --no-overwrite-ignore" is meant to abort instead of
overwriting an ignored file that is in the way. However, only a
fast-forward honors it. When a real merge is needed, ort and recursive
overwrite the ignored file whatever the option says. Two FIXME comments
in merge-ort.c and builtin/merge.c mark where it was never passed along.
Add a preserve_ignored bit to struct merge_options then set it from the
option and use it where merge-ort updates the working tree. The
trivial-merge path in builtin/merge.c gets the same treatment. Other
callers of merge-ort leave the bit unset so nothing will change for
them.

Add tests for a plain merge and for a directory rename.

Reported-by: Coy Geek <coygeek@gmail.com>
Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
---
 builtin/merge.c  |  3 ++-
 merge-ort.c      |  2 +-
 merge-ort.h      |  1 +
 t/t7600-merge.sh | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 5b4eb23a83..c7cd3ce29e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -756,7 +756,7 @@ static int read_tree_trivial(struct object_id *common, struct object_id *head,
 	opts.verbose_update = 1;
 	opts.trivial_merges_only = 1;
 	opts.merge = 1;
-	opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
+	opts.preserve_ignored = !overwrite_ignore;
 	trees[nr_trees] = repo_parse_tree_indirect(the_repository, common);
 	if (!trees[nr_trees++])
 		return -1;
@@ -812,6 +812,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		}
 
 		init_ui_merge_options(&o, the_repository);
+		o.preserve_ignored = !overwrite_ignore;
 		if (!strcmp(strategy, "subtree"))
 			o.subtree_shift = "";
 
diff --git a/merge-ort.c b/merge-ort.c
index c410a5d353..38dd1ac99d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4632,7 +4632,7 @@ static int checkout(struct merge_options *opt,
 	unpack_opts.quiet = 0; /* FIXME: sequencer might want quiet? */
 	unpack_opts.verbose_update = (opt->verbosity > 2);
 	unpack_opts.fn = twoway_merge;
-	unpack_opts.preserve_ignored = 0; /* FIXME: !opts->overwrite_ignore */
+	unpack_opts.preserve_ignored = opt->preserve_ignored;
 	if (repo_parse_tree(opt->repo, prev) < 0)
 		return -1;
 	init_tree_desc(&trees[0], &prev->object.oid, prev->buffer, prev->size);
diff --git a/merge-ort.h b/merge-ort.h
index 6045579825..d5747f358e 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -85,6 +85,7 @@ struct merge_options {
 	unsigned renormalize : 1;
 	unsigned mergeability_only : 1; /* exit early, write fewer objects */
 	unsigned record_conflict_msgs_as_headers : 1;
+	unsigned preserve_ignored : 1; /* do not overwrite ignored files */
 	const char *msg_header_prefix;
 
 	/* internal fields used by the implementation */
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 64fe21717d..c1150e50e0 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -1179,4 +1179,63 @@ test_expect_success 'merge with no argument defaults to upstream' '
 	)
 '
 
+test_expect_success 'merge --no-overwrite-ignore keeps an ignored file in the way' '
+	test_when_finished "rm -rf ignored" &&
+	git init ignored &&
+	(
+		cd ignored &&
+		echo secret >.gitignore &&
+		git add .gitignore &&
+		test_tick &&
+		git commit -m base &&
+		git checkout -b side &&
+		echo side >secret &&
+		git add -f secret &&
+		test_tick &&
+		git commit -m side &&
+		git checkout - &&
+		test_commit other &&
+		echo mine >secret &&
+
+		test_must_fail git merge --no-overwrite-ignore side &&
+		echo mine >expect &&
+		test_cmp expect secret &&
+		test_path_is_missing .git/MERGE_HEAD &&
+
+		git merge --overwrite-ignore side &&
+		echo side >expect &&
+		test_cmp expect secret
+	)
+'
+
+test_expect_success 'merge --no-overwrite-ignore with a directory rename' '
+	test_when_finished "rm -rf ignored" &&
+	git init ignored &&
+	(
+		cd ignored &&
+		echo new/private >.gitignore &&
+		mkdir old &&
+		echo seed >old/seed &&
+		git add .gitignore old/seed &&
+		test_tick &&
+		git commit -m base &&
+		git checkout -b incoming &&
+		git mv old new &&
+		test_tick &&
+		git commit -m "rename old to new" &&
+		git checkout - &&
+		echo committed >old/private &&
+		git add old/private &&
+		test_tick &&
+		git commit -m "add old/private" &&
+		mkdir new &&
+		echo mine >new/private &&
+
+		test_must_fail git merge --no-overwrite-ignore incoming &&
+		echo mine >expect &&
+		test_cmp expect new/private &&
+		test_path_is_missing .git/MERGE_HEAD
+	)
+'
+
 test_done
-- 
2.43.0

