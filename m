Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793668347;
	b=gWEjh/+pl/HcqZT4jdSefuS+hLv1mSKKT/0fiKchXe8wXL2EcPnBgBKrcj9PO5gw/94c
	 ikyugMFu/aahk+Rw0N9MFXjpElI6lh5dolaNXxCvm+KwQdVdnxIxkoaCW1k5xtmqHqiWX
	 XU0eWxAgxUj1r1C2/X+pzyabNbeoMsJJj75ut/3FKfroDL9kQLNkyPzkIwTpW8E1cK/Zk
	 6G02qCzhOtgRyCXi8QvKGG6/gAHxg4EprJ0i4bWvxjoMZfINUX6R6VMDO2gok8up7uBq6
	 DJq5LiW1BXdJ4g3tz15vni0kMMuf2NhTmHzFqBqEPWA5oR6WGEU2Kv+Cn0NS+iIw42g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793668347;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=7JHSv5Qy69HqyERK2ZLhYfXJoDiJPWl8mmx6wCBu6qg=;
	b=K1xC2j2WOAzibMfcZABvWsoxgnr65usvfL5+J/buZc/JuH2EI/O5HpFGtGqW+fOFXk/M
	 tjQJt8DWwpg19tCt5ClnMTUC66guUL0hyANQmOh/WZZAjl6b2zQp1UzixYONZKa5SH21Z
	 UsAvd0c4J06w+wtUsRn2jVxXVJ0zsKJJKNRZ+hJDCrujQEMmUxcc1GVSojM458bxmAoA8
	 tafZg/iafyZZae0bOPYt4rEuY7hrMYFc4Gfzr7Uyo9UZcXqYdSYrpdGpcoBmLemcWPEHj
	 2Odwae9EHAqpRluqudJ7g/AhNu2zNiAYKsdujsMTdcyCMgipZe/dMjKOGvULMg77uaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=e4VMvvks;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=u6mcFt6j;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2B8606A326
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 01:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B2B8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=e4VMvvks;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=u6mcFt6j
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4B92914001F4
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 20:12:26 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 02 Nov 2026 20:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793668346; x=1793754746; bh=7JHSv5Qy69
	HqyERK2ZLhYfXJoDiJPWl8mmx6wCBu6qg=; b=e4VMvvkskfUq4VKpQfQKJy3qdQ
	4Tj1NlsAs8OQeTikBcUdUPsxD9uAxcdImJyFo1TFRblQmMKb8i+V73F0Y/929iCu
	L8sAR+KR2+o1B6Dli++g+4Ub2Qy67qWjSmlEUdm+AelFsuZsLSMXDfoMfQMbYMHH
	JnSRRiQsDfjZfXSYaXpSD++6dBNmuk3rm7G/0KKCcbQZdNWDf8Z/SKpGVZgTRepB
	WE6ENYBPeZv+93YxAYgEYj/NT8lE9/ptI1SXF9GYVrT1eR7JQmZiBtqi0ZYY1CB5
	q0okijZGMnAI1kB3Y7wZ5DB2X39jNJ6UFNBlu13rO/nZSXrLxzjxYSfCma1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793668346; x=1793754746; bh=7JHSv5Qy69HqyERK2ZLhYfXJoDiJPWl8mmx
	6wCBu6qg=; b=u6mcFt6jn9bGU0zMGG6nzFzxAeZS8o+LkZqZDtfxVd+D7hXBZLP
	u1D9WKjGdyA2EgTDTzzM4PlQp/AKc1T/RBfMKIfS0VdsLJ1A4xMrqmYx7SbjJUuA
	9TFIUyZGWjnPITnQL5pZHKJZQ9hqHGegYqNt3Zm5ObC6yoRQ8H0bUQIITCwIoVpl
	gb1zwdB9NlsC0j1K+wTYuVJc1iSqtxZG9mmA0aCyuRjQspIUCxcohaWMFqgBlZkl
	CRMJPRxsdDTPzKF4Y5RyU8EUn+rPGJf7TI7x/9rZjTqjLWQ3qMfUhfjkbVUmr6OP
	qlHzq7zmif+OO0N20QvZKWsxTAWIrY6cmkQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793668346; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:lDxFZdK02TF5kqNnmM2bMHLXtP5Omu9fXS59TOK9IN5dOXX
	shGUL4slHS3AsPTEZdFCF/zbAvp+p4x19qTgm9oZb57aLmjpTV/tJ62swzrSakTJ
	RWwgdzan14LR5ux4E6B0YQnanSvePecXgVrnb+AlLPB0Xg56wrcCaOejGamc2sRx
	+5IGoXNSRKQpLqsdROUiJqLpcGfy5db31+j1p1Nu3lwdtPVokHkg+b5FDYxt30zM
	Kgcr0AzQW4LzUHL84yjl5RKNSHv/jLP52fXQgIjBxnE8C92T/KGz+8J99RkgmRl4
	u8s4dLGoun3B9P0duR6zyayKORfT94VyAwSjBKg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:CdM991WLFfsicQop5IwMSGtbZzxO8xZ/gKlSN1GCqyM=:0sdFaHuGELONTPfC+QdKqahdqNUxm7y4XYbfYW3EglM=;
