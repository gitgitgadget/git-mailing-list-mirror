Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2813BFE22
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772038946; cv=pass; b=sofTiBPbhUWJpKroXT61sLfM4AbNX0dBSRrEPSm2H8vsY8soW2iIO9Bp/2o0wg8gSvOoPIGNmHa5OXkkU0QB228C77ELrEzOf9DnXimyReqoY2WtCfbwmyybNsOqmpcr+nVDZ4RAaMg6ldgrLwWaLFgYxwOaVf0T4J/2us42GBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772038946; c=relaxed/simple;
	bh=Yp1pjY3XzoGMMSbOC6cXRWZ3u95b7gAOPNw9TP/fmoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXABdfrdj5PuJBbeZx6VN5iZY/Wn6zxAzrkPu57Qkmq2t2V3q66+umhK2Z7DnlOXkJ9LrxvKhbns/2vc1CguY1XMeQDTId5FhzEdkJGoxi9Aensi1Wbe7w4T9p+64r6guq0WG1dHJunDaEbfWECuG71KFO/3vM/lgEy/it2YFSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxTefMOP; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxTefMOP"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50698970941so77181081cf.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 09:02:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772038944; cv=none;
        d=google.com; s=arc-20240605;
        b=YotBGt5nzXyxIF6T8vfyOkbRT8dR79lpCLCXNzN5jDPoUt3PrwgpvhxuaMVrvFahtv
         SgF+OUdQhuTYRdGIIeXfhMPkE7/ba1X6sjWdSGhHeGjp6yZRSqCv6D79wnWbiptzfutm
         jwvqzBFRVJEy6y5LaN6rvE2VJxv0pXhuThKb0H1Z90NSJbbeIimhJFTdrmd71e4iO5lp
         9QfbgDIkj1E6e1ezOOhdM3wfL9sxYmFIzhdvJH9+5pzk8R22OMXPBW4D0qliW5mgaHYK
         t7TFvfonYjlTj25ob8M0hSrRtrVfU6sGd3MJkGzCom2IkFsHrvcS07nwx6RznwuKlrjS
         W7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=44AC4CSstvCHHFosx3wso8rGBkmidJKAinmx3OXL8X8=;
        fh=EPoxSmMJ0njGx7+q2wcdItTP09V6OqrZXp05nK8c6Cg=;
        b=RHrzHSPyxh67UAD8DEsaxw5zYD5PPdqMY4dHcXxP0hwFMHHyTpiyNCo6b2N1FKqKNE
         mGqo9N9wxvFJ5PewA1+bNwGXuYn+40KU3vSeUVWLEyiL/5Zw1J0Wn4XcsG6mQhideViF
         FNJ2BG+d5MbeZOg2/sZ0u1F2kBk5S+3jBiejvSp+NFgMAUF8cFYN/m0W16ZVQXwUYXkv
         b3ezyV/1zdrVttY5nUX6CZ+Rm71fIONWrV/RtFRtR7JMQA0NRa6NPjx2D9zC226X3gk6
         /gDdLwfHUnOpFPq39uLJ+YndEpdlE8ugoVclmeiLeoa/35t4bs2Pq8mEj2OVkVoD3GbN
         531A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772038944; x=1772643744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44AC4CSstvCHHFosx3wso8rGBkmidJKAinmx3OXL8X8=;
        b=bxTefMOP0Y2nGcs/90JQg52jZCaIYwU16c2p41YPEECHFMSAG8zlZ9wd4KnzdceyXD
         /7RlR9GIPvqws/nLZY//2D66arZQzUtp87Ydmpm4JFm4xVTgOSKoIoUARtF62MxykOp6
         OVt8C3u1KFeJgd9XoR1eUnTypwuMw/rs/cmsUReaQbdTn2aSzPar6bh/XghYQo/nDV/z
         qUVBq8JojGBQL8TWNqNaHdUL6y3HSstHFF/kGQE4vjb2OtyXgCzen7bBwffHos92sEMq
         L0wIp4MiJhWbsikvhRfzukHb1HHIYfFyvsW+OhG8bMhJ57Etc0Va4HKGwl8tmGkNdI3J
         TfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772038944; x=1772643744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=44AC4CSstvCHHFosx3wso8rGBkmidJKAinmx3OXL8X8=;
        b=O9809vi4bjqPzksJEqCC78lEYxIBmdHWORaacyWZB3K7wFAvYIvXsAzcEnX7cq5vZB
         1qLDRs4QZOqup9OgQmi/+qzbRUa3keU8US1jgtFFobrumHooxbcW64Beo8Z0CrziVcjU
         7jBP1vAXczbgFbfZ87iRT/jwXYM+qQqPOBDkDMTL+TYjklwDGXx1A+lQH70K5Q/4QrWm
         /ygE+b9OPddgFGRVSIoL8XFVl3QNq2jGO7RBcqYD+K3CNUKWRKTjty1KqtycWxAXQDzx
         lH+CkE4bRJJz1FDYIPNnN9gdWJ+GXrUjHiwZUQKfYK5IV4h9Y+MtWWlKceVdXLDqEe+5
         a7+w==
