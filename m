Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3DC16F0C2
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863510; cv=none; b=fW2DMlYyfZuzHafC2W6ldBrJbUq0s8W/+aVO4uq304fNOjflOTe+TV2iqU2G4nmjco25hnI4pEXmWKC8nub/S4/oB3He4gseKH31Ea84H7COCLs932WeIEEeTEGVuCpTHQdb4tuXKauSoV2/2qqDS1DMZEgNK0xn80ttDaq5dlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863510; c=relaxed/simple;
	bh=TrUJneWwnBmS5pWWcCKv9EEOgB4Nc9wHgnj4S5dmvdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P8p1uQOUpgwtKkA2KQSEfG8YSJNA9vbTdJZQhy0X57Am3fFj6CLrZM2CPtFfvyw9JDKJ36KYFMu03lJ1P0JxfCofLOypvGwFM4TP9WXCEC8AqCToFRa1mTGKSBa9WnvRmzouyG4Lpog32xelZJ9qKY6uygxv0vJ/ciA6Uv3nhUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=W60w42Gn; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="W60w42Gn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719863492; x=1720468292; i=l.s.r@web.de;
	bh=/UdynI0ewmIh3pbQ6HtezynRvnLwIMDJKT81ID48I5g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=W60w42GngLMRb17xlCrAu727ctPo7sQeJCatHa3QcY7/Jj90dOhGF18Ue7v5BOww
	 2665yF01GB3trLLdInTKMXmyoHw/w8Kpxzx3N8W7htX99CeQK2PdEb8aJ2I2yhWgw
	 pte8P6ujM8dBLBqC9wktlMEgysuPLlBOgAqDGWpcC4ILCa9DNITd4rJ1Sx3vtZr4K
	 JbMfz8NRfXWB7EcPVFdCfu1t7n4H6jdmwB41/pvmpCzgpFbEZq2e+3CrkHvIiWBRs
	 IwcJZC7JQtiBEkR324jSgGpjt2tJVkyV/jk6Z9Zvcx/mrjBUeV8Q7DIutWsstK/5X
	 ktraEb/z1Sgj31Ydag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.151]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mo6Jl-1s3vlH2fsJ-00eAKS; Mon, 01
 Jul 2024 21:51:32 +0200
Message-ID: <177e98da-803e-4839-9484-fd24828bd21b@web.de>
Date: Mon, 1 Jul 2024 21:51:31 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] t0080: move expected output to a file
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <c60c78c7-a029-48e8-840a-45dcc785a6e5@web.de>
 <20240701032047.GA610406@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240701032047.GA610406@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UvlNMJJcgcrVhiIJ2cqsElMIpR+orOI6zMj0iiSgIoP1o0+9Nd8
 MzQRW7HONrj1BBpHrKQr/72MHu395C5/SHW9J1/vw5pUMlm3aLsIIWdU787V4uPxTwzh3EK
 lVqggS+j8aTqCZeFzaZvryGBHZRTDG1BEYTTLAjrkuf/82Gknf1Tm6H1+7PzgJSxATlEI7/
 1xsAhi5IjfysKXL+r8HvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JvrApzfTG0o=;gtheZIJNjcqDRGmWf42nGuAwXnx
 6VMQt443enc1DjGvNJjS5xQg2rHSe5hPIIalJOchuVWP+342F4OEhxb3E9tOE2cNE7Q1ElpsD
 j1kB8Q13+VvWYUirwewi1lprdempf+FTRrH7JVF3w+K2pqbTYDrmwXConVd+AXcBT+7zQumoe
 Ju/LDSetpX4ZHKKh42bbphbzP5YyYqTPDZbnpgUl002dZa9aIlTiArGn1ymDZQi+wQc6vrKYS
 9uoB+dgdQ9eG269mo9FW8OGkgcxuV4M1l1AuNXUIyY+4K6CqH8YiRvrolUGscNPA9fA4q5DnS
 UL2CDI0txNyoE7nusd4e3kPULDYEe44Uh+sBvJJ4QB5JJzi01HF0nF78FxlYLCOw33VB9DTl4
 Po22RrahwaralWyGEqbQ2zZO1uamA70ORmLCqvXl9doLJyPyJDUJtoPY9lu924sM7YGZmEqXy
 PopN4nquhS2EtkaaGqg1gzjHnpTtb+ppZ7d2aMxXJM1I3ae3wTrnDWGIni9f88oF31q2JlUYd
 LrpLdmKbE8GufB8y57nJcTWbPsDk/m+C1GlzDWB+5bjCgfJ/lWsq/ddve7z1FDr5wkA8atq8N
 ND179YWpiLEPdPFHCCdlue6jjG0AHmZQ/1OYAsiNgSyUkLOn4V8x46GP/HkGFb0f+lDlBrLCR
 VapgncGLodNIlRjvjkplGtEJSqeEQ70+Vd8UA3dlp6vtPLT7F7uSHVB3Kfy1pic7TGhm0w/0/
 vecRGYjQW/7bnp6jdt0YoB6B9mM3nJ236E0TbFgB1D3TICUACd0aDSGbWaBD7rUOmBvfUFjr8
 Zo+dRfPlmUYkI7GLIten5wU4YbN+Dbq8s7BWr4orkz0Ws=

Am 01.07.24 um 05:20 schrieb Jeff King:
> On Sat, Jun 29, 2024 at 05:35:31PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Provide the expected output of "test-tool example-tap" verbatim instead
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
> keeping everything in the test scripts themselves so related changes can
> happen side-by-side, though I admit in this case it is intimately tied
> to the separate test-example-tap.c source anyway.

I can't think of an example where we keep test definitions in the same
file as the code to be tested.  It would be somewhat cool to empower the
unit test framework to test itself, but I suspect that this nesting
ability would be hard to achieve and not very useful otherwise.  And
would we be able to trust such a self-test?


We could cheese it by putting the expected output into a special comment
before (or after) the TEST invocations and letting the test script piece
them together to build the expect file, something like:

	/* expect
	ok 1 - passing test
	 */
	test_res =3D TEST(check_res =3D check_int(1, =3D=3D, 1), "passing test");

That would be a bit annoying if we change something because some
messages contain line numbers and the comments would affect those due
to their existence alone.  And there would be a ripple effect if we
change the number of output lines of a test to the output of later
tests.


The only downside of keeping the expected output of t0080 separate that
I can think of is that it might get confusing if we'd ever add more
test_expect_success calls to it, but I can't imagine why we'd want to
do that.

> But I do have such an "EOT" patch which I've been meaning to send out,
> since it makes many of these quoting annoyances go away (though of
> course it leaves the indentation).

Being able to pass the test code to test_expect_success as a here-doc or
file to avoid nested shell quoting sounds useful in general.  For t0080
we could achieve the same effect already by creating the expect file
before calling test_expect_success.  That has the downside of passing
even when the disk is full and the files are created empty, but we can
throw in a "test -s" to rule it out.

Ren=C3=A9
