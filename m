Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4AD44E03B
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138415; cv=none; b=bG1NbG8HuJtiuc7GX2B3jD//d3forfDGIbguyP/uE1YiPbRofRZsWloPpKC3/w55vSNe8lSbnHqEgeicKfSzEsPv8Ot4CYBHN4TJLEPHjmvZ4MrAb5Y1cv+N52inAB86UckYQ1k65AC5sDhRf1Ugp5ZnZ/oL0bde1fBGIiPQm8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138415; c=relaxed/simple;
	bh=wWGkKn220clEcprgjXSzgj4spZ/t467KedUHBa2qnfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUaCkJ25prVC3Y22GKRJzVYfeISmrW+dxSEG00xtliTvSJy2T9ZZDXtgPZqR0xx+CA+zvMIZ4Lcr35IKh/A0+4f3HiQpA4MYp4nxcbzsD+5yiBc7KfaRjzEZvC6NxF0p2qp/7F1t5ewIldGilOTKpEACf8THXfBLR+y7j++ly+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CDRmrRnY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cJDBJ1n4; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CDRmrRnY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cJDBJ1n4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2579C7A00C3;
	Wed, 19 Aug 2026 07:20:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 19 Aug 2026 07:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787138412; x=1787224812; bh=l6aPlyz1ru
	B1Occ37avD1sK7+OWvBgZNyIVlCF6iRbY=; b=CDRmrRnYTR40bHzRdySrIBUqPr
	wtWbGFPc+a7v8mJBwhmVXvYDYWg5aohH7TPySYTj12sagriKr5p8ejZX4vIOZdds
	XENhfput+He7WrsK3uJzdgKya1P6UA9zKwUGmglQTdCWqee+1EKlAi3871O3jsUs
	cti6JnlAS4VhBt07UwFBV/Fj/EJ255GRYi3gcQ0UXflLrIoi/GoOMCljd2IWd6G7
	jM7jOL9f2OINHGIWUrHYcoJ9+6ZT5I8g6bB6pl9OBcG63xJ0f2TAdI4PYtmcIDIt
	4Uk3I0OPv2e3KRRb0mdB+rHYKZmqMnLE5MP9l65KwNY0xwsqkkTfcf5g3H4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787138412; x=1787224812; bh=l6aPlyz1ruB1Occ37avD1sK7+OWvBgZNyIV
	lCF6iRbY=; b=cJDBJ1n47nW2mtJ01VCyUj8PR782eoHACmHcPRozUDgMT8DU/g5
	kWcpRCHH/P6THfHi/aaSZ6+nMpLM/YL7DI9QIqLpYDlNKIiyY2V8/F29OmkQEaIb
	Uy6d0oQy0YVUZpEYt8qRXbaRCTsknH0bLdvLnbJwD9KPHQaHP843BOCkhI2NfCON
	Yp0ljnKAHyNF8gjW2/eSWCVRgLvNKGfwwkTfpYmwMrqTJdKpVkl3SRGXWCaJNvYT
	b88zGSBjoe5JU5OX7Sz8Fwq7eByE8LtR+jXKcKppDAoZ3RRDtrfmVTwhG/CBFs+u
	9JfTbMVraw5/AChvfoE1cCiFokwR9H82OFQ==
X-ME-Sender: <xms:bJGFapWvRIqnB-qx2PUxAVgJ9kmupB1ik5YaSCCWJXy-U_woBJZK-g>
    <xme:bJGFahCYLFrpf-kibNjYldV9YpL1-v7ufUlrTxiyFIfcDVHVc63uR-i7K5YwEbLOo
    mAhlm1AxCcsu925vrooW5K61RpjJmhUXek84YxilE4FyQnlnXdWhA>
