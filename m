Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5456916DC09
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719865143; cv=none; b=r3LsysQw+rt+sfXr1EPUQnZg/4RA2J54o5QeUsPT59zZyirh/4yuLPzh4JkhE4txp6b+OnHMDZonSCV2opN4QFyrx9SmYCf4Q213tco3IGCPOAQshNPBEZx8zOX1ZbRwQFfmsej+DyP43LMVveJXbrp+nmnlk/useW9wyGZAkS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719865143; c=relaxed/simple;
	bh=2hV2QINRb+rZzKT4wMO3umbPzyvXoX4sLNugL6K+VWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u3DjrJZo4AtcQaI2gcM8G1NmgsN6JLYOv20eMCMAQABSN1h+oCfTT8gAXNWWxJakrCL3IkG34v5mMMLuYe9KBayPeWFvw2G3PoV1X4R0h4n95smUfSBjlAht5Syv8/OWA+19oFguplbJ6Zb15Ujn7PurPMWHhk3ET8po+aki0GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ZPerW/gv; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ZPerW/gv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719865126; x=1720469926; i=l.s.r@web.de;
	bh=yfRft8oE7kJoismx/cQrnh4lsZ0uB+dItzVHrGtGkHY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZPerW/gvvtGNvLDmidrfaSA9hyO4mdDP/nu8dzJDqWJjhJV5qcVVmdA4KS/JAK65
	 rGtBvqnm+cjUW9hzo5sfbuUeH9HXZCbpEkxb3hr78Z2tSaRfnyN7S7i+oaQ7NUoN/
	 /mO3+32fUvzzUQ7uxws/BBlbWnzMB+SQ+Jjb9+jT6eGoP/Rla3BVkJI9xn1lqa1bJ
	 xeY0t0OMAc/sYzR8RDr3qtBwqlMSBXQUxoXYuTkFhf1Mi4oLrWlSlrPabLsqYYPXy
	 rzkBlGQw5AvFAGCbxJsT7OqpwWZVrG1FitGP1W4GfOlmZ/lEgT6/SPS1tj297oxEj
	 2DCTpoTCqqIOUKKxQA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.151]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mm9Zi-1ry9TC0Ikq-00bgSW; Mon, 01
 Jul 2024 22:18:46 +0200
Message-ID: <6bd64e76-46b1-4511-a8f7-bfe28af48fb3@web.de>
Date: Mon, 1 Jul 2024 22:18:45 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] t-strbuf: use TEST_RUN
To: Josh Steadmon <steadmon@google.com>, Git List <git@vger.kernel.org>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <1bf053ae-957e-4e9a-90f0-11cc76848ce9@web.de>
 <bh5ectgtwdaeltflggzwnwhobewvcqqelforr4sfcmq47rnnrl@mzspptlhpofx>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <bh5ectgtwdaeltflggzwnwhobewvcqqelforr4sfcmq47rnnrl@mzspptlhpofx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G/eozPPCdKBw9qdT0SxLkCFGCSL4Th/DRlgwORG7utngqKpYKwF
 P2IqQPERi0xMMBHWkyvu89uHifToazmE8n9FIVCCafaOAhTSP9ob1t6+jgmIoQlL7dZCwN6
 6ecJDaRJXkQGyTmILZPIqe4tftoS5pwMD/1FukH5Uj1vmye46qBQsLBG0QN5hoA+tEmsBZl
 S48MhyHrZ/C8cSO14aB5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oLVhep+QiD4=;w5xH6DXfGvMzXje21mY9wPn63JO
 eGDYnPNVYyBABT6Y+uIgGqhbwPk0hyxixUEDX58FYTT25EC1+V0mwQ5caOcF6OCo07f4Ypt/Y
 VTUqj6qF8UQl8IlrJcTJSVPuA1OXrsoT3UdMLEbBVih9ZiqZEpxiOguuha/IUfU4T6ieykc1A
 o9ZEWLri8NA0r8kQFk2wzO2bGha4fvfCXSM6Bc/yS3u1dx010KKn0v33NRyy4NDTm16dLGEC+
 6jWjxIF7xuggnVCYTU3AIjdHg1zzPhlYf4LJlwUIf//hDvzC9kbpCRNmo32CNj3VEorr3OFBa
 i76rntV3kU+DHX1pb6EC4/cmFydF18/7QP/UVt7NL2BoHufap5D3LwGdhbsUbkjU76gZ70n+j
 RQVR4AThoVzAWraLSqrI+4GpaSOPzjUAkkcelHf0ufhcezItKMDeFI1t6Jqq3NsQdUz03wkq/
 e5suX6d13dDUgzkiwuvNc1mta4rfLWxcKTn+306/U7MF/QflxN9a/gXL8MYfzdd80Dk2+Ayjt
 jfN+FIi/tfEHSYhfqM7EUiLMIONCDq0R8J6dVfrP8G3/NSyGOIkOcqKVrQ/S0fMGuaohr/6tX
 Vr8mMElJIzfC16HPWzCBvU0sry1MS4PDszHNhEpeJeti6fYnUwhcFsNi9C74gIrjo2DU4kXcP
 ffjyLYyxKyLuh08/ugMpChGHI44J7QcCI4BfsceLog9fnnndVjqtEYfMGxRzaNkNdznMiLohH
 cozcaEyuSAPlaQ0xCXhawg60KvMjjCpfNIlTEGUUtyKvQO4lZQUrU7G2pCUjg/1j3QCb3CMFv
 vt7EKsTTj6y04ugJ2y0xMwbum2k7Akenb0ksOFbmB+6v4=

