Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795038552;
	b=fLliPTF3iG3a9uHNa52frIW8/dbCMSBjXaZvlapsdq0/3Yifr1xhICig1U4LB5Bszz5q
	 qeXn/75mduN//+8HZAjJYZwbUO962mJoMrCcft+fNObWygIcOSzvzJ8sYWoNkonLu0h46
	 cAksfwtuk1BMl2tqELU+20YFD9TgvQcQUfa4UflnvbxOtVl9OaF5L71zMCNIH/Qk+6zm1
	 xmJQQlFnVW9mLFQH0S+KDugdipbo9fuXsuGE8RNyoQQRFjtiNOdpRceIJGJCC2mH519WM
	 iA0YX2nA1aTPP/FPRNeBEltMFwjm7XOBYwHZy4AHMqJyKHkocS8bSAhvOzAWtlbV39Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038552;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=QmEqFV7+49uQ6yiVITWOBgkam17ndo4jTGxz6jWUjQA=;
	b=fOTHksewQhA9wKb0aLZajN3K9maGLlsx9advg2ov8p4lBWiXxuFpxyScUY+pZy/u5wMw
	 UeewOwJGlrQhjrGGK8qbCfqCy94HN7TwYbFlyV7RCSVgFBXkQyEkrR3uypqGgD5C8CHpz
	 Xkj9D9ulbRJTrHfMdQgV96L//Bn+sl6JJlq9ExiMYzB0KCEA6qUB9Oq80qntbXo8q5UdN
	 9QRtRDjNsEWVUSQ2trUpq1BjS2taDVVj7JyOJpjb8zojuWEf44TqSDEv80g5SAkQ3ohCK
	 bhApeRWpNPISsFHdgJlo/rGdI/nDtm6XLAKniJPtfKg67He5woTQSuUT7oz8241/6WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="T4/JbjCu";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SpvtHnTR;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DDF606A331
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 21:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82DDF606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=T4/JbjCu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SpvtHnTR
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 84776140019E
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 16:49:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 18 Nov 2026 16:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795038550; x=1795124950; bh=QmEqFV7+49
	uQ6yiVITWOBgkam17ndo4jTGxz6jWUjQA=; b=T4/JbjCuG8P4I+dyZPchQuuW30
	eCIlyRo8r1sIVfmhjISuGqCbj/I2ApXINCgl4M3O91Wq8jOlWVMJEy3TgEMQte3U
	9crT6Q8XSgcnsInWHGCR1AAVNemvRNM5VAuXm4S2quDxtcCKMD7xC17Qv6rS9GVZ
	7GRXe2CXIVysjiBdDlXmhC3uWl14ovUXSvzH4vDZerCbBnoRsskmvnrZEcccGJqD
	fu1/Ii6a3iDyWmShJsQZfdxnLsvrkFw+ZCB07sAUIwCquEE0TNeu5gOO41Eyi2J1
	3heASSdgHLbQh0pt9xDv2PcP1Fk8bPtAjbDphziS9zgLxtnyhAPKPtf0MSZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795038550; x=1795124950; bh=QmEqFV7+49uQ6yiVITWOBgkam17ndo4jTGx
	z6jWUjQA=; b=SpvtHnTRz5DN9Cawjjo3PPX2GXO66NoofQHDvNI51qI1w8NbTg4
	FWbogjV0D7r1E6M3VYEQDR/Neql6CvoafGZYdM2VAj6FwtwuW140EH+GR1mXwBtx
	PWEPlbxclsVLRmaaegJF9820T/aoQ+fF1vNDZFzjaFI4VSJUwr6GxlIm9dpnI4RH
	wAbGJpN2xtR4EbsN51uYpyc1bfiDguvKagcMO96Rn1qDYxzJF4qYbf8wUgcNF7q6
	RWoEs1k7sDEz2ub1HadIdxW3TrUtxPj7pzL+ndMrFpnSjifp0OnpJi7DXi9Fv5Fd
	MBrMogL1fvdSnb8h5rKLc3FEga0cJK4ilCg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795038550; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:k4V2j1UUqdH8Hww8pqVR8nz8pyGtsh7TQHBKz3jhjq9B1r/
	zn0tBaSxT89gio6eivTA+bFMt441c4MyLV7IVNaP582+hHQI5ka2njrfXa1SaFch
	9TmhAofPXEnsWtCLBRjVIUlCFLN8KdG1qMhfNDk4hEKQJ39kjhIvkq60443YPwW1
	WvI6dUoKd7fx4ftWuyEi5J1o35kahW7143qR3Q09dosBZXUVWRwCfCun/9HFN7lz
	sTV32BWnYeFH/7fcpQXnNKMCk2hxevnjKdl4EZHMWEHiKYnI1jFmdY669ewydCPL
	/nugmeMoxbPWwcVsJgymiQ/8fADb65xO24f/dVg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:4NtkBXzuaghWLycQOvgpHTMHVCD0u+s+ycX5607dpJs=:b+jOuHRQQQWMa90DdCRIraZDxrKA1wRVRQ9LHAOZXX4=;
