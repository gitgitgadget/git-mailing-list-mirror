Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A5424022A
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784508; cv=none; b=a24ZL0homwVbCvFIEZyS3DKnG+V7980nPnVGqi+8QIKR7rQJ3Jy4tNRlU9JDWoSmJRPuXQA9PzXlz/c5mt54LNEUFhACN5uw3R1M3bZJeuaLtXfjkQkjgWAtq2vP1KkeZv2NvKpSexjxCbFXAUKMj7Ak2eWNW/j1vggkvi56Q5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784508; c=relaxed/simple;
	bh=wr++9i1IqXwIPEQBJY66z2LVmWIWVXf1zNsN2rMBov8=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=I3Avr0JJwLJ771cm4B0YNDP4hROQOv6J/uI7qquWvVk6c/8TkLCD74TIbzpuTnvZQJP0IDcikPrsiI1gnZx4sTpvkFl1O/ZLI0AB6FYEM23I1Ig14QpmRTV0L9po8XWBIYEMlzzTZdTutH8q+ZNnxFz0xbg3B0I2WQde2jYaJOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=BL8q7zIC; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="BL8q7zIC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=wr++9i1IqXwIPEQBJY66z2LVmWIWVXf1zNsN2rMBov8=;
 b=BL8q7zICrftqH4arpN+Iv2N/B0j9ObQh4UsFA1L+QuVmk+QYldbpxOkXZF4dB1Ob5QAAYZb4RzJy
   4laShtlHnYzInNAoWjVPvg9w0JIjEkwh64hziY70nxG+oMWkEGGKQOPlPksuJhm2DZZi56PONLfv
   e+Pp4l1nq4xAwQFy/1qys9m/pzXD1AnulpsGP7dHxkNSVJrhEtzRlQbjsiRaqF1tCRGd/pQabFJb
   HGI6ts8rXzP6nOnCcJBy3lqyqdmlHT9T3JuZOlwK4k3buZQIBUc6sJWbWZ1P57S22tJ13ZIav8a4
   OvwohK3WEGhDYF3VfOEBMoPAFFbgUHCgKBBqjg==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SQ100ANYB9FJ910@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 13 Jan 2025 16:03:15 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Mon, 13 Jan 2025 17:02:31 +0100
Message-id: <D712LKI48ZUD.2UK8FX0YZBEYM@ferdinandy.com>
Subject: Re: Git 2.48. Changed behavior of the git fetch
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Danila Manturov" <danila.manturov@jetbrains.com>, <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References:
 <CAM6buW5KSDGHD7txroqVa0TN_Ou_eV-LocMy06cPy0ZGDQmY9A@mail.gmail.com>
 <D6ZXVILR1D36.3W0QVQCVE1P2J@ferdinandy.com>
 <CAM6buW6NbdZ6wLGP6LWePiA7n0At=jxxqtBEUv0fTY6mOdTmyw@mail.gmail.com>
 <D705W1554XJ9.30SRYLNGNOX4@ferdinandy.com>
 <CAM6buW77CeuKfr3b4SUbYyFaU1OTvRsYBjPBE05YMzJo36bGdw@mail.gmail.com>
 <D706LPHBPUL4.3LN27T1UG1FI2@ferdinandy.com>
 <CAM6buW4UiCs9pFeH0cxxdhLHCSNO9wLVz9_p4Y0u8LaGWy--ng@mail.gmail.com>
In-reply-to:
 <CAM6buW4UiCs9pFeH0cxxdhLHCSNO9wLVz9_p4Y0u8LaGWy--ng@mail.gmail.com>
Reporting-Meta:
 AAHM1CNR4kCShnj96YlBrRr6rTGj0cyVXXrZUSWGwsO+NsyaHu+kWcqHnO9+04sF
 U1oMEJLHn/uOZu11yhcUxA+wRlNykyWRuVMnO73paQyIy6UwsQUmM+yVY5vrAf2j
 pKSW2fF104hLcZjZSBRn88XTeNVQlR065PI66M56jNkw7lGfW9g8+dvbtzg5itqr
 byXHI1Be8KgVGoNrNG7JRXtDJhlZCfQio85M6WmsP8p92oHCtPrg5LPyorOOndit
 PWEBAQ7USHe58Ekh3pc3XJXLCM6T4xb8qcAU99tFXry/Eeo6liJBgkgyeGUVq5bG
 oNQbFGeFpeM1eFC1DfY3mw8kgdXLX/nJ7GdLhVH/bcjPzqFd6k7Ba7vMkhcAVRaP
 c4PFYzBV4vpW+jMGEJUBZLW8nwn8L4YKioFAlzcuhuPpb9zWkQFlqBGCbXYBq7Zj
 1Jzhp5xX15mK73qLUI2UfVH0DNJ/qfLcDS4ekFd1PMPu33Gn4o00AjQ=


On Mon Jan 13, 2025 at 15:14, Danila Manturov <danila.manturov@jetbrains.co=
m> wrote:
> According to our CI, the first commit where the bug occurs is
> 5f212684abb66c9604e745a2296af8c4bb99961c

That makes sense, what is more interesting is why the fix Junio wrote later
doesn't work in this case ... I didn't have time to dig yet.


