Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794112066;
	b=IOU+VrwhHoRnNm4vFR5vEPDWV4tbODVwpLtJoWJZ2uV2EJV4GXUQN+4JahcLlb6hsRt+
	 ZoLRH/S0sfBB9tW/UlBw8ANh8nQddtIdhu3K9qqGj5XPyiEDrdHXLIuWSNhT63pyQdhUg
	 Xz4KhVe+GZOW7dnILZOCzxchYKqUfUfPLjrnffphpEFNe7hWacFMAJoj6nwPG0KXhw578
	 gU+AvGGCONJ5JmO/H7q7h0mcGD7jHvqa9QGjsQAG8kBtk9fGrn0q5HOMPQr1FYUUEAUez
	 Rofh4uBJYpW2Q0PnDSx8lUKKeW73C4cPjrOxbZDgkU+ix3C0ld5xHgNoutBkfN/MQ1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794112066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:To:Cc:
	 Subject:X-Mailer:References:In-Reply-To;
	bh=wn/1Fv8ia0bNzr15dqUDhO97zwJk1F6lHnmRv72+CgQ=;
	b=HK0m79bJyYlwleQWtXoBivPbpmH+0ZVrpFP61ToVxNziG4TIKyrHtXJVq0hZdLkjKVT6
	 ECyXi/Byoj0ZVVoM7x5nJL2M0iH6+eNinNSWWbSHbNzqOcgQ7gDnHEvuwOa4HkOTGSyg0
	 CpYGWl0p3xobPeWKjq9iqnS1BB+ziyJrQqh8231naIoeaOKcnhfA94G6TBXvGsM6D7uKY
	 6jbFoiHPrH8U/fVHp8YOW+zkihswzOof5DZrtOuAhMXZ3disUOBaigPGtxc4xZjDW7vyR
	 GBAWBXGhJT99IvA3QPa6Kpo1SGUEzj+SBdycvC/dR+Dny/3mOChFyKP/extYdb2JJ0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Eq1nhF0K;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A16606A31A
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 04:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5A16606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Eq1nhF0K
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1adbf62dd31so143942c88.0
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 20:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794112065; x=1794716865; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wn/1Fv8ia0bNzr15dqUDhO97zwJk1F6lHnmRv72+CgQ=;
        b=Eq1nhF0KwHVrqZFewjrjhdrhgksgm/CrZ18zw320x3rQ5bSt3u4sAmxNJC9M+vnKnq
         FSn5rNCE5642re+qa4W9/ex5zXV5azblPDzIpnXuhbGB1nj9fP5IfInw5rYOl2NRjGu0
         lgl2adv/EAZhE15LRfbhfYmgi/uXMTIdtyJ+e8z+OCnrxBBLCNlB1zCnieM68jmmovtU
         KqtDq7IF7iuYibosLl4OPkyyJw+7qKmrvIrkQy9w9z6EtwKwv0zQd7pK894ybSJ624wP
         FMwBhkyXCd4AGk9ZjN3DRIMFwCx7QKakXqahJ+Pt0Whk+9yBQS1h3y9puSWsPK587jFP
         Z0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794112065; x=1794716865;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wn/1Fv8ia0bNzr15dqUDhO97zwJk1F6lHnmRv72+CgQ=;
        b=KhsXr/sGIyaHUQbnOK9nXBgdZ0kydogv351nDe9LLXGGHss9l4uSjxsnlCKVlibYGg
         1EsblMi0yYFYiG0/dDMpz+Moy/vbJ38VpWIzRLqXdOKufdFy8QApac5kGNtmHitU8H/I
         t0WatbbTD3X/A+itRBjCNBFUABZOTzAkY1zlqMY5BgvSoCMVAgjuv0byFB3ehBsmZgLn
         ZRd6zgemdZVyRnuAXOyy2EyhGyk9GFnI3xMrdw3LXin9iCjt7FUXA0aLkAQbKg+qDUHO
         rp1W4IoJT09KhAsBEzPZhqzwBKPS9Fmp4NewBqYF4qGFf2Dpv+Jvb3nmBvlfCSntNKNb
         tP8g==
X-Gm-Message-State: APuU4Z9+F0uD8/2bSFdwIvaoDiwduFNgpU/TbTnBmB0z0bIT9i7VweJB
	LhzPs3A1f6L4YqaD0oJ0vf+7NSvO0i/bGu6uVAnne2+9iaBHXKorR6tV
