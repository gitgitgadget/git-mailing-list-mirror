Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794473603;
	b=wekxxhdx07vTg0JL8suT4W8iiiHWQqaE3VNC54k92YyKClkQ0TwILVYqztGVNR7h1/OC
	 1GgcDD5nErlWXdA0HFob7IwvCuSXfNP+HcRk8Qe52V89cBJTSXbA+PpG3wKauf7k6y88v
	 jxZcxA1LsqF61PosRhK3RBFB7xD21GOtLwPRnhsmNeAwIkBxFtLf1j5orlZwXCWYPjeLe
	 Bi3dME6njK4D7jHgHEvXERZ+wMQgFP9o9PXbOeM1QaiHjlLfOQMD0PVJYoXM0GafaqgfP
	 00Q5wdbuU1vahXzFVguZNmNf/jKAKhX7bgNV565Sme6fKzp3SkDjAHgvENtNXjQblAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473603;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uBWRjhRc424X/QOj2vTTn8CI40w+hDFe612NPxAfudE=;
	b=NDokzJhCGXk7f5nz7Ak9uUJSplcmj+GRyV1eVdkQ5i7io2/MiTrLk7PKz994hJuEtLpr
	 9mrwF65YiAmOs1d5MUAdCfHXaL2VTpW463wgfIufYHrhrACK5EX0hhe0j4w1FAg+gQmAm
	 jMeuReKoQSeASm8GJv6Y2XaZlZZBTtd8Spi8/PGidja9824YE2BC6tuqkjePvH8SZ9tSP
	 Z6c+rTs3PdNRxpc7leUZqJu4CIdwd1gy1NvvPG+CiwI5zmNip+VutcFRyNth3cHJ/WrkF
	 6/JOpMigrNDrRPmpxg4Q1oIrVL+wN0HI9YQb/U2shHIadJVKuY2SFNneisLmMXAKALQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=lU0EeXVE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BEC606A321
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 08:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19BEC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=lU0EeXVE
ARC-Seal: i=1; a=rsa-sha256; t=1794473585; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ICBQlWKsjMt38A5vfyzDQ4ZS1tmKUmG+5P9BfSVfrQUxUxJoDPJaUbL/9J5fDkK4PyLC63jTQzK/I58lM3l5la02Iqqck4jc6GZ5mCnKE5sJloLHqiwF+pMGtymBaTHotsOicPinHS0Z7Yo9AN17fUDAJBzdk/amWbd1OjRvOLM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794473585; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uBWRjhRc424X/QOj2vTTn8CI40w+hDFe612NPxAfudE=; 
	b=ZcNvXyJvPzyEt/LM2RHF3ymOxSiTz4qwTRzK0xyF3hcJGZbZ4MfMPMi65yMWzR03kMUX6iHSqIlUU+uGEeVeD1UpHJkJgyS5I1gb2/jQnAAgLapn3PmJcoF1Xzd2LVoBUMIoqccjy6IEJiTz/EoQkoU2XjAzmcLchPYUvFLFySI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=lU0EeXVEsxA6r4wTCoj3aLtwLhOauQCE2dP+lnGDf5JH4CHzCFWUp0X6/EIiFIN7UgBKJXy1ekElCMLbFVWkH1uin0ufYX8bEfVicWxsNRPBURBdxdL4VDX8hJCzRBs0NhipJDjWulmSOYUqBxkmcmq7dai6vr8tqVsGZsyQxkg=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=uBWRjhRc424X/QOj2vTTn8CI40w+hDFe612NPxAfudE=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794473583779776.3426550080281;
	Thu, 12 Nov 2026 00:53:03 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Emily Shaffer <emilyshaffer@google.com>,
	Josh Steadmon <steadmon@google.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2] ls-remote: add --show-object-format
Date: Thu, 12 Nov 2026 10:52:05 +0200
Message-ID: <20261112085205.452463-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261105104541.790881-1-adrian.ratiu@collabora.com>
References: <20261105104541.790881-1-adrian.ratiu@collabora.com>
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

While working on JJ sha256 remote support (it uses Git for networking),
I noticed there is no way to get the object format of a repo without
cloning it. [1]

Git clone learns the remote format during the protocol handshake, but
it is not shown anywhere else. For example, when creating an empty repo
and running "git fetch":

1. If the remote has references, fetch can fail with a mismatch error
and "git ls-remote" shows the format indirectly through the length
of the object IDs. Not ideal, but then it can be figured out eventually,
at least as long as no future hash algorithm has the same length as an
existing one.

2. If the remote is empty, "git ls-remote" prints nothing and fetch
succeeds, so the new local repo can silently get the wrong format,
which only shows up later, on the first push.

To fill this gap, add a ls-remote --show-object-format option which
prints the object format learned from the remote on a line of its own,
before the references, as "object-format: <format>". The prefix leaves
room for printing more remote properties in the future, without making
parsers depend on the order of the lines.

