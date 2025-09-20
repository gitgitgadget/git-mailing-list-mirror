Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94B821B9E0
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 22:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758407114; cv=none; b=NZSiczrpXBU3CP1xlXTh6bSdbWpi0SWYmmZPUsnZ7D0/a31lt4lfqV0VlLU0RFa1872sq2IrOoNZFKKNC+jXn/KXApIUjNenHkW+EZbqcs/bxCPHQDOLLvbx3oiF2kCTPo1TtPQTI8+Xnnm/Z5pd0oqkPfllHFTg5hUaDMVFThs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758407114; c=relaxed/simple;
	bh=2tpNX4FTUuwLqcuoayl+Em5fiFhrilpqrZ+TtmDj9z0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=foypVsd1asRraV9IHZcwLmSYEP4FT+ENagbZOVFRX7Ue3jgBW0gcTEN1ddf/rXyZPIi4ECVa32m2t16MsK9kNfm4vjwXVwH+6g2wrkkIa1Z6lB6NW1PBddYFr2eI8bgYpIAxO8nf9LP+h1itbZis6W0t4TP0b3IFJFFYEx1zEGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TT9vJXob; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT9vJXob"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-60f476eab6cso1950988d50.2
        for <git@vger.kernel.org>; Sat, 20 Sep 2025 15:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758407112; x=1759011912; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3aPne0eLY9z1PnT2WZ/UeJ3ItkU4G/1hB9oQ3xB8M4=;
        b=TT9vJXobjm/xWMbHpuXcH2d4qNIafXxLERGTt7iIRtYnR7WiIiWs+bshYYHmkF1HWo
         D/+6Meyzf+pgoe4v5K3mkK5UYbfVLDgYUrEyWXVItZ8rNUxKW44ClApuXP/Cg1XnDWw9
         YT/A/g5n8VYqEC3+HiwmMg9p0ue96zHKNb5lCNA/qemngruFNpe9J+e/OWZKbemCcZJo
         aW6z73Qm7YAJeEvaNJtUCd3m/NZv+6LAekGpVt9IVgl3uxlemysYBA9CZ38HqQg+HioL
         h39LNGWa4NPgTZ/VJZ2Tp4vec37OdA2KWw5Ahl77dgmkGdMy+5gz4RjYWayWupMmenVh
         Veyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758407112; x=1759011912;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3aPne0eLY9z1PnT2WZ/UeJ3ItkU4G/1hB9oQ3xB8M4=;
        b=EWhZcvRfdF6qZRm6SSkaMLHOlg+8mMVFL1FEcwxicTb8q0djS52XaGjjTlCyEQTjyz
         7aRnWKgzgKz8hMm03Qj2OfAJcZTbsS55StSbxiXnS2krt3RVBDdZ2r5ozk7q9EM+h/+Q
         6Vcwoc4Xy6Vuy3ALV41fSkCi7/WEDEf7/YPnud1DyNLZ3oZuou3fm8k775HD8YsDjM8V
         7jurcONYHVqoBFT6ftwQzqQwzPKoIERE8QrJeobvzj8O2aVytn78ppBnWEiHNmeCFQEd
         /QXMPQqLrAAYnVuWbUZNAkU0jg8S2JZN8Bx7Slc9LeEZhj6flZCjvlg/cAqGWUdy0/Xz
         hsWg==
X-Forwarded-Encrypted: i=1; AJvYcCV8DDvAgV7miERLgKiizlmYF0t6HSEGw+tLnX3IZ9xLS7gSCQcGAfOTJ1q64nqNzN5U8vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUeM1NvgDFpVbiqdf66DTma2PNcOlqXluMU7wMrkhmvHijF8ei
	jFmUtF0uw5rkXns8g4MlLQY5ptt6onpf1Uz2Qxf2X1s2d6N6p2MT7FFxNbz1RFDA
X-Gm-Gg: ASbGncuvL5USfXsdSWrF9IVS/Wl/XPwCeAEcX3WYJnBW+Z3rUCmobkTiFkIV5ZTafHi
	PGlybtl3M7Uib8bUasp1/rXG0YmEwXMlmxCqNuvLbXjdbnbKs2M7rLFrDLlvvH4/wcP/Iv6jtmD
	j5lrhR+iUIsW24cKEU0q9QTP5+8YzDMsSMbgYaABeaWW3W3aukrHvxrBiSXT91aSXT8M4B1f1q9
	jPjcQz76JMPfaiwQS5QKEN5qpeFTi7ShvXuyRGKzMdPEdv24lG6r8t2muPJ/IKlV/gXWuC56quF
	EvpHf+GH/S4PjKcj2QoQmKB/jdU33CUB/bO/Pylx763BWCmH9Zv9lmwHjWii6SFUzU2yCTGkRFA
	yfyjlbPfnQuPVvDc9/MxCO9CMazYfhq0M+op3TJ26GdMzaT/sNeef1q2287SM1w==
X-Google-Smtp-Source: AGHT+IFJJg/8Hjx6suNMmTJo9pcGJV03Eo5rUxzVa4ULo3PZxMj4mCii9KfpWZA5r7mPV8peg5/mYw==
X-Received: by 2002:a05:690e:1547:20b0:5fa:d9ec:9963 with SMTP id 956f58d0204a3-6347f5573a0mr6400549d50.19.1758407111701;
        Sat, 20 Sep 2025 15:25:11 -0700 (PDT)
Received: from smtpclient.apple (69-77-149-20.skybest.com. [69.77.149.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7397188ce91sm23261967b3.54.2025.09.20.15.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Sep 2025 15:25:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 01/10] xdiff: delete static forward declarations in xprepare
Date: Sat, 20 Sep 2025 18:25:00 -0400
Message-Id: <C6E7FA9B-E415-4841-9DE0-BA597E5E54D9@gmail.com>
References: <CABPp-BFJPdVkA0U14_B_EzTj6rAi3jPFcQgW2uPqSz1ZBOdKAQ@mail.gmail.com>
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>,
 Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CABPp-BFJPdVkA0U14_B_EzTj6rAi3jPFcQgW2uPqSz1ZBOdKAQ@mail.gmail.com>
To: Elijah Newren <newren@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 20 sept. 2025 =C3=A0 14:31, Elijah Newren <newren@gmail.com> a =C3=A9cr=
it :
>=20
> =EF=BB=BFOn Sat, Sep 20, 2025 at 10:41=E2=80=AFAM Ezekiel Newren <ezekieln=
ewren@gmail.com> wrote:
>>=20
>> On Sat, Sep 20, 2025 at 11:16=E2=80=AFAM Junio C Hamano <gitster@pobox.co=
m> wrote:
>>>> Best-viewed-with: --color-moved
>>>=20
>>> Two comments.
>>>=20
>>> - This is a bit unusual to see in the trailer.
>>=20
>> I'm still not sure what the etiquette is for including those kinds of
>> flags in a commit message. Could you show me my full commit message as
>> a response with your preferred way of adding those flags in a commit
>> message? please.
>=20
> This command run in git.git will give lots of examples from various author=
s:
>   git log --grep=3D"est viewed with"
>=20
> I didn't call out the trailer because I saw Ben suggest it in this
> thread, and he said he had seen Peff do this.  But, searching right
> now, I can't actually find any such trailers from Peff or anyone else
> -- am I just searching wrong?

Looks like I misremembered. (Maybe I was remembering Peff=E2=80=99s notes, b=
ut I thought I had seen a differently-named trailer.) My apologies!=
