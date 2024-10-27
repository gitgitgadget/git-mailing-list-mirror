Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5767F17E010
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730066861; cv=none; b=ZKB3wrBIInArEtTomKSRPKcuMZFf641ej0I/5snJmZAb8Db1Q7SCBQAVMJ0u0efHOWwRgHR/YT8Ws89Fmyjrq6FrV9JnFGSUT+saXcG5HPKxpWwz2ueOsdB26GZ9VqGvTXErA0gKe3uP8Kq6B5bsFbkdlzIsYBGazxz6j0VVxQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730066861; c=relaxed/simple;
	bh=OFVuqKYKGcA4buQ+WFjaDggh2BH1jKw10djoe7QUnjk=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=t86dx+1FRfzyUpOlAE0/gexJasBrOSyyYCuvkhToJ2/mx6Xddj0+A8hFZk05FLeS6+Z4KGA009e/9lsH8c7Wx/gm3duNAjvlJmlyixWtihvfkzbm+P4V50VQEZ1bX68uq+vTL1LHMagSwQpas5yPejvSRoaCE+tvGLbH7Xq0tKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=hILE4zGV; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="hILE4zGV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=EYf3VthYAM9F7MKbvk4r/uN7t0WaGBJYLu15B5aq5do=;
 b=hILE4zGV25PXJjjCktkoJmm/DkeQUkAokUGZsE60Kx/kreqPMi5YAHS7en4qlG83hrVwX99mGK2k
   Ov5Ciim0cPjb87VkRcZIMS0WGIjKUyiVOLqswedDEW2PxUWhDswZ6Qb0OsAtA+3ptrVc0MdkmLHB
   s9ZM06Z65UJPP/FzMYRX0FQVprgnlS6EjbtD47hNWtZR2+EWuzN3j3it1rcUXxXBpBlIcKNfQu/W
   fLtggB84RrFySyOOIJKA1JZvdMta535gGWUOWSYg6hsojPQUJ3G0BCWns4xtWz3Vm8rvsGOq3uFj
   +uRFQqwz0UNnPpLJbASXb07sj28RUpJMKjub+Q==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SM100I94C4PMY30@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sun, 27 Oct 2024 22:07:37 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sun, 27 Oct 2024 23:07:07 +0100
Message-id: <D56XI8GBH2GF.3MP02MGQGP5M@ferdinandy.com>
Subject: Re: [RFC PATCH] object-name: add @{upstreamhead} shorthand
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241020202507.2596990-1-bence@ferdinandy.com>
 <1c056d39-950c-4965-89d6-85f0c2c1bccd@app.fastmail.com>
 <D50YLOBHJTLS.367TMAOLKL019@ferdinandy.com>
 <20241021191441.GD1219228@coredump.intra.peff.net>
 <D51R90BTHJMY.1C1XY5P4CHTWG@ferdinandy.com>
 <20241023215618.GA821188@coredump.intra.peff.net>
 <D549EIKDKGDS.2AETZLT4RTB44@ferdinandy.com>
 <20241025062438.GA2107756@coredump.intra.peff.net>
In-reply-to: <20241025062438.GA2107756@coredump.intra.peff.net>
Reporting-Meta:
 AAGz9HR8VvLKvG6svuCVSGIaauUPpVynKd0kvQZGe5wQ9FJaLkBJe0tpQvn4PoL9
 /SDZ6gT9RX+Fk6mdmoCaVpiG4AmSxaWg2kpBK+BKJON+dJwDWJaXTrMLqrLkco0y
 SObxJAfGUuH9Cv21c8JWJmw2ezVWWnWlS/suMRMbh7hV9Bg8ksXhDTck5drSR+MI
 UZVo9LxJLaxe5ub37opEpkLpa4zon1ZBrhoqARDXUneW6iloIly++yxs1PzgP9Hu
 2w0PbgI4iQ9y3p3oR7SYeikrV2iQPrKDrsD04D32Gz6iOqOqSUV7nDhAyOlY4Sqa
 4DCiX3id1rm6DRvEvR4yeacvEs45yTi3clYa9b5z2cCf6CAAbXpAIAKFcBXBmzLa
 ogYeUex07aUCZQzmvl9ZqzxVz8Q/EG7OPXdA1iE11B9gmHS6EaR1GldVrgxo0IKJ
 ChAOqizjW6j6GKmLErr1q5vCnvabtVMECLLB543GypE6ZDt96gSi2fUg


On Fri Oct 25, 2024 at 08:24, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 24, 2024 at 08:48:29PM +0200, Bence Ferdinandy wrote:
>
>> > So I think rather than "branch --show-current-remote", we'd want
>> > some option to make "branch --list" show only the currently checked ou=
t
>> > branch, and then you could apply --format to it to get whatever
>> > information you wanted. Something like:
>> >
>> >   git branch --list --is-head --format=3D'%(upstream:remotename)'
>>=20
>> Thanks for running through this in such detail! This would be more widel=
y
>> useful for sure.=20
>>=20
>> I'd probably call the flag something like "--current", "--current-only" =
rather
>> than "--is-head" though. "--is-head" sounds as if it would filter --list=
 but
>> not necessarily end up with a single entry.
>
> Yeah, I think --current would be fine.

I was looking through git branch and there is a --show-current option. I wa=
s
wondering, would it not be better to teach --show-current to also obey
--format? It would avoid having a "--current" that only works with "--list"
besides having a "--show-current".
