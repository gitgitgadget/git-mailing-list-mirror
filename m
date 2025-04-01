Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA8D224AFC
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743532531; cv=none; b=WYFG1wIZk5cDhkL/yur/Jb+Rw6cALnvuBP9EgEpY69YzjdIeqP7rGGVNS67Ic8+Wiz3PBdUKfYgLOfYMphAnoJH2yKnEJGZWadxipRjLiEyuQEyExImpjSJz2NOlPrQfdr4ggrnxMfr1gpA+q4jC041MBO02oLRTTrkzCbx7H/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743532531; c=relaxed/simple;
	bh=v1rweqTxEuM+BLuzFTPdmqznhJDKaxkK9MLUqxPtQc8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z/SqQFMxaT04epwMlHflMN38zGiShwohgOBNj2nuno5Pwg4qb8AX1ehpCYXidRJRBTTTsv1opDYVER2/2W6N7LG00l9Kiw3S/cQY8htJZeoZcnDKUVB2LIjyUeby3QNXFfXTwsOCCTTJCxJvH1Vv8dmOwcr2tpusvkQOmGL85As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=hLGze/f4; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="hLGze/f4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743532525; x=1744137325;
	i=johannes.schindelin@gmx.de;
	bh=INcQ3ZPsVE0tHLGHFfVtN89/RCw59dSZaMBVRIDfhBw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hLGze/f41mxc3nDIOxG2wC9pvLFdJMjXcWeWIcXzALYdrPHLjXpCFcVYjLQ26N63
	 mX1iIsOxZdsyQdtylk5ZOUJBGiyGMPl5neHxXN+WOyJEPUoDK4hLfDX+FcAU4cF3x
	 saaMtVI2oRtdtjbSSJa6sPWabj9CvOiod/JVEgNwquXzo41esKk8/RvpMo1AUOTX4
	 i3DDl0vm6CkOo381MzHByuQvDZ7ah3BFB/st06NRAy7qrNna8yHFY6Riu829kymOx
	 dg2GKvhmILuDRBQ22RZlZIQa+o8HmyomX8QGUlSCbApxdixv6PLH2VcHnacoGZzhh
	 N3ecf0YwNB9EHPrOoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Nv-1tVHOG2vuj-00pI7A; Tue, 01
 Apr 2025 20:35:25 +0200
Date: Tue, 1 Apr 2025 20:35:25 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
    Karthik Nayak <karthik.188@gmail.com>, 
    Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 12/20] t: refactor tests depending on Perl to print
 data
