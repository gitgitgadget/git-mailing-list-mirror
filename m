Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.106
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792701937;
	b=IhSIbhTfKomZMsqXqFr0IC6EXEfL2DsWLCbEFqOogCtywC52ah52JwAW35sQ86h+tBvC
	 VWfGUQx5blAu1Kte8mp4U6ExifNOKCkNP4f/VKiZQ70wbiYbOhD82RFAK5/NnugE2u/Io
	 ImkdqGN1nslcPK45mT1qVnBN1zTPHNRuwge2LCRif/H5O+maXmyb1Zefuj1gvO1fQzJc1
	 Ih7/pMaLY+H6uE4cfubSeMDZ1HcqesbwErwX3iFlcaoxr8SOYbSyE37aIlA/UXUWGjQod
	 MYb79/ficZX1eIAGaraknO/IUWZKVsoBO/vBKXVDc5tAjdYQVUkSyRd5BtlcdqPO39Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701937;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=hbxPyRGszq12hOs55lwihU4JWHw8VP+gegTqvCUw6t0=;
	b=zVFcDjRjsGArHk+o4J3xtxhCFkH3gWAcmbWkrrx75W/CM3u+va2E7s83JF3392Ig03L2
	 +7LFANFmRXJHWQ55CVJtdfTl2roy9+sl1+M/Ii8OXw5IrWOPW2rjRWXVh12ZMvnwt6gKk
	 EtbybW6w2sBzHzLK2CtMwB6OG1Zja8v07c5So9JD6tTDkXrmwg+sec/sng1cWGyCsZcDl
	 3XxGkWWk9Vp3lbweOksy71biS2fax+s5CQVdReHQy9eh7Wp6e2p35Rx58wDhTuHFtdb28
	 SG+l/tdJ8lk81X12QI0DXOodZSsbTkCQ0+AF9/cuholwzvm1vEl7PSaDtRnGk4YWJPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=vmiklos@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=KHT808S1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.106
Received: from sender5-pp-e106.zoho.com (sender5-pp-e106.zoho.com [165.173.182.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD872606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 20:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD872606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=vmiklos@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=KHT808S1
ARC-Seal: i=1; a=rsa-sha256; t=1792701928; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MCunvWKWv4gTc+4muFSeuJxoii7aaO+8Hjjo08HAJ8RB0jPHNq/g7DjjgZ3+Mq4vBioksmCk5amZ9j1PKOj2XaN/qCogmXLnnAJCVcOWqnl1FhQsQvpdafGExCmxXf2Iqwk73G9lCihqJhquEpp48pofl2MmjZz7Rt1TUjO0BLA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792701928; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hbxPyRGszq12hOs55lwihU4JWHw8VP+gegTqvCUw6t0=; 
	b=aB+xlTZ2tGiWWxlv2Yz4IyCHlJ9Y8IrqzY0HTaBYRgYuCWKWCASr3takHW3Ieaew8Cnub74Wc8qHoCjHtWLV3g3uonw4nSxFwJ+DYIc3n+yHTs+CimJXc5/VjVHrXOj5a3BG9zGWnYuijkFcHG5Dn3vFjiaO1gBlFLSWbdoSI9I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792701928;
	s=zohomail; d=collabora.com; i=vmiklos@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=hbxPyRGszq12hOs55lwihU4JWHw8VP+gegTqvCUw6t0=;
	b=KHT808S1nmWvD7Im351m5c3KbKB87MuqW5YooRoRxVgSCmK1HNHNFRRwGKlvAMnk
	MxSz8XQpvDhpfEOIP9QFirJhfmSbor/nEo1iNSjH0Tzynw+xsNJIwI8F4rCraQiV0xa
	lxU6lIKPSTKdBJGXDkZKTvX7qd0wDQ2tSkNmrRqI=
Received: by smtp.zohomail.com with SMTPS id 1792701925667659.2231402033653;
	Thu, 22 Oct 2026 13:45:25 -0700 (PDT)
Date: Thu, 22 Oct 2026 22:45:19 +0200
From: Miklos Vajna <vmiklos@collabora.com>
To: gitster@pobox.com
Cc: szeder.dev@gmail.com, ps@pks.im, git@vger.kernel.org
Subject: [PATCH v3 0/4] log: speed up --follow following renames for
 non-linear history
Message-ID: <cover.1792701579.git.vmiklos@collabora.com>
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
In-Reply-To: <atW0ctTe-lNq08A-@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/292.682.56
X-ZohoMailClient: External

Hi Junio,

On Mon, Oct 19, 2026 at 08:11:05AM +0200, Miklos Vajna <vmiklos@collabora.com> wrote:
> This leads to a larger patch: should I extract the "rethink the
> approach" and the new tests to separate patches or it doesn't matter?

Here is a series where I split the changes into 4 patches: add more
tests, a refactor, then your suggestion to start over (with one more
test) and finally the speedup.

Thanks,

Miklos

Miklos Vajna (4):
  t4219: test more --follow cases across merges
  log: extract showing the remerge/combined diff of a merge commit
  log: simplify --follow following renames for non-linear history
  log: speed up --follow following renames for non-linear history

 log-tree.c                  | 201 +++++++++++++++++++++++++-----------
 t/t4219-log-follow-merge.sh | 128 +++++++++++++++++++++++
 2 files changed, 271 insertions(+), 58 deletions(-)

Interdiff against v2:
diff --git a/t/t4219-log-follow-merge.sh b/t/t4219-log-follow-merge.sh
index 9616ac64ed..c8474ed151 100755
--- a/t/t4219-log-follow-merge.sh
+++ b/t/t4219-log-follow-merge.sh
@@ -144,6 +144,22 @@ do
 	'
 done
 
+test_expect_success '--follow follows renames through a fork with -m' '
+	git -C diamond log --follow -m --pretty=tformat:%s path >log &&
+	grep "^[A-Z]: " log | sort >actual &&
+	cat >expect <<-\EOF &&
+	A: add path0
+	B: modify path0 on upper
+	C: modify path0 on lower
+	M: merge with rename to path
+	M: merge with rename to path
+	X: rename path0 to path1
+	Y: rename path0 to path2
+	Z: modify path
+	EOF
+	test_cmp expect actual
+'
+
 # Build a merge that takes the renamed path from the second parent, while the
 # first parent only has the old path. $2 decides which side is committed first,
 # which decides the walk order.
-- 
2.56.0

