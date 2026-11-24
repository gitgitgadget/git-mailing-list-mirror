Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795547086;
	b=nSi94/g3KO1zNr1RRUYmBB1TxWoKWtwMBU0qEjcR5ybMSo03Ae1YTo06Sp5/sMg3EkRB
	 AFaS0nUtgZqKy6NmJsNLIizLjcNhG+pHLBQ34IT6wwIvm2zZwNMkRPzXXbYkpsTYJ3bIa
	 VsaUFT0GYCKK1smIhHcUFLv5EfXPRtoNaUNqG6zsKNNSBbp5GYzsG1aP/CQENnidMncrN
	 Rz73yuZ39heB9GbwRtIdRVrhiuXmcR4tGSWB9yVPPzEGBpGE2SQT5KTzgq8ICZTzs8+oq
	 z6460wDvXGcBD/ReLSqYDom4FKI2+FIeZPbf9omnIEwruB343Iw4MR2CULYLc2PODAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795547086;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:Date:
	 Message-Id:References:Cc:In-Reply-To:To:X-Mailer;
	bh=AmJ/S4XaOA8lG5+Jh1OFrugl87oVpjF5GU4FYG9swdc=;
	b=uJ2kUMQnaH/sFaoVvjM7e/NuZhp7VuKya9gezbStFP412HQ+vLIuORNI2BuKxACcS0TJ
	 WCdsk0OTFvRP49j+KD0lPOhGH3E+DtrRQPoTJYlVoPZT71ZTKeeW4VURcl5BNvjIjaEd1
	 Y4uPr1R/m/IMARRAahHT3QrRFfZqPJmn34hMjZsFpj9Dj4EtEtBCG2JACghrYMVxZ3GdR
	 ICBmGPX1RJjAy3e41MCmBfyLniSyBwV+kYz0CxeYMq1pIb14IJMwFW2uLmdKqc0bueOK4
	 LF8L4mHE5+B7uUSVhe6uSm0yMrbFGPCFw26UFRqKdw2jZcCBa9C6gvqMqtIGyPnV0eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VcF+6ICx;
	arc=none smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5429606A327
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 19:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5429606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VcF+6ICx
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67921b515a7so5298891d50.2
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 11:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795547085; x=1796151885; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AmJ/S4XaOA8lG5+Jh1OFrugl87oVpjF5GU4FYG9swdc=;
        b=VcF+6ICxMd8zT1syTRo+M7qn3fDUdgBi1kXCH8WLmuFH9pS1yxbusmPIrdLhzETg0o
         Cq3170O1XeLhxD+d7RrFTdQKWVDudnA8ck4lt/l5wmTXP0+k3VJ7uvSLDBXbsJyO0c8+
         TWOm2ALrwMahnhuZCX1gHVhbM91rOkT/QGmr1QITylYEl33A0sQ2SGckf8A5hRbO6MzF
         A+Fp8RyiNWwWSu8+0+e35A1q/CrVyH+UA4uWpQ9JorV06KoEIeqBiPMGufI9Dsz705W0
         qNLzWNIUKJxju8pZj/S4nWHFs93KIoGpi+dvuYZURW/SwxqImGh4YFuAplNTD8Uc8CsF
         OcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795547085; x=1796151885;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AmJ/S4XaOA8lG5+Jh1OFrugl87oVpjF5GU4FYG9swdc=;
        b=fJAA5NkCrSbHlm+WQ0x8nPOrzpWcdekBeNA8XpyZRHj5Clo4O1kTpQdvtjbJ8dLWI5
         G8m8YHa5rZpNmkn+T1KIAF3aKeX5ax630zvuwO1Ja+gZiLKQOLgnjJLfkfRWT3wbEnE6
         giCXi4u8H86Y/2jkU9QSna+B1/LSt4vZrUZHjuVkJhpZHvZsMIeKiLw/Bk2DRrwL1qL0
         SWzX4e1D+U+CMepkkIl0/rNYw3ItwrVk34RxZBznRn9rDf6uuwniW8hMUpY7bfTH1ZkC
         RuYE8GFrXYRL6P3coQWiwco5pK9Wss92cidrrNTZSftGXMSyw2WGrg/ZvBnbefak+x+d
         GO6w==
X-Forwarded-Encrypted: i=1; AL+hErF4Vw+elCeULXWSH8lue4A128NlPcL+oi6lRaUMqhmtPo+AdM6NN/PYXqGsgyyUKS3kw58=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WwhH2+AJs259WRY/Buex4TZxvyyR1Xt0yef0tZxTuk3SewiKR
	CIb/6hqgjogMexI+5qzVP5M0yT1IJwxmEvYpXTrS1Hs/Y6S7NGHRibtV
X-Gm-Gg: AZFdTZdB+HSq/gd/SGSJNmZwop5UgCNsrEkpWgy2UBTEPYAWp89fhILlBhTWGLzgyBf
	1MTDEaBK6C4cbGaPEbv4bPdxyAWlGCqwwhQzacNFnMmGAof1c3L338nj7ZuJBre8NngJUCQhTxG
	nIxpsmbfRdQ72W0Qfm8SBMWc66oA2v+B6EIVCCwpIH6zNGrerjb/gsrBgluL+ETjB2u6dqyeCO+
	I5o5FT8JfNOio5lpfWIcQr3EZRhAs6IK+RKNHpvuCTzxbPG4PSc0li+aKpjLvkNCLzEMnpUraPL
	rnCqguepK795WsDDvako0E8Gs8jOc/OT/UPrhIb/BApxFwGN+oKoPosH+I0K/TszYeNs6Nf0Lae
	Dgrhb/PQRbguGk7mrJbR+snpHhrkfhr+sWWhb+InEit8BqwYkbvlydjIwLeJAsShE2B1C0xfIZh
	UFBT6N7AtEhNqYU8klZuqODKMPVJj8vsXE1GeXjA+qKnn7CHBB0cc1O6CpTCyFh977yut3Ox7ex
	pY9QSnkjKyZyWeuj1ZmRZ+ZIIUd3qfGoSGuur3u2EtTfWmrxIeiOtysf5v+akpB3+h0lMq11wlJ
	lE9YumYBB51DvUKQ1zsyiv+mAiX7GziOxPjTkzJgpdfuroX3BiCh4QqObQhHjdGtWR/I1WsvpsN
	+nUPZj8NTe9qzoKDN/k2krAW5Iatq6nZpz4bkNWBtz650NGHO/tqlZ0J8dFoXLnxr0jkIGx0sJM
	zUuA==
