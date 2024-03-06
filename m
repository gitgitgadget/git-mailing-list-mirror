Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCDD135418
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749029; cv=none; b=V13zYPMOE36qPvpCT5wsm/5BaDtD7TgngH08LU4OSFQn8N2puUfgguR6TopqmASduJWXOqGdq4KwHefv0LupVLotfBxxVOMb46DctdWj925lCdAnjHE4/eQuzWUm/3w7P8oZOJf+ND4P1p0hQlBzfAYLUuDI8Ut8oWOzfAwnoJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749029; c=relaxed/simple;
	bh=0LEmZjalYR2ctMQG1wQGb6kUIosBw2p0I57WlcaAODM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpWuUISc4rS8QLjuAIkTgmocbot5rvWoKPM/bflAiKN8upMNWl/7ZvGpIep1kXDaOuiAv5D9viL+bJDzlulw4mT95I2W0r3q0TEzE4eYhKhYLxvGPeYa+YbMh+vjjuwpgKi6H8BUM+aWQtaSohYjhDiDb+ril9777FVIwbPEo9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=iM0A17kN; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="iM0A17kN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709749007; x=1710353807; i=l.s.r@web.de;
	bh=0LEmZjalYR2ctMQG1wQGb6kUIosBw2p0I57WlcaAODM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=iM0A17kN2eLN6bl09N+hRxcqZl2qbGuTsuCiFZ/Xj47SS8L4bdQ4U4/v+3r7A1LY
	 pNs/1VxomAS9tQxeA7STU5KPuQzRgCDKcQvZc6m19ogt03JzxZwRJV9iXfINKD7ao
	 eKLUx85zGpR4LP/9avpE/WC6KHZh/vx8bLiqRrTGf2+mMNsDF86zZhDdpkkDdbN4a
	 HyqEzOi2g9K+SHmqesh8/FTUoxOc4ThaWwZS784T9bsOjGpZT1ay+9cTR1ptCM8s6
	 jq1o3ykirc825S6xZfrCJPivMqlsqjHDM0NfwFKq0f5i7VgYbUPCc0uxPAR4LOIVD
	 XCMej+tPvlZ6bv3h2w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mc1ZT-1r8KcC39lX-00d59K; Wed, 06
 Mar 2024 19:16:47 +0100
Message-ID: <3ef0927f-4d7b-4061-925e-c113d1c8730d@web.de>
Date: Wed, 6 Mar 2024 19:16:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] t-ctype: avoid duplicating class names
Content-Language: en-US
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: Josh Steadmon <steadmon@google.com>, Achu Luma <ach.lumap@gmail.com>,
 Christian Couder <christian.couder@gmail.com>