X-ME-Sender: <xms:Vh3-aq0ll78o-_Q6bbMW1rbo2XjFu5TAwFILiD3zbZl1RqK7BaufzQ>
    <xme:Vh3-akhwgtLGHy5DW7J12Top91Qicwuo8BwI-YNLoNbsq-euidwJjpvvZ-mXppDKa
    N0YbL3XuMTaZT4uErAHHORGHrQw8yhBemC7VOl4ZCbDLBj4G1ev9DQ>
X-ME-Received: <xmr:Vh3-agSHSPmY4bm-0nN1dzd_tmx3eydq3yma83Ui4-SmMbSuQG5iTgWjZYxMs2NmvsMhot9yckBAL3qQHh5luXZA8_-uyTBcZCXk>
X-ME-Proxy-Cause: dmFkZTEg6gow4sKkubPwphJ4x1woRhI7Jf3g60BAXa3TtYsMip+FgFglEs/EuclyFIT1x4
    eG0Qbm6KG1mXUJSAwJ6cx3ZPeXPWfA0pk0CPEw03VkQ1xNLffL5YesjgF4FoXY0XbMIUal
    iEvdivbEWDKTnGxstAnfZOr+Y78Rurh2pK6J0QSLR7ntktcj4lnRjyZVAPdjyXxosTaYTl
    lduOwLBg1eXj8y3zs+98kWq88SQD/NHedm+A3cvFcvNabbnkqvt+TzrneDIbm0jNeeL1my
    l9rqhsrf6o4E5girWv/xwzgNOny3xK+G0+AxQHB/dKvSQX7N6608FFXRA22+5mS3K9h7hr
    43+vrxIwau09MgSqEnkpaiOVwWqOwieoV9M7Nb/r3Zqhtqh7ywcEcbsSB1W1Me5lIlJQaJ
    lmVjwrwylYmkRYQnEeMdvNTxwrTjuEku0R4mAJ1Dae3MIn+aHLOGtnOr8rYWxYxbdHo88W
    T24CjFuaISZP0bGY/nZYqNfWT/J/v6fSkHMnia7M/RY6UCDRWOBJd+o13zTeaRRkrskrDz
    K/vpaqqAr5tX2t95voK2RrAsPWD8ijL2C5Dm6YOgzmhbLKdKFUsUN0oJjwK8g2ChhbpGok
    fZFdJ/vbB4UK3fn8eGOXPhcz00CRbu7bwWlgK3Oq32DejHzR6h16HuocCq/w
X-ME-Proxy: <xmx:Vh3-aliYqSVshvXOhwSYpkqeuRCveFIW46JFDLFj1_UchLaiCOvzWQ>
    <xmx:Vh3-ag5plpMa-M_8iMEaEhj4zk_I_5xqZ9xmOAI3YKb0wGEr8J3_zQ>
    <xmx:Vh3-aiDQ5gB7H-K2XgxpfsqJLbXfdS5hJT1D9rxelt_04bqlIG7S5g>
    <xmx:Vh3-anZnlsynLYtjHQp80yUE87aTj8taQ8M7CW224-PjEZzLb5p-mw>
    <xmx:Vh3-avgD-UJsKSHu8NgmZ1Pf3N9AMgMqFpNbq-iPFqq64uk8TOuyYWwN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 16:49:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] utf8: respect string boundaries after skipping
 ANSI escape sequences
In-Reply-To: <20261118-master-v2-3-3f2aaec15d31@gouders.net> (Dirk Gouders's
	message of "Wed, 18 Nov 2026 22:08:52 +0100")
References: <20261118-master-v2-0-3f2aaec15d31@gouders.net>
	<20261118-master-v2-3-3f2aaec15d31@gouders.net>
Date: Wed, 18 Nov 2026 13:49:08 -0800
Message-ID: <xmqqse0x3j57.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Dirk Gouders <dirk@gouders.net> writes:

> -		while (skip_ansi &&
> -		       (skip = display_mode_esc_sequence_len_counted(string,
> -							orig + len - string)) != 0)
> -			string += skip;
> +		if (skip_ansi ) {

Drop excess SP after the variable.

> +			while ((skip = display_mode_esc_sequence_len_counted(string,
> +									     orig + len - string)) != 0)
> +				string += skip;

Overlong line.  You can (and are encouraged to) omit comparison with
zero "!= 0" to lose 5 columns but it still is overly long.

		if (skip_ansi) {
			while ((skip = display_mode_esc_sequence_len_counted(
						string,	orig + len - string)))
				string += skip;

or something, perhaps.

> +			if (string >= orig + len)
> +				break;
> +		}
>  
>  		glyph_width = utf8_width(&string, NULL);
>  		if (glyph_width > 0)
