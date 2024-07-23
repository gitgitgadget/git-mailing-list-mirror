Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D9E15358A
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721743117; cv=none; b=LA/NJOW+Mn2LIGDhf89HbxvPJ8vOX6Po84bbZY+Jczz2LV51FoqXWv0uT2Z6RpEdkYjL3A/6uwnVwk5kJ0gSbX16Q8bZ0UBnS3mEttuudRzPSlDxZefiE+S3s0bDU+ivxyMrnqclR+z9NuRvWCPzUyhtMP/A7+Vc3ERnNTWwlOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721743117; c=relaxed/simple;
	bh=HiCpLvy9PCUcKd/Tn8xsyykijWlkJ+71qtjY5icAka0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=teNneU3GI6xWcCfNH/043/XEzbD/JgDSjd/kVnMjDe86I2UvPsa2bcF6AP5nCABYaOplhOZOEPsv/ukIGPa/NsztnfUfJHXeuDcC0tXTWMbwUX3cIJNqfxKrQ2vNtubkQDzeCFycKX5pEa26jwRMolociQg0H9qzRR0cAEkNazE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=XKBt7Sv/; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="XKBt7Sv/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721743099; x=1722347899; i=l.s.r@web.de;
	bh=xtgCXW7FjwpeEFMRPG01YhekBoTSSW1PtUZKEuoeIsI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XKBt7Sv/A2OLJbRP1b9j3Jsa8ffvUnY02OmuWEqmtzShxuBZektBPgqG2WzsJdcL
	 SojtTnd8qaUgARfnX3gYicBymhsP4aVMnkEe28oz7Dc5odnERUuJj9EbxkfnxAVlY
	 06yxFmY5gB0zjP+vCt7f5BV3ZCsi7r8Oh19E1ASJnpGFWZ+1/ra4S50xmP7hnsUzt
	 6JmcwYQbIHP8MbCUbnHVtza/opLy3LFYeXpYfKUR6ynIBeqRzqo9TJuxVUEMZ43oj
	 bt5L5u+5kIRqMaeKBqaMn+LA0DIgfqpaxalBXEWZwksX24Z760g5KW2/S+sVxtWv/
	 gNUqTSyDh2J64qzfTQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRW2R-1si86w0YS5-00P4w3; Tue, 23
 Jul 2024 15:58:19 +0200
Message-ID: <4ccfab92-e66c-40d4-be56-e3eb04374670@web.de>
Date: Tue, 23 Jul 2024 15:58:18 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] unit-tests: add for_test
To: phillip.wood@dunelm.org.uk, Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Kyle Lippincott
 <spectral@google.com>, Git List <git@vger.kernel.org>,
 Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
 <2dff757d-3c5d-4923-97df-26bcb1c21230@web.de>
 <CAO_smVhoobWpsbYHnHJqTj7TJJ1udo_UaGdbOnUqe5jzL+tyaQ@mail.gmail.com>
 <xmqq1q3lb4me.fsf@gitster.g> <Zp9PfdZtWJBp2xgl@tanuki>
 <71aa553e-9b10-4bc7-9c7d-5414691db79a@web.de> <Zp99icyrc0rdxg9a@tanuki>
 <0af06e8e-e1d7-4cf6-b968-5dad5f4fef2e@web.de>
 <55857c83-2181-4dcb-b354-f9f7e77cd6b9@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <55857c83-2181-4dcb-b354-f9f7e77cd6b9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DTtD0idCe1xcEYS5jLDglkpqR6QlLn3aFnndbcPx62/cfdMfZSn
 6Z4ZkCsjXIE+AwgdjxQ6q7RdZ7/qPZjW4ucsUoUOdSTVf2DaELpRlBixGbIqWH4dQeqG5bQ
 4M5wX4trNYlk2we0k67x5wA2+4imVgv7281fZPJvhRfPvYbl2oP4+hWgCDPFCwhbnkQTwvn
 QVUmHHW64qyusoYGVb4Gw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OTu5JQLv0j8=;SbU7EBC4QsZxSt2FhzA3Imns/vW
 u3+cZleuXE+fb/jEOh2qBoaVghl7qcBDy4BAttiGOk+l5msoOuPty7arNIkWXJVmIgKF7VE0Z
 +sLJO9/uW8T8oZ9lrIyiafbRNkSEqYdezEP6WP3Stb1FTGMsRtZWEG3VNTpx2NkTaSu4Z+Fwd
 kTl6rKZfrzsGxmPyTmXeoIAIyG5dDLkMBNuw572Q2wyfGSvFEKwGlFbwwTsrHNLuwIFHF442/
 f4Gwlut6Pc2NcqOgt9ccV6QTR+ne+bvFlLfBv01DjDg2HIcGYG8tunlRdazX/wYqzwCVi/iln
 e9EeG7IbJPunzpLrUyvHV/Ni4uvUmezTrz/z7MFpQX2YTsIsorI0yRayv/gQRP4yh2hz3S6SZ
 7zuqLm/X1++g088hR/DR4/DtlTQb68+NakFJS25RQ2DakgXc0nu0ZA4y4am5168IronmAmYMC
 GAw4MlVdpfbnzQRiC+OCgNwhpClCXQ/6TFMrrGZsN7Wylxz2SeF8eoic9v58ZrFtsfm4plAw9
 9iQthQ2ImocBHvcr/N57HjuIxTn62u+mJJMG/R5EDJjOYLaUr2IdVeLIv0G+LtqDzcDiBBiKu
 GLhy0TR2q61y4YmzXk3K9YfbQDYj9CAI8SYgC4+TW/2uDpFRt8/hT83vl27GwQqohkeCIcfbL
 9RrGuN7eX8742xiTZVWT6yDZqbsylqgwAuy1LozhaCR5hws2Va8YDawkFN+Nj7DpUZrFqGHjw
 oYw0YOtkShbqVry/mYuIVW8mi1IbNwX+IHPZCsBJk+YCXCA4HLvaVKAnMEmUK0lFXus0g1IL6
 GDlgYTvoAcNmUtb1cV7Yg2Lg==

Am 23.07.24 um 15:23 schrieb Phillip Wood:
> On 23/07/2024 13:37, Ren=C3=A9 Scharfe wrote:
>>
>> In which ways can for_test break?
>
> Using a "break" statement to exit the test early will exit the loop
> without calling test__run_end()
Good point!  That will only be caught at runtime by the asserts at the
start of test__run_begin() or test_done() depending on whether it was
the last test:

 Assertion failed: (!ctx.running), function test_done, file test-lib.c, li=
ne 128.

 Assertion failed: (!ctx.running), function test__run_begin, file test-lib=
.c, line 172.

These messages could be more helpful.  And the use of the unsupported
break with a first-class for-like keyword would yield a compiler error.
But at least it won't go unnoticed even with this limited look-alike.
Deserves a comment in test-lib.h.

Ren=C3=A9
