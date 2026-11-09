Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794211454;
	b=zznNTzrvo3n1QXAMBOghjZGs1HAzlh+7ZCQBFn6jkB3n+oEpv2PbJq4BwbXAsz3Eh5bc
	 mGfbcn/H11RfIfkt39W6HGFte+C3b69XPIFK1ZLzMy0SlN/w2Ejt0iMBaOaLtioJCcXS4
	 5uFmkQhr2nzpdofYC7OEo92F4B+Um2Go11jqpCEh7eY8PNHoUXMjgc2FAui1n8c4KdV6c
	 hR5Z5MKRDBfHqECX1xkA+rmMYOrnGLr14+z8CDdwnka+O5Tbty/eeYSlxylujlWwhSp+O
	 AZMfwu2rh6uwBIjc7tUGjCMvpXI77BoZsJBpUrwnHXTiL0/6ob6yuZ2QwbvTjBlxsPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211454;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=ORKLlRTuwFknzmr0gtzSq5ns3D3mvq2JLV8O4PJ1UM4=;
	b=J1Z+LACDB6OJJOZoKQfOmgbxnuEPtpELAOZkBBql69UyGPhkPV3jzRV9pYzYE7QfKnm8
	 F/zxtdIvvUCAm0n9S0uZvS6vn2DnpRMYZcO3QRKy4kG3nsb0hefkxM22TxeB8TUcZruWX
	 2oIS+5bNHbB1plszLrL3BHtMyFfsntPZDjgwp6vZIMkMVxeY0cHFBjs1XUt36x2CUhvOE
	 UoylXkOKbHF65OlCsp44MzlRTdou92Dij/Ntq/g4Or9i0g+p8VciczWW0/Q03svOnAor5
	 AVJJYG+zGn37V/WwXWQ58bwmazj4g4mCcuGemEs4QnNg8Xb/kO7TCfBR1XfDjsfPfOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=NVE9tjz0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E58A606EE8F
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 08:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E58A606EE8F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=NVE9tjz0
ARC-Seal: i=1; a=rsa-sha256; t=1794211447; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VOu885YeZ5eif9eoDp4LsOdKVmRxlnBoRckf6zFtdwZbnqGX8cyc+fwRu95crMzOGqCjcXLQ2gpz4cO0zyfI483HGGebPPjtb+oVmwF4vvMVe7H/zZHacMD0zVPNItjDH6gx7McOmZ6dasaKCPGkeMrDVEtVND0Du8Mzps6AUhc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794211447; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ORKLlRTuwFknzmr0gtzSq5ns3D3mvq2JLV8O4PJ1UM4=; 
	b=afYC3spEz6SK1lwFfTis8Ai5P6eAPC9GD152ligMQrscGLlU9VWkCn9V/UA6WSmwoh8bnHiCwE5SQOcQqNYMqsbQ9HkxRLAToKqsvlf/qb4aip73NfUDcj0Bn+STlT6mI2sF8J1IbneDFCxi28VuZ0DVRO/ZSJ5zTi2ueTCWGXc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: a=rsa-sha256; b=NVE9tjz0LBnlgUeNFl2WSDrpuODTON7OoVUIJ2lxY+/tFji3XTFT1fmcotDFxBHSv2q55TaOzBlhLyosl9tj+gYG4vf4jwOcp/oBH8MquEvJPytGbOzrSpUK6HY/sF669LD/uYlOx9rbCKYo5STdcemVSJ2nTCTIf+vJ0dha1eA=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=ORKLlRTuwFknzmr0gtzSq5ns3D3mvq2JLV8O4PJ1UM4=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794211446389959.5458195229519;
	Mon, 9 Nov 2026 00:04:06 -0800 (PST)
Date: Mon, 9 Nov 2026 09:04:00 +0100
From: Miklos Vajna <vmiklos@collabora.com>
To: gitster@pobox.com
Cc: szeder.dev@gmail.com, ps@pks.im, git@vger.kernel.org
Subject: [PATCH v5 1/5] t4219: test more --follow cases across merges
Message-ID: <5512aa682f71243378c06dcb8cda2b53150d4e39.1794078554.git.vmiklos@collabora.com>
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
In-Reply-To: <cover.1794078554.git.vmiklos@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.182.33
X-ZohoMailClient: External

A later commit in this series will speed up 'git log --follow' for
merge commits. Add tests for cases which already work, but have no
test coverage, so it's easy to break them while optimizing:

- a subtree merge adding the history of a file that was copied before
- --follow through a fork with renames on both sides, with -c, --cc
  and --remerge-diff
- a --no-ff merge taking a rename from the second parent, in both commit
  orders, since the result could depend on the walk order
- a merge keeping the path, while the other side renamed it
- --diff-merges=first-parent, which diffs merges only against their
  first parent, but still walks all parents
