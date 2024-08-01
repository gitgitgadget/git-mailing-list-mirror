Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9805445014
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722497046; cv=none; b=HKdqX7yhs6KSrHysin44dwWAwV1J1MmS+B6OBdOz6fTNrbADQe2p1S6+QzBHfnKlScrfTU8od14aQJqRAbzISTEd2tyg9Tg0gUu+nRhaSKuU9gFiH+1c7pXkwHTvnGBWcwWa3s8URmcTjBXsL792Bir8nJ80rPVQw/JEAe4SHes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722497046; c=relaxed/simple;
	bh=CxuhpP6q2d6mV76GGUhf1MmJ1e0KqfHWZ2thlSAJPok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K85ocy7wVwlQBdhWU8xqPcYYmC2uM7NiWwZTIASGKQxwCwn4MX1W4Yg5l9p6n4rgVcV6p8+okZ7/xt+LqxyiQI75eRhWfdGstKKd0a51RhL+TSdRyB4ZCPT3tyvSK1+1dWMIs28iU9EM0KXQlWnxDF+0uL12HQiTkBrpQKSWr5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=EoEkcpKF; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="EoEkcpKF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722497033; x=1723101833; i=l.s.r@web.de;
	bh=PtBU9C6ossVQ8Us2BtFW2wwk3/1Ve+ZCgBXVXxoA5mo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EoEkcpKF0Ap4fbQLdo/IDkhHHzNBrfeySBLuiTjw0nj6MmfRuwtywtXkNY0RsIT1
	 6tS5WUdzbNoI8Jwdp1Wb1CNhSxZUSSdolq3D/ED78HVVRdpi+YSSxDXz5AwU9YhUV
	 7pN4nSoeQNogVkUTVOBBm/Fb7KzyZzBH0+E/GMc1MT6CG/auwK7ctnFlFeiSjincz
	 lHU1a5/IPIPsfgiaturtSVasJN9aqND5Np8qL+sQ3OEhpYe2tpyqlng7NmTsa1Npl
	 DIVXvP5QBXDEz+yOD3zgsIgRBGLgbxBOFRbUHjyQd1k1wtccU+riRA9QIFZOLFvJT
	 VSm5k8eC1g5SVV/+fw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.126]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjPPs-1rolsp06ZO-00cdOo; Thu, 01
 Aug 2024 09:23:53 +0200
Message-ID: <1970186f-f9f7-4cb7-a50e-fcf91da7ea9d@web.de>
Date: Thu, 1 Aug 2024 09:23:52 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] unit-tests: show location of checks outside of
 tests
