Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B431C7B64
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 20:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541553; cv=none; b=KSRCIPNppChd6LktwSBGHcsLvvtOuD88CcOpyNZjBGhkJ7BZykDmYfgFG0is8kt2iYPTZj1jsKjp1te0xH6/qW4viYg5d5Sz3CKRUpHPT9Kw70kcLKvQAahLiJx2efuqO5WKDvSCdQdW2RM151aC+XJgsiamBPniR+YR4AHviGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541553; c=relaxed/simple;
	bh=C+ay03ciWeMc4kuY2Q1A893uqtLsCKUrDaewFd8rRsc=;
	h=MIME-version:Content-type:Date:Message-id:Cc:To:From:Subject:
	 References:In-reply-to; b=nT35bDJdgmw4NPfCWNaVOJw0rn2Tf5g5F1R5K5hYEJ+uN8uf84cH/yGX8iX6SE2OIEIeBhWP8bOhBvSXdzljThsTzqls75lFSACOvwX0jIwLeUoV6g/jIMQjve/q8Pgk1mUzH/6b8F/tja1hOad4B+WrLuzoBo/n3/UuA5I8094=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=mgxeKEMz; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="mgxeKEMz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=C+ay03ciWeMc4kuY2Q1A893uqtLsCKUrDaewFd8rRsc=;
 b=mgxeKEMzJ6abdapte4SuZvjYQbV53gWMtYWwFiI5uyKrZfphX/y3JevR/VfvPay+NZYp12rShSYn
   X/M1yBfLXng9fCuTlxS7kOgq1lXaa/NDnhObLme0xg1J219AyXiD0kmV5hExCjpcQ4LIn8zqY+da
   Z4LoNRGsxJgGYZ7NwUKwIyJHWbOoMunXegKZFB6FDqXjJm8QRMhMwpreb5hwSIetub751HIbW2l/
   sFgfaNonRRWw/3z51+TPIH3eeTacFroLjWaREte8dP22Bk38vtdy/VtL5nZ8vonWzS7ZtNUXD4Dn
   36vZH7MMxuicU6/GeBihPIEpFFMj8cVfLHSIMQ==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLQ00NYM2STYO90@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 21 Oct 2024 20:12:29 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Mon, 21 Oct 2024 22:11:14 +0200
Message-id: <D51RA8GNVDC9.1DBQYNQVHEP69@ferdinandy.com>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 <git@vger.kernel.org>
To: "Taylor Blau" <me@ttaylorr.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: [RFC PATCH] object-name: add @{upstreamhead} shorthand
References: <20241020202507.2596990-1-bence@ferdinandy.com>
 <1c056d39-950c-4965-89d6-85f0c2c1bccd@app.fastmail.com>
 <D50YLOBHJTLS.367TMAOLKL019@ferdinandy.com> <ZxavVmjsshVHCPcL@nand.local>
In-reply-to: <ZxavVmjsshVHCPcL@nand.local>
Reporting-Meta:
 AAEnPGpg7kOVOZ4tMYtz5EM84CBz9HqcVKzXcMjURRbySG/ilfbnoQDh0RCIG0XD
 zNeu6MNdJX7p4SDQOrNrzxKDK69c4TwfQAqEVGJYw0dL3Hj4zxyZVgrPrRWSsTsi
 qNDFhgsqCidEUzrJKjcdx4CuAVw1VYYnNISQYn7GNKJkXa1bWkczekqXR8U2bBPi
 kG9zQmeYutxTcv5htDKu1lH5VeBn63hMPt8DicaS+TNsWW8UBxIuxyragJlVdZa1
 GZEUnD1ipsRzmfh4z58YDbcwqXt04xOtfn58DP8jKyHm09eohyCz1Rz/RgRP8Ler
 JdJsGQwfli1CujwB6K3uppLYL95RBOhWvpgHaEgUzlPmnXMRlz/9V/ZrhymBZOs4
 E+khxtaOfsX3hzvR+o91TmkxKXNIkYqueKcE4D5b8/W2cLhJu6GmOj84jIgW8v6m
 GkS8X/+97pPBNBKmWKz0b7y0HVj/XF487QLbdOYhnKMR9uYkQMptBK8=


On Mon Oct 21, 2024 at 21:45, Taylor Blau <me@ttaylorr.com> wrote:
> On Sun, Oct 20, 2024 at 11:42:38PM +0200, Bence Ferdinandy wrote:
>> But so the long story short here is that for
>> (origin|upstream)/(master|main|trunk) we can already have agnostic code =
with
>> HEAD for the second part and with a patch like this we could have agnost=
ic code
>> for the whole thing.
>
> I'm hesitant to pick this up because of what is said in this paragraph.
> When you write "(master|main|trunk)", I think you're really spelling
> "HEAD". And it's fine to write HEAD in a script when you want to resolve
> something to master/main/trunk/etc. without caring which and instead
> delegating that to whatever the remote HEAD is.
>
> But determining the upstream of a branch is already easy to do as Peff
> points out downthread. So this seems like a band-aid for scripts that do
> not care to perform such a resolution themselves.

Agreed, Peff's idea to make querying remote easier is a much better way.

Best,
Bence

--=20
bence.ferdinandy.com

