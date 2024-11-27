Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03D017E01B
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732750216; cv=none; b=keiR68u5h0AY2m0dOiMdkDC643O49Sdw1StHIHrmoZfpIlnVp9OQaEA0HZjL9wy4h1xwVdD5J+uJ/zEaMaOAl/5MnokCBt12byZ4NmLkDBpOM1JF35ThUVRiVNZsXlGNXifJGV2j8oOuTuTnvGIajxnVkrpW1NyGscKGsJ6P0MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732750216; c=relaxed/simple;
	bh=rk6DZmjD7Oahm20pQlS8rHheirRhNSYz+6cv+eIud90=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ThFeqYT7IUMNV8m88su8prbP29U3Cl79JWSqCqdDba8zVrUwd4QbqhOXi9l8jeh/AH0wBBlGHiIxx/s55/BmEHR7EgIo5/0Ts53bvTwdIvULYAv5NmUi2hEIDNR9K1E5f3UF4fZXDGrl+vWFZinzHJGO2yFwKYYYuA+9emyuEEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fuqbd4+C; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fuqbd4+C"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF29611400F8;
	Wed, 27 Nov 2024 18:30:12 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 27 Nov 2024 18:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732750212; x=1732836612; bh=CUm5S1xnBOHIT4DuJZAzXhOsyv/U8zvSwz4
	FQtKdoY8=; b=fuqbd4+CxXZ5/dxOCm1jnhOsPhR6CVfOJz0wOyqMmSTmHT7frej
	XdWWZre9jUMMowv1QUgXKJ11B28D0ZpSBVCJ/bAKfe0a0j9gbtbqjCtHHYmP2s/X
	7k7t62lKZcMKe/HHuYrJGPX8jj7SKjYL80aOQWQ8uTRLeFGzsZBoaJZgRHSKiKSG
	PvWeCfZGRybgOiZS33WLPuCs37LxfujfyPSuHg16pLXOvNf9ATUVMSyP9tHOGdZE
	5Y1LEp0DtUmc37cE2H+3J5CnXt+M2YuojsSEokCt+IInV44Bc6QrhDIduD0tBvb4
	8XlBfE7jSQjHS92yrjiSNyhgpAl8NskwwCA==
X-ME-Sender: <xms:hKtHZ8T_7PhlZAXbVmPzMKkCFjbHgYtkFplC9hgDg28RgX2JgkFKgg>
    <xme:hKtHZ5waWfMKU9OMI_-DxNS5_n6GXXMiW3ibRSx6760BKViU7_151sXzJHJrCQ_w7
    nDa-nMYrz05-8_D0w>
X-ME-Received: <xmr:hKtHZ53UCHJuVFMzRpo5gAnpJCoEsfZBDIrISoYeZvL3i3EQLDLZR-9oSwiux8STIkth9PuKBIGxfkNHDeUzIeHfTIsGWzYEh4BDQMo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedtgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepvefgvd
    ejjeekleehlefgveetudekteefkeffvedvkeehtddthffhveetjeehveejnecuffhomhgr
    ihhnpehtrghgrdgtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohepghhithesjhhofihilhdruggvpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:hKtHZwABZ-i4ax4UlJ0Wn-6RezHA_Yrqk8NztKWiOk6uxdRjGUyfjw>
    <xmx:hKtHZ1gxBac186GEOaGRJCXBHNSRsmIcujB4QA2YCxpAHpdxn-E4aw>
    <xmx:hKtHZ8qukRU4f4eACIyPg6iDwm14cyhiMdqr1O2qjpoxA73EW5yqLg>
    <xmx:hKtHZ4h55tK0SCXHAoI7nIEU2-kVaKTP9ulRXEdaw43_4qTjVTQwjA>
    <xmx:hKtHZ1exyrJJ6qc-6Xc0PdxAF8MxhzmKG_pYdsn1cI6II_aCjJRldP_9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 18:30:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@jowil.de,  git@vger.kernel.org
Subject: Re: git tag -a HEAD leads to ambiguous branch name
In-Reply-To: <20241127142711.GB1712@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 27 Nov 2024 09:27:11 -0500")
References: <47cdf937-6192-4c83-a0e5-700e98f36c1e@jowil.de>
	<20241127142711.GB1712@coredump.intra.peff.net>
Date: Thu, 28 Nov 2024 08:30:10 +0900
Message-ID: <xmqqh67ss1a5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Yes, I think that's reasonable. We won't ever completely forbid "HEAD"
> as a branch or tag name for historical reasons. But when porcelain like
> git-branch or git-tag sees it, it is almost certainly a typo or
> forgotten argument.

A quick band-aid would be

 builtin/tag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/builtin/tag.c w/builtin/tag.c
index 93d10d5915..c91aba5e26 100644
--- c/builtin/tag.c
+++ w/builtin/tag.c
@@ -449,7 +449,7 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 
 static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
 {
-	if (name[0] == '-')
+	if (name[0] == '-' || !strcmp(name, "HEAD"))
 		return -1;
 
 	strbuf_reset(sb);

but this (together with what "git branch" uses) is unsatisfactory
for at least two reasons.

 - This helper function and object-name.c:strbuf_check_branch_ref()
   should not be named with "strbuf_" prefix.  

 - The right place to do these checks is check_refname_format(), but
   it would retroactively forbid porcelains from using HEAD as the
   name of a branch or a tag (which is technically allowed, but it
   is dubious anybody wants to do so because it is so cumbersome to
   use).

There is a dubious test in t5604 that expects you can create such a
tag.  t5604.22 wants to create one:

test_expect_success 'clone with reference from a tagged repository' '
	(
		cd A && git tag -a -m tagged HEAD
	) &&
	git clone --reference=A A I
'

and t5604.24 wants to use it.

test_expect_success 'fetch with incomplete alternates' '
	git init K &&
	echo "$base_dir/A/.git/objects" >K/.git/objects/info/alternates &&
	(
		cd K &&
		git remote add J "file://$base_dir/J" &&
		GIT_TRACE_PACKET=$U.K git fetch J
	) &&
	main_object=$(cd A && git for-each-ref --format="%(objectname)" refs/heads/main) &&
	test -s "$U.K" &&
	! grep " want $main_object" "$U.K" &&
	tag_object=$(cd A && git for-each-ref --format="%(objectname)" refs/tags/HEAD) &&
	! grep " want $tag_object" "$U.K"
'

If we did this check at check_refname_format() level, it probably
will affect cloning from an existing repository with such a branch
or a tag.
