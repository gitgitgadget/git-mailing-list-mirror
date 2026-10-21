Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561173;
	b=PVwbe8ZcFmLa3IUCEz8JODoHYXd0o5m0VuJgUnqVQSyxBQ+EDDeRk0OORxIwCAMxBIlH
	 Kd4YQfDgZrhSiGcVuki8wMC3iaB/fTvVlRhja7Dg3/bS1Lg0LahR7i869GrFhYpDDU8cJ
	 KcuB63/SA4cU8eyC91n3dO/zecxr3eVovRmOrUx7t7TVrXSwVogVJQyYFI3h3Kqi7Ucjd
	 zXBx2IdXhaSTwkrQRlbUZBSLU88VllGVksxmNwbQLnyy5MQiaOgkTxJkAImuFJtPJccGG
	 20nhYbQMM1q0xT4jPHdbE8NYwBvTxjO7XgX+Zlfz01i6fkLHr9J5mso0MQmDi+eoh5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561173;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=yocJXJOe28EjByDsyLJwMBWG4gZcA8zr2FVauaomvBs=;
	b=wV1WeccmI9zoULTLWJzSULmda46TQEU1Vluj6euPTXOEH9LF333KtNRq0TLaMXLJLffB
	 Z0h+IPmDdZkkQMBPV/PwGHEI+wt7pkGRhO03tGXsqHmjhibcucLNnBVp/ptNs3W38eJaY
	 uJvGPw2MOfOAHVYkJFxobrI7IXOk6iFPoupd8tLTslsWaV6FPPmUommtIrCMXwKbxuzSY
	 uHfVHU8aJjU0QLI/Shw9bCd1YH7bb+Eyu/mrYLAj1l1uWsILjDgXebKLzD31rPF6plqR7
	 vvkKFMwSsVYSaiNBtgXnniqjDTzMYNq2xZjD0hQEFQ2cqZfAnVmBtInf2aKPYgsp3/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Cqid6hV+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=s7bWZpDX;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907B4606A327
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 05:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 907B4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Cqid6hV+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=s7bWZpDX
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E55951D0008A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 01:39:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 21 Oct 2026 01:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792561171;
	 x=1792647571; bh=yocJXJOe28EjByDsyLJwMBWG4gZcA8zr2FVauaomvBs=; b=
	Cqid6hV+1ISdsC63yda6JA4gue1b6MQGS0xWQlnezfY6TlQEsFrLgELZPGAlIlVB
	9TdIfvLCuyT9Kye6N8lBBR3h3ZJScY6/ZPGj55Ddpfdj3qybb2F7m70CszGiND2C
	0KihPq3ZguTazzx39TP5fIPqZFBr93erPMinLMHiX5Cs/JJv9BnNgDZcEmbvY4n5
	yjxCh7n4QVl5Yo+LebGad/IwewPrYgeEsBIcB+2IHgjDxFDLXtbzZwSDEVXVbsm2
	sHJv98PHHgPLLMopVv7ocNBRNcqwVxyT0/uxTaESwY8Y8Ucml5JR0AuB33piD8fL
	hGzu8nt+gADG9yeDTOsywg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792561171; x=
	1792647571; bh=yocJXJOe28EjByDsyLJwMBWG4gZcA8zr2FVauaomvBs=; b=s
	7bWZpDXXrXRiiEIeRkXYw2HUl9C1dhc1rg4KzRoIWzfg+h3yL9he7TmeqqLEEpyX
	iSpnpQJtK+z1OYfyoXioVmnpCU6n1AL5QQX6Ndc8TD+ZA7dOH41gOaRSU/lK4LKi
	hnAZe2JbI/Ec3Q8Qykp+PeBEMq/G1CRD0SsOYFz8mVDGOT2xocGFMT+bYannF6Yn
	206dvk6AHoSAdknnWy0Y11bK5QtStKEhk9+/LeGH5qRtPyViZC9zBAzZmFr3fAti
	4R2T6ulnW9aPtQ/qNHZcTeJ3AL9e3oV94tVugmN3TH6N6PAhD0BOJerTAKmX1jck
	jypf0u8Kbr9KMu2xA8xQA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792561171; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Xm1MuzYrzDXE0FCOdE7tiSvXlHWLcD2Nr/KQtLcw7caU0Rx
	XEP9OL0+A4Ee9wthRJA4zKmoJGAaZiiaNxhp1Y6cz92e88AzoT800gSCtBm0StMq
	VBG28dGjl79dTOX3SWnSOxigprEjqiYiTkfaxVRXYwMY/cCHKRcn1FvfRtvXWZHN
	UFIijNtAY0llb4yA4YxZxhoidIoPxwNCab0Gy+j8NpFNaj0y5icOl5RScLokb7z0
	UIFaNPS2Ma3djNAzUZgrDdGPd/stTHWtsOPu+w1ROC7glxeCZ7Hn9PqKKvKL/wDR
	9gyoJhQzG/PJVmtjgCD2nSmDVKPsXgmZN9bxoew==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:acRUyWB1gBik+0l7gdpodcAXesf7bSHPY8r6cczll+w=:529HMQBU1HdxMNMx3VCm1+Mxn2kCl5IbaBg6LtZkpr8=;
