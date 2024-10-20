Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A401DFD1
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 21:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729460623; cv=none; b=uW69wxstj207LSeF+H+rDkPfhQ8Zk5RYCGs0G4Bb6KP5Z2BTR9BmFRwXTmgXyUldK3H0Vyawby5t7IjiXV/fiEXNMUy62h+jWj1rSoUN4OJq21yhexe0jeY/RL5IaTXoXFVLQ5oxeJ019w6eHJhmq0BIoBN+iQwGDjIxk9pcBHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729460623; c=relaxed/simple;
	bh=oboY4kJtRg8mfJdCS6oAjtg3BfuT+ohhFQO9ZM0Ljjg=;
	h=MIME-version:Content-type:Date:Message-id:Subject:To:From:
	 References:In-reply-to; b=XR8ka23sO4L/ZsOT5UwjCabqB41Z8N65p59su0RrOeXtADFcl1+jrxpi1BkCwO8D3T+NNF5Cos8sPJRakpWSpFib+N5D1NWy7GInHcCeV97eV8GGguSjdCepErB/2Wl2IsR4cOPamTiCQK3ELNOVkbV2OJe9H/j8xgXhiKXG1J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=b3Xj0shM; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="b3Xj0shM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=D8XZgXJyUrtaj1igjvSuIEcM6y3IBdMTfOYMy87wGG8=;
 b=b3Xj0shMqTxDYsXNzwNwzm+8PQGatyDzM8EFlp9tSiFV0t0b45FqG+UrGv25VJoTrk0SIeGoFbPt
   fDnqWGmpQctNiSYBemArWw2DZ5IbiErlZBWfAp/vJYwwHxAGBy7Hm39sY+CLqveNxCAIHr4ZU1Dd
   0x4jW1kj+6xE5QdtncMx6/uRGP+792f3EgZbZdpuso8A/bJWcl6io9sXDXQnH2pCBihG2b8EgRKK
   pID7e1wnCgVaVKcu9LVpHO5FbcSMds/O3lGlIqPsbSrfHD9cVI9WZaPYVEpz5hoqWqwLAokbc47L
   syJf6W+VYNd8dCv2uwBuHNd6/T2oo6RwboGe0A==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLO00O4DCCH1240@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sun, 20 Oct 2024 21:43:29 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sun, 20 Oct 2024 23:42:38 +0200
Message-id: <D50YLOBHJTLS.367TMAOLKL019@ferdinandy.com>
Subject: Re: [RFC PATCH] object-name: add @{upstreamhead} shorthand
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241020202507.2596990-1-bence@ferdinandy.com>
 <1c056d39-950c-4965-89d6-85f0c2c1bccd@app.fastmail.com>
In-reply-to: <1c056d39-950c-4965-89d6-85f0c2c1bccd@app.fastmail.com>
Reporting-Meta:
 AAH3D2/l5r9c/iY69S+A4TX5yv9CZU9F8ev3mnv253ZGlKzn4RbnUBnZvZj8tBqi
 FCQrEDGoTU02yhfoDnf/ulVZ+H6N11jVPz+rOsuZMD/mL0/XV0nVltC2j7GVwLT1
 TPjCzbpKv01JVYxb5sK4/yRm6hysWBE8ceilLRFfuhsQsEuPwMCybniL+IF/2yZT
 isB8wQD6r8ml3kYecZ5AB0yXp9Yf1Q4smg2yR89dmJ5QHI20XmxpKnRNOiJVWVAv
 fKHaVeM0u55bZOa1hPEuk31dIhieLsR+zB2V4Q0azlAsvBExNEFpWgnYNZYll7HV
 xdXi3JK90YU/9Zvonp6x/qB+kyBuzCeMImqEFfuWdNe41Wls7HMld/7uany7uChW
 MKOI0DWn900iw4DpqhkYx1vvYPx9DfCLNKkiXS4c0e9x+VaThSMWpZD5xnEaU6qa
 uoEClKROI3xzdWhj4wt/xM4kNpn6Djt6SreLQniTMsUVvovd75jzyG70tw==


On Sun Oct 20, 2024 at 22:40, Kristoffer Haugsbakk <kristofferhaugsbakk@fas=
tmail.com> wrote:
> Good evening
>
> On Sun, Oct 20, 2024, at 22:24, Bence Ferdinandy wrote:
>> The HEAD of the remote is useful in many situations, but currently one
>> would need to know the name of the remote to perform something like
>> "git log origin/HEAD..", which makes writing remote agnostic aliases
>> complicated. Introduce the new shorthand "@{upstreamhead}" which returns
>> <remote>/HEAD for the same <remote> "@{upstream}" would yield.
>>
>> Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
>> ---
>>
>> Notes:
>>     RFC v1: Testing and documentation is completely missing, I'll add th=
ose
>>             in a v2 if people think the patch has merit.
>
> Do you have some concrete examples?  I=E2=80=99m not well versed in using
> remote HEAD.

N.b. I was intending to write s/many situations/some situations.

I basically use it for two things:

- variations of `git log remote/HEAD..` for which I currently have an alias
  with "origin" hardcoded. E.g. I'm on a feature branch I'm reviewing and
  I want to know what commits are new compared to origin/(master|main|trunk=
),
  but I use HEAD, because I never know (and don't really want to pay attent=
ion
  to) what project uses what. And although "origin" is usually ok, but not
  always if there are forks in play, so @{upstreamhead} would make it agnos=
tic
  to the remote's name.
- I also use remote/HEAD in CICD, i.e. with `git rev-list origin/HEAD..` yo=
u
  can run checks on a commit-by-commit bases instead of the end result of
  a patch series or pull request. It's really useful to check have basic ch=
ecks
  for commit messages for example. In a CICD of course for a _specific_ pro=
ject
  you know what HEAD is, but still, using HEAD makes a step portable across
  repos. And again of course, I think in CICD you almost certainly will alw=
ays
  end up with the remote being called "origin", so this change might not be
  quite so useful there.

But so the long story short here is that for
(origin|upstream)/(master|main|trunk) we can already have agnostic code wit=
h
HEAD for the second part and with a patch like this we could have agnostic =
code
for the whole thing.

Best,
Bence

--=20
bence.ferdinandy.com

