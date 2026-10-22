Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792701963;
	b=qlU6m72IBz77SC0GYV+6ZfTrwATwb73M0V1Tu+VjfM7mIRgYE6uq9B1UsVqwkOLSlhlk
	 24FmdSVzJtrscGdRv/nAguijTF+ti+uee7FT9UmWx0GndEcPeBYvca9nJRNaAniqBKdoM
	 GGw2BUf34TZaXr3V0jCrhJX+1iR3TsI8oJXlu8Pji7mxD2h/I7Rwam1yMljxvvrkhZTTH
	 EL/RkMs+qJPaIZduGSzngWSIrxL4D99V88ZFRgLFlgM0VBghT/Fkgei085gEZdX+f/w/z
	 WjZfXC/SZ4ixX6/h9SfiF+5IYqszt4Dn6KBE71FKzlZjGcDsPXsmNQw97aVfgxQWt1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701963;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=sYUuJIOi0Comm7VnXbt8BvIwOfv/SeFhqTW1aakSuQ4=;
	b=E1DQoLoIMqZ8wbDp9QjS/ArhJB65nI+LFFRZRGUQCiEeyNt6b0zyNLNs+YpHp9KcFAO7
	 URs+/tZY2U3JOqV8ivMyg0m5AH2aOMzcgiKqCRpuYyAjsOjLjnfljQIXGU67zJPOfDA8M
	 ivTFnLS8AVk5heNz99EUOWwNgs86uUvJ13bM5TlN2p73/ZyvFnEOpQG9KEVw6lo3xoOFo
	 50toUKAEqdp8w6wkxNYiZqjJEcd2SuMx+f0+FeivTHbbhuSpYfPIE4DL+xRsEQ0Etgc1B
	 1ViMikLPr/rv2IjGtmVJnWN7QDcdIFkIaFVNOpG31u2NLtonfAn8biRIbWMN5pwHCww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=vmiklos@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Ngv8L1KO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849FC606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 20:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 849FC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=vmiklos@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Ngv8L1KO
ARC-Seal: i=1; a=rsa-sha256; t=1792701954; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cYdjjpFouaIzCLk/nS5kAo7Ibgfx65G3NWzxxrLg9wLu+neTzuJJ0FUGysCwOy1rTu03BSFVsxrHoj4BJxo66WwLyEyTpO8hRKPrBq9IwZtUBla5fob0m66T3pDqb1I+B4d7Lk12PfK1Oph8EYP9QaApoFj/XRRa6CgPRxU1JX0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792701954; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sYUuJIOi0Comm7VnXbt8BvIwOfv/SeFhqTW1aakSuQ4=; 
	b=fNfQi9OgPlRJ6pWCF1usnNqDg1/quZf3TquTX4/n3C21jKJyCM3WY2doGGlXSs56hWnt6Bs2YI4bqJXHbcg+fV+8fuqysy6W5CYOXlg+CNiZafupM1Pt4eQ/+viBfgHGh82neytA+kJC2wJqvAXEfpjNESGJvFasshc6MZ5VOAI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792701954;
	s=zohomail; d=collabora.com; i=vmiklos@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=sYUuJIOi0Comm7VnXbt8BvIwOfv/SeFhqTW1aakSuQ4=;
	b=Ngv8L1KOjUlbpm0fyAscVPPx7p/k2wBB9/dG8myvO3lZnXqeWjJRgqwd1u3jwwIR
	ni/ADFcr++cHKWl5KHSgFsPVUXGjrJ4el1LCT0ttpoXvAzWTN87rgpJCMf8v19Djgl5
	MxJov9S6J14VTzoKcrM1201TDnKlMqxJ4fEZiIPU=
Received: by smtp.zohomail.com with SMTPS id 1792701952570835.3199616441486;
	Thu, 22 Oct 2026 13:45:52 -0700 (PDT)
Date: Thu, 22 Oct 2026 22:45:48 +0200
From: Miklos Vajna <vmiklos@collabora.com>
To: gitster@pobox.com
Cc: szeder.dev@gmail.com, ps@pks.im, git@vger.kernel.org
Subject: [PATCH v3 1/4] t4219: test more --follow cases across merges
Message-ID: <704c6df3ff82ae6a686200fd6df09c41b39619ce.1792701579.git.vmiklos@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1792701579.git.vmiklos@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/292.682.56
X-ZohoMailClient: External

A later commit in this series will speed up 'git log --follow' for
merge commits. Add tests for cases which already work, but had no
test coverage, so it's easy to break them while optimizing:

- --follow through a fork with renames on both sides, with -c, --cc
  and --remerge-diff