X-ME-Sender: <xms:E1DYaj7oNPaL_rwImge3eP7wdcsAj1_LZSRnm15FtnH_0j4oG2YNaQ>
    <xme:E1DYau416hJM98zhFKfBub79RQOErg5Npcrm0-Rfv1qU_qf4gKIkShlAl00EjtwJa
    NyZITFHj_3fEooSm3vopbDur3Hld1OHMIQw6ft1VIVcQ6oc-rqSkLwD>
X-ME-Received: <xmr:E1DYaoHA3ck29ZaQ6goy9I-9WxHwI9yVWmkPELaNIGt4fiBl2hRalw>
X-ME-Proxy-Cause: dmFkZTFjdiHAftcLcxym7iyS6GGrr/hwgFjz6lyXgvbwNBTSpUGjBHjsxHa7aWLwD6r8/y
    i2fuv7S9i1ADuywbn12Qket1cjLDXkJ8huziohbALlYFFv5IeSPdo64QwnwB3rK4fKY8wr
    6vG2mCCE9emAm7rwWxvUG3vs+lrefardrkhp+6NcddLYfYabalVLmpcdWs+HVZZxn+9RGQ
    GoZCIDcFFBIkpfsCmvOapl7dvlB/aeoZBxOJxhKRitBNLvf253VGsHLOlhed8EgJLNxlKS
    L5ApeOskZ0InMS3wHs4ISt+Rs2ia27LW4DilV75gqOCUTkCtNCrOfSgpi23lq1zKjF5St1
    5UT6qCMrG5LFI2xcn4EPWT9Rb37x3w3Wpw3XjeJMMGjH0H8SUlskHQQUdFRxZZ0v+OYuYt
    SPQgX5oisHL1iNNHYiwl1i4pgGGVWSE5N+vsbr+PYVqI+2mMSutKqZ4Y91cJf64xNdNYY0
    WoEEgNDzxjt4WrGQigaIXrFxRlPWX4qHKvUVkrE01PrYnCf6Dwn+5pTmfm4l6Ub47XYJBb
    1my6kgYom0GG/TCY0HdYh4pphpsbzS57fI00bGmqmmF7fzJZMPiR5jteITcNKGu3qSEpdU
    OxRYi7jx8+eFINuJnJKmTudWN6Hn7Gq8ba7HnXxvoJGEGzB7uZRs+fgOIGmQ
X-ME-Proxy: <xmx:E1DYavQlJasDY0-WTyfDBsVHWzdufA4XzppDzbBDhfU0t5j3p1bUBQ>
    <xmx:E1DYapveoL1YWRTYUR2W_UX2TIZMQAhwmFMLClRk5_aM5CWZtz2pAA>
    <xmx:E1DYamz1-YOsBLduU0aa1GZFv28kCNkAEALkwOwvEKQDv3z66WhzsQ>
    <xmx:E1DYar45EYc5LiPvaY4o-hfTsqs2jJnebFsGaBEfKQBxwQlQxexhGQ>
    <xmx:E1DYahq3X3X-2sXdRrJ0eDwTf03Zos2R4ktp3qcaqaXclYQdbSZK25ab>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 01:39:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id af26773c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 05:39:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 21 Oct 2026 07:39:17 +0200
Subject: [PATCH v2 4/7] builtin: expose the object storage format
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-b4-pks-odb-extension-v2-4-8cf11b65eda8@pks.im>
References: <20261021-b4-pks-odb-extension-v2-0-8cf11b65eda8@pks.im>
In-Reply-To: <20261021-b4-pks-odb-extension-v2-0-8cf11b65eda8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