X-Received: by 2002:a05:690e:168a:b0:67d:a4e2:eccd with SMTP id 956f58d0204a3-67df4494c09mr7139224d50.101.1795547084797;
        Tue, 24 Nov 2026 11:04:44 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:9d46:600:f854:fa55:5df9:927f])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df3378f59sm7164077d50.14.2026.11.24.11.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 11:04:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] doc: add tutorial on branches for beginners
Date: Tue, 24 Nov 2026 14:04:33 -0500
Message-Id: <6F694BC8-2260-4E06-BF0A-CC284F03616D@gmail.com>
References: <074bd710-1c32-4fec-9ddf-97157bd498b5@jvns.ca>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
In-Reply-To: <074bd710-1c32-4fec-9ddf-97157bd498b5@jvns.ca>
To: Julia Evans <julia@jvns.ca>
X-Mailer: iPhone Mail (23D8133)


> Le 24 nov. 2026 =C3=A0 10:56, Julia Evans <julia@jvns.ca> a =C3=A9crit :
>=20
> =EF=BB=BF
>>=20
>>> 1. Introduce some imaginary characters who are learning branches for the=

>>>    first time and examples of workflows they might use. Test readers
>>>    said this was helpful because it helped them see different ways
>>>    they might use branches.
>> This is extremely helpful, not least because of what it does for this doc=
, but
>> because it sets up future guides to refer back to well-known scenarios. I=
n
>> particular, I'm mulling on a triangular workflow guide, which could feasi=
bly be
>> one component of a guide to collaboration with remotes; these characters w=
ill
>> have different things to say about remotes!
>=20
> Cool! I think probably we'd want to re-introduce the characters each time (=
and maybe even choose different characters depending on the situation). For a=
 more advanced workflow the characters might be different.
>=20
>>> +Step 8: Create another branch
>>> +-----------------------------
>>> +
>>> +Now create a second branch called `add-animals`. We're creating two
>>> +branches to show what the process of working on multiple changes at the=

>>> +same time looks like.
>>> +
>>> +First, switch back to the `main` branch. This is important because
>>> +normally when you start a new branch, you'll start it from the
>>> +current `main`.
>>> +
>>> +We normally start from `main` because if you create a branch called `tw=
o`
>>> +while on the `one` branch, merging `two` into `main` will also
>>> +merge `one`. Starting from `main` keeps all the branches separate.
>> This feels a bit confusing to me on first read, if only because the "two"=
 and
>> "one" branches are hypothetical (and because we haven't covered merges ye=
t).
>> I don't love to keep the reader in suspense ("we'll explain why we do thi=
s
>> later"), but I do wonder if we can give a better demonstration of what ha=
ppens
>> when we stack a branch like this by using the example names here?
>>=20
>> Perhaps we can start with the idea that we want to keep work independent
>> ("Branches are a tool to organize your work", "working on multiple unrela=
ted
>> changes"), and then after merges are introduced we can revisit the stacke=
d
>> version and show what happens in that scenario? There are pros and cons t=
o
>> stacking, but I think covering "branch per independent idea" as the norm i=
s a
>> good way to handle it.
>=20
> I like this, I'll try just saying "You'll usually want to start all new br=
anches from the `main` branch
> to keep your branches independent from each other."
>=20
> I agree it's weird to talk about merging since we haven't introduced it ye=
t. I'll take that out.
>=20
> I think stacking is probably too advanced for this beginner tutorial.
>=20
>>> ...
>> Here are the last handful of sections, and 2 paragraphs that come between=
 what I
>> see as major sections. Here alas flat text bites us a bit: it's not parti=
cularly
>> evident that step 13 + it's merge conflict note form "the end" of the pra=
cticum,
>> and the stuff afterwards is (somewhat) back to the introductory concept i=
dea or
>> examples.
>=20
> I agree the last few sections are pretty messy, thanks for finding that.
>=20
> I've reorganized things for v2 like this::
>=20
> - Move the "merge conflicts" section into a note
> - Move the "3 ways to think about branch" inline in the step-by-step tutor=
ial, after step 6 (next to the example it's talking about)
> - Rename the section about workflows to "Examples of using branches to col=
laborate" to make it clear that the `git pull` section is a subsection of th=
e overall workflows section
> - Add a little overview at the beginning explaining the structure of the d=
ocument:
>=20
> This tutorial contains:
>=20
>   1. <<intro,An introduction to branches>>
>   2. <<tutorial,A step-by-step practical tutorial>>
>   3. <<workflows,Example collaboration workflows>>
>   4. <<tip,Tips, GUI tools, and where to learn more>>
>=20
> "Tips, GUI tools, and where to learn more" is still a little bit of a grab=
 bag at the end but at least it's laid out at the beginning now
>=20
> Thanks for the review!

All sounds great to me :)=
