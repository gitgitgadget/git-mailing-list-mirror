Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2402192F4
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772802140; cv=none; b=CnR6zBMkwk4xWPyzTfOcDbA8f/XdK+IgiznDsaUfQx//zfdedjOhN3WjG2QtbeQRB2Q1iaUcFBF95MiOjcQrAYL5Z1rzFaoe9Qi9ZaYe2bZeSlTnL8DHAN2qQVQk/4UgKkqPBIxInOA1+Yopq1hj3/I8ie4F3F7kPMk4f6Nvpq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772802140; c=relaxed/simple;
	bh=d6C0PWA4lyOdbcrew19rBx66vOLQyhHnIT/u6+KPm9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwrX30Zcbv12YMEuLLFtYyg/oIoViQLGmfw0H/3Z0IozlU7ODOyONM4JUotM1quNHsLZT4e8sblHv7JZPcsA8R5Vh6m4NB/AfToEHWxrs3qoA8am03dEuIQRVbhcNPqHE7iUxSO5PbMbFV+7sk54n6UnzYEMku4swSxB3ZlJRp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfy+JJ1G; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfy+JJ1G"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a126c8aab9so2890668e87.0
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 05:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772802137; x=1773406937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifZtRicSAoRf3AFPe0s5xAExqVPDKrbJxNemcqk2L3I=;
        b=kfy+JJ1GYNWG4xkRbVOs0kJI0ap3cjZ9HDzCNfeWk017eVFFvghsPwY/DhLdoaxiq/
         NLJ4SQNXuQ2PqeufHUAK5AQT/xwPcBrAgkXSSl8FL9nuKX5HM38dNEANt4V3AVdZu85x
         6b8Omqkh/4nEoY/6/zwFvA/zWnieg7RWv/GAI/+xLo4nc6PGWPBgI5lpjitV30rSvvku
         Qj//NAAxMxaybauKJ5YRmXK7jeBkPz213/0HLpajYPU+E6Iop3qXPHeENgj5k/bsUcvX
         9XiIYTsdt7pZZvq1UCc4K/8K0PJ3KfbYgzxD6cNNbjCwgw+5wio3qyokj5bhQie/WIwE
         sxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772802137; x=1773406937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ifZtRicSAoRf3AFPe0s5xAExqVPDKrbJxNemcqk2L3I=;
        b=j9d2jrzkFPDTk14W5OX9H/HL40ZHO7aCbHzn+B+cqbbivDy5fuUcqKuw2sqRJ6IFST
         q5JsMPkE61GBRvtVcLAUs80CkrtVGPsNyv+EDpakriFv0tkw7MEKhP6IzJy9BqocXIri
         lFUQ7lHVOCnDiSPsJfXCJPqNOBGCHVFGjmBzfGhEDnK0P+dRMNVy/myVzPilRhSefqcg
         P3457KhiPncFzX9vw5E8bsjaGHfzybIEOcZeGkOgPRvmtNLS4pXR8PJ9RNM8Xdiqs5RZ
         U1NNO6ycTKSjiGHal0cq9ng9kZbzIv4knZrm/OEvO/ZXIiD6z6F2I7eg4XXjBuQBok+z
         9I+g==
X-Forwarded-Encrypted: i=1; AJvYcCWS9LJBlaWxXpStb615gGVgFoz7bAA3RnTgVZVivHTS76v3nyR/cQgDhKFK3ZhbbuWViEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVSe46ggszNdQAd+HTOvxV2pGYNYiBb5XWzoWEhkIe65AArASu
	gWwNZA8MQ8vBScVfbcL+9KBuwdSj7IF76ypO/7aIBFBvAXdLNmMDV08m
X-Gm-Gg: ATEYQzzcFJczJla0xA91q24iGsf7WJ3af7YN+G1dhHEuWswu1j3Nj8e/A1BywNQs5Tv
	5yJvqFLCCkqEp2UrPWAE/09wIr+ZsusKqzbSAyG6PWRYyWjmZBWYjJ0xKp1KoFFsTRhfppVSk7P
	nmIYXj31p2NWj0Ad1IisbUcKfYgtEmi3jBGe7CA8aAGhu0R86ANwudrcmc3+ibZFvCVxnSjjWAa
	yPjpRT0xAxnAdTbK5fo+BgcY3R4IDJ+o3O4RqHad87lAIvu0QsPlhw1Qw1kJUL547cR6g8c3VCQ
	uPvKgy8zNgahVr6iujPCbH7AAhMQLtr6XpJKtggFRchFbIAwyZc41rxAL3kH0ZKuhd9OvtDCH13
	wFtItvAEcYK/7lVsWUy+p8N6lPSJ+WmzOmZj87YG9+8zIFHstJsgsp9zYPNNsLA7cRKGEliSPj7
	oeCSG2FAv8sOcf9i6DpLL1XExiyhFFZkHxXsoln2RKyaKRBYak2zF+Mxj7Jclm4qdGu2p9g056f
	IZMdy9MC7yGbsmeuo5OmMuKjh8eDT5t
X-Received: by 2002:a05:6512:a89:b0:5a1:4c8:a63a with SMTP id 2adb3069b0e04-5a13cabb70amr778799e87.14.1772802136776;
        Fri, 06 Mar 2026 05:02:16 -0800 (PST)
Received: from localhost ([2001:2043:be0a:d700:f4f7:caf2:a9bc:c43e])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d02b7f0sm332359e87.31.2026.03.06.05.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 05:02:16 -0800 (PST)
Sender: Erik <erik88@gmail.com>
Date: Fri, 6 Mar 2026 14:02:15 +0100
From: Erik Cervin Edin <erik@cervined.in>
To: Junio C Hamano <gitster@pobox.com>
Cc: Norbert Kiesel <nkiesel@gmail.com>, 
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Feature request: support listing worktrees sorted by creation
 time
Message-ID: <aarKxwOiv0XmoS6c@Eriks-MacBook-Pro.local>
References: <CAM+g_Nt8vZX4NxPvddJxNvSRgdMWQaLg2O9xzAU1pTHa=Et-gw@mail.gmail.com>
 <xmqqqzpy46n5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqzpy46n5.fsf@gitster.g>

On 26/03/05 07:50AM, Junio C Hamano wrote:
> 
> Since very early days of Git, we have created .git/description file
> that is not used very much (I think it is shown in gitweb).  Perhaps
> worktree should have an equivalent in per-worktree part of their
> .git/ directory and "git worktree list --verbose" can use its
> contents in addition to the additional pieces information it already
> shows, or something like that, perhaps?
> 

I think that sounds like a nice addition. I frequently name the worktree
to encode the intent of the worktree, but that can be a bit clunky.
Having a way to describe it and/or metadata sounds nice!
