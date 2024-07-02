Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72E20124F
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719953729; cv=none; b=FU9155BXLQo6FQUlWG0OiD6MPA8VtCCdNfBBEW1QnnjtVlusRpZTH8oqCSQIHJsjcvmn80PRczteoBgISSqPxySOb7mzTh3BIbiI1DOIK7fmu0D6tz5CsnDC5jGzOJrUvMaq4/+y5geRFKbIwnVo2smrwWQqxmt5zqYANdf0XGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719953729; c=relaxed/simple;
	bh=wzISYiakni4KhW1Xr6kTmhq32QiyB2pg0Wa2ALVN5K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MtuvqQk663BMuT05qPLa8HW0TgIIdS9JPO/EB0dop2IrGz9RQ78BV6c9szhDBDCPNt+otgI9vY5zKq6x8bk0Iw++rHhq2NXW0wzE4nDziz69qARgIL2aIQtUSNEXaK6oW6rYz95GZ7ZTnEy81iTnTZc2/NSUDZB7bHQ1Bu7qHAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=DDZt2F9q; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="DDZt2F9q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719953720; x=1720558520; i=l.s.r@web.de;
	bh=Nr8WlTY0ESiQ4u7j/XnJOxBRJcwh1VeL28QynIVs7lc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DDZt2F9q7hbiBEA1Jho39xcaBwlURmt037H+n6HISRnFnhYQEysmPfbKuF8pf3GQ
	 t7t3FqSEgepqEkiwCXlQFV4Xcq9IiJz/pwqimGvn7hDltw5Z8uYPEGmyhTyTCzTSI
	 Wf/Vu+LD+7fw4sO2EWigy89H41Epfc88YdJ7ufslHEYkFAF8nG1M4Sw5j1nuvfgog
	 tfYCse/2SX+PNCOcxPAE+3tboYDCngdTxKeF5X8ias/yGDcFxxpqtmMC9IifZSA7n
	 mLTVKdFsJr+xKiuaPVVD2B0gslpTTCEj1M5V56/nrfJS63pnGvjl1dLrPYGlPoe/A
	 D6fajYjL/ugGv7LUoA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.151]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2BI2-1sHdIf3yGs-00sLRd; Tue, 02
 Jul 2024 22:55:19 +0200
Message-ID: <e4da5c4d-2900-4d62-b855-7c4382a2b949@web.de>
Date: Tue, 2 Jul 2024 22:55:19 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] t-strbuf: use TEST_RUN
To: phillip.wood@dunelm.org.uk, Josh Steadmon <steadmon@google.com>,
 Git List <git@vger.kernel.org>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <1bf053ae-957e-4e9a-90f0-11cc76848ce9@web.de>
 <bh5ectgtwdaeltflggzwnwhobewvcqqelforr4sfcmq47rnnrl@mzspptlhpofx>
 <d768f700-654a-4030-bd45-e8e3dea351b5@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <d768f700-654a-4030-bd45-e8e3dea351b5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OJQSGqqPPQws5VnGxTNBTHv2Arvx8cMWWqZDuP9lVZ1ODUdSohZ
 +SfAYHIk+z0Iz4+qR0jU+OUFFkWkbCyPMyAroBGxJJOB1NJhoo8wXxi3uLeyncP/YEy3+dK
 zAUaPjOQUAzC1iOcNqW8f6L1ubWH/hakXDq+OxfDwlhkXe7uWrmKEnuYSQZMcgtO6IvuMMb
 SoX1IoOOJFUX9w2+2w9gw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N9LXcHreZFA=;LMJMU6LZ4uQlnEjC8rToRoKzAi0
 a+Sbpq3EXvXKEvWy5UooKAA+EINKvK9/teC0QNaicxP4tcSzwmVzKTXN30/c0w3hsYTwN+d7/
 MkoEAiCevHQMdvX81Fp0rEOjmN2wdVtXNl1sAdZBpanW0R/TDMUUvSZjD7t+4i+1/u0Ss9lku
 7L+FsNKPRbpspvqjk/nqb1uK8aG9mTbO6y83MB8k3KJ7oRiVX6MJnWI8k7tr0umZAyKPf99+u
 LGqCf8wxtnOlyWgegj/QPqEbaPhIMhMj8yKXD6v6hs6DojSuDNVvXTLDnkbe5+7o0gU9d1Ieo
 Rz26utAwo114zq/ncYS0IXjnnn1CztP3OwLcScP/JgJDnbEc27OWry+leaYBUJEAq7k86Wdv4
 p/MinLEBZ+WOHoSrSvfiqmX7wAmJg1OoNzE1UIHPsGvPABmHQeCZjjZw78akHlsFMTLSaev2+
 P044pT8FWrmuE3voJt8rKMGGRgVk5EDyLQxEzYEBdGseJ732wDNJgVMAqNiH34U/d8qd4HSMK
 k2UTGLHMwsgGKDjzrGxYZPaGCSN9H9o80Db40faBlMpXhod/roATaswCtLh6Fj84f0ioK31lG
 ISvrJaWKc51bnfmK6OkOeYctmI0Aj6ktOq1G+OJow53TqRvPnmCUUaIhBmqbm7ZqgmGpBtkYh
 FCqu0LtS5KzgjmlzX3gj+uk6zaq91x06hrKLQ7QUeENNEE+rQfPsh7/5oN8D06leXci8AncI5
 y/fzkc3KMIHF7ILoJb4mjoHC6B1EuzpGZLkN2+Z0CRG72oKRIsCXA+8qh5pKUtkq2g/yvlEpJ
 tewhypEOuX3LKBWdBBJNt+xRj1IcFju5npyVWqRXwkZKg=

Am 02.07.24 um 17:14 schrieb phillip.wood123@gmail.com:
> Hi Josh and Ren=C3=A9
>
> On 01/07/2024 20:58, Josh Steadmon wrote:
>> On 2024.06.29 17:47, Ren=C3=A9 Scharfe wrote:
>>
>> I think this commit in particular shows how TEST_RUN() is more
>> convenient than TEST(). (Although, arguably we shouldn't have allowed
>> the setup() + callback situation to start with.)
>
> I think the counterargument to that is that using TEST_RUN() makes
> the tests noisier and more error prone because each one has to be
> wrapped in an if() statement and has more boiler plate initializing
> and freeing the strbuf rather than getting that for free by calling
> the test function via setup().

I guess these are two sides of the same coin.  Explicit initialization
and cleanup is closer to what real strbuf users do, more idiomatic.
Which helps to see what the tests are actually doing.

The wrapping if is less annoying than a wrapping function that I have
to name and call.  The condition is just !ctx.skip_all, though, (for
now at least) so we could do something like:

   #define TEST_START(...) if (!TEST_RUN(__VA_ARGS__)) return test_done()

... and tests could look like that then:

   TEST_START("this and that");
   check(this);
   check(that);

   TEST_START("whatever");
   check(whatever);

Perhaps a bit too much magic, though?

Ren=C3=A9
