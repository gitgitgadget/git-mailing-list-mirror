Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166693DBD6F
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773228037; cv=pass; b=c9E1l5CyTEfa/NM27Lp25g6GrT0o+qoxKZfvp0Lsrxg23IuOGHUw4DIOL6qJaGteKb1HaR6xah+bJryxr30OlP1W7NLa87q9zHq6HGH7SkMeEn5CCnfQKuiP3WlCd02AGrOM2grL4RudEnJdW6PwL9VXPG3rg+oSpazU/Yh5X+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773228037; c=relaxed/simple;
	bh=7ieJf6vQ69ohXsuSQZrtdZ9QikeYppwGjocktpsovQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CTajPLdB70kNOob+67+v52mW3KNWqJdOHZ6N1uHmALxq6l5Zd4o6QhfELc+0UVgzo6yQA7rGaxC5g4wUFQrcjik+bbmw0jG8fu98cHdv6o/DfB7Rd1kCO6H+4ZizSw/Bb55gh+cXnUipxaijAEJvgECruYKKZJyi+BzuhddTTCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLJYwPno; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLJYwPno"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-798578e2918so128605357b3.2
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 04:20:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773228033; cv=none;
        d=google.com; s=arc-20240605;
        b=GoN3cPjPGH4f9S/IvB1QNxQigCZ0K02WamSjOjXepFS1tNrXm7vDnvhc/jv3dAToZp
         AqClNm3cdAOcGFnYyg+1di5ADLZbg3wRB9Nt9m/vVOClyTqfB+yq09k6TKnlAihSiKdA
         LSVnzcmICdBgGH03b5Uo7b/VrW1KkThS47vRjH0OHcc8spgkfDmdP1GbQYJP+TLoNJS5
         ZfPP+09ePqIlIcq94JYI9bnsfp7kK+ti3I6ZKFx6wTydpbE/2xe8OU6jr6LYpiiOq7kd
         5JWlF3ZB82U8eu7TjSEGbLS6G+s/wencdjPukNSQwuFnj2J3ZRn0k/bb7Gt0CWygaRCW
         FIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=7ieJf6vQ69ohXsuSQZrtdZ9QikeYppwGjocktpsovQQ=;
        fh=GoIJyD+bXCpCl+AYh/eP+Xy5IKArFE+iS8hi8kEEbbo=;
        b=E+vdGRQsQHwk7dI5RWxZtj3jD2SSWcFctJwGVDlAwL9SQZ6p7uWxb4/knB2RD3UG+t
         VbpAgERlg4qnXJw4oIIkZFOEs8wuG4NIMOfuXKagFQZW7wgkwwSocGqb6865ZA6TqNIi
         3hkZ+xmPwd6rBSvRo7UQirhwD+JEmsiT0XAFpd2U1AZTHQ7IwA0XFTC6xdp9KI/ED5Tu
         XNb2ivzrNORy8vl9t9T+7qCHQsNDSJscvXFYIwQCBDgAWaem0kVV6XwFA8D+lwyKa+De
         oUM6sX3Pek20KbD3RND3ARvNrBUf/IFgv7JULEBDGesYxy90QQ03KySKAsnxXEyuD1oW
         PF5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773228033; x=1773832833; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ieJf6vQ69ohXsuSQZrtdZ9QikeYppwGjocktpsovQQ=;
        b=NLJYwPnofYMXBD//U5qZFQyGQlYojaEGtAKABzCcNfVl8YNcdPG0mx4Y7iP7B2Sbmc
         uzZIiYiQzrKJYk+85jibJ7Er3jv1yeMaSzWPCe4aFmNFD1uGUzqZC0bAiP401KeSEES2
         oKumqWQp2aVmSan79Y6wCE1rwmrQrZqBDBzpQj7t/vKMq/nwWuN2+fHRPVn64SjA8cHC
         vW3GKGl24hS8JJwMCd9G2nG5AyFR+a+mFsJFZBRw2rm1HQNQHG2JXLCbUmh10L77i7s9
         wk1arqFzolBJrj5vpaIkjWGFbkx26mhbHG346yWn9o1rkYG9p0CLAK9XRWbhdOaCj+ah
         FgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773228033; x=1773832833;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ieJf6vQ69ohXsuSQZrtdZ9QikeYppwGjocktpsovQQ=;
        b=QZ9DD5YXZ5Asiu94SdFCQhVS8TOblezcMqDg1KUPdI2BlS7+kxVk3Pe3UA5UaK+nm5
         4f9fX43YRkyQxbiVUaBtvZsRq+S3fbRvDHgYm6Srxj5PZvj6SuIyL8jUOAcc1NUnTbiz
         iNZ/crpHhzlvKKshUHFLaJY01v+u4kI6oY7agG/R/Q3y4Se3BWj4SPqVAtgMTZjgkQ1j
         /7Fslr0tDNcltiiu1sM/LlFwew3phh+0/JLrxC7vquV15HfoGjtU8uAuiHFSA7pnV+7L
         FQS5DIHbqI3caJEm54zOlS00LMlvrvfUm8zKpD9m4qaWBoevTLfpaGYHCU4dxMTPbSGN
         sCxw==