To: Kyle Lippincott <spectral@google.com>
Cc: Git List <git@vger.kernel.org>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <077a178e-eb30-45ff-b653-a514bfd33077@web.de>
 <4b27cee7-98eb-41ac-a68b-44f42e15a5d2@web.de>
 <CAO_smVgs1+os+Mh+c_tEoD_W6m+oJG-w1QQZ8YSuzHGeWkmfcQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAO_smVgs1+os+Mh+c_tEoD_W6m+oJG-w1QQZ8YSuzHGeWkmfcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RrL2gOqWG61phyEVeonJD+cqMnoZkufHFJQyG/cg+edxRNroN80
 5xwZuMdg2mBUA1JqJJGcTUvHbR7VWB4VFGnQ0NmkTDuBWnsG3v4dm2DTZ+/sHDp53fRHTXF
 ZN0Pak+yVVacatVRL9pYsC7j/m6RGjHlBKLKUBI+axvvEv36sqQI9YUHrFkIhhR2qwKfaS2
 KC9KIYD6rsnp5ho+qpQ1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mHFh4LFJmfA=;ay5U774Xd7i3vrRKjpx/Woi2Q1B
 6o2ovjzGYoT4LNf5ruSuFlBy9KAAE3zrkdMf5HD5knzSmRACsb+O9+Myvkry5SN/aBorWvSh4
 WPzMf2JbQUKUetPViU1/0osD3sjHdA/vu2E8uZ6XtlWyoTP/7+7/I9sY+i3CLkxyrIWcyCSL+
 9ftnrOE4Gugxhp84Ncc3UIA3vwdV9aDbcUGPLPo/P7DrVQDT8Z/4LE5XcGpd/5bUGLypozz/P
 fuXxtcTD3QVrDdjy6ObGbihd1e8sosPP/hh/ySd35cejs7A/7ALVPF+ocjwyDtVLdFIyDq9yy
 c1fEAmqCVKRN6F8Z7WOFHiFSDr4euKzXrJ0/t4H58mMdU/d++RtD2tiniLfafAmWpvHdRFNnn
 TnoyaE91oD8LFjHSsGZ1PkS0WASXvmERyrdJ79Ff9Q1oB52n5q6XlfAcx+/AivIG84K2LWFPB
 qdymykIGguzizx0OPOTrYpbn26q/O5Ccw2nW/uHur++KTHi3Xw13x+/gSjAuYExSayjFbG1yf
 O++p5Msb5/5rxrkqrw28YNsUXdun1lFs8T8Zw1gIQJYXDzgcMcRlTaIHtcaxnZZ/Vtbk8cJky
 vqd32c70Ni+b0i41SEmrTppmg8e1J8eN4JDcBB863IktcGr4b9fNC6ZtuEzruLP+KNWjkSc9h
 ZUQLN26PDfegGc/Oi8Qe0DS2H4qlfdnf9yiGlrMxFE3nXaFs6auIg6xnInSl3l2ztDzLWa8et
 VYPSwKHokIUb1MwnUlN9Ri1icY2VjZ9YFfcqW2on8XUzFy9TV7R6wUE8HlBkIcaUq/INJfRx/
 Cn8ZSftKShRgbX+mcJln//Dg==

Am 31.07.24 um 23:03 schrieb Kyle Lippincott:
> On Tue, Jul 30, 2024 at 7:07=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de>=
 wrote:
>>
>> diff --git a/t/helper/test-example-tap.c b/t/helper/test-example-tap.c
>> index d072ad559f..79c12b01cd 100644
>> --- a/t/helper/test-example-tap.c
>> +++ b/t/helper/test-example-tap.c
>> @@ -72,6 +72,8 @@ static void t_empty(void)
>>
>>  int cmd__example_tap(int argc, const char **argv)
>>  {
>> +       check(1);
>
> Let's include a comment that describes why we have this outside of the
> TEST() macros so that people don't try to "fix" it, and so that people
> realize it's not meant to be a _good_ example :)

Well, the other examples have no such comments, either, but they are
tests (using TEST or if_test), so they at least have descriptions.  So
fair enough.

>> diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
>> index 3c513ce59a..989dc758e6 100644
>> --- a/t/unit-tests/test-lib.c
>> +++ b/t/unit-tests/test-lib.c
>> @@ -264,7 +264,12 @@ static void test_todo(void)
>>
>>  int test_assert(const char *location, const char *check, int ok)
>>  {
>> -       assert(ctx.running);
>> +       if (!ctx.running) {
>> +               test_msg("BUG: check outside of test at %s",
>> +                        make_relative(location));
>
> Below, `test_msg` emits a message like `skipping check '1 =3D=3D 2' at
> <loc>`. Should we include 'check' as part of the message here, or is
> it not possible or not useful for some reason?

It's possible, of course.  Didn't do it because I didn't consider that
we might have multiple checks per line and the complementary "test has
no checks" message  only mentions the line number.  The latter is
followed by the test description in the next line, though.  So yeah,
good point.

>
>> +               ctx.failed =3D 1;
>> +               return 0;
>> +       }
>>
>>         if (ctx.result =3D=3D RESULT_SKIP) {
>>                 test_msg("skipping check '%s' at %s", check,
>> --
>> 2.46.0
