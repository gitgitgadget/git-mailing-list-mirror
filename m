Received: from aib29agh122.zrh1.oracleemaildelivery.com (aib29agh122.zrh1.oracleemaildelivery.com [192.29.178.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6F02770E
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723921545; cv=none; b=oxRNp+WAZa9fixYgW0dxokU6U47OYgsySrTP1RvnVHjdbR8zDywAsMZI4H6CgEluYAKK8cADRgynN3YxyLoj0BPACtupV92cPBq0uBnNOK2JlCOgwtnfApcijpIAC1ws4GeWhYFMtwjsgxkbYA2H9FpdQxT8IGqLrUq/gX2Uv7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723921545; c=relaxed/simple;
	bh=19Cfnsjr3hfIbTBaeAyRyx8TLfPiJaryCpMtq4rtZWk=;
	h=MIME-version:Content-type:Date:Message-id:Cc:To:From:Subject:
	 References:In-reply-to; b=ry1rOjZpbOrpB38stzf6ebDqiEumsQQHLfFegJf4uNW984csVddTTtNdLMncPwtwzKCK8mXfuU8CqSMCBsL08q/UXi7pE5N1Nk+GzqfU5pg2XfuZEeDYGu/QYj0xR32zspXAJduJwarsQS5F0NRM/tJ9ZxNv/pAaLlG5S0SYIUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=IaEnMNk8; arc=none smtp.client-ip=192.29.178.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="IaEnMNk8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=aVb2ghM/HpKgU3si2D1Airrb9fKswUv1AdgbVG2vfA0=;
 b=IaEnMNk8VnbF4E/ux3LOyjleSC3ittgcpVXGTVX2MfVgtAGmQmxBtVn9I1BuY3D5n0iRn3hLdObY
   prgN6Z19WLGmd29g1dp0bOu2RyqahFUUVAw0Q5dl7COCTyn5fQq2uC8r8YwWON3Bhz0ap0QtDpKh
   SXQURp2xPSh+lsfnmcxUzV+KwEPhAMovz63f2469rpwH3w+yhNMTENDFZUvH4UGfNKXzOHknvq+U
   Vp5MUyxNOS2vIYVBzIXKG9wOMwNFVwCzbIm7iYgEEhX8EPn2oALChCp2JDJlKq6AxSHciQEeu15U
   CAxv/RQrriePd94a6IDgVRxTJJ4zK2X10GB2IQ==
Received: by omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240709 64bit (built Jul  9
 2024))
 with ESMTPS id <0SID0033NM4WB240@omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sat, 17 Aug 2024 19:00:32 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sat, 17 Aug 2024 21:00:10 +0200
Message-id: <D3IF2EVJPNMX.CFNKJQDPHZQ0@ferdinandy.com>
Cc: <git@vger.kernel.org>, <felipe.contreras@gmail.com>
To: "Jeff King" <peff@peff.net>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: feature request: set remote/HEAD with fetch
References: <D3HBD7C1FR14.74FL1Q1S9UCB@ferdinandy.com>
 <Zr_KtAXQuFwEmFfI@tapette.crustytoothpaste.net>
 <20240817050240.GA29822@coredump.intra.peff.net>
In-reply-to: <20240817050240.GA29822@coredump.intra.peff.net>
Reporting-Meta:
 AAEy/YMOifmFuVM1f3YiyQn5jwdvObZmrbPomH88mB7fDplMhp/QAGRrw82DdqNU
 6sTaPJ2ZqAJrQuXTtpZV6WuJAIt5T7BRgXUtjBaTEiisZJWsPJL93ghuC5/+VYCf
 Mo0/69D0xaF/F708D1eNFwYz0LFeM8vSnRfGm5PUyLwVDC/q/VJG4x8Ct8ns5O65
 8oEkNY830bPg7qLNILn9jlqgmQwfh2JIZ+2qNpTYRp8V8UmrA7UJSOGFnWZZUs1U
 46QsomvFQDbjj2dOWd7F0lPKcnbatNBRGU3B7xecfxQV+G11AknTVdX1gkbCPapz
 RmALidHtMzl5g7SZNlmpb3s6jQ/d90D3KFPfPrw5xR5pROcd0XN8yZkq6ZzNTbxq
 5SNSSRZH/qpaaegMKwkiTI70LcTmPi8kDvf4cjOWnYoMHj5od7TsjAM1if+HduQC
 H4bpvDy7Lmx9PbnHSqLKE9EkDYRl80cmW2tF4/vG/Hnj0t2g1HQtAHo=


> There was discussion a while ago that proposed a tri-state config
> option: never update the remote head on fetch, always do so, or add it
> only when missing:
>
>   https://lore.kernel.org/git/20201118091219.3341585-1-felipe.contreras@g=
mail.com/

Thanks for linking that, I didn't think about searching for old discussion
before writing ...

>
> I think that is a good first step, as we could stop there and leave the
> default at "never" without any compatibility issues (and/or contemplate
> a change in the default as a separate step).
>
> I don't think the patch in that thread is likely to go anywhere at this
> point, but if somebody wanted to pick it up, I think everybody was
> positive on the general direction.

My C skills aren't great (probably an overstatement), but if Felipe or some=
body
else more qualified than me doesn't want to pick this up, I'm willing to gi=
ve
it a shot based on the Felipe's patch. It will take some time though :)

Thanks,
Bence
