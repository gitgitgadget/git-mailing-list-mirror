Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6652E1CEAD3
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 08:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733386480; cv=none; b=egkkivvOPAsFm+q4+SnQhhF6C+qjxS3F6j5TT5ynI1CoZJxflGvin2lILjrMT1h4bilM6x3+S2eJoSajJPmIph289vd55IFMPit7ggbOTpBpssYcspJZF3FofL1G+pRX/UqXPsPEXohc4aNqcxoa+Sb4JMl8lEjtpO7+vf+kulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733386480; c=relaxed/simple;
	bh=ci8S95zlIMTHTGJmGCt+BWNGmSSP/0CriISFhZ16Dvk=;
	h=MIME-version:Content-type:Date:Message-id:To:From:Subject:Cc:
	 References:In-reply-to; b=kyj6aEca1Irk/fid0i9I9IkhvD195FsgDhFEUKZz+0fWOCGmRExcUOXXpole3SqyrWut+kWOJHiEFmScURJ3ruqyTlpXqwYhCbTDWHPt91QeCOP+F2YxZ6fwW6qYIBnmNORCiyBts2/NGGYWgqxlvQSW7CeepRRACmTAocakxW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=n6QWA5RW; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="n6QWA5RW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=ZrrAcVkwBXPrH5VHOWA51jWk4DQQ2bBeMeudkL467Vw=;
 b=n6QWA5RWBNDJo1TM4HMwtX4LJUL+ogBzlSYChX/vmi4+CGvo+EYFKR9lr1gCTsYoXFAnh4OrZGnn
   /XDdAokTQkSmX0wo16Q6AsPQT6wtuVhGsHTkFFA+P2Tz++Oydfe1Kupg46UhMuCSFnUa+/+LgBO/
   zXa/gQ7eK6PqNjwpB3KAeIe8oCXKuJBXyg41QFbv4vUNIyAO378t0llYizDovVvR25W6PcMbWdRX
   Gxh3AYAyfnOgawwOt09ElnFLQVxGt8eMZF1G2HjmgwI9GOukwK3mf18iZm1vRjNRqPWigiTNCil0
   ERBaDqdzNIsOlS67CwyqUr65pjjUB9ijdFauxw==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SO0006U7HK6YD80@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 05 Dec 2024 08:14:30 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Thu, 05 Dec 2024 09:14:00 +0100
Message-id: <D63M7LIBTL4B.EXTQ3OSFM9XO@ferdinandy.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: [PATCH v2 3/3] remote set-head: set followRemoteHEAD to "warn" if
 "always"
Cc: <git@vger.kernel.org>, "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Karthik Nayak" <karthik.188@gmail.com>, "Taylor Blau" <me@ttaylorr.com>,
 "Patrick Steinhardt" <ps@pks.im>
References: <20241203215713.135068-1-bence@ferdinandy.com>
 <20241204104003.514905-1-bence@ferdinandy.com>
 <20241204104003.514905-3-bence@ferdinandy.com>
 <cfd54be2-af8f-429f-a4c6-41f54c33c89c@app.fastmail.com>
 <xmqqh67j2ndc.fsf@gitster.g>
 <173ea521-6a2e-45aa-ae5e-4da99060cc4f@app.fastmail.com>
In-reply-to: <173ea521-6a2e-45aa-ae5e-4da99060cc4f@app.fastmail.com>
Reporting-Meta:
 AAHxBdUgdmJtBsrilB8uFyMEvDU3RE5WXku/p1eVde6E8yCosx36MGjjWVcXTfWH
 qkHOENlQH+e3wON+uJ2++6x7+P95PS7SBr90Wg8kwkA+7wQ6IOfsX6/VA9iOzpJN
 xAYKAX9r7/hdaqUlR8+WA81fksskPp/LxmzgRbukVD9FROBh3MMr+lXV3WEZD0LY
 KrVLt/GiRppPqaYIUzWx2Fd7qgq/tL3zWyXfMxUGqXuyenFKuOjud5+veOEF8HmA
 m8veUAMpPfdCQl1N5tlZ3R674V0l7uxJzYSxztZiMkf/U55gqZPMpUwU74PfVLds
 /unuIAtDQ/4hccxbkwGM1fGI+1b3Vdns93OA3YoBBfrV4bBZZ/PWs/T3oirfEZnm
 pjsQMW5OOkbUeATOk3QDRIiYlx6nowg+M/maWf1V+2uxYFOE1u7VUd+yD4BK1Zlw
 0fRpkIrLBrDcuOwSnh+cICMfBh6A69I+/IWpir6xIVLxYpYxVng9bWfO


On Wed Dec 04, 2024 at 21:44, Kristoffer Haugsbakk <kristofferhaugsbakk@fas=
tmail.com> wrote:
> On Wed, Dec 4, 2024, at 21:40, Junio C Hamano wrote:
>> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>>
>>> On Wed, Dec 4, 2024, at 11:39, Bence Ferdinandy wrote:
>>>> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
>>>> index 7411aa770d..daf70406be 100755
>>>> --- a/t/t5505-remote.sh
>>>> +++ b/t/t5505-remote.sh
>>>> @@ -504,6 +504,17 @@ test_expect_success 'set-head --auto has no
>>>> problem w/multiple HEADs' '
>>>>  	)
>>>>  '
>>>>
>>>> +test_expect_success 'set-head changes followRemoteHEAD always to warn=
' '
>>>> +	(
>>>> +		cd test &&
>>>
>>> I think you need to `cd` in a subshell here.  See `t/README`, =E2=80=9C=
Don't
>>> chdir around in tests.=E2=80=9D.
>>
>> Puzzled.  Isn't this inside a (subshell) already?
>
> Aha, then I didn=E2=80=99t read the context properly.

Thanks for the review! What I gathered is that v3 needs an s/output/actual =
and
we're good. I'll send that soonish.

Thanks,
Bence