X-Gm-Message-State: AOJu0YxYHD9KczmsHakR7CGbsHkFmkbeh7ZZ5jROsP/xh2IponJbqY1b
	hhUtys/rq5yE/GLP/yppuSQJ+G/qdbpOjhojCjifMtlD90j6lDhp4vRwFfwn+NdITLayNoWg9NB
	CizW1upEnRxjFNG643h/mDwOXOG0svlCKDTH1LqtC0g==
X-Gm-Gg: ATEYQzzEEnnVgE4tcdwVvqiUzrN6Gngbb2H5gB3hepV2d/opM+xnl3T79QRtuFksrzJ
	6GZItxUzG3SfQ2EsoJThiQfCeeZINFS2arNeNy3D3tLIY9aWU28rzvaemvV2fETRRht5p8SMiJO
	vkR0kmA+6m4nGhIj5Isry8RA6s7DpzVvNfPgncbfi0RpyDhFksrFf/6QJVIRr5EEhN+rm8oEX1t
	v8+r+ok8u9E8Gp6n0ofMpckWiWHiC63jgCTllVbtmLPTfPJM9xYHmzmYjsrNbjI0kTFO66FyKFx
	QWMBjUaa/7Lo5glEn56VMyJkRgKmw3UmiakDNM2FOaCDj4Byvx0aQRqXj9s9ExCvDmmmsfyhi9j
	TJVQy2n1jbOE6szFp0bX89ak=
X-Received: by 2002:a05:690c:7344:b0:798:72af:3c80 with SMTP id
 00721157ae682-79917f7353fmr17640107b3.36.1773228032783; Wed, 11 Mar 2026
 04:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN5EUNR0KJ4VeuOF_bVupaTuGKGaeTKa0SMRAUoBPo5wWi8YGA@mail.gmail.com>
In-Reply-To: <CAN5EUNR0KJ4VeuOF_bVupaTuGKGaeTKa0SMRAUoBPo5wWi8YGA@mail.gmail.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Wed, 11 Mar 2026 12:20:16 +0100
X-Gm-Features: AaiRm53rwQCvSSYqSqmFEvgu5qnYYD9B0yFE9YOoTNVrJ8Sty8vCi1N5iMneqmM
Message-ID: <CAN5EUNSK9Lk-ME3nCFSG=Whkcm-0hvF5Npyj8MaXucKLkmM=Sw@mail.gmail.com>
Subject: Re: [GSoC] Introduction Pablo Sabater
To: git@vger.kernel.org, christian.couder@gmail.com, 
	karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Completing my introduction.
I'm interested in the "Complete and extend the remote-object-info
command for git cat-file" project. My pronouns are he/him.

I've confirmed that I meet all GSoC eligibility requirements.

Steps I've taken so far:

I started reading the docs, followed the MyFirstContribution tutorial,
I'm reading chapter 10 of the git pro book that talks about the git
internals and I've already sent two patches:

[GSoC PATCH v2] test-lib: print escape sequence names
https://lore.kernel.org/git/20260311031442.11942-1-pabloosabaterr@gmail.com/
[GSoC PATCH] t9200: use helpers to replace test -f and test -d
https://lore.kernel.org/git/20260309230134.758107-1-pabloosabaterr@gmail.com/

The project seems very interesting and currently I've already read
up to the v11 from Eric Ju's and the feedback he received and what's
left to do for the proposal. I've taken notes to make a good proposal!

I'm now getting familiar with what's related with the proposal and
writing a draft
Once I get feedback from the test-lib patch, I'll seek free time to
keep making patches.

Thanks for the opportunity, I'm very excited about it,
Pablo.