X-ME-Sender: <xms:-jTpagt9ClFjL97d9c4MfM4DsFFGlz2jCJbViarmyIQktvxC-m9O7A>
    <xme:-jTpavsjwbxPf645ATO5db8DSLnLo04qfs2BRor7vFhYZgogZDh8kttKJs71gUK0g
    -QMRIXEHGQqk_sSY6r_SsHa031Pvt4RIyQ1fU0KOYdbYMcj1ysxB0s>
X-ME-Received: <xmr:-jTpauCvN6XdIj8hz2byZNraLZvy_4QBtu8uh359Bwo6sif-rLW0uL9yo383p_GfEHz_RSZyZojsyx80oB6YAXjmedIb5ZAzTK8Z>
X-ME-Proxy-Cause: dmFkZTEsCQA/WpcFvhUQN87xzkHiJHJsHqFuETkVaKoMqJvcfgDPDsgw/RNf0ZQ8hjT0b+
    lPvNfJslUVn7JwuTD07PG8Cm7nb8gRDfjOfGqjFJpjPyPwJq1raW0U+rj7vjGUkqJGGbSX
    v+ZtgGEnsu76J/fEobYKNEfkHXTWLb7X9Hx6/8YQ9hlJMmMqeJeyhdnw7VsMSQBdIHw3S9
    WYe3fV1vwWP6OmdgKWZE9VkRxIJu2ZexlDR3Ob0u7nPTijqynxzxu/PLXLOtkYva+JvVnw
    m0uuSNdvu9VtDbSqQM5WX2XzaPgJQ1amObtjLGwH5ySfxj74XEH3CQPt/NlDHcgOhrUbQm
    yqUCx+FDYycIOIa4zPz/VEthoKJI6FZBsPqwbVlH/OVpkEtqv2QN7AoKDU6ibgfs5yAAT9
    P0jttExHxXmfg6SxVF8MzckQ9HyUOCKRkuAgGSpwvqcw2E7vZnkrx9itMga5vz/ktgeGOH
    kC1U2Nkai+DE5bcL1KUveiGtwoTtykc/FVhL9TMi+prNmuupIMlF6iDSVjxA1II+zJQHUR
    GQs+T4oPJqYI/+qa61BjYBBIM6/FzSHv1midHE3/noizPUl/SY7RqVi1PgSgbVcgkZPeVd
    NRG64NmSXh01PNc+G0MvRC8tSsTcUiN3I/VUKIpLqX4SK8C6j7YtqTHbZnsg
X-ME-Proxy: <xmx:-jTpapOQ6FElPB4bb0TMZpXt9GJrC97qHnD0Gl55zviqtli8cb_4fQ>
    <xmx:-jTpavx0ItspprNUsiyYTHc-8Kcz1sDN3w_3Cs_SD_d4rgpO0Bg_iQ>
    <xmx:-jTpahWXY_XXWbeYEuOuQwy6JmBcIzWxFy4arMhOTBTIn-0RNRB_ig>
    <xmx:-jTpapONWuYcaIWzs0F-IaV35esFzVTm5puIO02akS7Y21ruE8-dBQ>
    <xmx:-jTpaqvn7tbe9tSKn3XXUjlnIZt91VrxYBRvaztSOm5Ob9FCV2roU84p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 20:12:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff King
 <peff@peff.net>,  Justin Tobler <jltobler@gmail.com>,  Kristofer Karlsson
 <krka@spotify.com>
Subject: Re: [PATCH v2] odb: do not list our own refs as alternate refs in
 the quarantine
In-Reply-To: <xmqq1p92g375.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	02 Nov 2026 16:37:34 -0800")
References: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
	<pull.2285.v2.git.1793619933300.gitgitgadget@gmail.com>
	<xmqq1p92g375.fsf@gitster.g>
Date: Mon, 02 Nov 2026 17:12:24 -0800
Message-ID: <xmqqld7aen0n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>>     Changes since v1:
>>     ...
>>        quarantine outside of the commondir.
>
> All of the above changes make sense to me.
>
> This unfortunately crashes with Patrick's odb-reload-alternates
> series, but let me see if I can get a reasonable conflict resolution
> or if it is more reasonable to ask you to rebase this on the other
> topic.

