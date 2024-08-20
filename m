Received: from sonic312-20.consmr.mail.bf2.yahoo.com (sonic312-20.consmr.mail.bf2.yahoo.com [74.6.128.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052BE19408E
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.128.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724169458; cv=none; b=Dl7qR90qM4gK6m+8z8mvoQagRqtNwT43J+hAszTFpWQjVAI1CsViJgk48Ervh5080VvZstjnDMFxA+HnP4HgEh7wr1TGuexdeTcW5bhzygIwHZ+tVMbIqyatDFlx52n4lw3OT9KdWysrf9VHp/h4kj9su4Pippzs6tc67k9lgpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724169458; c=relaxed/simple;
	bh=UeKYRmG5KGePrERp6A/ZWjyOuSXAw4yCOiwN4CY37xw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=EarD3NablOgST72BcF5rQtjbh+iy+x3kQcGVLSgLIvUCcHOnipj65vdFyr7Nji1LYSCvjAE4gmU81goPwB/vb1vq54kaeZbIE0Ym0A2AmIWUGTs5dKpQuodQ3AZtWKYCkc0vkAggMggMIhU4Wz0bJ6FYYMBSALgN87IHJgkXFcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=R2w+npCY; arc=none smtp.client-ip=74.6.128.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="R2w+npCY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724169450; bh=UeKYRmG5KGePrERp6A/ZWjyOuSXAw4yCOiwN4CY37xw=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=R2w+npCYnJfZ9x4Sc179bfP79eI1A0YZEdoAh1iEqJkCFkVayZP4Dm5EUZts0OWJPK3fkW+15pwDM766wU6nSe33W8Y7omp4dIgFePcjTYeNJzIFup5PVYV75h0/eIjrb1mxXDGkrKHaY1P+VuBgdDEOTstAxX5z4q2L7Rdx93kupPsu1IuiieYA1ns/mToxlVjXpoE6fYO3Yx1aLI0KvhwKfxqlokPmsAtsgJUV6cFm+jYfJ+gLpr9FaUdSR+HeXkU6oDy9QXFruM7JnTgAH444h2rSdEBb/m2Chqn/2e+7X/qt3XqXYprX09+i5cyc8oUJNMUxD/iKiA2fvjojkg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724169450; bh=W+45ff/7f2SAswn3p1mm5SMJtGyD0hYlMGrKGPUs22B=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=AU/OYgJURoMmKaK5wyp83jtwn3Teoi+jGib6pzaSg/Kq1koK8ia/gA1N8GrMtzZYRStUbUW+ycnto43+yrUslb0iqB+0an8C+gar+uOadn2o3coR6oMv59cioZEdLlAWx5Brlfsa4kUad1vuK4GrEtI26XvecnI+QyqKd2CSQF+W2X4aS4pcEmiJCLYbHrrSzFB3dxvrhvsFJPWDp2h2NDFUCG6ynssRLEjRK2yu14js2fzjjJKiimQZTid+rna4S1kCQItsb9gaP3zyG/99MzYxTa7DJsbN/zv4aKJGJJpw5Muyp1Brv64YhSbNR3jO8cqmPlqbDchHJrZBZCK+Vg==
X-YMail-OSG: GDPEp6EVM1lwaSZDsztMPTN_Upkc7pL98tI5p7jE_p9NJ3iHbXN5JKOK2dD.v_u
 _WDFJoI.Z7XKNq_t0hja0sl84aGQrHhtCGdnzCBO4iz0GAAM6vUhoRZhJURi0oZyWY2M_hjbR5yC
 ORQr3BvtrL4opAzN.RixELEc7dj5m2n0OcTkh6jtBCzxx4ay8VJ7x5.K_emSeS.yNqhWg9PbU5HI
 mZPKctgafTOI68eA0ikgtw7U_VLe7_XkL4xrOI8e5wZDMw5lG1y.42RsioA4.5EweQBaVY0XI0gM
 pLS2ZgKm_Gz9vlWcgtbYzbO8sbS2morJU5DN8WlSfW0pAvcopRksXAKsq4UJj13iRheIaQFWwDmN
 14OQEYBAV8I25ZC..TIglmlhgz.whaQj7wIxQiE4dJeA2s36jQ4Pgk5E.QCusMNv.lm7Er_D6YPx
 VeLmisFTF2oprWo5LHa2MqYw0Q4gU1lnjZyzq_l3Kio2EZCXK3f08MSTRj.8PooCqmqfqi89rJmG
 zbtS2uyXrvXyon_Il_pFvICJbu_ldbrqGZuPnKLu_KKrzxC2Lc9Nwew0zazshFSHyaQB5metkG3O
 Z__uyhHmLEWhKChOsbpVWlRFP2IzNT.bhZ5.6zhmzj8PYCrsNs7bfwMaJMkrMhu92hJtJmTux8Kb
 KpqbFfpy3GQqpEiuEhcBXjS9wHk5Mi7WUIBh2peiDocSuYGTPpFucxRQwkuU9CV2BvaSBy3h26de
 QNgo4Bpz0KhsboOeK17oG_ZDlsZb8eMHL1qAxFat6gJ4LUhB_pvBKS1pSbC3ElGKFRk4el5sw_2Q
 k92XPS5AZ1_c433vpq.T1CCo_MTB1N_MXrdWXhqwL_ZWd6LfjxabnNZ3q.HY8f8Tl9dWuNzct_9I
 Ofhy3k1V3216YEQYmQswlZfPZoQ6QEQl6WkEM2iJON7.Ha5kO_gPJvN3O4Kvouzpw.Ww_5MF2uIN
 4rVl8LwHyye5zlruruXz8nR3tMxjUKg3zdb7CqiQrwG6AP48rnnVIZNzG63j5u3Qs3rfO9OOOrxO
 5vvfEbixJP.vwlBsVZOUZUDBWFZMrEAb0yVML3EqHl4eX3RpAn3FSC4.uXNbWRhb95l2uP0wHEOM
 etdsg5fvpeIxeEqanaJc8dtr0GQn0Bu0KM_vJ7CbS5AKBxyv29pLu6UmqydGTT2F94NbQ_.Idn7e
 PEIkZ07M17jXyJJoZuYyg6Fwh7fdbGc7MMI1kHEc7EirSWamSn9vdx7zsY8XkOF9uxaxV8NmwIxQ
 bbXMvZ61Mn3NoKjjXxLSKSTgBbZg5Lj_vafJNwdxJ44QT8H1CBKjxYfO0rjYUw8cCSvVdVLSEghM
 JllKt2gi_64mkgpCUdCGqV4rF9nZ0.P9wchS1X1p4vio2ZpPa6wI4D57_H9JE7e9_HQZVzGJzvIC
 W5A6kM.3BIzP15IbqKecc_5zSiv0wgt4K262P042EOd3RPUKivLYJKve89CS0vhYqM0vO1KILnGe
 tgV8MtVtRyr6F9.YX7JOogxUEX7m_vTqSKM3bWI9njLBY_wLn4.adbn.ibNsABh4corUHysRJcVu
 ZO9FWDS2lfsp4AaXycE6WOWmsIDb7PXyGzWw6XrWjdy5PMy0rgNcz3MYZBtxf45XZb_MZVjxqCEU
 I8lmULfn2lw0wfc19N3e6WGRT0U14kDvuCGQ9uzQ.swkCHOAkDrgLaMQlgdaWSERTsYUU3HmSL52
 gMkskN.3u5Bn3jslyaDARSLvRvFeT3h8E47PLm1HJc62ykJdJzpW9FbPOkJ2QfyffH.Y4TqlKhSc
 7nn8Jpg6knlovqO8BOEiSa0qNZs30k18qfuWYsQKyk_v.mtfUuMhi5.BAyqfn3EmqLP4RRm4cfBY
 jmfWUhbD0OBcF9UyI5jmQVvCHv1_7KGteywXCpIt7UzwbG1JuDFKMadiQO0EJ6R0UFyb4o_0NRBx
 CroNnU11dLGVkfarJ_eTIwBJr0nLN_eHiBro2JGcEMG6xR45wYoZaapMEoItmElMxILECc1i.deK
 IQ0lecnIO8KT4hzv0v5M4lzpuIfZAR0yxinYywluxo_iZtrD8tpnb8gRXETB42Gc9dNgkYYM2IbS
 jxXDDeanMiPsjkSeLWXbjww6me9vU0F5NLhPsywXuLhsblm31TLu7f6uPY0l_5_6wHtAhNWcYd13
 MHPzx1C10G2mDaXuHoAyUmf2EO8u8WcY0SEGdX5TpYHdLGWTVxU198HfOxLghuhRjxpab9fl3PQb
 OEQpQ55a1JmPJHNOxkm9E00fdfB5j019DkG5Y
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: c13921b8-fe03-4927-9364-7332ee07798d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Tue, 20 Aug 2024 15:57:30 +0000
Date: Tue, 20 Aug 2024 15:47:19 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: Avi Halachmi via GitGitGadget <gitgitgadget@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, 
	Eric Sunshine <sunshine@sunshineco.com>
Message-ID: <1689227029.5308571.1724168839763@mail.yahoo.com>
In-Reply-To: <xmqqr0ajb467.fsf@gitster.g>
References: <pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com> <pull.1750.v4.git.git.1724118513.gitgitgadget@gmail.com> <xmqqr0ajb467.fsf@gitster.g>
Subject: Re: [PATCH v4 0/8] git-prompt: support more shells v4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22544 YMailNorrin

 On Tuesday, August 20, 2024 at 06:32:55 PM GMT+3, Junio C Hamano <gitster@=
pobox.com> wrote:
"Avi Halachmi via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> This addresses review comments on part 5/8 v3 (git-prompt: add some miss=
ing
>> quotes) to fix minor wording issues at the commit message.
>
> Good.=C2=A0 This exactly matches what has been queued in 'seen', as I've
> fixed these typoes locally while queueing.

Ouch... Indeed I didn't check whether "seen" includes those fixups.
You're testing me ;)

>> Hopefully this is the last wording fixup.
>
> ;-)=C2=A0 Let me mark the topic for 'next' in a few days, then.

Thanks!