Am 01.07.24 um 21:58 schrieb Josh Steadmon:
> On 2024.06.29 17:47, Ren=C3=A9 Scharfe wrote:
>> The macro TEST takes a single expression.  If a test requires multiple
>> statements then they need to be placed in a function that's called in
>> the TEST expression.  The functions setup() and setup_populated() here
>> are used for that purpose and take another function as an argument,
>> making the control flow hard to follow.
>>
>> Remove the overhead of these functions by using TEST_RUN instead.  Move
>> their duplicate post-condition checks into a new helper, t_release(),
>> and let t_addch() and t_addstr() accept properly typed input parameters
>> instead of void pointers.
>>
>> Use the fully checking t_addstr() for adding initial values instead of
>> only doing only a length comparison -- there's no need for skipping the
>> other checks.
>>
>> This results in test cases that look much more like strbuf usage in
>> production code, only with checked strbuf functions replaced by checkin=
g
>> wrappers.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  t/unit-tests/t-strbuf.c | 79 +++++++++++++++++++++--------------------
>>  1 file changed, 41 insertions(+), 38 deletions(-)
>>
>> diff --git a/t/unit-tests/t-strbuf.c b/t/unit-tests/t-strbuf.c
>> index 6027dafef7..c8e39ddda7 100644
>> --- a/t/unit-tests/t-strbuf.c
>> +++ b/t/unit-tests/t-strbuf.c
>> @@ -1,32 +1,6 @@
>>  #include "test-lib.h"
>>  #include "strbuf.h"
>>
>> -/* wrapper that supplies tests with an empty, initialized strbuf */
>> -static void setup(void (*f)(struct strbuf*, const void*),
>> -		  const void *data)
>> -{
>> -	struct strbuf buf =3D STRBUF_INIT;
>> -
>> -	f(&buf, data);
>> -	strbuf_release(&buf);
>> -	check_uint(buf.len, =3D=3D, 0);
>> -	check_uint(buf.alloc, =3D=3D, 0);
>> -}
>> -
>> -/* wrapper that supplies tests with a populated, initialized strbuf */
>> -static void setup_populated(void (*f)(struct strbuf*, const void*),
>> -			    const char *init_str, const void *data)
>> -{
>> -	struct strbuf buf =3D STRBUF_INIT;
>> -
>> -	strbuf_addstr(&buf, init_str);
>> -	check_uint(buf.len, =3D=3D, strlen(init_str));
>> -	f(&buf, data);
>> -	strbuf_release(&buf);
>> -	check_uint(buf.len, =3D=3D, 0);
>> -	check_uint(buf.alloc, =3D=3D, 0);
>> -}
>> -
>>  static int assert_sane_strbuf(struct strbuf *buf)
>>  {
>>  	/* Initialized strbufs should always have a non-NULL buffer */
>> @@ -66,10 +40,8 @@ static void t_dynamic_init(void)
>>  	strbuf_release(&buf);
>>  }
>>
>> -static void t_addch(struct strbuf *buf, const void *data)
>> +static void t_addch(struct strbuf *buf, int ch)
>>  {
>> -	const char *p_ch =3D data;
>> -	const char ch =3D *p_ch;
>>  	size_t orig_alloc =3D buf->alloc;
>>  	size_t orig_len =3D buf->len;
>>
>> @@ -85,9 +57,8 @@ static void t_addch(struct strbuf *buf, const void *d=
ata)
>>  	check_char(buf->buf[buf->len], =3D=3D, '\0');
>>  }
>>
>> -static void t_addstr(struct strbuf *buf, const void *data)
>> +static void t_addstr(struct strbuf *buf, const char *text)
>>  {
>> -	const char *text =3D data;
>>  	size_t len =3D strlen(text);
>>  	size_t orig_alloc =3D buf->alloc;
>>  	size_t orig_len =3D buf->len;
>> @@ -105,18 +76,50 @@ static void t_addstr(struct strbuf *buf, const voi=
d *data)
>>  	check_str(buf->buf + orig_len, text);
>>  }
>>
>> +static void t_release(struct strbuf *sb)
>> +{
>> +	strbuf_release(sb);
>> +	check_uint(sb->len, =3D=3D, 0);
>> +	check_uint(sb->alloc, =3D=3D, 0);
>> +}
>> +
>>  int cmd_main(int argc, const char **argv)
>>  {
>>  	if (!TEST(t_static_init(), "static initialization works"))
>>  		test_skip_all("STRBUF_INIT is broken");
>>  	TEST(t_dynamic_init(), "dynamic initialization works");
>
> IIUC you're leaving t_static_init() as-is so that we can determine
> whether or not to skip the rest of the tests,

Right.  And that place might be a use case for an official version of
test__run_end(), but it's probably better to gather a few more such
candidates before drawing conclusions.

> but is there a reason you
> didn't convert t_dynamic_init() here?

Good question, I don't remember.  Perhaps an oversight or laziness.
Or just a general feeling to leave the init tests alone since the
first one doesn't map to TEST_RUN easily.  So, in a word: No.

>> -	TEST(setup(t_addch, "a"), "strbuf_addch adds char");
>> -	TEST(setup(t_addch, ""), "strbuf_addch adds NUL char");
>> -	TEST(setup_populated(t_addch, "initial value", "a"),
>> -	     "strbuf_addch appends to initial value");
>> -	TEST(setup(t_addstr, "hello there"), "strbuf_addstr adds string");
>> -	TEST(setup_populated(t_addstr, "initial value", "hello there"),
>> -	     "strbuf_addstr appends string to initial value");
>> +
>> +	if (TEST_RUN("strbuf_addch adds char")) {
>> +		struct strbuf sb =3D STRBUF_INIT;
>> +		t_addch(&sb, 'a');
>> +		t_release(&sb);
>> +	}
>> +
>> +	if (TEST_RUN("strbuf_addch adds NUL char")) {
>> +		struct strbuf sb =3D STRBUF_INIT;
>> +		t_addch(&sb, '\0');
>> +		t_release(&sb);
>> +	}
>> +
>> +	if (TEST_RUN("strbuf_addch appends to initial value")) {
>> +		struct strbuf sb =3D STRBUF_INIT;
>> +		t_addstr(&sb, "initial value");
>> +		t_addch(&sb, 'a');
>> +		t_release(&sb);
>> +	}
>> +
>> +	if (TEST_RUN("strbuf_addstr adds string")) {
>> +		struct strbuf sb =3D STRBUF_INIT;
>> +		t_addstr(&sb, "hello there");
>> +		t_release(&sb);
>> +	}
>> +
>> +	if (TEST_RUN("strbuf_addstr appends string to initial value")) {
>> +		struct strbuf sb =3D STRBUF_INIT;
>> +		t_addstr(&sb, "initial value");
>> +		t_addstr(&sb, "hello there");
>> +		t_release(&sb);
>> +	}
>>
>>  	return test_done();
>>  }
>> --
>> 2.45.2
>
> I think this commit in particular shows how TEST_RUN() is more
> convenient than TEST(). (Although, arguably we shouldn't have allowed
> the setup() + callback situation to start with.)

Great, thanks!

Ren=C3=A9
