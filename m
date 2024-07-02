Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6B6205E05
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719953734; cv=none; b=efLlMd0XircAfGeH4idGjgqAaCIYjVmQXMw6/uLDY4fi1XU4zXzuvZxCeOxoLbFC4Xh1m38A50tJO2OTEwQqyyAEknKSCpYFH3lor4Ssj82UMjJ7j1CXzUWA2cRyuHErYj/KrL6YG9npYsdVLi7tNPIXD108AuU7yI4fqwORtOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719953734; c=relaxed/simple;
	bh=+Bzz3KVOI5NHXkC+4ol9QmT6vy/mkJhoT64DlszKmlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gEqfr0ZGp1dl3r6XZPd58yieWB9J5+v1aVEpVwF36dP2HVeN+uONHQhHlDB70Z7R4LMkRYasy1hPsF0SLLfBx8pd9+M4hiHlqw1tQilGaxYLz1jFdcjJwi9Alnw80irsfAUdbKMVs5wlJvQyhEafulKNcklih+PDhg/i5O6fIwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=NrDXG44U; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="NrDXG44U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719953722; x=1720558522; i=l.s.r@web.de;
	bh=5VwsTbfD+V4X/qc77Nwb71wl+N4MCu4+mpmBclFs2k8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NrDXG44U5/uscJnrQdhKFjXikRKdOSbOPZ2KLejd5JEtUreKgMdgEcofsPvQbUW3
	 DoXA6eU4i1wkQLRGd1T6qGwYd2vY797crrVtkWjzAUhcmKzvnpqxJTcXd/EV5tkIB
	 yQnwSs8sF7vf+xzZc+7DrQm0THEOV5Nlq2ijMtwYE0PCQWsY92j3iGaDBqxIiMNhw
	 /s+muOA3I3dQ7NHBauTxmvdzbJ7c2xvZXzDbzlXBFeuGnjLx4KhyqIpEfJm11Swy4
	 JHOjWxbiAYGF/AstPOYTfkT7Fz8KJDztNg/qFhpMtA1J/6yWlm0oOqTgd+nFMxutc
	 37/0V/99a5x5gbfpBA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.151]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqZMK-1s2s6E142i-00gtMh; Tue, 02
 Jul 2024 22:55:22 +0200
Message-ID: <c690e0ad-21e1-4b51-b594-70f4b2527df8@web.de>
Date: Tue, 2 Jul 2024 22:55:21 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] t-strbuf: use TEST_RUN
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
 Josh Steadmon <steadmon@google.com>, Git List <git@vger.kernel.org>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: Phillip Wood <phillip.wood123@gmail.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <1bf053ae-957e-4e9a-90f0-11cc76848ce9@web.de>
 <bh5ectgtwdaeltflggzwnwhobewvcqqelforr4sfcmq47rnnrl@mzspptlhpofx>
 <D2F8BS39IFC4.WJ9TNK3IDFBV@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <D2F8BS39IFC4.WJ9TNK3IDFBV@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:orl23+uZkFbKpSMyvnvSMsZqz2yo81vF02t7fzaznkUPRg8PFG/
 JtabuTSRi2Bpw9cj5ZpUI+bMW0gUpZTO7Xr04ookp/+La9CmswqOuEZPJ1V7JbjY/UNZaJF
 yNOkqro4MpRyH+5dvCxOBEpTaMl25AcglfZCWwpfVnbj/al5VE+0mp6biosESUJ/Ud/oU4z
 6XsrnscSIp8F8h08LBCrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d2MLJoSZEV0=;ICGao1o4pD3RcNAI1mobtrRRScz
 6M5MgbS8ALtFZF32vF4dfYez6Kmt9AH+xJw8z6RTg2VSDqy0iYroPAJUh7DLMFgXa4RTAnmxV
 WP6tAzhrXMlkAgvDWUwdvpQb8n6hYcrRl70bmy8o/WyHsVuMmPDgjy21dnPeZ5hjZJTgcFceO
 Ur8huXnHbW+FmOJgCJFcEFMw2o1ID3OpbtqbeKyIC44Xkz9YTeer/s41S2LZQn1IfTzSFoOTz
 9u7c51R85MHYu9mjdqKC+LaPj7uhjOfb+P7O8B586W7Yc4PH/GUJmYGrkreORl+1hJUX5dDyC
 9cURbKXbfTIPI8rHKyQa+0NxdC21XwOUpuohfgmWL0bDgzlFDQzfbni8uxRhzQyiraur+dC/w
 ThM3l4sweV1zU72zpe8xZwffXRnNkPHZ1ZGZiP1XPvgg+OUhL81mrjxT2usWXA0Nxe81ncEoZ
 X+E3Xq/2VG+uPIUzH2ht2xw9ApzzrDLkFoCyjpzYH9IvIgJsbg1tgcpFnYNkBydZ//LCEYwLN
 0v7RqRCpcKFmKvovDJQ7oMYMNdarzTU5boGKQBPdNycj4ZlXuUHKi66YuleP8/Ah7CAKxAfvD
 npKRdlmVDsq7eM3h/GBaLNqdzo0IY2dIFka5Pcwt+xFjLFUxVdpR3EdtAmLumvcx5rB9ZKXwR
 9G4mxPtpIvc9FRbIcWnFtYxMchHfx7KPOQVuR/DIipzDVudA+Vims1jDyfI9ynZWJBx5Y5FvQ
 qYgSea5ei/HQwfV5RyNAcZforzM6P7eiN5lYpz6tu4w27fam9yxzIh05zasRbs6+V0WUOz/Vp
 Yu1b7h4E/QqRI6HZ56UzpL27AABeXwosi0y7yHpXXPMQs=