X-ME-Received: <xmr:bJGFaiwn2bhKRviPo7FL6tfMN7GiW-5niDmxglnDt4mW6vPL_Lbk6mHcuyMToShsdrTEg9f0VZBugLyginvo44Ss2lrQBfNWBrgzyiHL>
X-ME-Proxy-Cause: dmFkZTFAT4gPysT1OfzUZaWg//vbUN3vL+bWhhQZFjtxOUDuxUPbK7qhJm8e5y/qU7XNUI
    Lm6GJLHkYe7t9zwxyugdN2rUs1rM0XrFSmhsVUF6bjJihylPMhxkSvbY0O5cEvqP45UfRy
    JHoV22F5qiDEh7UmaiTmX6rm7jLhpJcq1IvmqNd6oV24ATSy/Yp2vZkob2XS/DJ345xXnd
    zWW0dLiNfzHhBrFN7UMvWdkcpJDDXtL64MrwsHBWHbTkGyAmNGEvhG8zhcJeuEXqEHVG8z
    vZEE7wcg7cEa4Z7Lo7uvnYq7qhrIDrqlkA/K1ryCKN3YQqwLB1FfWUAvzbWoLwUfk3p4l6
    dKJ2zOLaqp9dvyBnbn2kirphi+dCfabVbPRN9TpGMh951qymzq2o76RtRXrG3LpJ5aPOqR
    8oIpXR1k67u62m2vmmDv928ZwRAiOjWqO5BdNLadYkscBo/o5s3YLRbMzBwrb3xhmeMaVk
    eWToXy0ztLsfNYx8gOOyoMjgLy4dEsupmNnIYgruF1OJwy2wWQep5q05O2YxyL82bcPAyO
    ZC7DKzl4pLe5r+uwTD1zV2FRn+tBDvQaB2jBabF5i7ldKdJd1PaEmg06HSh9fHVeLFIRZG
    EaLd8lizSSGKnwPOOSUM8JkCIq45mFDddM5pkSVihrZmgPeY+pEYQhc8S5JQ
X-ME-Proxy: <xmx:bJGFamC5AfuszSyDuJdcJyjZ8q0BMbQd85d0hw8dmQSPAaZDE8uxWA>
    <xmx:bJGFanapKfvXu-DAVWEQM4nzlt837JTfnqRr0q98jZ_YwrTnlojWRA>
    <xmx:bJGFamisVvZ8QUjFXJO5qIbQ5g0HpX9hdy8e0Sph9PZ-dER7Dr8pyQ>
    <xmx:bJGFah7if08AKyiOc1Fl2tmHTb2eph1K6thsdjf-KeH2VZMMrN9e4Q>
    <xmx:bJGFaldxy4C8YSXxsm8CZBJB5sTGYzSyRamveOZq9REY9tqDluiNckU3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 07:20:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 23b74a39 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Aug 2026 11:20:10 +0000 (UTC)
Date: Wed, 19 Aug 2026 13:20:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Nikolaus Schuetz via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Nikolaus Schuetz <nikolauspschuetz@gmail.com>
Subject: Re: [PATCH] t1402: test forbidden characters in refnames
Message-ID: <aoWRZhO6BVy7uPLI@pks.im>
References: <pull.2203.git.1786653837190.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2203.git.1786653837190.gitgitgadget@gmail.com>

On Thu, Aug 13, 2026 at 08:43:56PM +0000, Nikolaus Schuetz via GitGitGadget wrote:
> From: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
> 
> git-check-ref-format(1) documents that a refname cannot contain a
> space, tilde, caret, colon, question-mark, asterisk or open-bracket,
> and that it cannot be the single character "@".  Of these, only "?"
> was tested as a character embedded in an otherwise-valid refname;
> "*" was checked only as a lone character or with --refspec-pattern.
> 
> Add the remaining forbidden characters in that embedded form, and
> check that "@" alone is rejected even with --allow-onelevel -- where
> "@" is otherwise a valid refname component, as "refs/@" confirms.

Okay.

> diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
> index cabc516ae9..bc1e878a0f 100755
> --- a/t/t1402-check-ref-format.sh
> +++ b/t/t1402-check-ref-format.sh
> @@ -51,12 +51,20 @@ invalid_ref '.refs/foo'
>  invalid_ref 'refs/heads/foo.'
>  invalid_ref 'heads/foo..bar'
>  invalid_ref 'heads/foo?bar'
> +invalid_ref 'heads/foo~bar'
> +invalid_ref 'heads/foo^bar'
> +invalid_ref 'heads/foo:bar'
> +invalid_ref 'heads/foo*bar'
> +invalid_ref 'heads/foo[bar'
> +invalid_ref 'heads/foo bar'

This feels a tiny bit excessive, but I guess it does not hurt to enforce
this property, especially now that it's so easy to add new backends.

One thing I was briefly wondering is whether we could maybe have a
simple loop here, as this feels quite repetitive. We could for example:

    for c in '?' '~' '^' ':' '*' '[' ' '
    do
        invalid_ref "heads/foo${c}bar"
    done

By the way, one weird bit: is it intentional that all of these really
use "heads/something" instead of "refs/heads/something"? I guess it
ultimately doesn't matter.

>  valid_ref 'foo./bar'
>  invalid_ref 'heads/foo.lock'
>  invalid_ref 'heads///foo.lock'
>  invalid_ref 'foo.lock/bar'
>  invalid_ref 'foo.lock///bar'
>  valid_ref 'heads/foo@bar'
> +valid_ref 'refs/@'
> +invalid_ref '@' --allow-onelevel

This one certainly is a good addition, as these are quite a bit more
subtle.

Thanks!

Patrick
