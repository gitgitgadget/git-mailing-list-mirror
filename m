Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E651E49E
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 19:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719861438; cv=none; b=Sy9Xzkxa/QzQCgaedERnWzFNyfOayx7GjKorPx7fxh2rCSOSt9gamDtTUuqB4SAnn9JOadYmals99wUAn+m1bPytclXJiHzrwu60xlQisLjh/MB9/R2EchCU+xrCgKukSXQ14IFZ0DfIn3ZImOrkxV/HqIQME2BFx5C0OqbSDBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719861438; c=relaxed/simple;
	bh=aMIzEhol03SjI1Qc9s/2ogO7huNNqd7dJJs1Rpcvo9M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nCVpDTncSk5Pnvlj9nJST8NQM8LAp8CG4DtNuyaOiMp+Ecb4ka5RXy5nV/ooXphwfPLcLUm0VmbIzSrIviOh3jfHbCkUonZsigKoLAVLNJerKFDDOBRNMZb4vWzg8Id1jAJ70CccUI4YauRP4AZuXjj337mxxPA2ZZ6jF4hE54M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qH8rWDxw; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qH8rWDxw"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D59551DF00;
	Mon,  1 Jul 2024 15:17:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aMIzEhol03Sj
	I1Qc9s/2ogO7huNNqd7dJJs1Rpcvo9M=; b=qH8rWDxwW7teiC7jzXf8RLd3yQ7Q
	EVizU7CzlMsotOqGsM+s2iZRMoGlYFxk8qjhSF2o6DwzWI5Bk8Yneq8M3ZV8Tro9
	hXjGXPvKl/q+fnLFoUJsawbguZWnKS39AC0IwFTAbb0s7gphdyYo3vDVTkDu/S1B
	1jXog3Lj6AbX22g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CDBA21DEFF;
	Mon,  1 Jul 2024 15:17:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6F4CB1DEFE;
	Mon,  1 Jul 2024 15:17:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>,  Phillip
 Wood <phillip.wood@dunelm.org.uk>,  Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH 1/6] t0080: move expected output to a file
In-Reply-To: <20240701032047.GA610406@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 30 Jun 2024 23:20:47 -0400")
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
	<c60c78c7-a029-48e8-840a-45dcc785a6e5@web.de>
	<20240701032047.GA610406@coredump.intra.peff.net>
Date: Mon, 01 Jul 2024 12:17:11 -0700
Message-ID: <xmqqed8cx6q0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 858E1822-37DE-11EF-9A00-C38742FD603B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> writes:

> On Sat, Jun 29, 2024 at 05:35:31PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Provide the expected output of "test-tool example-tap" verbatim instea=
d
>> of as a here-doc, to avoid distractions due to quoting, variables
>> containing quotes and indentation.
>
> I'm not really opposed to this patch, but I wondered...
>
>>  test_expect_success 'TAP output from unit tests' '
>> -	cat >expect <<-EOF &&
>> -	ok 1 - passing test
>> -	ok 2 - passing test and assertion return 1
>
> If you could take the test input on stdin, like so:
>
>   test_expect_success 'TAP output from unit tests' - <<-\EOT
> 	cat >expect <<-\EOF
> 	ok 1 - passing test
> 	ok 2 - passing test and assertion return 1
> 	[...]
> 	# check "'a' =3D=3D '\n'" failed at t/helper/test-example-tap.c:64
> 	#    left: 'a'
> 	#   right: '\012'
> 	[...]
> 	EOF
>   EOT
>
> would that be preferable to moving it to its own file? I kind of like
> keeping everything in the test scripts themselves so related changes ca=
n
> happen side-by-side, though I admit in this case it is intimately tied
> to the separate test-example-tap.c source anyway.

Yeah, it does feel a bit of cop-out to separate the expectation out
to an external file.  I guess I was to blame for things like t4013
but there is a valid excuse there (it would be expected that similar
tests would need to be added and one test per one expected result was
a natural way to manage hundreds of tests).

In this case, I think the fact that validating the test framework is
an oddball use case is a sufficient excuse ;-).

> But I do have such an "EOT" patch which I've been meaning to send out,
> since it makes many of these quoting annoyances go away (though of
> course it leaves the indentation).

I am not sure about your "test body comes from the standard input"
(not saying "I am not convinced it is a good idea" or even "I am
convinced it is a bad idea"---I do not know what to think about it,
not just yet).  THe above illustration does make it easier to grok
by keeping everything in one place.

Thanks.
