Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D86182D0
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736090339; cv=none; b=tGeoxTqoRuA752WCVYOCpxRiRI9qi3yRz4wD0IQacu5e3UIJdEBIVu2DAEgcWe+8LitaON+U0fHgG9yKVbznkDK5iwah/EMN+qj2YN60/q/myY/Qr/aoO4HRiIrQGfk4S8E5qPvFYP3J/DaNBYiOLLV4fQ87bS3LVneilWvD2eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736090339; c=relaxed/simple;
	bh=dri2uJ4u9SNZWaEplcRuOifPbxRXo574G1sRbClcUvI=;
	h=MIME-version:Content-type:Date:Message-id:From:Subject:Cc:To:
	 References:In-reply-to; b=VbaTL3R9sz5aZRdZLk09NRZTZfA4GQt7zOQ5zJi1wyebLA5ikm5oCsPJ1HMoBqWr4vFj4EvFoldMik29CydU4aNGxmFPnbQdorAa29VBZbYWODji3xaaLGIJ8+vKqf5AjLdiGzHuxMIfdzYR9AFru8XOBPRrhuSaYLVzq/VmVA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=IBoFboR7; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="IBoFboR7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=daBLgAaSd7w/mTShyQk/G+n/xLcOTRTPu7xNygyiUec=;
 b=IBoFboR7s7tvZ8eCjeZONUcw6laQaKlgRBOS+VsOXH/tO/AwRsCQl5Bz6+k17spQipYMcGw1prJf
   zDW4Yui/I5BHFQxglwoo75qAU21MAq//VFDO3CcVujNdJLvh6whWSpq+L396fIsSE/f/YkeMjIPD
   kbxJH5z6KKdl8w4olCO8JftJ62UCbFg4J6DyWhfBHtpQlCS5bi/diAlhTPHpgUJu2xzAxM0SKps2
   eQZCcAJABxn01DMGDa5gLoYePssuHADqf3iYeugR0kzNLqxZzr78J2eIENjjBCSyeh+mlLNOYWQ+
   f8N16C/O6OPJlBzs1l/v/3Z6GBRJ+gBTQwUpTQ==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SPM00O5UFN14R60@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sun, 05 Jan 2025 15:13:49 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sun, 05 Jan 2025 16:13:32 +0100
Message-id: <D6U8JPC18M31.3N0PIVKB8XTLG@ferdinandy.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: [PATCH v3 2/3] fetch set_head: add warn-if-not-$branch option
Cc: <Johannes.Schindelin@gmx.de>, <git@vger.kernel.org>,
 <karthik.188@gmail.com>, <l.s.r@web.de>, <me@ttaylorr.com>,
 <phillip.wood@dunelm.org.uk>, <ps@pks.im>
To: "Teng Long" <dyroneteng@gmail.com>
References: <20241205121737.1181695-2-bence@ferdinandy.com>
 <20250105114201.35079-1-tenglong.tl@alibaba-inc.com>
In-reply-to: <20250105114201.35079-1-tenglong.tl@alibaba-inc.com>
Reporting-Meta:
 AAF2FAaPSH76QMmHOIAc0xUOGf1nAdXyAc8wjigM9DlYu/c4Sf0j5YKk8fxi67Ey
 SNa5Wx+zuujEi+8O9WbVtWRCWTqBxzFwTy5PrnMIOOAaY8ZK0qF5/hQctOK4AB5M
 yopipLjXslKgN5R7C8WFVRdugF1WllW4Vct7LaPWqQubyqavXjKNINssCzf01hkp
 XfH1OtKgoMvEq0JIyf5695eynwKVO8lwEUUJBttl2e2+IkwVXlBuQAmyU71BpzhM
 wAquIVuD9tcJA9aPj1Q0nhjvzgjbV4xFMguK4PKKaVALfXRt7PSypEtX3L+ykQFe
 sb4t5CWr14ofssKJYdw56HJ4YyTrk2ozk3UlE5wZRS5weHaUq/Oe8vTPxJHQPhQl
 PL6cr+klxeIPr7uQtthFXsK464v7/HFz2ZpxUC4MTRRQdDto++jhNj53VCaiHMtQ
 qt8T55TqstUKbD4xR2ANiCuKTHCXAzwQLg3tgFxrnqh+T5XSGKnjtyw5


On Sun Jan 05, 2025 at 12:42, Teng Long <dyroneteng@gmail.com> wrote:
>
> Bence Ferdinandy <bence@ferdinandy.com> wrote:
>
>> @@ -1584,10 +1584,12 @@ static void set_head_advice_msg(const char *remo=
te, const char *head_name)
>>  	const char message_advice_set_head[] =3D
>>  	N_("Run 'git remote set-head %s %s' to follow the change, or set\n"
>>  	   "'remote.%s.followRemoteHEAD' configuration option to a different v=
alue\n"
>> -	   "if you do not want to see this message.");
>> +	   "if you do not want to see this message. Specifically running\n"
>> +	   "'git config set remote.%s.followRemoteHEAD %s' will disable the wa=
rning\n"
>> +	   "until the remote changes HEAD to something else.");
>>=20
>>  	advise_if_enabled(ADVICE_FETCH_SET_HEAD_WARN, _(message_advice_set_hea=
d),
>> -			remote, head_name, remote);
>> +			remote, head_name, remote, remote, head_name);
>>=20
>
> Seems like the config is unsupported to be feed a variable named "head_na=
me"?
>
> Thanks.

Ah, yes the warning seems to be off, it should read

git config set remote.%s.followRemoteHEAD warn-if-not-%s

thanks for catching this mistake!

Best,
Bence
