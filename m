Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154417C089
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590111; cv=none; b=qsKtSKeiA2ABRuuPxtgnD5l38YgHJYKYzkPonvX8ihzACyu7KAl2MTqc3ctHP7LFl/cEWOlXe7I8dsQhmqcNK6DhasXJRzYDmKWgWcd/qZYgoEDvLFuVC8Z0An3u4zW+cxGMBHy9PHhGoBSfcSr1EaNWhB8DNSV0oKfdMqcqZ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590111; c=relaxed/simple;
	bh=9RbiAwrlG8BUN8unBHKQzKMTvQlzj9AgluZDdrIerKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4gEVPjqfalbPA2EyPSupfzCSViLOJsZZs0syOUCA4uNT8aZGfx9FQngIds5MnX+zyO8IJ27MsI68b2tGXiU3nbIhmwLKMEzvxxe1OMSvg15JREh+DV78qWtB+8OJp4RgaNzYyVKIRDV5aX8ZL+4gNdMs4qlXJVkMfJfuJ1wSSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=iX3RdIIW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SvcT8gWK; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="iX3RdIIW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SvcT8gWK"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E54D01140138;
	Mon,  4 Mar 2024 17:08:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 04 Mar 2024 17:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709590107; x=1709676507; bh=HlT6ZayyFdfzS2twdCTsem+TUrcwEdTH
	pG7BdG1+QTI=; b=iX3RdIIWu4drHs0dLzMkpbuuIV5kEehwmJWrkJ5MoECBY8T8
	gBdFiNL1lfk581ykcaOQiCkEQkMb5czQqH9+oIkPVCcKCm6ED9n+2Fq/3AZcwDPx
	mR3fiwKCvpsbec0tnmDJoJh7VDR/vtKKAx95h5uwLSyBAqxxs5zGG/9CN8BGampg
	y9bwWw8BuJRFaaQw18/wz4oGbKs+vuKBJ351eLdbsXR1ulJCNDoMZpagPo89i+xX
	PG0tcvsLtm87118xY2OLFaOD4BxSwAr061DxlHa4xwZ5T+6GZDK0nXZfgTvJelrx
	GM7dXf3o0goW7Wxr82/TITD5DwFXSRujuHPn+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709590107; x=
	1709676507; bh=HlT6ZayyFdfzS2twdCTsem+TUrcwEdTHpG7BdG1+QTI=; b=S
	vcT8gWKgL57GqhPLZLj6eaEWMBvfwA5rLdPn9WNIQNoG0eW+mwcYZBl/4kGDizTM
	d3PTBcLOOYx32xoDovqOItmr0vpyfwlHTxHLvmH7oS311ogeDckpTR3Dxr2HXthf
	Dznt9sEEUbOXpB1VECfzEIHhutLKUmNrGbDerk8qrmHwKKzV9L9Le2rpUkLZk29N
	DtZXv33iId9jehHEK3RXcPksthH9toXCR+FfR04LDw9zOiDKd5t5NcSNs+M/diMP
	0XtXyDjTpIgvbFaMQp+2ML0++aQeEi+DV+DBJ62+s169CqI7oO/9uS5nRCTxiP6I
	nAbKtlWImv7Wn2ckPZziA==
X-ME-Sender: <xms:W0bmZQ9fnpMqCVygTAzXgix3fDd_2Wczg0XIZuucSG1pFiU-WnvLyIA>
    <xme:W0bmZYsPoA8mBLOxY7zXg8FrHpY_JUSBX-355nObCm_cUu_f8KyFVNTFRhDUyGsGe
    7HJNrlp0E58fDED8A>
X-ME-Received: <xmr:W0bmZWDYoUrfzIf-TRXjB3S7SB7Zz3qQdClTP-ZvJo03otwm8tN4CujbGdTPeL_tpb_AMMnP45zVj8r-WYCWop7PaYlw2xUb1T2PEZ3J11PGCvNEv89POwE2NQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepvefgleevieekgeejieekueevhfelieduvdel
    geefkeejtdekvedttefgffevtedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:W0bmZQfNsixl-bEBAjjlV5OdNOMbLtg1KTI5nayDTD6xDQLCa2Me2g>
    <xmx:W0bmZVNaDf0Gtr7LialpckjHz0lOToAnEx8KNZhj4yddZur4dqloeA>
    <xmx:W0bmZamjQH1C43QROBrhrnyIWciOJG5mTSDRNzQ-aVsf2xVh7L7K8Q>
    <xmx:W0bmZarZyvVLI3GYgv1rHqJbIc86XJzvLdChUkOLfgkaQ8fFSFksSw>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 17:08:26 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>