References: <20240225112722.89221-1-l.s.r@web.de>
 <20240303101330.20187-1-l.s.r@web.de> <20240303101330.20187-5-l.s.r@web.de>
 <0947cb09-8b07-4fcd-bbe2-ae37c2cd5ec7@gmail.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <0947cb09-8b07-4fcd-bbe2-ae37c2cd5ec7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I5+ibcw4BQKs+H21xGxW1Rxg8z/zj224KV25ZwnCRtHEoFlHJfh
 yNb1HUz3dgWJ4WKI0pScvKY2T1OHcD76BT1P3Tjp7rXTll5QcBN9OSAjp1ZJdVVCvgUjBFX
 5557rFoWWClyL8QXw1xdYbzO+I6SQ2Wp0FUlSgNJj0T4lRo8p2Z2S4UZCFR2ahRUACGFhX4
 zqAlJ7U2GgiLlSsugYBGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zyn4rVVJsu8=;s6S5shPML5wNhp/Rmj3IKevTvae
 28DhaI5Lqy2qotzIAPqbFc8VmYXQj2eL5/Y+UMs94lc+ic5tZtn1oiR4JRBG9GiBljdmZfTUc
 xF3gyvqo8YkCWVZeo9PE/X2dOKLeZOsCOck4UspjyVAe924gc9O3MWKMrHwWusYqo+b0e4AFh
 Ht20oZ9cMBTXXEvL8eWC1bwGYCvTpc/YgpPgVEIwMr1mFtwYAU6aK4SgXqco89YuE1SnhsRVB
 ampeYtIUewDxxcyFxxomcH++ZIdw5tvne12g0ixccmUpQO3odX6CKv/bv7TI2K5zoZ67DUBn9
 PgbwS2hKIoHOeC2RnhAxv82rz+o/VYnPA8s3AHj72+mcbJWrSGrespvw/58zk2Vr2xqhDIDrk
 Id3LzuHFtucs5gt782xynenSrfFaYwTwzb10cStX38z14GIY5yCEVNpWmyTNuoA7eugp7jxXG
 HaOLKjxkaTEmIpHxr0ExCQ7ubb4KRWbyYSCr7MhdlZckLhLRLAUl8h6cFMscSGBHWK05kaAeI
 YdmbmPmtLuUfbh3VPGNmKHj7te+D8XNJgeXL6WM0pz45kDOl2Iwf6CeVSefNX1q9dex9ihk3O
 b6mV5dYrZ1q9w82fuIHfxr17mmHXn98PWL1LMReljjKc16ZkSrovXgO3oHcCf/mOoevk+xSQj
 nb/u+wRBxNYLspu/B+iX9SY5zjwGSsZKt/6JBTieMiRJ7cbT+1ySU76hclrZ+crg+DeiBl3kK
 rf8xTx2HwKAF/xyfTOhtGUkE1jeUUCSSpir0+ZmZnd6Yx9wQ784lwIzVcW2WwLR8RBdlG2A9+
 BnmXi4G1Brth/pbW/sNE4oI3fXAQ43ZD0r1XiI/z31xKw=

Hello Phillip,

Am 04.03.24 um 10:51 schrieb Phillip Wood:
> On 03/03/2024 10:13, Ren=C3=A9 Scharfe wrote:
>> TEST_CTYPE_FUNC defines a function for testing a character classifier,
>> TEST_CHAR_CLASS calls it, causing the class name to be mentioned twice.
>>
>> Avoid the need to define a class-specific function by letting
>> TEST_CHAR_CLASS do all the work.=C2=A0 This is done by using the intern=
al
>> functions test__run_begin() and test__run_end(), but they do exist to b=
e
>> used in test macros after all.
>
> Those internal functions exist to implement the TEST() macro, they
> are not really intended for use outside that (which is why they are
> marked as private in the header file). If we ever want to update the
> implementation of TEST() it will be a lot harder if we're using the
> internal implementation directly in test files. Unit tests should be
> wrapping TEST() if it is appropriate but not the internal
> implementation directly.

forcing tests to be expressions and not allow them to use statements is
an unusual requirement.  I don't see how the added friction would make
tests any better.  It just requires more boilerplate code and annoying
repetition.  What kind of changes do you envision that would be
hindered by allowing statements?

> Ideally we wouldn't need TEST_CTYPE_FUNC as there would only be a
> single function that was passed a ctype predicate, an input array and
> an array of expected results. Unfortunately I don't think that is
> possible due the the way the ctype predicates are implemented. Having
> separate macros to define the test function and to run the test is
> annoying but I don't think it is really worth exposing the internal
> implementation just to avoid it.

The classifiers are currently implemented as macros.  We could turn them
into inline functions and would then be able to pass them to a test
function.  Improving testability is a good idea, but also somehow feels
like the tail wagging the dog.  It would be easy, though, I think.  And
less gross than:

>> Alternatively we could unroll the loop to provide a very long expressio=
n
>> that tests all 256 characters and EOF and hand that to TEST, but that
>> seems awkward and hard to read.

... which would yield unsightly test macros and huge test binaries.  But
it would certainly be possible, and keep the definitions of the actual
tests clean.

Ren=C3=A9
