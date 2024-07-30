Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5F9198A15
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348030; cv=none; b=gcgPYkCE/qyHmIk06FSlpglEmxuSGbO2NqAJ15yxwC1DCtFO2tq8Id8xg7Ku9CoeucYfbhhXDbwKswRvc1vEdeCRR/7zOXeeOXg4ern4pdmqVtYYHYLMU6H6tVlWLVjId1yC1qvq4CgiPy50UdW/ILPuenshn8AS8Kie6aZNMo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348030; c=relaxed/simple;
	bh=jCXWK2dIhwYG0Nrp/+G0uDv8AfditgV4jdubMWoDA48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kMyYlNH2pqa3PsFoeiGy9+Rq1FYxnku6+z8mYMZsdp3jqESJgTPtNs2zazWAOiQANpGHPKKSyVyHS6xrmWwwMnee39SPL/uVRjS+jrmuL/tvEssMPyhNDsbOjR2zF/z73VrKdiz5MaUqQV3f1T5486qtFbetZpK5PSI3q3suoJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=EfkfvVTW; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="EfkfvVTW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722348008; x=1722952808; i=l.s.r@web.de;
	bh=rZRPQsJPacSco+RKdUFg9OAUeqjO5Jr85yKelaENPBA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EfkfvVTWGg8jQo7GD0I7VrPrmfu29UFy11slMUuxNtGm6ADl2V8mkl6e77iKYpoS
	 90sPVgn9pTX4YU92GCU6+Kqzqn3U4gCHNvGVybe3tFTmr1CZiJEWgVdLg678Jjd7c
	 +jnFHSnfFfwvvitagNp153prlALgI6Z6/WoYvyL7o9+scJfbCO58iHkAIKi3H8aev
	 iRBavxobSWgF+5VpeagkeamQxBMOKrLBKgRwlFQJ1HAige6eneAgX+Yd2QZfFlqIS
	 iFbWhHkW7n0aQlf6V9F9jXwlDny47zjviMo4aATYzrI/Zj3iYgz9T597VkKzGEdYG
	 k26WiNce2lrIZOBNhA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MaHSp-1snFi1141l-00XrqI; Tue, 30
 Jul 2024 16:00:08 +0200
Message-ID: <53c1eaeb-6106-492c-9c44-13a7cd1bd0d0@web.de>
Date: Tue, 30 Jul 2024 16:00:07 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] unit-tests: add for_test
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: Kyle Lippincott <spectral@google.com>, Git List <git@vger.kernel.org>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>
References: <73465c3d-1be0-456b-9471-f875e819c566@web.de>
 <c51025cc-26e5-41e2-be56-94e141a64f5d@web.de>
 <CAO_smVi2rJd5SDMsbbxzFUj28a_1KTgdHMz4DTKMsii+Wt5H_Q@mail.gmail.com>
 <xmqqfrrxjw8f.fsf@gitster.g>
 <CAO_smVhq=MkQV3a6qJtDiFykvR4im7AX4hMfKMNcL5SegnOSLA@mail.gmail.com>
 <xmqqv80szxgw.fsf@gitster.g> <ZqOc9vxdD4qttkFs@tanuki>
 <xmqqed7gxhyz.fsf@gitster.g> <ZqdldZE2MV-Pkuu-@tanuki>
 <xmqq8qxkhvt3.fsf@gitster.g> <Zqhwwudf-yjvJ_By@tanuki>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Zqhwwudf-yjvJ_By@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oWSrwcfcdBoj54B4xy4WQMs3sNzxB43G59rOWW7eRmmYnxS6klD
 03cicTWw6GxBCM+ofwoY9oLczbG0s69o8q6IiK6+fs0KAmxogaCa7R4FAIF5l6Jc2IBq5RZ
 pTgaFTJsuodbxupCr13M/LYqikaWJ6NBr+sekTQT/SWCGMBwq+eszqLgSf5uuKSm5EIIzsd
 hB263lTHORxu/AJwSIPCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:awGkrXzCIjg=;4QNQXb1bvIjIYWyeXECQQ9pvzkA
 /IZCD7QhHATeIEIZRxwvqF1wcHwjtjsWhK7lZvEV2aFJ2NpTHF7Or9YhVk68xJQeBmtnGcl4W
 i7WhCTH/c9aTthCJldPLy20jzplrxV4zZxkglW25bHDfeU1j3p3DxMZPxHPmH4Nf0Q30m/OMi
 /M+GjIvHfn48h81xa4FBpGEfPfRrd+9EEnj5iFXZ1eMRQrPFvIx1p5lzBGIctqKOQgB+T3sLN
 4NfupydOLNQuNnb8sB7e8ddB2/oQ5jiR6zm+TY2xryP3yHecgWox0X13RQSqBoWTv3w2WKgGa
 3ec8RU9nSfS6tU5izHUpmSq7RGyC4oyFunyMvJResszM5WKBVz1/mKQ00xvxnMDvXOoXwh6M7
 Q3NtAmYTzFe7JchakNg6aU9826nSA/NyOqNBTmKywtrz4szWpfYxoD7ElojRicQc3/WT+omKN
 nHHcXKXfh3mJ3qNQE0XdZZdHkPIClzCB0/JbL1yacGilQmk8PW3NXxlkKTEZP1V4EGQP5lH9X
 rE46kciK4zIwK0Pp6AO1X6MP6bt523XVbVlW1agHn+dgmBZUkGy9MXQlNaecbSbboeo/HEqYw
 FOjvgWjaeyNq+VBWuPn7WVCj6D5UShSbkjI98yGBf+dBjC12myMmSTJ9oKy1uOvVxH4Oqi7DD
 86V4hKGAQJr8VI6zPEmOFErCmxjyrcEHMiHUvyc8EXqGjsj2mo/SynBcJWraZkCZ+9pjguI84
 fmowv7gGTt9vA4W6MGsxoxBXR4u+ym+SYhVKlFhkFJ2gbS01vzYBt6p8LDHpAbzpXLTloM7ad
 9goCf4X9DIibgpCQk/hRLsig==

Am 30.07.24 um 06:49 schrieb Patrick Steinhardt:
> On Mon, Jul 29, 2024 at 11:55:52AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>>> is standalone nowadays and called "clar" [1]. The biggest downside of =
it
>>> is that it depends on Python to auto-generate the test "main" function=
,
>>> which is not really a good fit for the Git project.
>>
>> Is that because Python is optional (like, we only use it for
>> optional Perforce thing and import-zip in contrib), or are there
>> other concerns?
>>
>> Unlike these components, unit tests are not even for the end-user
>> consumers, so if it is Python that you find it a blocker, I do not
>> see a reason to reject it.  The thing looked like a simple script
>> that does not use any tricky language construct or modules.
>
> No concerns other than adding another mandatory dependency for devs. We
> already depend on Perl and Shell, so adding Python to the stack feels
> suboptimal to me.
>
> As you say though, the script isn't all that involved. So it would also
> be possible to port it to Perl if we want to do that, I guess.

=46rom the point of view of a "minimal C unit testing framework" surely
the implementation language with the best dependency story would be C.
Perhaps it could then also test itself.  On the other hand, writing a
string handling program in 2024 in C is probably not the smartest idea.

Then again, generate.py uses a non-greedy regex to remove single-line
comments, which seems wrong, and doesn't seem to support preprocessor
directives like #if and #ifdef, so whole tests can't be disabled this
way.  And it uses pickle to cache results; does that mean it would be
slow without it?  Anyway, point being that parsing C isn't so easy
using Python either.

Ren=C3=A9
