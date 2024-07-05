Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C58D73445
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720202516; cv=none; b=clKtOT7lroHYg89tC5FfcerX7pR8jFi00NVbOKLiQtRDglDmklzjSw0DvHEZqLGWkgtwViK3HSTCvr8CtU9x2jdftEDPGiw30UdV54WgIfCdA002tiNoP59ZaZGBeY69GMLrkAvMy5LF1cU9mpOPgKlmz+hrUuv91ob/4EazVU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720202516; c=relaxed/simple;
	bh=8CAfaqDcZdmnH3VRyKv9dMCpG3WeIwp8/ptZKO9zNYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=StYnvXpPb08gWjxqrGZhJP5rNfX7OiCh5YQRHSYnUNAwUVE1mAvCqzz0qZMPP191NXTkjuPBsdA3s8SEvlGeynxo/CapRMulpeeqN5r4vkpOItPnHfEue4mecsBYy8flYkWqk+joiDo13AA7roHA97oLGsyrgrNK5iAFPFNMVKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=BlZFLKYS; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="BlZFLKYS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720202505; x=1720807305; i=l.s.r@web.de;
	bh=D+Kahn32cMWLIre8Soc1x3L5IPXgc0+UrPf+dcYxAYM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BlZFLKYSdmnGNEUwJf2++EeEr6YdLz6TmlTJ+SumLv4tp3KWBT+zaAV9qRQvMPf1
	 YpXxDqPNMtAq1aWdRateCShpeO5Z4hnunvlAf/szQyKNZF4VDwA/fvDK6KMfsAqHO
	 SC5U+ucUnQWnmTM/uyukb3IoV9XAa2n1jDuZ46MxktS9Epz29+QqoqdZgUW5izPZI
	 xuSeYB+lM8En70+jIYJfvpm9t5WldaiJHkb+dJa+Sqry9LD3A0fBqs5BlX56C86LI
	 K2H2Ny5Ajmx5BvB6Hu2QQhZ2rvGkH3TB4XjJMVaf/oWyKQ4V0j9djSfZlu5opZ3od
	 /qm3cyQNUHwzALjHIA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFJjP-1sb1XN47HV-004Yag; Fri, 05
 Jul 2024 20:01:45 +0200
Message-ID: <6c83357a-825f-49d9-8cc2-e81415e8010d@web.de>
Date: Fri, 5 Jul 2024 20:01:44 +0200
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
 <97390954-49bc-48c4-bab1-95be10717aca@web.de>
 <8802b3ab-9986-47bd-be80-51ac599b2892@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <8802b3ab-9986-47bd-be80-51ac599b2892@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cZKYkA2X8osLuAPyKdYMPFg3YhJ/q2CdAmE/NwIQty9PAf9ScLa
 O9y2DcnGfaHwaw96C3dA7KKsZKE5RuKEG9eHYtXQMnuXm5ur/tR1MPNmU2AexSewgshHzbj
 PTMNJjgV/Uhg2jO4ilUUqgE4yj/b8Q/TJdLWcwlH4boWl+kPYgZgYXHLmyEWChaftXhgWVC
 O0sJF7bY1z+GHdk5ujFdA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rnW+6GPCBow=;7AHEsKvxuMQvZ4a9LY5Lw/BXDoe
 CtoEMfruNl3dqfBG6nApqFT1Ecda54owYYm22S/9WlBVhs9Glw8LUhcZi16/2FNbPnhuTfa0J
 Kv8/AKZkY1F9ASJGgkrKO/2uvZOEg0mFjJNHL/AOd8GqBXRVbqWjm+BgxXYDv2eGyww2qBEJp
 Dc9qM7z4mhMITBn/d0I+EJ669DX8jWYO18ln0FUP3Jb54o+ZhuM+QzqH0GyWV1wd2yZpcTXtt
 ugTdFpS6/oTFKuTrskc/sry81VhPtu6Dmz8EMKmi3Z5cW9SzzUKsJWf4NV9c/8kcFA1g4uDQY
 m6MR42spTv8sh74McleirpA+X7dPwptxKBoEgdsZket8wNSC2M5AFWMPvmiGKD7Ex6GWh8MQX
 08EsgUVYCxaqCzEKyDyfLsFtTzKQ1HuWnQotFV8f6hEVBuvGbMy66limvb2r1vwzEfM/YdLHW
 gcfjxyq77pIf3BDN8IL//aKfjXVtZ/NdR7NqoAZzysbFn1u0gE7j+csVMeEwOxaQmEmI/4fZw
 +R9ua4fKmMlx14UH6f/Ks0PyfAk5gnYuKwQiWMAKaRx3D4cgmYN0bS6Ztn1dKZqo2YjZ5w547
 Z9NX4E4+w3Bgc39PrXCw18ybK23gLJJ87cMAKW+Bl5ZKJ97ZExmHlFxPNA534i9u2R0PeZBBw
 UrgPVFICYG0v45YQqLYDVxl/P80S+1F/A3ZKa2pWWXUaScKGBS/6Pii8wNlKaSiXBZrdcFGz3
 1YCCusIKNeiL9YanRagYfyf0e8uR93fEiTaWi5esh4fcQcUtgfcVHFYKyW5gd36eLeUZZVwAK
 x/ipx8/uSDH6+C+jND5wLOTC95MkfKGlfKD+coruZDSMQ=

