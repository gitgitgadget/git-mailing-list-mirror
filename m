Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5ED23371E
	for <git@vger.kernel.org>; Wed, 21 May 2025 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747814185; cv=none; b=aCQXXbsnjahqeDhaca5hHxZt7TTVAoCPGuhynblGUmyrS7WWNGzTg+K4miiC5Td5zzKaBORBApi1g8SE6bwdmDYsYFqQOSM9dmPXIkOnQDlU0aTGfokJ4eDs6yTR4jSK17O/gSxuWeQtP2BYbxXDPr12Vzq6fxWJI613spH8EBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747814185; c=relaxed/simple;
	bh=asZIySz0q6YwE7xuCf+6u7IuBckfCH01iwZQDHi/20s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNQRrEuLqi+iSW+R4KXE/fr9Xyb2KNCX8aB8CCm9/1vosZCvYPLmaSCbLpoCdUq0k6/0oCS5A1wvCTRTeDU9z+qR7yaQ1QtCk7bLOqRvDmIBnwGntJoZvxslGjeiPqel+3WeWIHGiLvjos7SzjwTOYzntBMpCEak4PZ0PSEW5Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b7rOFmXo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XS9kgzTF; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b7rOFmXo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XS9kgzTF"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 1E66813800ED;
	Wed, 21 May 2025 03:56:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 21 May 2025 03:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747814182; x=1747900582; bh=jlDkPH/8Yw
	KKlCfzd/i8oAl6IsV3YFibcS7Bz7xj7eA=; b=b7rOFmXoVhoowfgQO/9hzeX/cL
	Y+q3gcLvlJ9u/3d5nFB3el+RL+xbzmVSMttF2QIozHXsHJuFtHEFV/8EtfBT24va
	SGuOE/iRRd4+iHXb/vnM+pB9Ed2YyHG0kFjsg8imisGhWGEgeflrGkhsAzaaWKkX
	GtZFNBEAwUgmOUCAmrTpemy+58/eCN9LxW9DGbGr1Ukb22/3Y6ve/I3tu1gqoED3
	NknIiypNaOIXdyu9hzVErUpjYBcQYbas/+PJsciJf4P0xijUL7SYaBDmD/7mNCq3
	mjsndiQ+423TzCnBdidIu5wllO3H6dmKe3VZpVOen0MJLQPpveqDJMNVxMnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747814182; x=1747900582; bh=jlDkPH/8YwKKlCfzd/i8oAl6IsV3YFibcS7
	Bz7xj7eA=; b=XS9kgzTFLDIujT/A7yoIylcc0aDCSi9/M9crm9ODZMh3kMbQl/k
	BRcUF6x9UfJiWnpc0BMexYIvcSafGs8JSCTiry6Lbkai0ocZeFuuUhGH2FMhHOTN
	/wTVt7Z5h4IbCThKGfd8f9qt12nho882Cc2JMWLAzFTsGgxaxjd4XftT1u843HLN
	QtTBtse5Nydq7oau3t/EPKFpEbukBuyx6lDvfJLy8uQCiy/mfcOgqIAQgb8aKYXN
	ZeErfPu4vvHVdZWtU4MCrz2lb44QGJfIqqX8cAqYrRI4mQcJr05wUnd9k14STUmw
	90lQIhpVXXONZJysRZXeBi7MphcJPpQIEVg==
X-ME-Sender: <xms:JYctaOaX5YL82wgFKwLvDC8hknfMhFE0qWnJbPMqVVNgheWc92Va7g>
    <xme:JYctaBZtOMbGsZLFNM149Bja1BMiJmhapmlCjINzr9k-oFBvWzXFqc4dncwBpVuZ0
    h0ICOozLJAX5zCqrQ>
X-ME-Received: <xmr:JYctaI-OsLMaagr2hvN2jDlz3On3c1PUtUMAVsLHJzZukBvx6-YUVrv1irRJOfa8jvP3RcjLA1kEdfeZafqCTS62QHVNTn5k9RzVCFiJdc8C7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvheefucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefr
    rghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrg
    htthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfej
    vdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvodhgihhthhhusgesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JYctaAqZ-NTv1vjmTAPwlpCDg7r8k936Bet6l7Dal0IA0oTwqJecJA>
    <xmx:JYctaJrp0wRTl1SoFngWxNE6UEKPN1bu6ZmY3MWIzO762Vkj4ccL4A>
    <xmx:JYctaORu-dgHOAdRCdRORo9B8AuCLia56gJS2PzE80H6EYBQYnBqaQ>
    <xmx:JYctaJqgouB6BMSKyWPoBZYsLJxg7z1QiPyPdYPhmTTTr3QznDKsmg>
    <xmx:JoctaFHQEA_08aUNmozKu28Mnz3Gvti0iOymIdoBBT2djUrh9CCR74wN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 03:56:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e150a89a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 21 May 2025 07:56:20 +0000 (UTC)
Date: Wed, 21 May 2025 09:56:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] t7005: sanitize test environment for subsequent tests
Message-ID: <aC2HI4sMF3t8K4Jv@pks.im>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
 <20250520193506.95199-2-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520193506.95199-2-ben.knoble+github@gmail.com>

On Tue, May 20, 2025 at 03:34:55PM -0400, D. Ben Knoble wrote:
> Some of the editor tests manipulate the environment or config in ways
> that affect future tests (because they test a sequence of overrides),
> but those modifications are visible to future tests and create a footgun
> for them. Use test_config and undo environment modifications once
> finished.
> 
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
>  t/t7005-editor.sh | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
> index 5fcf281dfb..06fa1ecd91 100755
> --- a/t/t7005-editor.sh
> +++ b/t/t7005-editor.sh
> @@ -111,6 +111,8 @@
>  	'
>  done
>  
> +unset EDITOR VISUAL GIT_EDITOR
> +git config --unset-all core.editor
>  test_expect_success 'editor with a space' '
>  	echo "echo space >\"\$1\"" >"e space.sh" &&
>  	chmod a+x "e space.sh" &&

Could we maybe adapt the tests that set those envvars to use a
`test_when_finished`? Something like this (untested) patch:

diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 5fcf281dfbf..a14ff4b38c4 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -93,17 +93,19 @@ unset EDITOR VISUAL GIT_EDITOR
 git config --unset-all core.editor
 for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
 do
-	echo "Edited by $i" >expect
-	case "$i" in
-	core_editor)
-		git config core.editor ./e-core_editor.sh
-		;;
-	[A-Z]*)
-		eval "$i=./e-$i.sh"
-		export $i
-		;;
-	esac
 	test_expect_success "Using $i (override)" '
+		echo "Edited by $i" >expect &&
+		case "$i" in
+		core_editor)
+			test_config core.editor ./e-core_editor.sh
+			;;
+		[A-Z]*)
+			test_when_finished "unset $i" &&
+			eval "$i=./e-$i.sh" &&
+			export $i
+			;;
+		esac &&
+
 		git --exec-path=. commit --amend &&
 		git show -s --pretty=oneline |
 		sed -e "s/^[0-9a-f]* //" >actual &&


> @@ -119,13 +121,10 @@
>  
>  '
>  
> -unset GIT_EDITOR
>  test_expect_success 'core.editor with a space' '
> -
> -	git config core.editor \"./e\ space.sh\" &&
> +	test_config core.editor \"./e\ space.sh\" &&
>  	git commit --amend &&
>  	test space = "$(git show -s --pretty=format:%s)"
> -
>  '

This hunk looks good to me.

Patrick