In-Reply-To: <20250327-b4-pks-t-perlless-v3-12-b436de9da1b8@pks.im>
Message-ID: <4d461a62-9cf5-c64d-cd97-c70ef53afbac@gmx.de>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im> <20250327-b4-pks-t-perlless-v3-12-b436de9da1b8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GLFCsnYMDiK6hu8IJQ+dpToB13oLGa3LQRbfAXd9PLXLcrJEAR2
 AK8ubmmdrOlgHVkQT0oAuQtCKQ/4RMwqJxPKrXuPQOyyfogZrEOSnmBou+KEwEcIHa78e4h
 QVlm8YdVTtf2UNXjixhokS9yWuv0SSYKeXLOOoXvUqdwgY1XR2hmJ6BD8hHm1xDENYRE/6E
 +2jePZvmC+X3Bp7o9I1lg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M6nTMYSlqjE=;MTzrPEQTNVInYrFpzDGQjcK4MYx
 QqP+/0Ze9+ZGbgBv9kLFypzIqnN7cCfzHGuogmI3j0EWrUvRJEAZK8n1nol3hyW3D4+4BgPUG
 /TrnBgTVhl/c1C2d+rFYEV7k/lorROmUW4qsrmV32L50s1kQkRZIRkKmACNPf4X5a1zep9VA4
 REb0V3aBj9IHFjbbRaQLJHqNbby1g+C3oW6z0AX/wWI9EwJz21BF9KXse9j98Nvu8seW1FDyV
 bcDWuWl1wcFPW47fpF/64GEYx2qLu3qWJ9yJQANFBSh5kBwhR8Rf0ybi3iwJYc8vY26Zc+9ZY
 /71STPd5n9Y9C7l5PsnKywRAyvtcZAS+NqtzHyz5rGzfpEhb6iSvKs32nYpwKtQnwcK0PAp+s
 jxRyYeqlv/OLHTAbbnZ7op131cnGgS0eu5rga8ylmxyc4AmFBpVLMjeShvld/wNtbnspvVTBv
 FIaGRMGpv4sw4VfivAp85FaGP3eUgaE1zQMZVjSP4tlxY+zN10K3Y2gwn2aVLZvVufyV1+xte
 RdbgQhhXB6Yvbn904XKih24phOOIjhuYPuuNxEuJHBvO72JqLmWP5lBpMmvCgjLKTzYcegelL
 zBKdT2cu6aieHmnHmoGFbNOgBawD4VR981VsjX/fhZ0TDHRApSw5CUWXvwefrjNs4fu2zcweE
 msZNvmIkoGBjxqWzyuj4tpXwBSFUhZ1Tyiw1kMKbWeO3/HWxQh5po0bfAWALH2rd0kKp9qXND
 Op4APHZPYyUXpfozgnhK+ZRWmg8uJMSf90oatFTlw56Und8UCOO9IcM420wwzDbWDCTs4q888
 ybo7j1TKCQz7GgO4oMyqeqUlfZ3T8dyzmNAr35o0ANFlHyOdse1UUKZCt4HhjvEPmlf+aQRkq
 sa4l7CG2eVEzcAHDPv8UGKKVI5DcJ9wHCFGF6cziqF41HrKQvsF6a1nJc0UW4nZOXSJctQk93
 AdkDvLiW0lsq4zm4v4GDSm/MTeCzepEooIxQc4utXNJwjlHOCr92v0VEjSMpAQ6cIbd408T+X
 2wfG4/4UsPZ8kUSzZoZLoAm/R/9DVDQcxm/OaxJ9cce7eFsXVCCsKRClmo++XXf9k3SeFmiSE
 lyx8/KPLTS15EiX50njbCIzw+gO8cRBxpo7LxhhUTA/QmCBkao1hRHvL9g62dZHE7NFPURIyv
 GsVJb0xAbvWAZxg6Tp/4c0TU8gXilScHP2WhEkSbfmaPqIDn8Cvc8FjWdsjWMUr43948kC1B/
 IyZrvTLCJgxIYIbiw7eQIk7otY4ZTnI/YRYcjr2PRf5GgXilVqeEWsnHXQAQ6Ney4eWBjVmQw
 Y88V8rCjg4C/Fh8lSeopKXia/JxpPehOHZ9w5PHwLIkZvaXk+kJziCfnYjKnGc4W8k9HppsNc
 oodz6u1H43FPuggIAfDiXhYsyJxAbxboK3bnfvqd0jXpz4v/3sFPk/vVXUjijZhogHoLd37mc
 bJRWB1I5oTY5hYeesPjEYNZaCnUbavLw0+cC20wndwsynwTNh
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Thu, 27 Mar 2025, Patrick Steinhardt wrote:

> A bunch of tests rely on Perl to print data in various different ways.
> These usages fall into the following categories:
>
>   - Print data conditionally by matching patterns. These usecases can be
>     converted to use awk(1) rather easily.
>
>   - Print data repeatedly. These usecases can typically be converted to
>     use a combination of `test-tool genzeros` and sed(1).

It might be even more elegant to teach `genzeros` to generate streams of
bytes other than NUL.

>   - Print data in reverse. These usecases can be converted to use
>     awk(1).

Or, in one case, `sort -r`.

These changes all look good to me.

Ciao,
Johannes
