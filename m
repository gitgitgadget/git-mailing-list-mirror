Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C8C4A1D
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 07:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720336873; cv=none; b=lSgTDiUR3y5/vNlnI2Kt8OPefwLsAQymn7tLEp6e0Jhpwt8rvCox2oqCEfZaa0s9vyX7AFZ9lxeYVOAlJtr8Yeggd9ZqzCVnR6gNx9EuuqHYpdlqWoJ8OoG8pmYp8QME7Ujrlb7yNZF8uslOU0v3TDqCdB4xAKywu12WlpVZxQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720336873; c=relaxed/simple;
	bh=mK5liCxkPD9M73hoMCkh5QoqKV7W7Eg30H3sVBIZies=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=c1qrQbnBLWtFL/KxfHQJOAsOmInhdSVl3LMxCYlM8SBFATCshZfEHE5dRWtv2wUi4h+wxIfSmzK5pLNfX9wdhy5i/iJx6AQkt3U0aE+qK+tmA8y1NS37MI+hVZ7x/Z/FgRH9qh9lANj75z43MfYHK4ko6vWAUW7qKKykL7c1RQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=sCpgg8W6; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="sCpgg8W6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720336857; x=1720941657; i=l.s.r@web.de;
	bh=XCQHRe8xlFJvFLRC3HS0GKjyv9QsONUWdVvYShnVL+4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sCpgg8W6wZFGqERdLJsncagZ5g8ttrwLRdGO/b7dALbVaC/F2N1quaNdiG1+qc8B
	 JrRU9ePzrjzR73tbNoga20JA2hzcz/FaFOG4NohCgIg2dOGlRlEEE98TBDcFCZxje
	 yMo+Qcw23WdgusG5/9GdhqVoF8hx/d6tIfhylxZJAhu1UmNNHlMSlATnXWMz5u9D7
	 pC7yp7zaqsIT9Mp02MM1OEA2VILjO6kXuWhNr/XbpUJIem8ER+5c0aCk25N0v+kUY
	 aN31qUuqSfQ7UpJOunjCiPrZpQT63LAnZPxEgKaIpwrruBORdbJcnTUrUPiyMyozk
	 FgUHo5UdSdDqsR/1/A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6HG8-1sSaBc3bq4-00E72S; Sun, 07
 Jul 2024 09:20:56 +0200
Message-ID: <62d221cc-532a-4a6d-8e96-b5a246ddeb1b@web.de>
Date: Sun, 7 Jul 2024 09:20:56 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] unit-tests: add TEST_RUN
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <8175f239-8d4e-49f7-ae0d-dba7df8c365d@web.de>
 <51ebc0fd-ddae-4bdb-a5d6-c92ce8b1f3e6@gmail.com>
 <97390954-49bc-48c4-bab1-95be10717aca@web.de>
 <8802b3ab-9986-47bd-be80-51ac599b2892@gmail.com>
 <6c83357a-825f-49d9-8cc2-e81415e8010d@web.de>