I decided to queue it as-is instead of asking you to depend on the
other topic.  Here is what I got after making a trial merge to
'seen'.

I usually use "git show" to trigger the dense-combined diff format
(i.e., "git show --cc seen"), but "git show --remerge-diff seen"
output is shown below, just to see how easy it is to read.



commit b7f4d1e66b034c2a64b7f3323f9cd156a028f080
Merge: 1707829739 3f91b4bc4b
Author: Junio C Hamano <gitster@pobox.com>
Date:   Mon Nov 2 16:37:57 2026 -0800

    Merge branch 'kk/quarantine-alternate-refs' into seen
    
    The connectivity check in 'git-receive-pack(1)' has been optimized
    to not list the repository's own refs as alternate refs when running
    inside the object quarantine, avoiding redundant traversal of hidden
    refs.
    
    * kk/quarantine-alternate-refs:
      odb: do not list our own refs as alternate refs in the quarantine

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
remerge CONFLICT (content): Merge conflict in Documentation/rev-list-options.adoc
index 4e92cf6456..d20c5f6372 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -223,23 +223,13 @@ explicitly.
 	Pretend as if all objects mentioned as ref tips of alternate
 	repositories were listed on the command line. An alternate
 	repository is any repository whose object directory is specified
-<<<<<<< 1707829739 (Merge branch 'kk/connectivity-check-ignore-replace' into seen)
 	in `objects/info/alternates`.  The refs of shallow and grafted
 	alternate repositories are ignored, as the history behind them
-	may be missing.  The set of included objects may be modified by
+	may be missing.  The repository's own object directory does not
+	count, even when it is passed in as an alternate, as happens
+	inside the object quarantine of	linkgit:git-receive-pack[1].
+	The set of included objects may be modified by
 	`core.alternateRefsCommand`, etc. See linkgit:git-config[1].
-||||||| ebdc087dc9
-	in `objects/info/alternates`.  The set of included objects may
-	be modified by `core.alternateRefsCommand`, etc. See
-	linkgit:git-config[1].
-=======
-	in `objects/info/alternates`.  The repository's own object
-	directory does not count, even when it is passed in as an
-	alternate, as happens inside the object quarantine of
-	linkgit:git-receive-pack[1].  The set of included objects may
-	be modified by `core.alternateRefsCommand`, etc. See
-	linkgit:git-config[1].
->>>>>>> 3f91b4bc4b (odb: do not list our own refs as alternate refs in the quarantine)
 
 `--single-worktree`::
 	By default, all working trees will be examined by the
diff --git a/odb/source-files.c b/odb/source-files.c
remerge CONFLICT (content): Merge conflict in odb/source-files.c
index 4239cb493c..8ce437fdc2 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -75,15 +75,9 @@ static void odb_source_files_free(struct odb_source *source)
 		odb_files_dir_free(files->dirs);
 		files->dirs = next;
 	}
-<<<<<<< 1707829739 (Merge branch 'kk/connectivity-check-ignore-replace' into seen)
 	strset_clear(&files->dir_paths);
 	stat_validity_clear(&files->alternates_validity);
-||||||| ebdc087dc9
-	hashmap_clear(&files->dirs_by_path);
-=======
-	hashmap_clear(&files->dirs_by_path);
 	free(files->quarantine_path);
->>>>>>> 3f91b4bc4b (odb: do not list our own refs as alternate refs in the quarantine)
 
 	odb_source_release(&files->base);
 	free(files);
@@ -362,15 +356,6 @@ static void read_alternates(const char *object_dir, struct strvec *out,
 	free(path);
 }
 
-<<<<<<< 1707829739 (Merge branch 'kk/connectivity-check-ignore-replace' into seen)
-static void add_alternate_recursively(struct odb_source_files *files,
-				      const char *path,
-				      int depth)
-||||||| ebdc087dc9
-static void odb_add_alternate_recursively(struct odb_source_files *files,
-					  const char *path,
-					  int depth)
-=======
 /*
  * Our own object directory is <commondir>/objects, or the parent of
  * GIT_QUARANTINE_PATH, as an object quarantine is created directly
@@ -410,10 +395,9 @@ static bool is_borrowed_object_dir(struct odb_source_files *files,
 	return ret;
 }
 
-static void odb_add_alternate_recursively(struct odb_source_files *files,
-					  const char *path,
-					  int depth)
->>>>>>> 3f91b4bc4b (odb: do not list our own refs as alternate refs in the quarantine)
+static void add_alternate_recursively(struct odb_source_files *files,
+				      const char *path,
+				      int depth)
 {
 	struct odb_files_dir *alternate;
 	struct strvec alternates = STRVEC_INIT;
diff --git a/odb/source-files.h b/odb/source-files.h
remerge CONFLICT (content): Merge conflict in odb/source-files.h
index 7afc2f28ad..9117dbea5b 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -70,22 +70,16 @@ struct odb_source_files {
 	 * Whether directory paths shall be compared case-insensitively, as
 	 * determined by "core.ignoreCase".
 	 */
