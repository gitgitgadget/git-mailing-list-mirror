Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BFF277026
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792270698; cv=none; b=a0xiz7hv7XB1zJVwIMTQXVL4K7onknGlURDe3bQSocgZMNxvFgTfiOsTdJHWn1Qi/bzxjpkaG65RsryelzsJm8J7aLRCRQIUzYNSynutDkTwgKI3Cdyzf8626tergO4GEfe8jcRv9B/IqLIFqaHaTOaj6adiMawVv+tkUwjl0QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792270698; c=relaxed/simple;
	bh=O62J6UpwvD2UVEpw7CRqrNnDp0Whl55ccjnDS+O2OTo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=J8slmWrHUF/ZbV57SyuuY3FE52KBN+At0brELL84+1lTplksudecmACc9NrSeKmkb4Nddkpr/FWqYVaZPa8viOPgZm8gP3/BvnB0kyoCxgraeXdUZWToVnUTFififi3tzSvc+jxj/qEVkWbJecOt9mzh4SxHi96YS4zzYXg3hyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YutZpGnh; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YutZpGnh"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48df4e9d2d4so502708f8f.3
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 13:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792270695; x=1792875495; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GMvfOkh79q81W/sYzhr4AjfibsKDova42ZDOqcuycEM=;
        b=YutZpGnhq87Opu9duSjmL1vwm7ORg8PI0K/cJesWt6l4k0lXD/Ow1FeV8ww12/FqoW
         obQz6XM83N5HEI64ipQnSKk0Cvs+k3V0Ha/zNmlgsoF3dDuEUPnDuGvcLb/icdGjxuLo
         xKDtEzHKe/Kid2a/0tbB2b6H8oPjR8EFozZat/WoFQREiNOwx2+zn/z2ZRctKuejGK4U
         fTIFUoh035W4/6oj/3HXXsPg8blzsfvn8pRiwBVtaY6j3VPxfG1dzMb9Exm2dTPUDEBK
         lFPIeEKWRAE9jIXPUs5OMY500q1HOIzkgCgQfD3VUmcbs5WhKRj4+eBz6n6QWkzSp7Lw
         K2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792270695; x=1792875495;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GMvfOkh79q81W/sYzhr4AjfibsKDova42ZDOqcuycEM=;
        b=neFMLHtdoWdI32dtuXpF8HoVwjrsekdoYJNiiSoq7G1ddrz6VL9NDvd0uqve/1Ad9K
         TcdNRKMjxr5fxkuh8LS3tmwcB/geaGLqFJLkEimiaHhe3LBKz693cpltqwQwQP/9T38U
         0b4tZo1FRNdnijARmJ0/7qOgV7IDTHquZ71OwgcF6P9JrV6pAjKuh0sgMk3ik2WMApU+
         D9UfY+2pT1XRSuETF0MP8wXKuf/Wh/Ms1+HrrXhmaiV++pS32pSOTUxpFVhnB9msMDyU
         1b6VorDDgSat+35JgyOVAWqXRhVkadUhJMwWfVTjezOb+ta917qvAjz2NsWauw1NlPSw
         TXjw==
X-Gm-Message-State: AFq9FYIJGNuzYnaf62qLYSQX1Biz1nO0fOSjmf3Y2bujZ/PioFdKUvzE
	t3Id326fRDVK9/41oKRNP/7VesXBsxJtsfpIFBeZCWhVOxiAig/7wJ4/X7/QjUTW
X-Gm-Gg: AYBFou2FEdqxTmek9iVKknx3KqaQKrpGXjTgtNaGUiMDkDFWaTSm76uDJYMD8RCrydu
	OmMPxs1mhjWV+P7+mmwPx3ltjbawLRcs8E9PSW9kg1LGgrPCiS9aAlCUQfvLdTwfVyLv5M1HIID
	JZ9Wv+ASXFxgXAHKwlA0OlRaSpR3PsrHeNRZGbFBJeHe2M7CdA6aTO2mv3aNJVvQcdTuDtmUw2q
	UswuZFi1zOzDeYo0E30e5HS5wnlcr6kxgjAOR9okRAGMAuNZDhX5l7yvXKEh4hLJHvZoXf1hhLk
	sVs41g7oVB4kN7RFB3jlVO4wePPcGOivMAsmrmVIoHNmqx35AsovNU0oFkPrdsAMUxwvGZyb5++
	W1g+R2eWdFuRarcbye6TnBtbqEX2SRPY+zwjlO2zQ8aGUFmAX+T3ZcRZFIOHqaKC8RGAzUMNC07
	ouLkoHW7v0uXE6lfNcrWKPBnwL6i3QB2y3mDW5pO77dZfrbbZ08FHsev2dKgGwzTWdJpIzbVR8+
	BEYUkbVnEn/HZPNY5GynyYSE2cSGmYXXbVYpnjIKcgXuUUqvBuT3OG5Jqe79cGH4sMjVA==
X-Received: by 2002:a05:600c:6095:b0:4a1:dfaf:f465 with SMTP id 5b1f17b1804b1-4a1dfaff7ccmr24501195e9.4.1792270695218;
        Sat, 17 Oct 2026 13:58:15 -0700 (PDT)
Received: from smtpclient.apple ([2a00:23c7:890d:5f01:bdc9:40dd:a8b1:b37b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1d7659805sm108996935e9.7.2026.10.17.13.58.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Oct 2026 13:58:14 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: My summary of the Git Contributors' Summit 2026, was Re: Git v3.0
 timeline, was Re: What's cooking in git.git (Sep 2026, #08)
From: Luca Milanesio <luca.milanesio@gmail.com>
In-Reply-To: <xmqqfqy4b7oq.fsf@gitster.g>
Date: Sat, 17 Oct 2026 21:58:03 +0100
Cc: Luca Milanesio <luca.milanesio@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2B2D8F89-A68D-489E-A3BB-E891CF64ACC6@gmail.com>
References: <xmqqwlsei1pv.fsf@gitster.g>
 <76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de> <xmqq4ifhgzvx.fsf@gitster.g>
 <5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.de>
 <BEEE94B1-EEFB-48CA-8B45-EEDB10FE244F@gmail.com> <xmqqfqy4b7oq.fsf@gitster.g>
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3864.500.181)



> On 17 Oct 2026, at 17:41, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Luca Milanesio <luca.milanesio@gmail.com> writes:
>=20
> [Administrivia: PLEASE TRIM YOUR QUOTES.  Most parts of what you
> quoted from the long message are irrelevant and did not help giving
> context to your comments below].
>=20
>>> SHA-256 support across the ecosystem had been a blocker. GitHub =
reported
>>> experimental support, with general availability expected around =
November.
>>> GitLab already had public, non-experimental support, and libgit2 =
supports
>>> it, too. JGit remains a gap; Google was not planning to fund that =
work.
>>=20
>> It looks like the above statement needs amending, see:
>> https://gus26.gerritforge.com/schedule.html
>>=20
>> Google will present their plans for SHA-256 at the forthcoming Gerrit =
User Summit
>> and jj Mini-Summit at the Google Campus in Sunnyvale CA.
>>=20
>> The talk is at 2:00 PM PDT: "SHA-256 in JGit: Why, What, and When =
(Xing Huang - Google)=E2=80=9D
>>=20
>> Anyone joining from the Git community?
>=20
> You forgot to mention that the talk is scheduled for Tuesday,
> November 10th.
>=20
> The home page at https://gus26.gerritforge.com/ has a registration
> link "Register - it's free".  I have registered, as I expect to be
> within walking distance of the venue on that day.

Cool, see you there in November!

Luca.

