Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF9036C
	for <git@vger.kernel.org>; Sat, 18 May 2024 00:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715990557; cv=none; b=rkijE5AZTd0v4Ot+PySS3x5VEl8uYH5EU/5aptOyhGesw2ZDGJYLd7yJxcq5JH85JFcK7zFL8Dnr553W7DYeCf7N3hAzipcstq9IXhpQKsMf5gQJKQNyUbIwmhUvo7OftCTXJl4elV17xjYm4Xrzsm9a7cL8m4HL8cQ+9e33NYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715990557; c=relaxed/simple;
	bh=gH1kObjyo0pq4Z8uQGTUhqchwOqp7TrLdR7EwV1CWVo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HEl7o1R8WUmhggpyMn8Ughc5V8oZI46egLtF1g87GNfec9/+7Gk08nPAtejH3tKC9o/aOrM1Y3uWcmsVkSJkoICIx4DOimIa3zwAtyFxrF00UvCOuY38Fr9VviNWbv3cOUko3cXtbElm2tWVvhw3yuW4CY06y6rt1jrljNc6wWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=PCUiCWFn; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="PCUiCWFn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715990543; x=1716595343;
	i=johannes.schindelin@gmx.de;
	bh=7fMewBqMf65QVhzzUELJ3qrkA9i0TxcPOXRqQkVYlLA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PCUiCWFnyJqhmMCdMYIZYIHay8TXac5ALJ7ZsB71He9PXw7ih5oWwx0t06RV1C40
	 2dI1mo4MBlREU8G+yJGMfPNJnK0KrH0wfKqIr7z5wPfjBkYPReJVGcFmFHGM/ARLc
	 So+4UlwSyGPjrpYrl48ZDnUeF1dqAqXcWHHsdbz/OfRUAPM09ZKgJLZNvX4hmSN8Q
	 WXU/+V3JQ29OX9iccDkH+rE+wHFdPFKx4ghfRc8XR9y6uAHsZ2sWT7M5fOkDx5dGH
	 j0m0JBaP8VyahyMS7eLiLk3SV2KkqvqboCdf9LhYDClmCM5XNEBUb+MRELBCrxBDR
	 ipLwGvu0k7qfvwQcng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.77]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2V0B-1sYZPM2sk3-013z7w; Sat, 18
 May 2024 02:02:23 +0200
Date: Sat, 18 May 2024 02:02:21 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/8] Various fixes for v2.45.1 and friends
In-Reply-To: <xmqqa5kodmil.fsf@gitster.g>
Message-ID: <3b140a63-ddb1-bd84-94c5-51e39d60c011@gmx.de>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com> <xmqqa5kodmil.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:I64nAjNhATZoc1QXXNXy7FcdpiMIQAgaXbnvSOu+2Y2N4WLW6Cj
 KG+ugvW2sUQNBRhQ1yxwmhRFPoyubYIy25pd9QdZC7BdD3ranI9DNHoCadALBSC+AQj9A7N
 LYcxiF40yXppCICE/ZF3OVMZP9wUKClTrmaYx9yry7IN3n2fBjMLysPoAZGY/f79mXUK08N
 CUHyFMvkrhMSIBxJ3tmCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9r2nCv3vv2I=;dQ3HSb9LUpXFnQ6KJw2DG4IkyMQ
 J0KICWmItTveIZ9hS6Seq8i9YhDTtfYBObNmHZWRZ7YUAQVMOtPCIRPQ9H0WwqgcHmLg76Hgp
 OZaAZ+9fzk1R3LAzPcVHzkywDyPq9sh3luNgh3n3bHtq1kcA6r1Eynl9PBO8mzAJXYYrW+KN3
 XRbyediVSZLnxVj8QHTQRdzMAGfecCbc5uhfEM+TihPEdJURd6YVhycs3BwAJ67rWBC/fmKQT
 gT8HWcuXV2XiAfI7AQEIpkONDeXf0NQwmGPOsf4wj7BliFn/N8cf048hYlh3Q8yuEw3l5ts4+
 Nv0sAp6kf0NU0XdzzK/8aG3X1Re9pjwUdTR8l/rG/U0F7K+zvOyuF5MLkIt7AA7bsK5BveDLo
 R9vW7OduRflDgHe3TBP5yQ/Nt9waLFyP5//Y2uE7oS7XNBDjGt1OfSYa0tNegAi8ObyCvgFLx
 iRySkC5w2KQbuquAfIMMRnNtzm/TAZpysW2aJ8g+JRKSs1RrM4V49G4CpH5gsr8aDhSKXUNIl
 k9avDKKVf+xvKvAzcc8m7nXuJiZCgvMV2eK8LE+2mOeXzk8CCr2/VOobM8Hz6gpeB2ixThMqQ
 yFXLLzyj9iiKQaERy2+6V/gJBf7oiP8dfm6wIOu2FHXZRl32bFoRpO/WQJoGdKjns1TvDqWPK
 OZB2JM728jSTRmHEa4V0nDkqzWxJaTqpV70GhgNOJwwMcDGWZrrVVijkLK8GvDp8Zg/JlGqzz
 zujREGV+Nae7n+njX3ESgzcj0xFWxMPKrxYeth+r97/bipByLzQ5neTRZBWpaLIiJvEM7FGsv
 5K5my/cd6xWhWorhS6S0BCKMdYqAt52HEtFSgmoy9ToHo=
Content-Transfer-Encoding: quoted-printable

Hi Junio and brian,

On Fri, 17 May 2024, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > There have been a couple of issues that were reported about v2.45.1, a=
nd in
> > addition I have noticed some myself:
> >
> >  * a memory leak in the clone protection logic
> >  * a missed adjustment in the Makefile that leads to an incorrect temp=
lates
> >    path in v2.39.4, v2.40.2 and v2.41.1 (but not in v2.42.2, ..., v2.4=
5.1)
> >  * an overzealous core.hooksPath check
> >  * that Git LFS clone problem where it exits with an error (even if th=
e
> >    clone often succeeded...)
>
> I thought brian expressed an interest in the issues these patches
> attempt to address, so I thought it is helpful to Cc them to his
> attention.

oh my. I forgot to add the Cc (I guess I should have slept first, but I
wanted to get this out so that the Git LFS breakage as well as the other
breakages could be addressed as swiftly as possible)!

I really meant to Cc: you, brian, hoping for your substantial expertise
and kind code reviews to help get this landed soonish, in a shape that
makes Git better, and hopefully averts more breakages.

> > This patch series is based on maint-2.39 to allow for (relatively) eas=
y
> > follow-up versions v2.39.5, ..., v2.45.2.
>
> Thanks for basing them on the oldest version that is relevant.

I also meant to provide `maint-*` branches but basically ran out of time.
Will work on that next week. I expect quite a few merge conflicts.

Ciao,
Johannes
