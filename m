Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E4D1EBA1C
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 11:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086183; cv=none; b=IWtlPDnPXj+zqKTWeM38PclCnU1tybmwIl3OSKYcjKNHKaQ2vEtGGGWs+sKure+J/WafvI4Tt7tHuP6XAwszw4XFedAXrXW4L+4iIjP4zVBWheAki3kN0BqC/UeuLOgDKtHkIy4J2ft31jFsZLpVeXIabBOPmj0Upf1eWCTcYxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086183; c=relaxed/simple;
	bh=DPYPHR0mP9KzgPB4sUp3z8OazCIwbK1bnLyz9xh2edA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAq3mqwIt78tENR7PM1k7kHmmAgWQB5lotlLmiL/31wIDr+8G2b4YwODkZsBLJ1zis3B4ywuz5MZAntjDd+Ik+27lmqKmmU8XSyLx/wWnUNxLlC3pehbudEMh0upmPcEqeHYOxF9vTedkr1Lz35hGIllDLPjRKsDYx4wOlJCs9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mi91uudl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=at5cWUZb; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mi91uudl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="at5cWUZb"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9E93D1382741;
	Tue,  4 Mar 2025 06:02:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 04 Mar 2025 06:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741086179; x=1741172579; bh=hcEtB+UYN5
	Bpi6wLU81KB4s9vqzCzVj584SNrGNGxz0=; b=Mi91uudl1elgk3L/5SH4U1D0NJ
	3HKEcMMX0rtwe1Qv8/UOQ0Nb23U6U3y00T7Co+8XfquR70y22I2TAR6TUTRxKwBb
	dpaibLpbjTXwLZwBM/jBVXfeJILTg5HV7eBL4ia0/Mf+ryt6yI309iPQBBWVtKUC
	aGs1qIIpmkaxf56z6RU7wXXFhEMyOmDgGaYRe1jTiQI2+ylT8lZA2L151ygRedY4
	gCSdJ60pIVeFVIpHnPYr6L/BcmnCyP53KoqMmV4SrwgUH108lNxS80moTgyvDUUN
	oQ4Lg0uQ+6BjHbJDoFnQMujCPtV5vpqYJ/BAT47oFxjInWPhuzJV9ElpQuWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741086179; x=1741172579; bh=hcEtB+UYN5Bpi6wLU81KB4s9vqzCzVj584S
	NrGNGxz0=; b=at5cWUZbijOX71XNMkv3iC2HMIrRBElY8YOazZas7Rm/G2RgiQ/
	c1O/rVECUBp8hmJ2MU0W+Y4lIV1B7sfIIY3OwU6XFdMDr0dfkkwysBkQfE5A27U3
	Sn38dyWf9dJRdCuaQOcPga7SqXbDj4NGD4/wmAE+gAsbX5KshQarMBAeJxG1Ey+G
	2FgAEAd0oVmLRd9UpxtjbvgOtyj3Y2pazNsbeIko6UzMwgCXLvUlpngBtcegaXav
	48rnPXRsyAH91v0/IovWSF0vgrfAO81Uf0eayLBv1dROZL+K2pVrWDaz3r25JU2V
	4IPxZDr+4WNxlashu1rUoqPP3sr5NTvmLzw==
X-ME-Sender: <xms:493GZ0Y2oSm0FSGzH53P7zsn-ompTf8rDl-uF8Ha2rMz1U_A-pvKmQ>
    <xme:493GZ_Yb5ZTqeXz-lIU73zlelMgC8RuU5KIYrzmE4fdveKWRBBCKJ0Y-LTAZIh16b
    y_qFZkonSzwN6ZknA>
X-ME-Received: <xmr:493GZ-9D1E6T19UuTmfePxoIBcW2Y6r3w8woCODFKqd4n-n8sqp7BoQWpVddy8ZOsufGHOQUUo2dKZbx6pU4eDIqGpRylBkkncuZyvT_8QStD3M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddukeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegurghnihhmrghhvghnughrrgdtledtgeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:493GZ-oSoWyXJKuxUgZobosEvCSUWkvk9ZeBLxYqZMw6ROY-QZsIWw>
    <xmx:493GZ_oNj48gqxiv9TEqpKpCzsgeADOQFCwny1n6QAx5Pbr71zrKww>
    <xmx:493GZ8Qr1tUFcKTTRBgqWoFEYHARVMGqz4IFB1ufugrXed0cp9OtYw>
    <xmx:493GZ_pL0DrWI5BImUAoAzFVXtP08kY0tK_iMnfiqaVS3hzRqkWW1w>
    <xmx:493GZ20gDGPr6coxLtOIEbTk-O9Z5CPlRDH5hM2RKGFl0TU_zaEakB7l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 06:02:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e43178f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Mar 2025 11:02:55 +0000 (UTC)
Date: Tue, 4 Mar 2025 12:02:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Mahendra Dani <danimahendra0904@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] t1403: verify that path exists and is a file
Message-ID: <Z8bd3iHrhXb4WH6A@pks.im>
References: <20250301105838.1481-1-danimahendra0904@gmail.com>
 <20250304092722.25757-1-danimahendra0904@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304092722.25757-1-danimahendra0904@gmail.com>

On Tue, Mar 04, 2025 at 02:57:22PM +0530, Mahendra Dani wrote:
> test -e does not provide a nice error message when
> we hit test failures, so use test_path_exists() instead
> and verify that if the path exists then it is a file using test_path_is_file().
> 
> Signed-off-by: Mahendra Dani <danimahendra0904@gmail.com>
> ---
>  t/t1403-show-ref.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
> index 9d698b3cc3..4afde01a29 100755
> --- a/t/t1403-show-ref.sh
> +++ b/t/t1403-show-ref.sh
> @@ -196,7 +196,8 @@ test_expect_success 'show-ref --verify with dangling ref' '
>  
>  	remove_object() {
>  		file=$(sha1_file "$*") &&
> -		test -e "$file" &&
> +		test_path_exists "$file" &&
> +		test_path_is_file "$file" &&
>  		rm -f "$file"
>  	} &&

There is no need to execute both functions. The underlying
implementation of these functions use `test -e` and `test -f`,
respectively. The former merely checks whether a path exists, whereas
the latter verifies that the path is a file. It follows that when the
path is a file it also has to exist, so using `test -e` (or rather its
wrapper function `test_path_exists`) is redundant.

Patrick
