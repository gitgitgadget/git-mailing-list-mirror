Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725071A8F8E
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740038733; cv=none; b=pnHdZg4aKfALr1buIDJ9JzoJLLhA9hJCKyUn2lqZwXtli/+EVm6gknSJp+SRts8/lI82HHcKw3mqWasFMTpkaMoU2ffsJO//+JGD+F/TJNzpkl2sCK3kI+OIBhn/p8jxJMXlEtDBOnpYYW/raN8RKxMNDr4tYRFpHIqjTnrSecg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740038733; c=relaxed/simple;
	bh=m/vJuwSx7y26fLPfmOYJ3CwHL5kAbfs7vlzZSKz0dA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWqK7trxkSDYHOrmg9H/2Es9NUeosMONdk/FYhovLx9hW2zizEVdX39ZZQN4o9Npru1JWloo31NhHblJFj6K5NwnHrCXbEUO/kAw4cX4p4LAeEp+uBeKhyExTBj7qbBnuPghIRsVd6mJRhDxNrfy76E3mgQ4Hzesa2ZCSfbPcjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mg7J6PrA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hipYg/2M; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mg7J6PrA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hipYg/2M"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 1EC6511400CA;
	Thu, 20 Feb 2025 03:05:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 20 Feb 2025 03:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740038729; x=1740125129; bh=jlYCoAx/7O
	M0ljElxkfcKU9bkCy9HeRf+iEhFY2gQU0=; b=mg7J6PrA77ZIguZz7XgAqE6/6r
	D0X5iWAKoPT/Y3yp1v14lupz4ICkg1gp7ar/n+yAD1ne48xtQe/YkPuENG5iqWXH
	fKwvJdu1juNd3P2V/taLpo+6CyvxDLD/emNs5KUMySaT3VnMJ7G/qjK0bcNDa6Bf
	Lfj8tWdTMQDbzhfKCcFquTDVwxy58HeGZny5+8NOU9THEBri/c0Raxkv+VwUUYVU
	IUBncFDIbSd3U+GPe359Hm05aoqLJvMLkPbVmLxqK8q46ogGdeEtjUxHPT9EYUwR
	1K8cpoOebNfJ9lvs99RkRUi80lmMeMnxsFxi2ahAmZKwFH+th5yzbeJ2cFiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1740038729; x=1740125129; bh=jlYCoAx/7OM0ljElxkfcKU9bkCy9HeRf+iE
	hFY2gQU0=; b=hipYg/2MhvB+3IemV7VCICXiZ9CTjErmOa7fnuGX2dlJGCOOcfp
	/z8PPkx5xTV0BfY+3yM5gg1UwyrlHra3lYEdsGWQ4DrGWayHz9Ci5qE7RShjRXll
	zySAmr9FNkaUkNSpxbOAq4PaSnN9KYlLe/ZRDcfWE9FFufnxq9yEOz/hvAQzAFg9
	kIEcXzJwN+VNYnBIhIZbWOmSCTkmkRf3bOggvDmxiedhlS1o2hUy2F2ReV5LaKpV
	hFPmorncExy08V1kkbyiiJ44TB53LBfqbpVTwVjW7m8HywjxuULmJVVeRoWAr/6M
	vZJHV7vAl9mp3Q/75yl52IBfnhmg8k9AMgw==
X-ME-Sender: <xms:SeK2Z4sL6NaMA-6X-dOjMUhjiNCvdClVny-GAjPDbxhYZE01hcOLew>
    <xme:SeK2Z1foRXFZHgtbZNIt61siwKC-RB_REvjkTc4xda1AdodcZnWiF4oxWHnoUU8JE
    gNtoUz8LeJhT5sMCw>
X-ME-Received: <xmr:SeK2ZzxvFqN2Bwq1Mr0rUOU7hn5GQnGlDbmmRx-rgBbTCGcqE32liMhssDO5aXqI0hfWygQH0hFofta3xxl9Qv6hedXJP7hgW3HJ6bw-F3Jd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiieeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghl
    vghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:SeK2Z7OwsHA1zenLBuuSUdzXsw9BzcI4ayYkC47TbHFYHszyU5U5mA>
    <xmx:SeK2Z4_SQxWaM819XhIWBTpUhj8DcAeQCvWmEC7SpS4sHluuqTM4Aw>
    <xmx:SeK2ZzW9x5u-Eb1s9yalF9PDdYz3QQerWfqHO27W7XN4qQ8Z6SSCKA>
    <xmx:SeK2Zxe_gp1yzRxr7_5lu7QpuiL7hMkobpEJVECta3ouczhVYZQ01g>
    <xmx:SeK2Z8Seb7SdufQUCu0FnnVj-m93M7d44MjxUl8FYx1rHnt-gBI14d1U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Feb 2025 03:05:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0e27bed7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Feb 2025 08:05:24 +0000 (UTC)
Date: Thu, 20 Feb 2025 09:05:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	shejialuo <shejialuo@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 03/16] builtin/update-ref: skip ambiguity checks when
 parsing object IDs
Message-ID: <Z7biPX-FAefLanh5@pks.im>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
 <20250219-pks-update-ref-optimization-v2-3-e696e7220b22@pks.im>
 <7q2ldwq2mc7vhpqfpj4lg5jc2badt5sgcv6x3eeqjcboraiqxn@5bzhi5n6alxm>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7q2ldwq2mc7vhpqfpj4lg5jc2badt5sgcv6x3eeqjcboraiqxn@5bzhi5n6alxm>

On Wed, Feb 19, 2025 at 12:21:44PM -0600, Justin Tobler wrote:
> > diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> > index 4d35bdc4b4b..d603f54b770 100644
> > --- a/builtin/update-ref.c
> > +++ b/builtin/update-ref.c
> > @@ -179,7 +179,8 @@ static int parse_next_oid(const char **next, const char *end,
> > @@ -783,7 +786,8 @@ int cmd_update_ref(int argc,
> >  			 * must not already exist:
> >  			 */
> >  			oidclr(&oldoid, the_repository->hash_algo);
> > -		else if (repo_get_oid(the_repository, oldval, &oldoid))
> > +		else if (repo_get_oid_with_flags(the_repository, oldval, &oldoid,
> > +						 GET_OID_SKIP_AMBIGUITY_CHECK))
> >  			die("%s: not a valid old SHA1", oldval);
> >  	}
> 
> In builtin/update-ref.c all uses of repo_get_oid() have been converted
> to repo_get_oid_with_flags() with the GET_OID_SKIP_AMBIGUITY_CHECK flag
> except for one in parse_cmd_symref_update(). Is there reason to leave
> that one untouched?

Ah, no, this was a mere oversight. Good catch, fixed.

Patrick