- a --no-ff merge taking a rename from the second parent, in both commit
  orders, since the result could depend on the walk order
- a merge keeping the path, while the other side renamed it

Signed-off-by: Miklos Vajna <vmiklos@collabora.com>
---
 t/t4219-log-follow-merge.sh | 112 ++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/t/t4219-log-follow-merge.sh b/t/t4219-log-follow-merge.sh
index e370f82955..9616ac64ed 100755
--- a/t/t4219-log-follow-merge.sh
+++ b/t/t4219-log-follow-merge.sh
@@ -126,4 +126,116 @@ test_expect_success '--follow follows renames through a fork in a single history
 	test_cmp expect actual.sorted
 '
 
+for opt in -c --cc --remerge-diff
+do
+	test_expect_success "--follow follows renames through a fork with $opt" '
+		git -C diamond log --follow $opt --pretty=tformat:%s path >log &&
+		grep "^[A-Z]: " log | sort >actual &&
+		cat >expect <<-\EOF &&
+		A: add path0
+		B: modify path0 on upper
+		C: modify path0 on lower
+		M: merge with rename to path
+		X: rename path0 to path1
+		Y: rename path0 to path2
+		Z: modify path
+		EOF
+		test_cmp expect actual
+	'
+done
+
+# Build a merge that takes the renamed path from the second parent, while the
+# first parent only has the old path. $2 decides which side is committed first,
+# which decides the walk order.
+setup_rename_on_second_parent () {
+	git init $1 &&
+	printf "line 1\nline 2\nline 3\nline 4\nline 5\n" >$1/old &&
+	git -C $1 add old &&
+	test_tick &&
+	git -C $1 commit -m "A: add old" &&
+	printf "line 1\nline 2\nline 3 modified\nline 4\nline 5\n" >$1/old &&
+	test_tick &&
+	git -C $1 commit -am "B: modify old" &&
+	git -C $1 branch topic &&
+
+	if test "$2" = topic-first
+	then
+		git -C $1 checkout topic &&
+		git -C $1 mv old new &&
+		test_tick &&
+		git -C $1 commit -m "R: rename old to new" &&
+		git -C $1 checkout master
+	fi &&
+
+	echo other >$1/other &&
+	git -C $1 add other &&
+	test_tick &&
+	git -C $1 commit -m "M: unrelated change on master" &&
+
+	if test "$2" = master-first
+	then
+		git -C $1 checkout topic &&
+		git -C $1 mv old new &&
+		test_tick &&
+		git -C $1 commit -m "R: rename old to new" &&
+		git -C $1 checkout master
+	fi &&
+
+	test_tick &&
+	git -C $1 merge --no-ff -m "merge topic" topic
+}
+
+test_expect_success 'setup merge taking a rename from the second parent' '
+	setup_rename_on_second_parent rename-master-first master-first &&
+	setup_rename_on_second_parent rename-topic-first topic-first
+'
+
+for order in master-first topic-first
+do
+	test_expect_success "--follow follows a rename from the second parent ($order)" '
+		git -C rename-$order log --follow --pretty=tformat:%s new >actual &&
+		cat >expect <<-\EOF &&
+		R: rename old to new
+		B: modify old
+		A: add old
+		EOF
+		test_cmp expect actual
+	'
+done
+
+test_expect_success 'setup merge keeping the path, other side renamed it' '
+	git init keep &&
+	printf "line 1\nline 2\nline 3\nline 4\nline 5\n" >keep/F &&
+	git -C keep add F &&
+	test_tick &&
+	git -C keep commit -m "O: add F" &&
+	git -C keep branch B &&
+	printf "line 1\nline 2\nline 3 A\nline 4\nline 5\n" >keep/F &&
+	test_tick &&
+	git -C keep commit -am "A1: update F in place" &&
+
+	git -C keep checkout B &&
+	git -C keep mv F G &&
+	test_tick &&
+	git -C keep commit -m "B1: rename F to G" &&
+	printf "line 1\nline 2\nline 3\nline 4 B\nline 5\n" >keep/G &&
+	test_tick &&
+	git -C keep commit -am "B2: update G" &&
+
+	git -C keep checkout master &&
+	test_tick &&
+	git -C keep merge -s ours -m "M: merge B, keep F, drop G" B
+'
+
+test_expect_success '--follow follows a rename on the side the merge did not take' '
+	git -C keep log --follow --pretty=tformat:%s F >actual &&
+	cat >expect <<-\EOF &&
+	B2: update G
+	B1: rename F to G
+	A1: update F in place
+	O: add F
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.56.0