Subject: [PATCH v3 0/5] advise about ref syntax rules
Date: Mon,  4 Mar 2024 23:07:25 +0100
Message-ID: <cover.1709590037.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.64.g52b67adbeb2
In-Reply-To: <4ad5d4190649dcb5f26c73a6f15ab731891b9dfd.1709491818.git.code@khaugsbakk.name>
References: <4ad5d4190649dcb5f26c73a6f15ab731891b9dfd.1709491818.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Point the user towards the ref/branch name syntax rules if they give an
invalid name.

Also make some spatially-appropriate improvements:

• Test style
• `advice.txt`

§ git-replace(1)

(see previous cover letter)

§ Alternatives (to this change)

While working on this I also thought that it might be nice to have a
man page `gitrefsyntax`. That one could use a lot of the content from
`man git check-ref-format` verbatim. Then the hint could point towards
that man page. And it seems that AsciiDoc supports _includes_ which
means that the rules don’t have to be duplicated between the two man
pages.

§ CC

For changes to `advice.txt`:

Cc: Elijah Newren <newren@gmail.com>
Cc: Jean-Noël Avila <avila.jn@gmail.com>

§ Changes in v3

• New preliminary patches 1–4
  • Fix test style
  • Improvements to `advice.txt` (style consistency and other)
• Patch 5/5:
  • Tweak advice doc for the new entry
  • Better test style

Kristoffer Haugsbakk (5):
  t3200: improve test style
  advice: make all entries stylistically consistent
  advice: use backticks for code
  advice: use double quotes for regular quoting
  branch: advise about ref syntax rules

 Documentation/config/advice.txt |  91 ++++++++++++-----------
 advice.c                        |   1 +
 advice.h                        |   1 +
 branch.c                        |   8 +-
 builtin/branch.c                |   8 +-
 t/t3200-branch.sh               | 125 +++++++++++++++++---------------
 6 files changed, 127 insertions(+), 107 deletions(-)

Range-diff against v2:
-:  ----------- > 1:  e6a2628ce57 t3200: improve test style
-:  ----------- > 2:  d48b4719c27 advice: make all entries stylistically consistent
-:  ----------- > 3:  30d662a04c7 advice: use backticks for code
-:  ----------- > 4:  3028713357f advice: use double quotes for regular quoting
1:  4ad5d419064 ! 5:  402b7937951 branch: advise about ref syntax rules
    @@ Commit message
     
     
      ## Notes (series) ##
    +    v3:
    +    • Tweak advice doc for the new entry
    +    • Better test style
         v2:
         • Make the advise optional via configuration
         • Propagate error properly with `die_message(…)` instead of `exit(1)`
    @@ Notes (series)
     
      ## Documentation/config/advice.txt ##
     @@ Documentation/config/advice.txt: advice.*::
    - 		'pushNonFFCurrent', 'pushNonFFMatching', 'pushAlreadyExists',
    - 		'pushFetchFirst', 'pushNeedsForce', and 'pushRefNeedsUpdate'
    + 		`pushNonFFCurrent`, `pushNonFFMatching`, `pushAlreadyExists`,
    + 		`pushFetchFirst`, `pushNeedsForce`, and `pushRefNeedsUpdate`
      		simultaneously.
     +	refSyntax::
    -+		Point the user towards the ref syntax documentation if
    -+		they give an invalid ref name.
    ++		Shown when the user provides an illegal ref name: point
    ++		towards the ref syntax documentation.
      	resetNoRefresh::
    - 		Advice to consider using the `--no-refresh` option to
    - 		linkgit:git-reset[1] when the command takes more than 2 seconds
    + 		Shown when linkgit:git-reset[1] takes more than 2
    + 		seconds to refresh the index after reset: tell the user
     
      ## advice.c ##
     @@ advice.c: static struct {
    @@ t/t3200-branch.sh: test_expect_success '--track overrides branch.autoSetupMerge'
      	test_cmp_config "" --default "" branch.foo5.merge
      '
      
    -+cat <<\EOF >expect
    -+fatal: 'foo..bar' is not a valid branch name
    -+hint: See `man git check-ref-format`
    -+hint: Disable this message with "git config advice.refSyntax false"
    -+EOF
    -+
     +test_expect_success 'errors if given a bad branch name' '
    ++	cat <<-\EOF >expect &&
    ++	fatal: '\''foo..bar'\'' is not a valid branch name
    ++	hint: See `man git check-ref-format`
    ++	hint: Disable this message with "git config advice.refSyntax false"
    ++	EOF
     +	test_must_fail git branch foo..bar >actual 2>&1 &&
     +	test_cmp expect actual
     +'
-- 
2.44.0.64.g52b67adbeb2