The ref storage format of a repository can be inspected via both
git-rev-parse(1)'s "--show-ref-storage-format" and git-repo(1)'s
"references.storageFormat" field. Introduce the equivalent options for
the object storage format, as well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-repo.adoc      | 6 ++++++
 Documentation/git-rev-parse.adoc | 5 +++++
 builtin/repo.c                   | 8 ++++++++
 builtin/rev-parse.c              | 5 +++++
 t/t0001-init.sh                  | 5 ++++-
 t/t1900-repo-info.sh             | 3 +++
 6 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index cb8c1e7292..d2dc9b7a69 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -105,6 +105,12 @@ values that they return:
 `object.format`::
 	The object format (hash algorithm) used in the repository.
 
+`objects.storageFormat`::
+	The object storage format used in the repository, as configured via
+	`extensions.objectStorage`. The valid values are:
++
+include::object-storage-format.adoc[]
+
 `path.commondir.absolute`::
 	The canonical absolute path to the Git repository's common
 	directory (the shared `.git` directory containing objects,
diff --git a/Documentation/git-rev-parse.adoc b/Documentation/git-rev-parse.adoc
index 5b866af66a..9103d54d53 100644
--- a/Documentation/git-rev-parse.adoc
+++ b/Documentation/git-rev-parse.adoc
@@ -338,6 +338,11 @@ The following options are unaffected by `--path-format`:
 --show-ref-format::
 	Deprecated alias of `--show-ref-storage-format`.
 
+--show-object-storage-format::
+	Show the object storage format used for the repository. Prints the
+	value of `extensions.objectStorage`, or `files` when the extension is
+	not set.
+
 
 Other Options
 ~~~~~~~~~~~~~
diff --git a/builtin/repo.c b/builtin/repo.c
index 84e012f83f..451c940140 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -6,6 +6,7 @@
 #include "hash.h"
 #include "hex.h"
 #include "odb.h"
+#include "odb/source.h"
 #include "parse-options.h"
 #include "path.h"
 #include "path-walk.h"
@@ -128,11 +129,18 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_object_storage_format(struct repository *repo, struct strbuf *buf)
+{
+	strbuf_addstr(buf, repo->object_storage_format);
+	return 0;
+}
+
 /* repo_info_field keys must be in lexicographical order */
 static const struct repo_info_field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "objects.storageFormat", get_object_storage_format },
 	{ "path.commondir.absolute", get_path_commondir_absolute },
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index ec33c19bdf..9dd692dcb6 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -17,6 +17,7 @@
 #include "gettext.h"
 #include "hash.h"
 #include "hex.h"
+#include "odb/source.h"
 #include "refs.h"
 #include "quote.h"
 #include "object-name.h"
@@ -1138,6 +1139,10 @@ int cmd_rev_parse(int argc,
 				puts(ref_storage_format_to_name(the_repository->ref_storage_format));
 				continue;
 			}
+			if (!strcmp(arg, "--show-object-storage-format")) {
+				puts(the_repository->object_storage_format);
+				continue;
+			}
 			if (!strcmp(arg, "--end-of-options")) {
 				seen_end_of_options = 1;
 				if (filter & (DO_FLAGS | DO_REVS))
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 5e7c25e42c..d080ab04a8 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -853,7 +853,10 @@ test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage with files bac
 	git -C objstorage config set core.repositoryformatversion 1 &&
 	git -C objstorage config set extensions.objectStorage files &&
 	test_commit -C objstorage A &&
-	git -C objstorage rev-parse --verify HEAD
+	git -C objstorage rev-parse --verify HEAD &&
+	echo files >expect &&
+	git -C objstorage rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage with unknown backend' '
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index d115d2d9f9..493a78f230 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -69,6 +69,9 @@ test_repo_info 'object.format = sha1 is retrieved correctly' \
 test_repo_info 'object.format = sha256 is retrieved correctly' \
 	'git init --object-format=sha256' 'sha256' 'object.format' 'sha256'
 
+test_repo_info 'objects.storageFormat = files is retrieved correctly' \
+	'git init' 'objects-files' 'objects.storageFormat' 'files'
+
 test_expect_success 'values returned in order requested' '
 	cat >expect <<-\EOF &&
 	layout.bare=false

-- 
2.56.0.307.g5fe7bd680c.dirty

