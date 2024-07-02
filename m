Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A21201255
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719953731; cv=none; b=SKouIeLxfANl5ojFRyNmXzDkkj8mmjR8HUGiGAv4BmLdSfr7tnc/jX1dRdmbSRtVrASo0K8qkcibLjUr5jaPsrqxwHBAZ8CIH5MwK9O/stKgLzXtiAzZSk/MGQyXP9E4Ec0DzsA5fOh7xb7EcQKgVIRb5gRtPgrHd/rYHgrFGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719953731; c=relaxed/simple;
	bh=hNGnJe4mspes6n0ekgIpc1gixtrTmd9Scef25I06/58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rskj8wjxSzU6T5gKeZebzWI1cmGfwifgi4owN3TjCQ+CsfqmzJqzK+8LZhbcqk3A56WXnWKACLoTGws7FOHmCtE1RFCR8dQ+6PE3RjRDmJ6AdDyCD2EfLUy8e0MKzXBEr4EqctuK5OMSQTeWibm9Ol+fc6F8axz8jngakLPtm2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=eLQ4y662; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="eLQ4y662"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719953714; x=1720558514; i=l.s.r@web.de;
	bh=K8gl7orMTH7p4qv7c3mIwpPluC0+WaoZWu2GVo9tNrE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eLQ4y662qUZlqBK41pgZZkLXIwnJp351cUlbYuqbSfKopKhDow0ArMf/wkMBkvv+
	 R+8KWfcumpMJHdur8i8sLVMQ8o8FScRTAUCxt7me2ycCPoucUiB6iJznv8XBNCguV
	 XTRN08GGQF1af3/yEvhObAZiUvwvd7G+BMgvMRKJnSKrjx1IPr4uZuPP2qEy9ZB+Y
	 XrUjWDOQHH88Pr4XIAf1PYuMVU8iICS5OwV/uBipbaTMGKfjVZJjSVwUnxWHAgqZ2
	 a5woHmd8UlFAjQdvXt+LR0lS5Sebz3b4VPZZ5f4JGsi8pQuh/GxWLofdyo8L0710m
	 9QlwM8IYfduZUSUN6w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.151]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N30dV-1sHM3L2XIT-00scQY; Tue, 02
 Jul 2024 22:55:14 +0200
Message-ID: <97390954-49bc-48c4-bab1-95be10717aca@web.de>
Date: Tue, 2 Jul 2024 22:55:14 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] unit-tests: add TEST_RUN
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <8175f239-8d4e-49f7-ae0d-dba7df8c365d@web.de>
 <51ebc0fd-ddae-4bdb-a5d6-c92ce8b1f3e6@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <51ebc0fd-ddae-4bdb-a5d6-c92ce8b1f3e6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CbfgKMk0lFguy69PweA1NkPSCRPMWO5cGZWuk/5R3lgxWFSgptI
 ++h1J69SAUwqe7so9jyRatlHkAIE4/r1L94rdEipuCwdVQiH4Q2luAMf4h0UwGmG+VSvTNr
 gyOEa9uF/jK7RFU2HL03H6DZUBQ74Fv4ToVAHi3rFHiDTd8rqjOwOge3iBS8n3iV/nlGy1y
 z0w+VaFmspO8kaInG6uLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DpFNMPI84KM=;Ggaw3Ew5DSpld3m753aDYhhKNeN
 z5Mh4R8XC5btDxaZNWw3lCxThe2X80VPg+suHDHx+/G58axBvnnye+6T5s69ysRYpFJTDH6I/
 Y7oS6PxCpUAlStLyq6Apc/lkCv9B8vnEfZC1IgJ11Rnf1Qv07j0+rMeoBjDHtkF7OOJV68j3h
 c2BN6xI8V0/usf5cAflFgafCKaL0QlOz0VJ/4V7tTGpHgFAb0DdGbRnUIqhlZEMIyC64URiVP
 bpeObEb7pRDOf+26WIGCQJZUX4E0QvejMrC3r11acI20J5dPTXCa1wdX13nIBmPyqPWQ9IEGO
 yKv7tng5wo+pKWCICGO23X+sec19Itt0A/U6EqIypeFr13gBj20eQ14Krxf50zsY3/sQQwTIM
 lQqpKmSj2GGQy7WiE/xKkF7OXyysKOxeppgXTx8Nd5du60mXd9T/Nhp7MaFRRgygFGhta1iRJ
 +qwEXuU64nBTq4phpfW2Ld4ludLXvbFIryXbhwwe9s8mLDk8X70B+CKcJqbXeGBmdjs8P89r9
 kVhl/vnNPGZ3yoyKZ/PYJ/HxmUs55EaxXuZOv2SgXTPCgXi22rN2T+hQkxFzJDpt6oyIYiqEQ
 PO54XHlcC/Q9ZcVUG35hb2CtZLIjyyP84b2VvOnII4cHb/dkA60jlI0sN1R7Bk4smLuWjjskj
 PjCX9v1dlNjzGUApmn9Pq28+hmN4h0/rgP5yLvIJ9vBwmV0VzFZZ0W0lIVZmLLFx9izlIE/Ac
 Hf+/lSPDdPbbyL1zzM/MxkYnjS5xaF01wqReZ+G2fh+d2qk+BaT3srpXTaUMN/X/kpLeIIGEu
 9swnhCfbVvD8yO8X1bpRBE04jpUPiwkljz8vZeXGcI1UE=