X-Gm-Gg: AYBFou1OEe2wNLMufZXpg4OKWzVbg/8vHTA7Kz48YWODZDrQxXK515237bR8/BQvjPH
	EeBlba4gcTmGJl3xgInMbBWRWJ9zQGjfq04wUINYeSNx3b4AdWb9T80jB7aHHaxPYnCZUzKk9Bn
	lFtlQlsmRw6+V819uvbTC+OfP6/nTS3cC1I1/fpLVrjOAzUb3MPe7MKqFwdFOASWm8kCfq1FVz5
	+rIntWCBqFxJnp9NSNSDLYcKoqd67/u5QzuRVpTL56MhsyTFypn0SXMPzTfz6M9e5ns6/4/GVbX
	NNqxVJ4HuS3CUguwsTrHzX3J5z+ulwG/D3jsyAv4NcFl9W6v+AzMzBCbfPUcR5Lvab5dVNM82Y1
	F4hYMmLk9O2qN9NT4B5uvkiE+k/uUCWy+hOXirUhTvcJEJAcjn7SuN+Ctj1TWocFbKllrk8cA+Z
	L3fvqnVQOK6a2eFjHzcI83ropEJTH7mWrpdvNt1M0OBoJkrz2/c8mAqlrzYVDIQxDcWBxYeG2oU
	UFe5CI7vA6vbRsgi3sw30xbo5zvWjg7FvOOMAeY7yIQI/zHwBERtFlsefwYRbdUnprrIwvZugQf
	HPBB3GUfTbZHTFdesnayTpSPuBP/pYAr
X-Received: by 2002:a05:701b:2095:10b0:151:2e62:fe8a with SMTP id a92af1059eb24-1b39fece2edmr813368c88.40.1794112064828;
        Sat, 07 Nov 2026 20:27:44 -0800 (PST)
Received: from localhost ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3755e936bsm3309734c88.6.2026.11.07.20.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2026 20:27:44 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Nov 2026 20:27:43 -0800
Message-Id: <DMPJNBIHZB35.1EJF34BS6RR9@gmail.com>
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Farid Zakaria"
 <farid.m.zakaria@gmail.com>
Cc: <git@vger.kernel.org>, "Jeff King" <peff@peff.net>, "Patrick Steinhardt"
 <ps@pks.im>, "M Hickford" <mirth.hickford@gmail.com>, "Johannes Schindelin"
 <Johannes.Schindelin@gmx.de>, "Jeff Hostetler" <jeffhostetler@github.com>
Subject: Re: [PATCH v2 0/3] credential-cache: fix two races when daemons
 start at once
X-Mailer: aerc 0.22.0
References: <20261101-fz-credential-cache-race-v1-0-28f0bac51e11@gmail.com>
 <20261104-fz-credential-cache-race-v2-0-ddccd0831eba@gmail.com>
 <xmqqik2bybfk.fsf@gitster.g> <DMOCMXGWSKK6.13UR9RHCJY3SI@gmail.com>
 <xmqq33tc84rk.fsf@gitster.g>
In-Reply-To: <xmqq33tc84rk.fsf@gitster.g>

On Sat Nov 7, 2026 at 5:56 PM PST, Junio C Hamano wrote:
> "Farid Zakaria" <farid.m.zakaria@gmail.com> writes:
>
>> It was not clear to me as someone unfamiliar with the codebase
>> whether the complexity of handling it was worth it. It seemed like
>> it could only occur during upgrades (old git version).  My comment
>> was meant to say: I did not address it but I can if we think it's
>> necessary.
>
> I am not sure if I follow your "upgrades (old git version)"
> reference.  Doesn't a reasonably serious installation of any
> software have a babysitter process to notice a dead daemon to
> automatically respawn to keep the service running?
>
> If you are unfamiliar with the codebase, how would you know which of
> the careful arrangements the existing code makes can be ignored?  If
> it is not important, what would the reason be for reviewers to spend
> time and effort to write a message to point it out for you?

I'm not sure how you want me to respond here;=20
I made an attempt at a fix for an issue I came across
within the context I felt comfortable to contribute.

I tried to capture that within my cover letter.
