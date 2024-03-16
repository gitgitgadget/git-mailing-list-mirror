Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ADF1FBB
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 03:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710558468; cv=none; b=EUBXFNu3b/fudg/kGF9Ss05D5bTBkz3MHSu26H20MiXSEVW20OhD7+6n6jkD0SYUyyZ68PqFWKk9uKgw2VIgJ7ssYfXEqj/9+zTOezR6g6u9+9T/Zgf++VQAxCl4fechnl1U8SLS1psMW4A7Kd/BZEElR+lR5mUtMt4xHm0Gwbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710558468; c=relaxed/simple;
	bh=D589JYrBebBsXHe0f+ytZDjdfNtZu7YaP+K73Wa+8Ic=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=b6e9QSPx1MCjWmJj7u+Kvz9BlXoSZ4V0/4BAa0rzi1cBf+f6fD9SWQVOv0bajXp2g1HHRlfyrkF4blckAx2DMz+3TxtEuYmFjRvDMNF9cDSzawKMvrrSi8lAnsABonDANB1QOy8hX/oIYJox5C6hwDMS538lcdbV6mAoUbjO7vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNxrRuqP; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNxrRuqP"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3662d7c79a9so18696675ab.3
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 20:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710558466; x=1711163266; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oemyP/YfZ8pbLLsb7OvI/c6SAFDAABM45PAwuRJB3+Q=;
        b=KNxrRuqPLv9GiuGvcU/8nqQBEtK5jT72YQPyrkOUMvRlUkaEBwQPoMf50eEDIScfwu
         enuNOQE5SEvjp3tdauYRufcD7qzkrxFrAO5tyKJxlzXPO93t5cxwvygNCqtHL5RqYIog
         KKDRAMaeXMPaKSTjvcLTKb5TFU+J2hYsMA32zhLaY3z9+4bnmjjPqDtld+WCe9+GwWLr
         M0kw19O7vEtwwTgG3wdp/eKZ4W2CsM7A71jlMnqfmKzzvdHhQ0dcrTZeEjbK+i3+jAht
         D7BOiqxYBisz0sDLppyjhTjxkoA6ktNlTvFfn3wzFw4lnkus7QTNOlW0KEJVrC4yEyz5
         /R7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710558466; x=1711163266;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oemyP/YfZ8pbLLsb7OvI/c6SAFDAABM45PAwuRJB3+Q=;
        b=JgsUeXURZVYtvjHhR6d54maVVBYJHSeGsmXmxAlcX6gY3RWbbz08UYMQI+iCoCj7/v
         QOC3fnPo05sjFCuSKZr9OR3VF+Z7kqE69AEF2AL5OvvnBnyQOfv00hkwz4qLEoYOfvcR
         SqnBiSAvNN+y9Q+WN5PeVMiXbHZ5VecboucqGxls3w220/7PEZdpVkkFCTz+4DtmwkLI
         wr5PyVVH2aYyvATuTM1YcSnnambP0jioMPNba33zA3gCK+otsFWvEnSxjalI0FJYrQP4
         MRJcn9zATHO3KK9p4D+9oXS+cG1k48AR9qPivfir1PTkyLWjv1+sgRQwjba9+KsVDUBF
         lXPg==
X-Gm-Message-State: AOJu0YyQ6WyW5jsZdZDmbLc+C4REU+NX55Jwt2tx521ZPMDtjNkJDLHd
	1/7E2sSTkNdQ6FP401AX8toa2NWy0zFCA8GIz2El8iIckQISWFeGjgVDFlEu
X-Google-Smtp-Source: AGHT+IFmMzM/dXARRSYfpiX5alrCHZTx9jGV7YPiSE/S8KyN3afvOPzdo46L0PNx+ah4w04dDqSWYw==
X-Received: by 2002:a05:6602:4a:b0:7c8:b164:57c2 with SMTP id z10-20020a056602004a00b007c8b16457c2mr7007117ioz.8.1710558465865;
        Fri, 15 Mar 2024 20:07:45 -0700 (PDT)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id k9-20020a6b7e49000000b007cc049b0667sm188996ioq.42.2024.03.15.20.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 20:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: <phillip.wood@dunelm.org.uk>
In-Reply-To: <87155d50-40b8-4394-99f3-5194d7da785a@gmail.com>
Cc: <git@vger.kernel.org>, <newren@gmail.com>, 
	<me@ttaylorr.com>, <gitster@pobox.com>
Subject: Re: [PATCH v3 4/7] sequencer: treat error reading HEAD as unborn branch
Message-ID: <17bd1fdc7357bd91.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Sat, 16 Mar 2024 03:07:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip

On Wed, Mar 13, 2024 at 10:10=E2=80=AFAM <phillip.wood123@gmail.com> wrote:

> Hi Brian
>=20
> On 10/03/2024 18:42, Brian Lyles wrote:
>> - Avoid using `--quiet` in the `git diff` call to make debugging easier
>>    in the event of a failure
>=20
> Sorry, I forgot when I was reviewing v2 that we need to replace --quiet=20
> with --exit-code otherwise the diff will never fail. Apart from that I=20
> don't have anything to add to Junio's comments on this patch.

Ah, of course -- thank you for catching that. I'll include that in v4.

--=20
Thank you,
Brian Lyles