Am 05.07.24 um 11:42 schrieb phillip.wood123@gmail.com:
> On 02/07/2024 21:55, Ren=C3=A9 Scharfe wrote:
>> Am 02.07.24 um 17:13 schrieb phillip.wood123@gmail.com:
>>
>>> The changes in patch 6 to use TEST_RUN() mean that each test now has
>>> more boilerplate to initialize and free the strbuf.
>>
>> This makes them more similar to strbuf usage in the wild.=C2=A0 Using
>> the API idiomatically just makes more sense to me.
>
> I see what you mean. I think it only looks idiomatic if you're
> already familiar with the api though as the test bodies call wrappers
> rather than using the strbuf api directly. I think that reduces its
> value as an example of idomatic usage for someone who is not familiar
> with the strbuf api.

In early versions I used the original names by adding these just before
main():

   #define strbuf_addch(x, y)  t_addch(x, y)
   #define strbuf_addstr(x, y) t_addstr(x, y)
   #define strbuf_release(x)   t_release(x)

This allowed normal looking code to be used in tests, with checks
injected behind the scenes.  Rejected it for v1 because it offers no
structural improvements, just optics.  It does allow to forget the
checked versions when writing tests, though, so perhaps it's still
worth doing.

>> We could also let xstrvfmt() call vsnprintf(3) directly.=C2=A0 The code
>> duplication would be a bit grating, but perhaps there's some good
>> base function hidden in there somewhere.
>
> Oh, interesting - maybe something like
>
> char* xstrvfmt(const char *fmt, ...)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0va_list ap, aq;
>
> =C2=A0=C2=A0=C2=A0=C2=A0va_start(ap, fmt);
> =C2=A0=C2=A0=C2=A0=C2=A0va_copy(aq, ap);
> =C2=A0=C2=A0=C2=A0=C2=A0len =3D vnsprintf(NULL, 0, fmt, ap);
> =C2=A0=C2=A0=C2=A0=C2=A0if (len < 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUG(...)
> =C2=A0=C2=A0=C2=A0=C2=A0buf =3D xmalloc(len + 1);
> =C2=A0=C2=A0=C2=A0=C2=A0if (vnsprintf(buf, len + 1, fmt, aq) !=3D len)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUG(...)
> =C2=A0=C2=A0=C2=A0=C2=A0va_end(aq);
> =C2=A0=C2=A0=C2=A0=C2=A0va_end(ap);
>
> =C2=A0=C2=A0=C2=A0=C2=A0return buf;
> }

Yes.  Though the current version allocates 65 bytes in the first try
and only needs to call vnsprintf(3) once if the output fits in.  No
longer doing that might affect the performance of some callers in a
noticeable way.

>>> I'm not very enthusiastic about requiring the test author to wrap
>>> TEST_RUN() in an if() statement rather than just doing that for them.
>>> It makes it explicit but from the test author's point of view it just
>>> feels like pointless boilerplate.
>>
>> Hmm.=C2=A0 We can add more magic, but I suspect that it might confuse
>> developers and editors.
>
> To me its confusing to have to wrap TEST_RUN() in an if() statement
> until one realizes that the test might be skipped. If we document
> that the test body should be enclosed in braces I don't think it
> should confuse developers or editors and will keep the tests a bit
> cleaner.

You don't need braces in either case.  I.e. something like

	if (TEST_RUN("foo"))
		foo();

works fine.  And

	#define IF_TEST_RUN(...) if (TEST_RUN(__VA_ARGS__))
	IF_TEST_RUN("foo")
		foo();

works fine as well.

The confusion that I'm afraid of is that we'd effectively invent a new
control flow keyword here, which is unusual.  There are precedents,
though: foreach macros like for_each_string_list_item.  We tell
clang-format about them using its option ForEachMacros.  I see it also
has an option IfMacros since version 13 (unused by us so far).  Hmm.

Ren=C3=A9
