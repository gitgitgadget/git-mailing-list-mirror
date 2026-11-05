Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793875586;
	b=atlwEzF5HBd4EVG3T4hjKJS6l+OuLVF7EXFXtzThJAQWwQZHsHcvG6qwV/Ck1OhSk/wH
	 o4kqwJCbHqS3kVqJMF1iQD/LDWgDmdZYJM6s4Qo4yNQyrUU9qofdCwScgUQvQ3WqkfWv4
	 ikan73DS45347lYIHqZZn+L+uVkHz2CGOJyuEtum0Cjnjbfmeon6OVQpN4RWQLa+inzhU
	 nzZ5y9XMirlcNmqFG/774ae5Ja92IgY7S0vEXdayP/MPQ3fQIjHkCDZSVxdYN28FWodFz
	 6hWBjnkuklDBcv1/QEqRfX/QRIRCjakYv8UAwOrT8dNh6ywoew+rqFLwrrPaBIuiGeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793875586;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=SMqEBvUSaN0MF4fLSkiPAPfSD7HFrICSLWcfgMyuqMw=;
	b=m5zZEfuNe1P4IK0vPLft5hl5eQckcf7b1+PSR5FOs28hQ6jYmXPSgpCHSughDnwapTuD
	 tldCVpVAK/s6iBfvwvMKl1SzNJnbbL7IQxkJbtVofepI4DX24hA/v4Z8jFH7PNSv1CCMj
	 azclx56FhpyBjRRwFkd0rFAtTadXzQ+NSA2Ul9GqI2I67H78bFACrksEszmjtUg0Fd561
	 2xxWaeu4ZbYBfd33oViWrDPzjZ9kf7Fgml8OLI0bPek7uPMtmaJGgCHdU62ED6NporZ2l
	 mT/z7PR2qR5+J8IGhBK8Uf2u22NCmowF7k+GExZT/yDgjx9Y/4dq0femCIdHX5OpcXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=GJFOo9ZX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AC3606A326
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 10:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84AC3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=GJFOo9ZX
ARC-Seal: i=1; a=rsa-sha256; t=1793875573; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bZKqDOAc3XPfYjfylnvE6m0twXpQ4w8SRuV9MxfNZwK7uS81+3jTMI0WKJ08BfJWSdu/PBrp6FvS9HF9K33sIxHcVKAex3a4fp+YCAZBKiyiH9R8H8qoYQ0MNZW4bWYy7f5Xh8hq/u829zlloi2bbUg58mpTvFzJ7BkaPi1St0s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793875573; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SMqEBvUSaN0MF4fLSkiPAPfSD7HFrICSLWcfgMyuqMw=; 
	b=gMIqfNZSE6gmtR6kQClmtghr49BtHwBobhICheWELA9Jh8Sc8EEmgUrJWPh/sATJ/111bgAHFIaPZlKaICI2y8Pn6a14X6XkmNU4SeA1d1nZjMNCA6HyGwxMsBomGf5uDAvlA+P+PcoryYoTO3PJ6BwMfh7p7NXEFTCr7wf+BIU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=GJFOo9ZX7emYdCueYcLh64zDVccnkokKUvEA0GAfM1jEOthupvKSmgktkpnP6xHuRrotZmksDzs+eHBsAe/IXSYx6UTHtX/+bNyjtaILTqw66aHfmW9hJQu+AW/hqLjHz9MRL5Bq//J/YaEUkqJVQBTeCnj1cSR9zrepUPM8h5U=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=SMqEBvUSaN0MF4fLSkiPAPfSD7HFrICSLWcfgMyuqMw=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793875571744249.87756031576828;
	Thu, 5 Nov 2026 02:46:11 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Emily Shaffer <emilyshaffer@google.com>,
	Josh Steadmon <steadmon@google.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH] ls-remote: add --show-object-format
Date: Thu,  5 Nov 2026 12:45:41 +0200
Message-ID: <20261105104541.790881-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.56.0
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
of the object IDs. Not ideal, but the it can be figured out eventually.