- a merge keeping the renamed path, while the other side edited the old
  one
- a merge keeping the copied path, while the other side edited the
  original

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Miklos Vajna <vmiklos@collabora.com>
---
 t/t4219-log-follow-merge.sh | 214 ++++++++++++++++++++++++++++++++++++
 1 file changed, 214 insertions(+)

diff --git a/t/t4219-log-follow-merge.sh b/t/t4219-log-follow-merge.sh
index e370f82955..806ccc24bd 100755
--- a/t/t4219-log-follow-merge.sh
+++ b/t/t4219-log-follow-merge.sh
@@ -31,6 +31,33 @@ test_expect_success '--follow finds the pre-merge commit through a subtree merge
 	test_cmp expect actual
 '
 
+test_expect_success 'setup subtree merge adding the history of a copied file' '
+	git init graft &&
+	echo outer >graft/outer.txt &&
+	git -C graft add outer.txt &&
+	test_tick &&
+	git -C graft commit -m "outer init" &&
+	mkdir graft/inner &&
+	cp inner/inner.txt graft/inner/ &&
+	git -C graft add inner &&
+	test_tick &&
+	git -C graft commit -m "copy inner.txt to inner/" &&
+
+	git -C graft fetch ../inner master &&
+	test_tick &&
+	git -C graft merge -s ours --allow-unrelated-histories \
+		-m "Merge the history of inner/" FETCH_HEAD
+'
+
+test_expect_success '--follow finds the history of a copied file through a subtree merge' '
+	git -C graft log --follow --pretty=tformat:%s inner/inner.txt >actual &&
+	cat >expect <<-\EOF &&
+	copy inner.txt to inner/
+	inner init
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'setup merge of two branches that both renamed a file to README' '
 	git init foo &&
 	mkdir foo/foo &&
@@ -126,4 +153,191 @@ test_expect_success '--follow follows renames through a fork in a single history
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
+test_expect_success '--follow with --diff-merges=first-parent follows all parents' '
+	git -C keep log --follow --diff-merges=first-parent --no-patch \
+		--pretty=tformat:%s F >actual &&
+	cat >expect <<-\EOF &&
+	B2: update G
+	B1: rename F to G
+	A1: update F in place
+	O: add F
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup merge keeping the renamed path, other side edited the old one' '
+	git init keep-renamed &&
+	printf "line 1\nline 2\nline 3\nline 4\nline 5\n" >keep-renamed/F &&
+	git -C keep-renamed add F &&
+	test_tick &&
+	git -C keep-renamed commit -m "O: add F" &&
+	git -C keep-renamed branch B &&
+	git -C keep-renamed mv F G &&
+	test_tick &&
+	git -C keep-renamed commit -m "A1: rename F to G on master" &&
+
+	git -C keep-renamed checkout B &&
+	printf "line 1\nline 2\nline 3\nline 4 T\nline 5\n" >keep-renamed/F &&
+	test_tick &&
+	git -C keep-renamed commit -am "B2: update F on B" &&
+
+	git -C keep-renamed checkout master &&
+	test_tick &&
+	git -C keep-renamed merge -s ours -m "M: merge B, keep G, drop F" B
+'
+
+test_expect_success '--follow follows an edit on the side the merge did not take' '
+	git -C keep-renamed log --follow --pretty=tformat:%s G >actual &&
+	cat >expect <<-\EOF &&
+	B2: update F on B
+	A1: rename F to G on master
+	O: add F
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup merge keeping the copied path, other side edited the original' '
+	git init keep-copied &&
+	printf "line 1\nline 2\nline 3\nline 4\nline 5\n" >keep-copied/F &&
+	git -C keep-copied add F &&
+	test_tick &&
+	git -C keep-copied commit -m "O: add F" &&
+	git -C keep-copied branch B &&
+	cp keep-copied/F keep-copied/G &&
+	git -C keep-copied add G &&
+	test_tick &&
+	git -C keep-copied commit -m "A1: copy F to G on master" &&
+
+	git -C keep-copied checkout B &&
+	printf "line 1\nline 2\nline 3\nline 4 T\nline 5\n" >keep-copied/F &&
+	test_tick &&
+	git -C keep-copied commit -am "B2: update F on B" &&
+
+	git -C keep-copied checkout master &&
+	test_tick &&
+	git -C keep-copied merge -s ours -m "M: merge B, keep F and G" B
+'
+
+test_expect_success '--follow follows an edit of the copy source on the side the merge did not take' '
+	git -C keep-copied log --follow --pretty=tformat:%s G >actual &&
+	cat >expect <<-\EOF &&
+	B2: update F on B
+	A1: copy F to G on master
+	O: add F
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.51.0

