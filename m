Received: from aib29agh122.zrh1.oracleemaildelivery.com (aib29agh122.zrh1.oracleemaildelivery.com [192.29.178.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35AE45008
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 21:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724189969; cv=none; b=nFxJqX85Ty0h05PVRBJQ8TMxii/pfEBf/n94X6XB1scG/4GVzzNVqiQsddehcRmpbX4o9dzWP29jQsJgjinWfDuiW6SeBOB0mk8Sn2I+lvRob9TGUigYiNUlX50al9Xky1k+3GRuK+OosMTuxVTmQUzhyS+IczZItPjmKTb2KSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724189969; c=relaxed/simple;
	bh=gxVCtrCp1IkMXI8nHtAUTIhQZTo3IxsMDnAfq4jJtQk=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=Ce8+X03jMXcyq5Uq9Ti9qHIzE7Ag9k+T+zIrl42QuP1oaFoOngOBZTB5xSgD5YR8pJd3hWdZyaWIakcCdvkYoB/eysZFC2wFjZ4I3LTpSmz69YR0GvpOCFXwbGrilxttXzJJTqcUXN2OTAPHWoXaW/doV89nxrE/KjXnyHRsdbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=SEHddG7j; arc=none smtp.client-ip=192.29.178.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="SEHddG7j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=gxVCtrCp1IkMXI8nHtAUTIhQZTo3IxsMDnAfq4jJtQk=;
 b=SEHddG7jVf3F39UhZKJfezr2wQzJUXIXL0i3Iwxs/Si0x03uG8aWdx1/1TW2Q04M7EHltBfudGuG
   nApEwaElEgCabvl4WfWCKecKKTAinGFhutnSqg/Ic/eEvvOoVYbEKhTlhSbNZgGvO9DMwL+uMVFA
   WUF82ULdjFub3aUFR+QkUsnO7tsTtBIcws6DyyLgl2lRJh2YnTeRxBQZ7Jdsr/JLJORVeNjsg3xh
   pGw9m4d8nOdyZbDL7cfirSbH8xOkBY4i5ymlAtbTFP4h0ShrcThnFqqtOh+/7P4ETFG0V5fpHnLW
   AxK+8lBiGVJQO/2V6RtHLpPRXeuDeeTGEebXgQ==
Received: by omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240709 64bit (built Jul  9
 2024))
 with ESMTPS id <0SIJ0019UDHI4140@omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 20 Aug 2024 21:39:18 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Tue, 20 Aug 2024 23:38:53 +0200
Message-id: <D3L2BKO9M1IE.3ADG61CDGXLV2@ferdinandy.com>
Subject: Re: feature request: set remote/HEAD with fetch
Cc: "Jeff King" <peff@peff.net>,
 "brian m. carlson" <sandals@crustytoothpaste.net>, <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <D3HBD7C1FR14.74FL1Q1S9UCB@ferdinandy.com>
 <Zr_KtAXQuFwEmFfI@tapette.crustytoothpaste.net>
 <20240817050240.GA29822@coredump.intra.peff.net>
 <D3IF2EVJPNMX.CFNKJQDPHZQ0@ferdinandy.com>
 <c10652f9-3cf8-e1b3-27f3-63fd5b8ac52a@gmx.de>
In-reply-to: <c10652f9-3cf8-e1b3-27f3-63fd5b8ac52a@gmx.de>
Reporting-Meta:
 AAHN/r1j2yuFv66BSzW43sTENpp/j6EnkQMEFBtkbI3xdCkemdjS8cq1mG2cBJS2
 IqNraqHp/uvz9YS0jdrKchvWbo/jKKqcrVs0/1zngPWKNsyOV0Sf4eWHcrvnHsNa
 5GiP+K3U2SCD9TwgrPvAw8EMx1DwlIcD/sR4srx8/u3oTB46xOH3NA+uPPcymvKB
 PCWj4a2nnS/HNaeN7vA/M5KiSazLalBTuhbnpp3OlA2OyPggTWarcyPVez1UnRgr
 Igb/fTfSAv5LqnwvI1J+Nnrxy9kbHyavRO7QFF+aHlaBLQSGMLlTamZKfFKXC45H
 rg+mngVCFLP3lSv9wkXSo/3yGxGwbgN5WXgUe7d3IpdFpxxTnU3WgwY/cVYV/+xB
 FEXfgItJn02248rBRm2JKM7adA3O+1lahIMV6GGwNl2BTbI3/N8pOWB9A3H2dM/V
 PKO67CwQE+5kaudVHFgSeUrGbDnRvtOtsBED5nrCTfK56XzQkbh5elw2

Hey,

On Mon Aug 19, 2024 at 18:40, Johannes Schindelin <Johannes.Schindelin@gmx.=
de> wrote:
> https://lore.kernel.org/git/ZF%2F38DXNYMsZjvy4@nand.local/.

well, _that_ was definitely not something I searched for.

>
> Since this leaves you in somewhat of a pickle because you probably should
> not start from those patches, and since you seem to be in the same time
> zone as I am, I'll offer you to pair with you on getting you started. If
> you are interested, please just reply privately.

Sure, thanks, I'll reach out to you about the details in private.

Best,
Bence
