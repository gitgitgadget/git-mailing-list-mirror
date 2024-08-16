Received: from sonic320-25.consmr.mail.bf2.yahoo.com (sonic320-25.consmr.mail.bf2.yahoo.com [74.6.128.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E852170A1F
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.128.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803869; cv=none; b=p43YXpk1EW33mVazHXWh/zzyVgZEgWsstyrEzpeV13XihGRI/gjJrJxWN5fKg4j86k85GOlT1a+VqOQVv+Z/OHb715Ob64OPOr1ZsD0zD6Na493WEpk5ElQ7qiXjCoz4FDzeG4zcbxGWTUD7eTMkRLWL/fKfaTBVEU0QRRK/fyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803869; c=relaxed/simple;
	bh=DTwyLRrg6Toi7ClKPRqN1HnlbUer5H8OTzyT7cz4tNU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=jTvLjDsuHwszh8bZWPiZ/rWjc03Fi6dLkHpHiFmZRMtev25ay1il8pxOGOoUzZ1DV9sQ3JSvKjjChAN86ukOp0WHG3iP65rZpz0NoPC9aYDZV65Omo+vbohrpusULKa+MktFqKj0ifPtalzwXQ70HhxTH3VL7nmUQ4oc4W3K3Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=gwyMmfXg; arc=none smtp.client-ip=74.6.128.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gwyMmfXg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723803866; bh=DTwyLRrg6Toi7ClKPRqN1HnlbUer5H8OTzyT7cz4tNU=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=gwyMmfXgWsbn/KwFjmnC4fSqn7VjkIEdHHcAQWojTjfUdQ/EgRjq7JFgmiAtN3nFun4m6BpFLz7gvFEj6NYY8vSF8zZWDbw2Ajysj7QjstQzaiO+JtvwhK/YUluTbjtUB7k/Q6gUbOZ7C8eIF4IHYoJ49+FtAGJ2KDVVe77auoHioFOwUdSFEJcwLrgc4gA728f3yrtb1g4TO7x33N+uFMsKXmTY2psBAC2y7jXBnqJFZTO6s2sfI8b7ufGKVm0HUsQeLT2+otWAieugpbZNjKfmn6c/vBBt58TFxUP/upZQDLvhzIWl9ne1vZFOo1QyY2sGSF+h9csLKCDkA0R6hg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723803866; bh=jpoeXjHQCTj7E/Ta/k8wNEtInXxDPJf4vb2e/xu/x5y=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=QkHysEdGFpZ5I1+hxrmr2lGeGW2BVaWcXGxBdQJJXVNAmdSeBpYOLxWf5fM+Vbd4TdrZnkm9NMaGU5Lh/Ywuw30BFMdozJvIXHQyxtKhEvncxCkyGPPlSNKeaaCQd8qO8vp3jdKjANeabWWeyrgIaDVEw9feWFrt0jHaeSZN76IrnWsqHRl70mSuQrWzysJyjmMW/ySFOvG3AO2MihCxJKQtacK8dwp7Deqe5rIBQ5c0N6Cpjuo5fcKh91xm+lPlqq8RrGuoqewCPkzPUcQ33fCb3uAOkFCN5x6+MYelm7CsUOjXC6fR0iy32ILt0H2Iu4jn+B2phiPmm5wfejCGpg==
X-YMail-OSG: ZZfuRGYVM1m7J8wVhUYEVHleEeyLTYuobyH92I.EYrSA9broaGjAd6nd4ynnRPP
 n7EerUcGoRExitzdeGGws11aZdEWJKAYiSzTNYArdFgOR8.sZyuF.75QQI_ngUsseFUX8w0QsCtc
 cOyruxStgkm4WZmxluTh.HDw1K5SEOkxlgEFNzhs0FV4rJUAsZCzTmhknVEFqt5hasz2v_F_ZAwi
 r0n12T.c.ljRBTwF6_TpHxNR6sVeKf.RplwiMTgdVNsmuybTgOzNHFQ5rM50zY1efQyhKIbbVRHk
 59nfVU14npLbbczPCRTT0nA60bImhcJqIpaRiEU0GVXoSEci6LxiGiEsXp0bbIFztF4k79u3uZtE
 AykuUE0yqXjAKZLPpN1MzB86KFLtmyqy0f4JcoCZdxe250LHGXUkLLMqVZ8B4Y91YpY73MNeGbgP
 tu8h7oKRqYu2NyaJNYYfRUGuNR7D_NkpKij9fiFrT12WMee_TbkcGdjToBE3krr9NAudZkP3l926
 r.1O3tt6st542OYh3BhYr1rEFzxNma6NhO4d9dn9YiL6layALPfCdznt2MFuCjaDnLxXBDO2yLJc
 GkS5vcxvmzOLB6DL.1EQT8cAL0nMSlqoAD15TsDG8AzXoGywdNbhqLI4kCAwrsAj3xRQZYnP1tdY
 xxqZ9deSatzrEPn9eUiVGii9P.Lp0euyAJmry33BBiJj09k.Tw15CRaRVCy28g3lD5SHfMs6XQV8
 3qkChMlP.dVBiIluI9KLIPcbBzODz5LB78fzvO8rxuyPaj76jpqfesNkP4qz3u0H2xkIKK8OIRlm
 jgAZ5bJW0S2jbMMgf6G5XnQSb0Rt0dRaSBTZL3yu9fe5Q52fjFzNaZ.Oep1xmF9usd_eAodU5p01
 nU.dSTCClASYlUi1YkxqfG2g4McZFdZ3K4QFQN4XoxFPqsllYo9271sZoOKXWRP1AJJWaTK9xVuV
 wUx1QhEIefX4eSf5sFouJuSFqmMp1MpL9J8x_VJ_PxzbM7Mur0pwe5Bpm0FiEkSFx_qvIsot7Hqg
 BiORSNtoMSuArObaMO9A81JAXXjIm5IYq9yqbo9w2ghDHzolODYGoGfN46dVl6xj5YN5AEnOzm2z
 B3pEjW1.yS2fLpHcCKSJwFcnN20MUyuYfw_fY_BUSOf6XPDfh4kd7rb0Q9z1cSifSOWmc2dtu.0G
 gw.83yllmbpoCMgxZjLwYw84e6OYI8UoqkNQR_jaUBa8s0sZzm8MqL2DQphDvYiJJVcO8UiTRwC.
 rRuMhfZL80Lhjbg1CyGyEaU_ZpCrDdCxGzys_.Q5MnsrGOw7F8kbRhhZ.7Zy5fPVuAzgk0Xpzhkw
 J8elXpMagwtPQKSaugnism1WWd7gJTEsXiYJpwyDmLOOk52pqtfRKexAm1UOGYdPPe03HSixGbNC
 5PLpgzDm_1MMfqXh.YnNyC.u2B0E3yfZcJaG3Ur0oz8EMCQRCXEHI9N0IzsVju6Iw_QloW68YOIm
 e04EA6XhR4oo4H1ATgzLe6wxcTvJZXHkQtYqwhRnvflrLB8fpuk9MmeI_YFlE1CkYQ62.AnYfQqK
 Gg4HaNNoEE0AMh2PU_ksQAV15zsvG2.5De52e_a345tQgBwppemZxAeAU6mLt3owjlxdKgJselMg
 OTh8ZDg4bORbRlJA7aKcPiVR6r1AGOsohFpg0mzCydTzzxypR0TWN6rP8GEkjGiGt8_dQPE_PJSH
 swvk54Ynjf1KSZLkjMgrfAF5zzP5xHIQoPXcuCWLnWywQ4E4TAagg1bOdeCkL8_abUqGQ8b4LSVz
 jWrcsNJyNAbbNIDpGj5npNd1gQlaYhxJXdMClxU4u1A9SrL8IfL6mJcM6FaFggoD9vIrYYVAMUU8
 fI79GUZhR7kJDgIkbONYJvadY3xwv6MlziSDi2T3i9ZfrPISw_6EArdbcIpx7Toc9BiNq8nREnK.
 hiv4k8OejfdhDQD5GMFatnAhfbZX13ws3nKWW5x.Z8bZ8upwdTFzGrwVgJxO2Q_QY746XzR_kn_b
 egahQzFsa4knzoJOtvjuGfIrclDxJ4pZZf8lo3bLTOumCsXkJngYzO7wLGl5MqG5tlPKwI7Ts.E6
 OzSto9L6pYgHbifgGU3nF5lZpWB_rmk.ZfICmLU0gXIXOzwSwayKQ_0.Hm4Wb1h5dBtvIOb8uMl_
 3zRty9klHRVx4kTi7QijCPRYdHANkskiaZM6T0I0lSuZcjXVxVvBDrc2ULHp7aiMe_v.T9qBuGSu
 QjxJ5iH5dzZJxMFd_RTcdIOlsi0.jPb9yNA--
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: 7c6921ec-b911-49fb-9c2f-5416b1261aab
Received: from sonic.gate.mail.ne1.yahoo.com by sonic320.consmr.mail.bf2.yahoo.com with HTTP; Fri, 16 Aug 2024 10:24:26 +0000
Date: Fri, 16 Aug 2024 09:53:36 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Message-ID: <1677713578.1741123.1723802016957@mail.yahoo.com>
In-Reply-To: <Zr8Swsn3H2ebB7g6@tanuki>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com> <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com> <7e994eae7bc3dfa021262410c801ddb124ce24f1.1723727653.git.gitgitgadget@gmail.com> <Zr8Swsn3H2ebB7g6@tanuki>
Subject: Re: [PATCH v2 3/8] git-prompt: don't use shell arrays
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22544 YMailNorrin

 On Friday, August 16, 2024 at 11:50:14 AM GMT+3, Patrick Steinhardt <ps@pk=
s.im> wrote:
> On Thu, Aug 15, 2024 at 01:14:08PM +0000, Avi Halachmi (:avih) via GitGit=
Gadget wrote:
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 svn_=
remote[$((${#svn_remote[@]} + 1))]=3D"$value"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 svn_=
remotes=3D${svn_remotes}${value}${LF}=C2=A0 # URI\nURI\n...
>
>
> I was wondering whether this is something we want to quote, mostly
> because I still have the failures of dash in mind when assigning values
> with spaces to a `local` variable without quoting. I do not know whether
> the same issues also apply to non-local variables though, probably not.

IFS field splitting and glob expansion strictly never happen and never
happened at the assignment part of a "simple command", since the first
version of POSIX in 1994, so quotes are not needed to avoid that.

See my guidelines at the commit message of part 5/8 (git-prompt: add
some missing quotes), and this always works: a=3D$b$(foo bar)${x##baz}

However, this does not answer the question of whether we want to use
quotes in assignments.

My general take is to use quotes only when required, and if one is
not sure, then use quotes, or read the spec to be sure, but do keep
in mind that some older shells are not always fully compliant with
the latest POSIX spec. But unquoted assignment is ubiquitous.

I'd say to not quote in assignments, except to avoid tilde expansion
(which can only happen with unquoted literal tilde at the input, but
not after expansion or substitution).

But if there's a strong precedence or preference to use quotes in
assignment, then I can change it.

avih