Content-Language: en-US
In-Reply-To: <6c83357a-825f-49d9-8cc2-e81415e8010d@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:21h/nmh7xzH4UZ0wXq5OXojzAxNnpL5SadVxmgJxuDZeLxCjtAj
 M9g9u/uIXmFpC/Xdwrg56dzj5rnajhtfUC5B0OJyz0OByPsX1Ip+zpDzkoRUJealUHGdbxY
 mF6NC9JlTK4Pa4sdPx9Hr+Ofc+z4Ffr/9+nXRmM+JqWkpSYUb8+UO/GRhf5AP5FPAgtVP66
 qzCRrVzZW9XdNQ3MVpkPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:78NTEhILC3o=;pwKdnO4X4f7yEcO5LN/xwNUBvLT
 gh8oswQ5p+Rzvoy1DEsUajWCjkQVJw6UBf+uxhmM5naTjYvpQKHaen1P18lP1J//p1gLsYSMs
 xtZ9O1eD981GPagqBM8mgt1QSVYV/hhB5qCYc5OJMYYWeDMh13WvwbWAzedS3kV4tcwDJ9b4k
 XdP+uz/ybj51ocVMhnCfJwQH2Gk++D74u1I+mFl0jcjDADkKYC0gL8pps/4pySdA+SugzMgsm
 FrByncLVEZFu7FSRQDnCqjJCwqAwvktT/r+UVZTd+FPjXlrfed6BTf0uwL1lkNC+4QpqfHuyM
 QktHwg9PrkVlsppRozcol54vUocJ9uJHOV2fIpRPVPr7dFuJhdwqtZDj9+9XPOW5C5nP1AjY/
 GinPRbQsctP91gNOD0VD1uRwKb8SXMZyBgLk25HyWF8fR/4AI5HQJ50PJuR3LNQK+cmFsemCu
 NyqID6LS320oTnqBnhq62xN8UiGuKD7LJzdxOqx6LBXQ2KUZbFp7slWvu0FemRG8C6DglPWe+
 OgdBn635z91FEcAHlxamS8W0dtyhfRVBibftkl+G8nHD0V8VKqzKJM3BCJ/R6+m+rYyQig+n1
 agMNPchcyGch1Az0cUT4X4qtVjUiq/rSGFAKWIClKnyKHHuTS0gKpzq+zCBpQIkaKvpeahd7E
 Gq4iy7Pz4O6h9ai+26Jk8LvU9ZgNiBHIaqxUuUYDtI8ufe+ohqgB3CvIQEwHGMHz53EDzeNr/
 ymFfeu36zB4jg/7hN4W2ZCxXjTkfgV+4Qcj20snp+8rmuM1hVb5u9M6hNU58/iJ5QKpsWgOQb
 FvMky7MHIz/nxpBwfi266t1vGvMZsJ2hWOLJcSRL7VgjA=

Am 05.07.24 um 20:01 schrieb Ren=C3=A9 Scharfe:
> Am 05.07.24 um 11:42 schrieb phillip.wood123@gmail.com:
>> On 02/07/2024 21:55, Ren=C3=A9 Scharfe wrote:
>>> Am 02.07.24 um 17:13 schrieb phillip.wood123@gmail.com:
>>>
>>>> I'm not very enthusiastic about requiring the test author to wrap
>>>> TEST_RUN() in an if() statement rather than just doing that for them.
>>>> It makes it explicit but from the test author's point of view it just
>>>> feels like pointless boilerplate.
>>>
>>> Hmm.=C2=A0 We can add more magic, but I suspect that it might confuse
>>> developers and editors.
>>
>> To me its confusing to have to wrap TEST_RUN() in an if() statement
>> until one realizes that the test might be skipped. If we document
>> that the test body should be enclosed in braces I don't think it
>> should confuse developers or editors and will keep the tests a bit
>> cleaner.
>
> You don't need braces in either case.  I.e. something like
>
> 	if (TEST_RUN("foo"))
> 		foo();
>
> works fine.  And
>
> 	#define IF_TEST_RUN(...) if (TEST_RUN(__VA_ARGS__))
> 	IF_TEST_RUN("foo")
> 		foo();
>
> works fine as well.
>
> The confusion that I'm afraid of is that we'd effectively invent a new
> control flow keyword here, which is unusual.  There are precedents,
> though: foreach macros like for_each_string_list_item.  We tell
> clang-format about them using its option ForEachMacros.  I see it also
> has an option IfMacros since version 13 (unused by us so far).  Hmm.

Hmm, again.  I can see the appeal.  How to call it?  Given that the
foreach macros have lower-case names, perhaps to indicate that they act
as control flow statements, not function-like macro calls, would we want
lower case here as well?

	#define test(...) if (TEST_RUN(__VA_ARGS__))

	        test ("passing test")
	                check(1);

		test ("split single item") {
			struct strvec vec =3D STRVEC_INIT;
			strvec_split(&vec, "foo");
			check_strvec(&vec, "foo", NULL);
			strvec_clear(&vec);
		}

Can't get much cleaner than that.  Requires learning that this macro is
not function-like, but it's probably not too much to ask.

Ren=C3=A9