-<<<<<<< 1707829739 (Merge branch 'kk/connectivity-check-ignore-replace' into seen)
 	int dir_paths_icase;
 
 	/* Stat data of the "info/alternates" file. */
 	struct stat_validity alternates_validity;
-||||||| ebdc087dc9
-	int dirs_paths_icase;
-=======
-	int dirs_paths_icase;
 
 	/*
 	 * The value of GIT_QUARANTINE_PATH when this source was set up from
 	 * the environment (see ODB_NEW_HONOR_ENV), or NULL.
 	 */
 	char *quarantine_path;
->>>>>>> 3f91b4bc4b (odb: do not list our own refs as alternate refs in the quarantine)
 };
 
 /* Allocate and initialize a new object source. */
diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
remerge CONFLICT (content): Merge conflict in t/t5618-alternate-refs.sh
index cefc37797c..048c7c63c1 100755
--- a/t/t5618-alternate-refs.sh
+++ b/t/t5618-alternate-refs.sh
@@ -58,34 +58,6 @@ test_expect_success 'log --source shows .alternate marker' '
 	test_cmp expect actual
 '
 
-<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 1707829739 (Merge branch 'kk/connectivity-check-ignore-replace' into seen)
-test_expect_success 'connectivity check of a fetch excludes alternate refs' '
-	GIT_TRACE2_EVENT="$(pwd)/fetch.trace" git fetch origin &&
-	test_subcommand_flex git rev-list --objects --stdin --not --all \
-		--alternate-refs --quiet <fetch.trace
-'
-
-test_expect_success 'connectivity check of a deepening fetch excludes alternate refs' '
-	GIT_TRACE2_EVENT="$(pwd)/deepen.trace" git fetch --depth=1 origin one &&
-	test_subcommand_flex git rev-list --objects --stdin --not \
-		--alternate-refs --quiet <deepen.trace
-'
-
-test_expect_success 'refs of a shallow alternate are ignored' '
-	git clone --depth=1 --no-local . shallow &&
-	test_commit -C shallow shallow-only &&
-	shallow_tip=$(git -C shallow rev-parse HEAD) &&
-	cp .git/objects/info/alternates alternates.bak &&
-	test_when_finished "mv alternates.bak .git/objects/info/alternates" &&
-	echo "$(pwd)/shallow/.git/objects" >>.git/objects/info/alternates &&
-	git cat-file -e $shallow_tip &&
-	git rev-list --remotes=origin >expect &&
-	git rev-list --alternate-refs >actual &&
-	test_cmp expect actual
-'
-
-|||||||||||||||||||||||||||||||| ebdc087dc9
-================================
 # Our own object directory as an alternate is not a source of alternate
 # refs, but the alternates it brings in with it still are.
 test_expect_success 'own object directory as alternate lists only real alternates' '
@@ -120,5 +92,29 @@ test_expect_success 'parent of the quarantine is not listed as an alternate' '
 	test_must_be_empty actual
 '
 
->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 3f91b4bc4b (odb: do not list our own refs as alternate refs in the quarantine)
+test_expect_success 'connectivity check of a fetch excludes alternate refs' '
+	GIT_TRACE2_EVENT="$(pwd)/fetch.trace" git fetch origin &&
+	test_subcommand_flex git rev-list --objects --stdin --not --all \
+		--alternate-refs --quiet <fetch.trace
+'
+
+test_expect_success 'connectivity check of a deepening fetch excludes alternate refs' '
+	GIT_TRACE2_EVENT="$(pwd)/deepen.trace" git fetch --depth=1 origin one &&
+	test_subcommand_flex git rev-list --objects --stdin --not \
+		--alternate-refs --quiet <deepen.trace
+'
+
+test_expect_success 'refs of a shallow alternate are ignored' '
+	git clone --depth=1 --no-local . shallow &&
+	test_commit -C shallow shallow-only &&
+	shallow_tip=$(git -C shallow rev-parse HEAD) &&
+	cp .git/objects/info/alternates alternates.bak &&
+	test_when_finished "mv alternates.bak .git/objects/info/alternates" &&
+	echo "$(pwd)/shallow/.git/objects" >>.git/objects/info/alternates &&
+	git cat-file -e $shallow_tip &&
+	git rev-list --remotes=origin >expect &&
+	git rev-list --alternate-refs >actual &&
+	test_cmp expect actual
+'
+
 test_done
