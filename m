Received: from aib29agh122.zrh1.oracleemaildelivery.com (aib29agh122.zrh1.oracleemaildelivery.com [192.29.178.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5724EB38
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 19:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728762125; cv=none; b=QjdAeHtCgrLdMR7w/57QwmHYu0ojHGC6efM3xHpm62nTcJLcI/E6kIWNls1pRvk2bKh37TR7bkqtOQmzT0VtgEYa23TMxrCcBMK19HZyrqg1LL2/DFAMgTBslWAQXWMOwtlb9KYMD+/j/dTlkqeF7pT6wtdkk3ovZzFaqEv/QOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728762125; c=relaxed/simple;
	bh=CdZ4QKQN8AA2ihgLAhKNeSJZxAj5by9y1wte9s5lvls=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=SCoRXtsDz8f0fXXltPV4nG4ueOpsTVhe5wan76XR+8rsRtNFaQa/ts6wOKVhQtqOoOhWAzc6C3dkOwRGlPQXO4f5z14RuZUIZffdcyqeYHqX7mBJLv558DQBMu9B+OcoH4k1SPa07A0qerHOnEuFC+f/wz5kJVW782uuyvmZt6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=C3L9IMnM; arc=none smtp.client-ip=192.29.178.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="C3L9IMnM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=LZxj7ljhL63iSRXa1N0z7KCg9J/gEK6dwGXEjSF4glw=;
 b=C3L9IMnMN/ynUnOYNVDgnv3Ubv0OxTp1mZ6GZWohD2BjLGteO456Y8SpbOorygiHst4oeq1csreG
   nnZSvSzT0rjAyD57ldjfIcrlGrnpd6p+kx68uhBYQemuhtlLezUtKPppa0oTlMSJkqAwBEFhHICm
   9fJj/TvyDHwtIu6l55NOXYniPlIIJutg2ctuaPyERk09QtsP+O3YiOqRU+mnTppJNJykZ0dv1UAA
   ZCX5z42/XGgQQidrhXcQfdK64h5vQovMJ2+N1Pqfsag3g7Qp3fbDD5s9Re4TOzCJkrfqtlR+Vulu
   a4xP+KDgqNoSZqHgW75WWKrMKBB0VegWdSRECw==
Received: by omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SL900GYCDDVP220@omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sat, 12 Oct 2024 19:41:55 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sat, 12 Oct 2024 21:41:34 +0200
Message-id: <D4U30MD29CJT.3US5SBR598DVY@ferdinandy.com>
Subject: Re: with git update-ref?
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 <schwab@linux-m68k.org>, <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <D4T9VCF8OS6U.1FMB8P6YU7I3S@ferdinandy.com>
 <cb60b7ad-7902-4293-81e9-06d1b1526842@app.fastmail.com>
 <D4TA5EXQFFA0.1XVEK1RM2Q6VA@ferdinandy.com> <xmqqa5facosb.fsf@gitster.g>
In-reply-to: <xmqqa5facosb.fsf@gitster.g>
Reporting-Meta:
 AAGBk3Atf43MEWuN5NICX3gPj4D+ab6cqDUwNceNEfd5fXbrvZhoIVnEsywiYJec
 BhF6Ka3/C1T+WzaVj0d18cJ4PG97qKbLzU0nav79KlnTfN5FhlrE5WI4JVbW/vNB
 v03QUfyfSCU29tT5w8Fsb/p30ZWhk2dNMOhxt7YInxi/YKNvTfTjj19gpj2/qIqT
 fC0Jx9SuTpLWlR0EPQoG0nlyqCdnurbeSgpc0pVKe21kDLYk7suYqip1BT2wnn5R
 Y1IQCSJhlgiJxyd0y3KCLkiIIV9xS+SgmWFiQ70+JdMntYEN6y6wy315XxlXtm4p
 9xbOpcvIDX0UeWCpQthYXxp3SvNOVxhM107OV2jWzJn7+PZM4Y0odksV7y3GDCev
 mtawfJRMGssnoBTDZYNv3PJzOaPnTLV94J2sEOTEsgfxJYbiasF12Tk/BoqrGx6v
 IUpZmScLhFHlbsLrD5YOWHF/FZj83xrKaqzkY9BfQHV4x8aHaAmYrZA=


On Fri Oct 11, 2024 at 23:28, Junio C Hamano <gitster@pobox.com> wrote:
> "Bence Ferdinandy" <bence@ferdinandy.com> writes:
>
>> On Fri Oct 11, 2024 at 22:56, Kristoffer Haugsbakk <kristofferhaugsbakk@=
fastmail.com> wrote:
>>> `ref: refs/remotes/origin/test`? (space after colon)
>>
>> I tried a couple of variations and no:
>>
>> =E2=9D=AF git update-ref --no-deref refs/remotes/origin/HEAD 'ref: refs/=
remotes/origin/test'
>> fatal: ref: refs/remotes/origin/test: not a valid SHA1
>> =E2=9D=AF git update-ref refs/remotes/origin/HEAD 'ref: refs/remotes/ori=
gin/test'
>> fatal: ref: refs/remotes/origin/test: not a valid SHA1
>> =E2=9D=AF git update-ref --no-deref refs/remotes/origin/HEAD 'ref:refs/r=
emotes/origin/test'
>> fatal: ref:refs/remotes/origin/test: not a valid SHA1
>> =E2=9D=AF git update-ref  refs/remotes/origin/HEAD 'ref:refs/remotes/ori=
gin/test'
>> fatal: ref:refs/remotes/origin/test: not a valid SHA1
>>
>> I guess the intended way of doing this is via git symbolic-ref anyway, b=
ut I'm
>> curious if this should work somehow or I'm misinterpreting the meaning o=
f that
>> sentence.
>
> I do not think update-ref is a tool to modify a symbolic-ref.
> Moreover, the mention of "ref:" is meant to be for those who are
> overly curious for their own good and go peek into their .git/
> directory; script writers should not have to know such an
> implementation detail.

Yes, that was my impression as well, but I think it is pretty misleadning
because "It also" is preceded by an entire paragraph about what you can spe=
cify
with oids so it's easy to read as if you could specify a symbolic ref here.
Because of the --no-deref argument it makes sense to talk about symrefs, bu=
t
I'd propose to rewrite this part a bit to make it more clear. Something alo=
ng
the lines of referencing gitglossary(1) (thanks Andreas) for what symrefs a=
re
instead of explaining here and explicitly mentioning that it's git symbolic=
-ref
that is for manipulating symrefs.

Best,
Bence


--=20
bence.ferdinandy.com

