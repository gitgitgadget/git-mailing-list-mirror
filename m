Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA651C6A3
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721816406; cv=none; b=AtUGIU51fudjFWe2l42geRikhPES2h/7UZ2chRK2/KjZhqmOsj+7k8HltYdlaJPXwpEvYiP/UEpqVKee5EoYlyCtDseUxHrx0k+Q+AeintafKzelxvizc6o2+SkSLqRWiBaDL6/+w/jfQIWJwZDIM9yZiUwmn/ekqEDGlC5hRJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721816406; c=relaxed/simple;
	bh=QiZK3YpHxmCAUuulfxA7ZSQjMfNKryOsB8BVxIZqcuE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KkWrkICgYH0KPScy6hxvEtn9U3eqOVLDlMlhAN+ruFZQ+9e3qeN25bjEwpa5eQUhUKy34y1hM6bHMs+F23iO+zuqjeEKImxPdaIyEBpuOTgX+fGkwc3nilKcwFL0CbTepiuB7pgj5Gfw+aZ+YJK543LI/lEHZPjPzA6jGepopMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Nk3iunSz; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Nk3iunSz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721816398; x=1722421198;
	i=johannes.schindelin@gmx.de;
	bh=s9xNbAD5GxWgBhZH1RyuCdKKlCu2d+lFIyTEGrKSt3Q=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Nk3iunSzsk2Y/EXfPIDB9iGVEx/rYbp+mtczsZfUHZOxS+0aIjdU6Bp0xKQOCdfH
	 TVs6KcH20fxwdHj5N1xNY+GgoA8Mssm7oClGzocKEHPG6xQdEE+0cTnORvt/v0kx3
	 ocUu4oW/OxP0GSVJU28+AxQy71iG1WwQxSv/MGXhkX8jMqQmu1XlpOUV9Ka7CMWY8
	 HEnaXgsb+zkSJIDU88AeQmLlw+iNzlc9n6uemXGL5zqCnlumpgQHyFKGwJTr3ewd1
	 W42ZA33dv5JsWOnp+uFO6wM30VIim9HvYP2FcWSvxse9P1CMAj4XWfpN6I6ko5//6
	 tFz4i+2RpjsctsaNpA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.218]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6Udt-1sdQiy2BfF-00Byfc; Wed, 24
 Jul 2024 12:19:57 +0200
Date: Wed, 24 Jul 2024 12:19:56 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
cc: Junio C Hamano <gitster@pobox.com>, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH] cmake: fix build of `t-oidtree`
In-Reply-To: <D2NXQ2WZFF24.1GVN7WUJ5PCHZ@gmail.com>
Message-ID: <c109d620-0258-cc1a-e847-6c6c841a2232@gmx.de>
References: <pull.1761.git.1720816450344.gitgitgadget@gmail.com> <xmqqa5iml28j.fsf@gitster.g> <D2NXQ2WZFF24.1GVN7WUJ5PCHZ@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/qZcII1gL+GO9RfQvLDPupKx+tP6R38SBiuh8UUdX4lLRMtCRdw
 uBA3ooMguWXPFNNTM8SCImKZBTiV9WNZL+GZKu1WAx54gfHRiH7GWvcr0S2t1Cz1faHJBeY
 k9PzkeH8/2KxkEFlkQsxmMxZYgpPMkNlFuG/muxh9W7sPTT5HlRlfJnq6lVyXB00E25WNN9
 kLIhAGRMp2yTkOPCFPiaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Pg+TagOUwho=;255OXQ1eerPWL2y05p1oLD0jllL
 9LzCPEu3gSoOVlM0KLer4yhGRixTUd0z8NMLwQFG5EwH2qhqzb257z/vvAZ/Y09J2j7X9Pd7U
 XVGDxg5fL/5HyVbBBQbbv8kTPf0k37fWZMgQfno0Ugb0bNk8mBdVJJZqxlo9qgOhdB4zpuMOl
 h4JVR71YoAqhGSOAuT1F3ojUsfmol7pAI7POJD/xchVo5UTC64QQTNiKNpy7szlfY+TZYZF8R
 lW/lf61zMIqEvZkI5a2DI2sgOWeW3Vz1iYb2NFxIBzQ4EwWH3xc1RVS2hM8iae6YI2jTFSBE7
 dZK4EQlqbNcCzijK1DgjUCTPV+EGn4uJCD2uggtG5wEQgiroywiKv1g8TaC9YqB1jYMSv9Ym9
 c9ZsNORkLSN5D5MPDRO6n+DfmuC/398g+oFIZkZ6Sw9YMc4Tm3hH5Sy8/HB7YW+BJgBRTRPlW
 M/MbptQYluN92JGcMJiBj2phI5UhPXMh8SlV6mc5Wi/wQzGC5pQvwcfMU0PCVc3ZZGolVhSq1
 8VZ4JlrIL4SOa84Wn2NGoEdpW0Jd3asz8ICGFj9fRZIPXROMPqk35H1wMieTYhOU1Bgoc3mUP
 jwV/7fZVbIfHIv/vo5ypCg8HSIWNkqLbEtoFGQhNbfZXfpc9mDfBf/Q68MAfhTlWCBYhgez+e
 mGNkoZRNux7xvLvrrV0K1sF8uM2FXO+5oAIQ6RzrxyPXs7ek80Jzo2GYr/LYsdTtoyJoFo42G
 g8ILtLnk4P+AA/i8lUgz1NsV5ato28O2JjrDPd+9JFIm6RFQKLTV2mCmHu7tIziko7WctbtB2
 KOQON9LtsSxKHeU7iAfU9UhT3/nGgd5hXU9sk96xq3nkI=
Content-Transfer-Encoding: quoted-printable

Hi Ghanshyam,

On Sat, 13 Jul 2024, Ghanshyam Thakkar wrote:

> Junio C Hamano <gitster@pobox.com> wrote:
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> >
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >
> > > When the `oidtree` test helper was turned into a unit test, a new
> > > `lib-oid` source file was added as dependency. This was only done in=
 the
> > > Makefile so far, but also needs to be done in the CMake definition.
> > >
> > > This is a companion of ed548408723d (t/: migrate helper/test-oidtree=
.c
> > > to unit-tests/t-oidtree.c, 2024-06-08).
> > >
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > >     cmake: fix build of t-oidtree
> > >
> > >     This is based on the gt/unit-test-oidtree branch.
> > >
> > >     /cc "Ghanshyam Thakkar" shyamthakkar001@gmail.com
> >
> > The base topic has been merged last month during this cycle, so the
> > fix must be merged down to the 'master' before the release. Will
> > queue.
>
> Changes look correct to me.

Thank you for confirming.

For what it's worth, it was this confirmation by the domain expert (i.e.
you) that I was looking for when I Cc:ed you, not to spread blame.

The CMakeLists.txt file exists primarily to support building Git in Visual
Studio, and I removed that part from CI builds specifically so that
contributors on the Git mailing list need not worry about that support.

Ciao,
Johannes