2. If the remote is empty, "git ls-remote" prints nothing and fetch
succeeds, so the new local repo can silently get the wrong format,
which only shows up later, on the first push.

To fill this gap, add a ls-remote --show-object-format option which
prints the object format learned from the remote on a line of its own,
before the references.

[1]: https://github.com/jj-vcs/jj/issues/3813

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/git-ls-remote.adoc | 10 ++++++-
 builtin/ls-remote.c              |  8 +++++-
 t/t5512-ls-remote.sh             | 46 ++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-remote.adoc b/Documentation/git-ls-remote.adoc
index d71c4ab3e2..1abf7b60b7 100644
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
@@ -64,6 +65,13 @@ OPTIONS
 	upload-pack only shows the symref HEAD, so it will be the only
 	one shown by ls-remote.
 
+--show-object-format::
+	Show the object format (hash algorithm, e.g. `sha1` or `sha256`) used
+	by the remote repository before printing the references, on a line of
+	its own. This also works for a remote repo without any refs, which is
+	useful to find out which object format to use for a local repository,
+	before pushing or fetching the new remote.
+
 --sort=<key>::
 	Sort based on the key given. Prefix `-` to sort in descending order
 	of the value. Supports "version:refname" or "v:refname" (tag names
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index fe77829557..6d961f9961 100644
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
@@ -150,6 +154,8 @@ int cmd_ls_remote(int argc,
 
 	if (!dest && !quiet)
 		fprintf(stderr, "From %s\n", remote->url.v[0]);
+	if (show_object_format)
+		printf("%s\n", transport_get_hash_algo(transport)->name);
 	for ( ; ref; ref = ref->next) {
 		struct ref_array_item *item;
 		if (!check_ref_type(ref, flags))
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 2e1d4f7586..7e82154fe4 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -332,6 +332,52 @@ test_expect_success 'indicate no refs in v0 standards-compliant empty remote' '
 	test_expect_code 2 git ls-remote --exit-code --upload-pack=./cat-input .
 '
 
+# Run "ls-remote --show-object-format" with the given arguments over
+# protocol v0 and v2, and compare its output with "expect".
+test_show_object_format () {
+	for version in 0 2
+	do
+		git -c protocol.version=$version \
+			ls-remote --show-object-format "$@" >actual &&
+		test_cmp expect actual || return 1
+	done
+}
+
+test_expect_success 'ls-remote --show-object-format with empty sha1 remote' '
+	git init --bare --object-format=sha1 empty-sha1.git &&
+	echo sha1 >expect &&
+	test_show_object_format empty-sha1.git
+'
+
+test_expect_success 'ls-remote --show-object-format with empty sha256 remote' '
+	git init --bare --object-format=sha256 empty-sha256.git &&
+	echo sha256 >expect &&
+	test_show_object_format empty-sha256.git
+'
+
+test_expect_success 'ls-remote --show-object-format with sha1 remote' '
+	git init --object-format=sha1 repo-sha1 &&
+	test_commit -C repo-sha1 one &&
+	oid=$(git -C repo-sha1 rev-parse HEAD) &&
+	printf "sha1\n%s\tHEAD\n" "$oid" >expect &&
+	test_show_object_format repo-sha1 HEAD
+'
+
+test_expect_success 'ls-remote --show-object-format with sha256 remote' '
+	git init --object-format=sha256 repo-sha256 &&
+	test_commit -C repo-sha256 one &&
+	oid=$(git -C repo-sha256 rev-parse HEAD) &&
+	printf "sha256\n%s\tHEAD\n" "$oid" >expect &&
+	test_show_object_format repo-sha256 HEAD
+'
+
+test_expect_success 'ls-remote --show-object-format outside repository' '
+	nongit git init --bare --object-format=sha256 empty-nongit.git &&
+	echo sha256 >expect &&
+	nongit git ls-remote --show-object-format empty-nongit.git >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'ls-remote works outside repository' '
 	# It is important for this repo to be inside the nongit
 	# area, as we want a repo name that does not include
-- 
2.56.0

