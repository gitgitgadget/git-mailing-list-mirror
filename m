Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977231C4A0B
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016060; cv=none; b=t8NIoZrzaq1j3sGV0/NM3DwuZ9sPo4Y8H7gmeJTvzpEmATeU8+JiG1HIMKwlsoq3/lmQF339u+XAdqh+N7WCIDSfkUWKVkzS/HZuwlbBVqTYI6WFKt4IDe03A3IAW0xjv5EHvEfxjy9g64+ZE8I5dxLGbVg5/lz3L4FasT9vRW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016060; c=relaxed/simple;
	bh=6nlUHCRhBznD3ApluvOYivYaL2NuUuAk0cPkDVDv0gw=;
	h=MIME-version:Content-type:Date:Message-id:To:From:Subject:Cc:
	 References:In-reply-to; b=sKiedcIkJUWSJbEIyDFDJC01vXy8GwTCaym6qVEGwtHBYYDbak5rzXcRWQ+6Cl0XJUc/oOcjSX03T++aPZD0+6ukayxQHKo3JsVjHa7LaP7vN+/YqSPb8QHj4Xg1d8AJvBufoE5V9ZsR2Ze2PAkJUHxfEKaIP6G2MBforuuqRTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=j9T7spjm; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="j9T7spjm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=Fl0dda+ifv6cfSaUzQcN+RtGzr/vrCivbly0eLODaOM=;
 b=j9T7spjmVYsAbsf4ijH1ralv98zpPNHYM/iRhl/iZt2DPjvoCPiD6gyxlsbCQyptAhZ4KO1RQ9mf
   XUU6LWU0D87I3g0zHlNsN0+RFMDi0gv7scPWgFuc5EeN8jF9daD7m0pUCFPKumSLJm4EbSUmZOwQ
   F2X03TNk+U9VoUZtshYteESKqkr3qhlDUeaCZqjjrSz030Eu7EfEnpG6qf10FNrnp0O6UzCiXDnJ
   0LzF/HENxjfXxwx0e0817lK/mm1mDa08GXXegh4+U5CSG0UnsxPdmhmUA/wj6L9hy5SFMSHxcHmW
   pVyHPV1ETqYYITPvF0yEneqj7qCRek7G0hyupg==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN700CJM45467B0@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 19 Nov 2024 11:34:16 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Tue, 19 Nov 2024 12:33:45 +0100
Message-id: <D5Q4FTSLI0V9.OWVEG3K8AKRN@ferdinandy.com>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: [PATCH v13 5/9] remote set-head: better output for --auto
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>, <karthik.188@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>
References: <20241023153736.257733-1-bence@ferdinandy.com>
 <20241118151755.756265-1-bence@ferdinandy.com>
 <20241118151755.756265-6-bence@ferdinandy.com> <xmqqldxgez4l.fsf@gitster.g>
 <D5Q32ODJM8P5.6VQ08LDQHPXS@ferdinandy.com> <xmqqiksjcx4e.fsf@gitster.g>
In-reply-to: <xmqqiksjcx4e.fsf@gitster.g>
Reporting-Meta:
 AAEByJ93dgQs7iIJkwxQLsVWG1S3F4/8Qx3A6mFbgNWJDuWgsf2A7CdKX6IdO1dl
 oh645hPgN4Ow8cnOVIT+Qg8mIGulp6WyRuC4sVBOF7ZKvwXacWqnNSSkaFYq8VxN
 J/IG9zfHIRlqFNvBI84spYq7tQxtIsgVu6PUTpl8vqobMqPA4bTwiJzDYw1/N83z
 Phc7s5zHUZOXplBOSc4lDNd9uJCDbSSGBlfL7L3NzaoF3VY35n6fwDO9e9B8MYaS
 VI61P0x9BLGzdWgyuvPvmjuElQY5HhwyE64ZceWhPzRuB7h8bT3ShrlgrkHrtQtO
 S7puByEimanF79Y3WPcNG9lDtvPXBugcvDYu2kTecGWB7AbAXtogY/37hGxVIGFk
 REc36BvB4c6BCuIx5in/gDC+222IJ8uYQiMnh2H6tvOoF/eozhO48Jc/7hGa6Qrq
 czq/YdrFEbfjaCxm2U9dwUEh6a/DFb5NTNTyLC3uJDt7lEwY2VAY26I=


On Tue Nov 19, 2024 at 11:54, Junio C Hamano <gitster@pobox.com> wrote:
> "Bence Ferdinandy" <bence@ferdinandy.com> writes:
>
>> No, it is not, but it's also a mistake. It should be `updateres =3D=3D 1=
`.
>> refs_update_symref_extended outputs -1 for "not a symref" and 1 for any =
other
>> error currently. Before I touched the code it was 1 for any error, so I =
left
>> that as is. So we want to error out on set_head if we get a 1 and contin=
ue if
>> we get 0 or -1 (and handle the difference in the report_set_head_auto).
>>
>> Thanks for noticing, I'll get that fixed in v14.
>
> It is good that somebody noticed it (and it may have happened to be
> me), but if it is a "mistake" as you said, I wonder why none of your
> tests caught it.  Do we have a gap in test coverage?

I think there is no test that is testing this branch:

	updateres =3D refs_update_symref_extended(refs, b_head.buf, b_remote_head.=
buf,
			"remote set-head", &b_local_head, 0);
	if (updateres =3D=3D 1) {
		result |=3D error(_("Could not setup %s"), b_head.buf);
		goto cleanup;

Running this in t/=20

	grep -r "Could not setup"

also yield nothing, so that's probably true. I'm wondering what would be th=
e
best way to trigger this error, refs_update_symref needs to fail for this.