Am 02.07.24 um 19:29 schrieb Ghanshyam Thakkar:
> Josh Steadmon <steadmon@google.com> wrote:
>>> -	TEST(setup(t_addch, "a"), "strbuf_addch adds char");
>>> -	TEST(setup(t_addch, ""), "strbuf_addch adds NUL char");
>>> -	TEST(setup_populated(t_addch, "initial value", "a"),
>>> -	     "strbuf_addch appends to initial value");
>>> -	TEST(setup(t_addstr, "hello there"), "strbuf_addstr adds string");
>>> -	TEST(setup_populated(t_addstr, "initial value", "hello there"),
>>> -	     "strbuf_addstr appends string to initial value");
>>> +
>>> +	if (TEST_RUN("strbuf_addch adds char")) {
>>> +		struct strbuf sb =3D STRBUF_INIT;
>>> +		t_addch(&sb, 'a');
>>> +		t_release(&sb);
>>> +	}
>>> +
>>> +	if (TEST_RUN("strbuf_addch adds NUL char")) {
>>> +		struct strbuf sb =3D STRBUF_INIT;
>>> +		t_addch(&sb, '\0');
>>> +		t_release(&sb);
>>> +	}
>>> +
>>> +	if (TEST_RUN("strbuf_addch appends to initial value")) {
>>> +		struct strbuf sb =3D STRBUF_INIT;
>>> +		t_addstr(&sb, "initial value");
>>> +		t_addch(&sb, 'a');
>>> +		t_release(&sb);
>>> +	}
>>> +
>>> +	if (TEST_RUN("strbuf_addstr adds string")) {
>>> +		struct strbuf sb =3D STRBUF_INIT;
>>> +		t_addstr(&sb, "hello there");
>>> +		t_release(&sb);
>>> +	}
>>> +
>>> +	if (TEST_RUN("strbuf_addstr appends string to initial value")) {
>>> +		struct strbuf sb =3D STRBUF_INIT;
>>> +		t_addstr(&sb, "initial value");
>>> +		t_addstr(&sb, "hello there");
>>> +		t_release(&sb);
>>> +	}
>>>
>>>  	return test_done();
>>>  }
>>> --
>>> 2.45.2
>>
>> I think this commit in particular shows how TEST_RUN() is more
>> convenient than TEST(). (Although, arguably we shouldn't have allowed
>> the setup() + callback situation to start with.)
>
> Could you expand a bit on why the setup() + callback thing shouldn't be
> allowed? I think it is a nice way of avoiding boilerplate and having
> independent state. And, I see the true potential of TEST_RUN() in
> testcases defined through macros rather than replacing functions. I
> actually think that the previous version with the functions was not
> particularly bad, and I agree with Phillip that the previous version's
> main() provided nice overview of the tests and it was easier to
> verify the independence between each testcase.

Each test uses its own strbuf and the t_ functions don't use global or
static variables, so how does the doubt about their independence creep
in?

With tests specified as above I now notice that we never check the
resulting string.  t_addch and t_addstr check the tail matches their
argument, but strbuf_addch and strbuf_addstr could overwrite the old
content and we wouldn't notice.  Perhaps it's not worth checking, but
now that tests look more like test_expect_success and all steps are
visible I somehow miss the equivalent of test_cmp; didn't see that
in the original version.

> Perhaps, the code snippets inside the functions are small enough to
> perceive TEST_RUN() as more convenient than TEST() in this test, but,
> for future reference, I definitely don't think TEST_RUN() should be
> looked at as a replacement for TEST(), and more like 'when we have to
> use macro magic which requires us to use internal test__run_*
> functions, using TEST_RUN() is more convenient. Patch [3/6] is a good> e=
xample of that.

Sure, not all tests will be improved by using TEST_RUN.  If TEST fits
better, use it.

> But, I also don't mind if patches 4, 5, or 6 get
> merged as I don't see any difference between using TEST_RUN() or
> TEST() in those patches, besides moving everything inside main().

The difference is that in the original version test description and
definition are separated, only linked by a function name.  The new
version brings them together and does away with function name.  A small
change, for sure, just to get rid of the artificial divide and the need
for that link.

Ren=C3=A9