[1]: https://github.com/jj-vcs/jj/issues/3813

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
Changes between v1 -> v2:
* Print "object-format: <format>" instead of just "<format>". (Patrick)
* Reworded the --show-object-format documentation. (Patrick)
* Test helper now takes the expected format as an arg. (Patrick)
* Combined the sha1/sha256 tests in a single loop. (Patrick)
* Minor typo fix.
---
 Documentation/git-ls-remote.adoc | 11 +++++++++-
 builtin/ls-remote.c              |  9 +++++++-
 t/t5512-ls-remote.sh             | 37 ++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-remote.adoc b/Documentation/git-ls-remote.adoc
index d71c4ab3e2..5d80967df7 100644
--- a/Documentation/git-ls-remote.adoc
+++ b/Documentation/git-ls-remote.adoc
@@ -11,7 +11,8 @@ SYNOPSIS
 [verse]
 'git ls-remote' [--branches] [--tags] [--refs] [--upload-pack=<exec>]
 	      [-q | --quiet] [--exit-code] [--get-url] [--sort=<key>]
-	      [--symref] [<repository> [<patterns>...]]
+	      [--symref] [--show-object-format]
+	      [<repository> [<patterns>...]]
 
 DESCRIPTION
 -----------
@@ -64,6 +65,14 @@ OPTIONS
 	upload-pack only shows the symref HEAD, so it will be the only
 	one shown by ls-remote.
 
+--show-object-format::
+	Before the references, print the object format (hash algorithm)
+	of the remote on a line of its own, in the form
+	`object-format: <format>`, e.g. `object-format: sha256`. This
+	also works for remotes without any refs, so it can be used to
+	find out which object format a local repository needs before
+	fetching from or pushing to the remote.
+
 --sort=<key>::
 	Sort based on the key given. Prefix `-` to sort in descending order
 	of the value. Supports "version:refname" or "v:refname" (tag names
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index fe77829557..1d7bb578b3 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -12,7 +12,8 @@
 static const char * const ls_remote_usage[] = {
 	N_("git ls-remote [--branches] [--tags] [--refs] [--upload-pack=<exec>]\n"
 	   "              [-q | --quiet] [--exit-code] [--get-url] [--sort=<key>]\n"
-	   "              [--symref] [<repository> [<patterns>...]]"),
+	   "              [--symref] [--show-object-format]\n"
+	   "              [<repository> [<patterns>...]]"),
 	NULL
 };
 
@@ -49,6 +50,7 @@ int cmd_ls_remote(int argc,
 	int quiet = 0;
 	int status = 0;
 	int show_symref_target = 0;
+	int show_object_format = 0;
 	const char *uploadpack = NULL;
 	struct strvec pattern = STRVEC_INIT;
 	struct transport_ls_refs_options transport_options =
@@ -89,6 +91,8 @@ int cmd_ls_remote(int argc,
 			      2, PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "symref", &show_symref_target,
 			 N_("show underlying ref in addition to the object pointed by it")),
+		OPT_BOOL(0, "show-object-format", &show_object_format,
+			 N_("show the object format used by the remote repository")),
 		OPT_STRING_LIST('o', "server-option", &server_options, N_("server-specific"), N_("option to transmit")),
 		OPT_END()
 	};
@@ -150,6 +154,9 @@ int cmd_ls_remote(int argc,
 
 	if (!dest && !quiet)
 		fprintf(stderr, "From %s\n", remote->url.v[0]);
+	if (show_object_format)
+		printf("object-format: %s\n",
+		       transport_get_hash_algo(transport)->name);
 	for ( ; ref; ref = ref->next) {
 		struct ref_array_item *item;
 		if (!check_ref_type(ref, flags))
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 2e1d4f7586..1b063a586a 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -332,6 +332,43 @@ test_expect_success 'indicate no refs in v0 standards-compliant empty remote' '
 	test_expect_code 2 git ls-remote --exit-code --upload-pack=./cat-input .
 '
 
+# Run "ls-remote --show-object-format" with the given arguments over
+# protocol v0 and v2, and check that it prints the object format given
+# as the first argument, followed by the same refs as plain "ls-remote".
+test_show_object_format () {
+	format=$1 &&
+	shift &&
+	echo "object-format: $format" >expect &&
+	git ls-remote "$@" >>expect &&
+	for version in 0 2
+	do
+		git -c protocol.version=$version \
+			ls-remote --show-object-format "$@" >actual &&
+		test_cmp expect actual || return 1
+	done
+}
+
+for hash in sha1 sha256
+do
+	test_expect_success "ls-remote --show-object-format with empty $hash remote" '
+		git init --bare --object-format=$hash empty-$hash.git &&
+		test_show_object_format $hash empty-$hash.git
+	'
+
+	test_expect_success "ls-remote --show-object-format with $hash remote" '
+		git init --object-format=$hash repo-$hash &&
+		test_commit -C repo-$hash one &&
+		test_show_object_format $hash repo-$hash HEAD
+	'
+done
+
+test_expect_success 'ls-remote --show-object-format outside repository' '
+	nongit git init --bare --object-format=sha256 empty-nongit.git &&
+	echo "object-format: sha256" >expect &&
+	nongit git ls-remote --show-object-format empty-nongit.git >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'ls-remote works outside repository' '
 	# It is important for this repo to be inside the nongit
 	# area, as we want a repo name that does not include
-- 
2.56.0

