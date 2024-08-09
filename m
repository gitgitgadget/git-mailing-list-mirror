Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F0F17BBF
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207258; cv=none; b=NS2DopD2I1Ng89MAT4GSqJXiML1ivzULuJLcevi4+lFJNYnv87ZVsgMysPf4DSvlsrxzJ0AhUit6+G6iyQNqHLnLEcDPEkYez73PMBMMI2+7poW9jtGWjLzHMkrho6bz52X8XSeo0px7A8Ofr5avIgWRH/fUhARHtFwg0VEO8q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207258; c=relaxed/simple;
	bh=HTJroQkitVnU5qy1xhT5tcII9/Ty6PK3lKo/lKr4P9s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=qLxV29o+XJFS5Wrjs8SM84HScj/CACI0kTtqIxUjrVDKxOotOfuGs0X/RL/ItapCOQmFP3NspTAK6FCdBvz20uW5goqCRMhNGt1uu8n/Cp3Mg8leBi8/k8+0orChdfOMc8/Wgz6CC7dYdKEuFEfAthUQhmYhMBNiK5h6ZuRRiDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYgX0x39; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYgX0x39"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db18102406so1341021b6e.1
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 05:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723207256; x=1723812056; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTJroQkitVnU5qy1xhT5tcII9/Ty6PK3lKo/lKr4P9s=;
        b=UYgX0x39Kt//k0tO89YIPHNnsfHWdp+1Tv52cFSodGReU7nquCaAgtz2daYVtAWDYn
         oEn38572CXfHWNOpNOALHQ6gllR0JxvO2SItcaDVZveDcb1UqUf6pLNizk9+MGWf7y5h
         1CiPXr4UiIHzinLgX7ZaixOG85uSPCqAPfz/0itu/9dFh+cwIAuOrWFLMaBfJKFYh3AS
         Fe6Ky8h7SX9GajqtAnwveMw0nJTp6CScp1x//BgQnP8ERM7WqZjmu9TAmSoDIGN4JkT2
         DGgRlq0SQusRhDQ2I2kCRR1CVN2/Znikbg6niwx9hCRpl/hCz/J5PI0V4bMAOCx7iVv5
         ZStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723207256; x=1723812056;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HTJroQkitVnU5qy1xhT5tcII9/Ty6PK3lKo/lKr4P9s=;
        b=atVy+dwFLxbUC3c869S8cYUo8yydyZ+Od5VNceTYG5x9kKa0u6/NleOpH+ziDkvHeH
         I1a3pTcCIbn4PiJmBGG2orz92Qz+N+oNPh7pVUxemt0235yAfWdNHavTesYWQSgGR0a5
         1c/MspGJ6yGomHbvqNHyfyHb0FiGvhPUt9CXBgWaCaPuq6UsAw7o9tbeQu/phqaHWch9
         fWjnHausDsCIBB9Ws65QF2mEHksQDIgzER6cxp7nRv1MggOL03hOhRE6zFFRQVSJt425
         EQFRYkJqgVwrK5R/FQT9hWB/dBwmJho90RLSGE/EOg9aMFb3sMS7hwaXdMzDGaGui+PV
         lP1g==
X-Forwarded-Encrypted: i=1; AJvYcCXQ0oGo6xNhZSMWsUS56yqtOfeBMQrZ3lzvNbi+E+oAk6BV69hFtx7sPJBP/3mrdCAyuqN/VvNszly3AGgiXd17XSwd
X-Gm-Message-State: AOJu0YxxK91WhQWNWh1masFxmvQz+eXitwd5eyYYjJdMK0YuSg/Q1MNt
	wBwIxZmp4elJrdptQtbcH9cRW3xDBVsaPEgcFJk2CW+gJJT+Qyem
X-Google-Smtp-Source: AGHT+IGHsjFZRCpvo8a4qaEu1fu6YpbFNM1YJC3awPOwipI0hEQAUHFBDi0SvBgPgogZBJW0wmKRfg==
X-Received: by 2002:a05:6871:79aa:b0:25e:1382:864d with SMTP id 586e51a60fabf-26c62d10769mr1710141fac.30.1723207255904;
        Fri, 09 Aug 2024 05:40:55 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2e57e9sm2529701b3a.154.2024.08.09.05.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 05:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Aug 2024 18:10:52 +0530
Message-Id: <D3BDZN0TAM06.23KXC017WCLD4@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2024, #03; Thu, 8)
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqqo762frkz.fsf@gitster.g>
In-Reply-To: <xmqqo762frkz.fsf@gitster.g>

Junio C Hamano <gitster@pobox.com> wrote:
> * gt/unit-test-hashmap (2024-08-06) 1 commit
> - t: port helper/test-hashmap.c to unit-tests/t-hashmap.c
>
> An existing test of hashmap API has been rewritten with the
> unit-test framework.
>
> Getting there?
> cf. <CAP8UFD04uQbWhY0QDp+nC8VyBvpUs=3DtBDm=3Dw4CzKK2GcwFZdGQ@mail.gmail.c=
om>
> source: <20240803133517.73308-2-shyamthakkar001@gmail.com>

All the suggestions from previous versions have been taken into
account, so this should be good to go.

Ack from Christian: https://lore.kernel.org/git/CAP8UFD3VwiAbGvzgi14EcEQLX6=
Gs7pNy+dvZcXkPOueKpJS7HA@mail.gmail.com/

Thanks.