X-Forwarded-Encrypted: i=1; AJvYcCV3yVvafRggd9N9r9mhGSLAYor4aS5LxG4dy67nuQHdpXk4PDgoUUvqEHDI++d4NWfzfYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwz3Y+yyKLRjw/0ZiZoq9hJNpTqHBEH2YdDLUOwSseiVF48GmJ
	apl5Ez7PKalqlEQvXxW+wolgXvgKAuutdMYESyeqcSLX5SkU+MTlXnsoUaCCnEHdEzuj+3qRFft
	0v7081ose0evDNuXEKuRNej4m6Y3cPfxuOwKX
X-Gm-Gg: ATEYQzwwVtAWE20d/fnXIBznpO7lo8JJa9OW5vOp5HuL07+aD4xTmOeEM56CBdooeGu
	Bdwi/7WusTNssQnSY3w8CHqYd4uhBMWkOBM4z71dE6lgFgh8UXBuiqwsCmQzZdNvYD4KasNOUNV
	Go/UwCUpWKqHL0SuQ2OSibB+1G1BGea1ylZeNbRdt5nd56FfB75u/mdybw+6+IZYFN5MlcaXpeZ
	OzTssCMToxFkf02LAOnM/Prqx2hvvcxwsE/R0IE637yarWNg7XKaX+NIHn5fKRlxzHfoqjlT0Zq
	VDar/pPBTuEkUjRm6YdsdV9F1hOT664RspU6RYGTBnRNqf15g8v1LoBPRx6zwvux2QoDmkQ0bn0
	QAvD1Ch1KAkj2y9qmpgCxM8PSm7gzH6rj1N9W
X-Received: by 2002:ac8:5acb:0:b0:501:49f9:7488 with SMTP id
 d75a77b69052e-50741f9b5a3mr16379281cf.49.1772038944142; Wed, 25 Feb 2026
 09:02:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqjyw1cziy.fsf@gitster.g> <20260225153414.7461-1-valusoutrik@gmail.com>
In-Reply-To: <20260225153414.7461-1-valusoutrik@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Wed, 25 Feb 2026 22:32:13 +0530
X-Gm-Features: AaiRm51cDF85vLPIP-kd75sjADMQPkO_Nx83MQ1o1PRTWD0RBzn6OXB7Z5q28sk
Message-ID: <CA+rGoLd90PQ3TWTM8CE_jeWakJgeY_iuqoVWFm1DHOf8GBZHWw@mail.gmail.com>
Subject: Re: [RFC RFC PATCH] builtin/repo.c: change info default behavior to
 show all fields
To: SoutrikDas <valusoutrik@gmail.com>
Cc: gitster@pobox.com, ayu.chandekar@gmail.com, git@vger.kernel.org, 
	jltobler@gmail.com, karthik.188@gmail.com, lucasseikioshiro@gmail.com, 
	siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 9:04=E2=80=AFPM SoutrikDas <valusoutrik@gmail.com> =
wrote:
>
> > Thanks for clarifying what I left unsaid.  Very much appreciated.
>
> Hi, after reading that part I realised how pointless my mail was,
> so sorry about that.


To be honest there is nothing to apologize for
In fact that is something I love about the Git community
It was a cultural shock for me calling people by their name instead of
putting "sir" at the end like they do in India.
No one will ask you to say sorry for sending a patch that's for sure.

The list is super active and this will be gone under so many mails
that you will forget this existed.

Regards
- Jayatheerth
