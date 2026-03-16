Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112643B2BA
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 01:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773624096; cv=none; b=H7ZWv2Dr/OV6N315BtJNuYoKK2pX+UMGeH/+mGJL8NAs67wX8mwdfd955yRzusmv9fhk1t4AbrNE6KPPBIA50qhtx2xKRcJlFrj4ZiEqc5R/n7oRttB0EdzePKwadGb5dFNaw/6R9RyjOhtLljhJHf4aQqU4MiN8Gy3r1EA8eik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773624096; c=relaxed/simple;
	bh=IWDi+W0N9XGxA4PRJ14cfX5Or2sxyi3YRCmxi7W6+BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOj7IR+BYjJ04MGwfWKxy5+BVKDIY71J/vMDmsGa2jSi0Qwlf4rWPVh5DvEvqUMlhMQf4aWqSOtpY/SYwoHRjV+nxZB14/nPkR3mqp2WIkjiq4b3NN81DD5otnZNbAxjSybXa92je9KVwZBOPCgqt1z+wZetbDaxb18ovS/9Nnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=Ajn67GmM; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="Ajn67GmM"
Date: Mon, 16 Mar 2026 02:21:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773624092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IWDi+W0N9XGxA4PRJ14cfX5Or2sxyi3YRCmxi7W6+BE=;
	b=Ajn67GmMc3/wZHa3P5j3pfxyh5v1EoJf3mUbOJ+W5+DG29v3br70uo01+Kkl1KmSxwya/F
	e8GqB6kO0uqz2SCsE/xojrj4n6jHkfUgdIf2sAgZCqlgP3mu2noYC4kzcFGKu3FCOjjME5
	ElMuuLQ7KAgHpSrKney8c/wwmVb3qrkao8zdoDRvmLg1ZD8fnv9sv21eGU705UYTtks6YQ
	0P8dBFG03zWFVJeSaxvA5nDK882jQg5iblh0RgVQ7XQYE0NbeZm50y6wjXglXn9Rf0WblZ
	hs9hZ02nU6QTKMsUOTROpveolQtmdXFiBLg+pEivBeSzsNU2YUFNbz+cAfZJSA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v2] t0008: improve test cleanup to fix failing test
Message-ID: <abdaD52qLrFz2B_M@exploit>
References: <20260315034851.2261530-1-mroik@delayed.space>
 <20260316011544.13825-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316011544.13825-1-mroik@delayed.space>
X-Spamd-Bar: ------

A curiosity of mine. How often are the expensive tests ran? Is it when
there's an RC? "large exclude file ignored in tree" has been there since
2024, and "symlink not respected in-tree" since 2021. I find it hard to
believe that no one has noticed this test failing had they been ran.
Since no one noticed I'm assuming they're not ran on github's CI
neither.