Am 02.07.24 um 17:13 schrieb phillip.wood123@gmail.com:
> Hi Ren=C3=A9
>
> On 29/06/2024 16:43, Ren=C3=A9 Scharfe wrote:
>> The macro TEST only allows defining a test that consists of a
>> single expression.  Add the new macro, TEST_RUN, which provides a
>> way to define unit tests that are made up of one or more
>> statements.  A test started with it implicitly ends when the next
>> test is started or test_done() is called.
>>
>> TEST_RUN allows defining self-contained tests en bloc, a bit like
>> test_expect_success does for regular tests.  Unlike TEST it does
>> not require defining wrapper functions for test statements.
>
> There are pros and cons to not requiring one function per test. It
> can be a pain to have to write separate functions but it keeps each
> test self contained which hopefully makes it harder to have
> accidental dependencies between tests. Having separate functions for
> each test makes it easy to initialize and free resources for every
> test by writing a setup() function that initializes the resources,
> calls the test function and then frees the resources.

Right.  We should use TEST and TEST_RUN when appropriate.

> The changes in patch 6 to use TEST_RUN() mean that each test now has
> more boilerplate to initialize and free the strbuf.
This makes them more similar to strbuf usage in the wild.  Using
the API idiomatically just makes more sense to me.  Not hiding
initialization and release makes the tests visibly independent.
This is not enforced by TEST_RUN, but made possible by it.

> Having each test in its own function also makes main() shorter and
> which means can quickly get an overview of all the test cases from
> it.

That's true, now you need to grep for TEST_RUN to get such an
overview.

On the other hand I find the start of the description in TEST
invocations somewhat hard to locate, as they are not vertically
aligned due to the preceding variable-length function name.  Just
saying..

>> +int test__run(const char *location, const char *format, ...)
>> +{
>> +    va_list ap;
>> +    char *desc;
>> +
>> +    test__run_maybe_end();
>> +
>> +    va_start(ap, format);
>> +    desc =3D xstrvfmt(format, ap);
>
> This uses an strbuf under the hood. So far we've avoided doing that
> as we want to be able to test the strbuf implementation with this
> test framework. We don't need to support arbitrary length strings
> here so we could use a fixed array and xsnprinf() instead.

Fair point.  xsnprinf() might be a bit too strict, as it doesn't
handle short buffers gracefully.  Perhaps that's OK; a developer
getting hit by that could simply increase the buffer size.

We could also let xstrvfmt() call vsnprintf(3) directly.  The code
duplication would be a bit grating, but perhaps there's some good
base function hidden in there somewhere.

> Looking ahead the plan seems to be to change most instances of TEST()
> to TEST_RUN(). If we are going to go that way perhaps we should steal
> TEST() for this macro and rename the existing TEST() macro.

Not my plan, at least -- I'm content with just having the *ability*
to keep all parts of a test together.

If we wanted to do that, though, then TEST_RUN would have to be
complemented with a blessed way to check ctx.result in order to handle
the t_static_init test of t-strbuf, which I mentioned in my earlier
reply to Josh.

Err, no, we can simply check the check_* results, like check_strvec_loc
does:

diff --git a/t/unit-tests/t-strbuf.c b/t/unit-tests/t-strbuf.c
index c8e39ddda7..c765fab53a 100644
=2D-- a/t/unit-tests/t-strbuf.c
+++ b/t/unit-tests/t-strbuf.c
@@ -19,15 +19,6 @@ static int assert_sane_strbuf(struct strbuf *buf)
 	return check_uint(buf->len, <, buf->alloc);
 }

-static void t_static_init(void)
-{
-	struct strbuf buf =3D STRBUF_INIT;
-
-	check_uint(buf.len, =3D=3D, 0);
-	check_uint(buf.alloc, =3D=3D, 0);
-	check_char(buf.buf[0], =3D=3D, '\0');
-}
-
 static void t_dynamic_init(void)
 {
 	struct strbuf buf;
@@ -85,8 +76,14 @@ static void t_release(struct strbuf *sb)

 int cmd_main(int argc, const char **argv)
 {
-	if (!TEST(t_static_init(), "static initialization works"))
-		test_skip_all("STRBUF_INIT is broken");
+	if (TEST_RUN("static initialization works")) {
+		struct strbuf buf =3D STRBUF_INIT;
+		if (!check_uint(buf.len, =3D=3D, 0) ||
+		    !check_uint(buf.alloc, =3D=3D, 0) ||
+		    !check_char(buf.buf[0], =3D=3D, '\0'))
+			test_skip_all("STRBUF_INIT is broken");
+	}
+
 	TEST(t_dynamic_init(), "dynamic initialization works");

 	if (TEST_RUN("strbuf_addch adds char")) {

> I'm not very enthusiastic about requiring the test author to wrap
> TEST_RUN() in an if() statement rather than just doing that for them.
> It makes it explicit but from the test author's point of view it just
> feels like pointless boilerplate.

Hmm.  We can add more magic, but I suspect that it might confuse
developers and editors.

Ren=C3=A9


