Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3859616F851
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 05:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731649836; cv=none; b=cKMxtFGOr148+p0en1pBZfkFbqW46ROjr9veRUxx9msX9liJyaO89Jn3CnOUCnKKspDkwBTXaz7/wXYc9/UuPSdEh+n/CW8FO13sAHSdHmSJBJfKkBMRlZ5NXhv72ds9bX2edGGulYmVuY2eWAj8l1vJ64rU05iq5J0wePMvJ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731649836; c=relaxed/simple;
	bh=WH7EnY+r8SdC0ZqeFqyqQuir3lb5mJyRcEyGtjTHVC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KLA3dwA2HZ/ZFY+1ewGjH7tmi3u+VtPXR8cHxm4GmcD+8DKc3OR6Ps29VtYXFrEdyzqnJQ2mhGkpTy1Ja2amYPUs4HP9oVAsBNjC0b3KoyR3J8F5feKhsfumK73PrkZP5otSwQ6/zH3N3hZaRyjbTqoCVBZ//3hjGLT7xQiJinA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qv7I/0jl; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qv7I/0jl"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 4B3ED13802BE;
	Fri, 15 Nov 2024 00:50:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 15 Nov 2024 00:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731649833; x=1731736233; bh=Mygn8cWFQQrQjhbPB1JhAe938PkNuuuwBSg
	6r8FGtPg=; b=Qv7I/0jlUkaUvirGikgiFLqk9y3zf/uZkq09tFN0pWZhXQVS1F/
	wS6Fut7N5ehPX0MudB/o5Sex9s3ORrvgobHk7InRddly/bmT0IjSEIl/j2aaPDdL
	Yxe8sGcXanSPqWKHkaH2t0YKKfvy1cDicMwTI1oc49x/1A6hieckwuuzLaPKqMyw
	hVuDNvqmawjw1DGhkhHi1p6P0NmyKpspYwX1Nl2xWPHG4HNaFhXFxtgjrzJEmeuc
	AwJktdYXF93VteJ6c+9YK/OzSWlj1RZG9F7p2FcTAH9Xeu3GBeY6OOQE24oENxlo
	3MnlvSqlB+0Hw/gvkIIajLFM1842dr5P/uQ==
X-ME-Sender: <xms:KeE2Z-_bs59WeLVTSverBGdzQz-zRji_msNQph92DaazWMAlxTJ34Q>
    <xme:KeE2Z-t6d-HQ1acVTisib2c6Kas9Ti-jjfA8a7gxvVUE18dYr7i0y9tg34hNtkRID
    zgmt71bPlc3QCglZw>
X-ME-Received: <xmr:KeE2Z0DQUmpFDqIrn2CABGPdRyP4BoJAh-xdZ8h2aGRtnOkYcuS6YMfFQvnuEs_q3iBJ0cBAqo66jmX7bsedSrRJ4gpyzejHkr7U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvghrug
    hinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruh
    hkpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhhohhgrnhhn
    vghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepfhgvrhguihhnrghnugihrdgsvghntggvsehtthhkrdgvlhhtvg
    drhhhupdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KeE2Z2eXP2yLnzwU8QNHGbYx-nj_sHCh11fFPdGx1cA9vs9OCIcGnA>
    <xmx:KeE2ZzPFUVrqWCf45u1p8hXiusYX-rgAZQ2aaym4zIoSLspD7P6UPw>
    <xmx:KeE2Zwll53GEyvDdGfjFBqouWLb_WXOGLNbWq2e7Y143KADW2sXh2w>
    <xmx:KeE2Z1usNcmOZl5RHu30nIsRGB1Ci9HV8lM9pAavqZegx0lJxAkW9g>
    <xmx:KeE2Z-pfFVN8ugh7SeB6TxYUfYC1_wThoggvATEmmTz47NA9wBn_Clek>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 00:50:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk, 	=?utf-8?Q?Ren=C3=A9?=
 Scharfe
 <l.s.r@web.de>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 	karthik.188@gmail.com,  Taylor Blau <me@ttaylorr.com>,
  ferdinandy.bence@ttk.elte.hu
Subject: Re: [PATCH v12 4/8] remote set-head: better output for --auto
In-Reply-To: <20241023153736.257733-5-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Wed, 23 Oct 2024 17:36:38 +0200")
References: <20241022194710.3743691-1-bence@ferdinandy.com>
	<20241023153736.257733-1-bence@ferdinandy.com>
	<20241023153736.257733-5-bence@ferdinandy.com>
Date: Fri, 15 Nov 2024 14:50:31 +0900
Message-ID: <xmqqcyix11w8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> Currently, set-head --auto will print a message saying "remote/HEAD set
> to branch", which implies something was changed.
>
> Change the output of --auto, so the output actually reflects what was
> done: a) set a previously unset HEAD, b) change HEAD because remote
> changed or c) no updates. As a fourth output, if HEAD is changed from
> a previous value that was not a remote branch, explicitly call attention
> to this fact.

OK.  That's sensible.

There is a slight variant of the fourth case.  HEAD may have been a
symbolic ref that pointed at an unexpected place (which you
addressed), or HEAD may have been a non-symbolic ref (which the new
code would mistakenly say "HEAD is now created", if I am reading the
patch correctly).

> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 9b50276646..0ea86d51a4 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -432,12 +432,51 @@ test_expect_success 'set-head --auto' '
>  	)
>  '
>  
> +test_expect_success 'set-head --auto detects creation' '
> +	(
> +		cd test &&
> +		git symbolic-ref -d refs/remotes/origin/HEAD &&

Are we sure refs/remotes/origin/HEAD exists at this point in the
test, regardless of which earlier tests were skipped or failed?  If
not, perhaps

		git update-ref --no-deref -d refs/remotes/origin/HEAD &&

is a better alternative.

> +		git remote set-head --auto origin >output &&
> +		echo "${SQ}origin/HEAD${SQ} is now created and points to ${SQ}main${SQ}" >expect &&
> +		test_cmp expect output
> +	)
> +'

Here, we could insert another one:

test_expect_success 'set-head --auto to update a non symbolic ref' '
	(
		cd test &&
		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
		git update-ref refs/remotes/origin/HEAD HEAD &&
		git remote set-head --auto origin >output &&

I'd imagine "output" should at least say that we are setting up a
symref origin/HEAD to point at some ref the --auto option figured
out, and if we wanted to report its previous state, it was a non
symbolic ref that pointed at some commit.  In any case,

		echo "${SQ}origin/HEAD${SQ} is now created and points to ${SQ}main${SQ}" >expect &&

is not what we want to see here, I suspect.

Can we detect the case where we overwrite a non symref with a symref
without going back to step 2/8 and doing a major surgery?

		test_cmp expect output
	)
'
