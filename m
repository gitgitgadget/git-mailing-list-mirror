Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDBE17DFF2
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730901889; cv=none; b=Z1dcJ0FE5fSiMvDkPpTEnvje186PMg+t2Kf+RQhb7KZeLnXp0iEiOCTRAgs3qpnx3CFTQzvP3itErHFPJny0PJuQsoMD0jf6f/H7fWL/qymChp14nLyy3Vxk7txTqB8TC9dok5/R2exgDaTbRkWyNKpNBKkdRqZZQ2SV20tIji8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730901889; c=relaxed/simple;
	bh=LpxevZsg/vs4wgw7W8xQP45MYEj0p6h+b7UP2DyIIuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsWYq8MMpK4MoGCtjn1F8SWQXEylI072HKdqXytTq13cwLY6qAKb/lWpRRQxN84w0FsVuX1Yee59NETae7VKopHB64Q4fBKhV9oCMC80Nf5A08+O6DXwOyQofY74BGwgvCeWBQYgWvFSFCZwfqebDGFjeXvtxdOEvi0Zlh+dpWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VXNlPwcM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NEzUI0NJ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VXNlPwcM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NEzUI0NJ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 211E811401E2;
	Wed,  6 Nov 2024 09:04:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 06 Nov 2024 09:04:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730901886; x=1730988286; bh=icU0GnfXjf
	NCYbFJgdLfrmKKcDqAcn9/SeshHGeI0a4=; b=VXNlPwcMuPW4W6mAC4BZcdaoKx
	zBQ1MesivjwKuJ+bfR8YRMs8DK8cjF9CRkwe1DW01oOPlwZLdVoTxn/eqjybiVGi
	IfCb8TVxxGz6F4qjCdnwLB6c6H2zr7IFE+c+LVfs1hOa8nszW/zhSWz+tO1Znhe5
	sGqdzdnGl7Xq+6nnZ8cRaZb/garyh/G+/tS3lIN6TdqFo3LE0q1kMR3y05ncGRnT
	HzqKlc4r3viF8vk5fcB5xSQKNu+c/zWXt1Sm6pLoclQ9YDFWcLT8KjIepgp5zOpH
	Zj9hplAD5CM6vyCxyyfsjmaRLafgMZy2tx2X99d7A370Mu5ToNaHJFd9d3ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730901886; x=1730988286; bh=icU0GnfXjfNCYbFJgdLfrmKKcDqAcn9/Ses
	hHGeI0a4=; b=NEzUI0NJigD7hRNdVewzu79+UAW9foOugL48spSbHx/YzNZxzKn
	k/IYkaUcK/Zc7SR8c/cAp9lETxOz2bZxpThXHY6N0v2TmbBzncuNPyhWmSvGT4dj
	n1uQDzU1AgLmsK/MqL0ojRaSo/HBiWKYemQA8aTpczAtzvN4mRzLpEol9yH8zkff
	vs6OS2k/YYh9pt8Ggb+KQ2j485JpTT9/wYvUf75jVjAhujripUqGib5yt8sEPob7
	Jre0oGSn7Wgqq+tkh8RrlWXX6DIjPbNrtuhfrYla/F6lzr66tr4/v7XYYZaI1ehv
	TXIgLZ4e1Pph6Adr5qNKv6ur3sMFwyrMN8A==
X-ME-Sender: <xms:fXcrZx-oD2AaKsXbyRIRBc1KjO9jbOeOeSNt3F-75m6V7khbcjsHiQ>
    <xme:fXcrZ1uLQB4QAT4gmUFt7e-RP6SVo-HzMaybf5nIam2MEUYJ2V13Rwo69u8EErMil
    -Ttk2jZxZn__9S0OA>
X-ME-Received: <xmr:fXcrZ_Bv8zetdDIFCF8MZb_ehfpNX9QzpaIxioKs-LP2MkAwAzepG4mWtG7VEazONJeP91tRQ7Y8NpiIdyjYAFQltmbCLvuF9jIeWcwmmY2H5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhope
    hjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohho
    lhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:fXcrZ1e1Wx-c3MrCXCdxs2fztjfS4QmVaXCs39OGlQp0Ruqv1omZVA>
    <xmx:fXcrZ2MkcJlZhPx8L-5MzKGfAUuSnNaPaBb1239IjZyt0K1Z5ch4XA>
    <xmx:fXcrZ3kMm_sDDmNA8ENde0t7yhAW2SBu7rE2UM5ZZH1RVX-TuoEPUg>
    <xmx:fXcrZwuXYk4vz4oNciObUegXpIC6pJ1aHOcBX5m6uBNtVOOkFtMQbg>
    <xmx:fncrZ1eiH2d6yIh-oRh3JPcnD4AO9EMlZvRagCIukfXoWY3uYRh9K_l8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 09:04:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d548d527 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Nov 2024 14:04:17 +0000 (UTC)
Date: Wed, 6 Nov 2024 15:04:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/4] Add 'promisor-remote' capability to protocol v2
Message-ID: <Zyt3cVUtCS88UTAI@pks.im>
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240910163000.1985723-1-christian.couder@gmail.com>
 <20240910163000.1985723-4-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910163000.1985723-4-christian.couder@gmail.com>

On Tue, Sep 10, 2024 at 06:29:59PM +0200, Christian Couder wrote:
[snip]
> +static void filter_promisor_remote(struct repository *repo,
> +				   struct strvec *accepted,
> +				   const char *info)
> +{
> +	struct strbuf **remotes;
> +	char *accept_str;
> +	enum accept_promisor accept = ACCEPT_NONE;
> +
> +	if (!git_config_get_string("promisor.acceptfromserver", &accept_str)) {
> +		if (!accept_str || !*accept_str || !strcasecmp("None", accept_str))
> +			accept = ACCEPT_NONE;
> +		else if (!strcasecmp("All", accept_str))
> +			accept = ACCEPT_ALL;
> +		else
> +			warning(_("unknown '%s' value for '%s' config option"),
> +				accept_str, "promisor.acceptfromserver");
> +	}
> +
> +	if (accept == ACCEPT_NONE)
> +		return;

This code path is leaking memory because we don't free `accept_str`.
Once you reroll, I'd propose to have below patch on top to fix the leak.

Patrick

diff --git a/promisor-remote.c b/promisor-remote.c
index 06507b2ee1..0a4f7f1188 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -424,12 +424,12 @@ static void filter_promisor_remote(struct repository *repo,
 				   const char *info)
 {
 	struct strbuf **remotes;
-	char *accept_str;
+	const char *accept_str;
 	enum accept_promisor accept = ACCEPT_NONE;
 	struct strvec names = STRVEC_INIT;
 	struct strvec urls = STRVEC_INIT;
 
-	if (!git_config_get_string("promisor.acceptfromserver", &accept_str)) {
+	if (!git_config_get_string_tmp("promisor.acceptfromserver", &accept_str)) {
 		if (!accept_str || !*accept_str || !strcasecmp("None", accept_str))
 			accept = ACCEPT_NONE;
 		else if (!strcasecmp("KnownUrl", accept_str))
@@ -486,7 +486,6 @@ static void filter_promisor_remote(struct repository *repo,
 		free(decoded_url);
 	}
 
-	free(accept_str);
 	strvec_clear(&names);
 	strvec_clear(&urls);
 	strbuf_list_free(remotes);
