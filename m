Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8111BBBD5
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719953728; cv=none; b=MNq4BbF+bPiU0Awac+50btc0CgE1s103tWs4l144S45Wj2hNOdomgrsoHQBDDf9kpr551XpTUBte7jeTr3tQRQRqp6m6ISBu40t80i9jYVgMtdJ2FpcBSwudAKVltJ9XeblhUf6WSLIidQOZiOMl6GopI5olzMgtVfUCTT+YxtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719953728; c=relaxed/simple;
	bh=6tDnagSufan1tY+ZYXXH9lC+J3ylGwpxY9igjydsYVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRo/03bIXQF9Odh6hLdy1YtEID0ExlVOKCMnxRjgf0ysS/YDBak9Ypwyl77UfNy9MKkjviSA1Kbs1gB0Ped3qppkR1ZP4N0geYatvQTXiPIga0NW+E2TF9w5Be1k9YJNC3lM7O97SBfqrsi09PwwbMZX7OR/dNIITxpYMPtieCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=vM0fFSpW; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="vM0fFSpW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719953717; x=1720558517; i=l.s.r@web.de;
	bh=v1q//qatntkczIB4e/2LpZtRcbzEn6fBkq8Tw0+s8Hc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=vM0fFSpWmJdeaTBTw6TO1xTWARGcDdTohCqfaBvAMH7NUKtr7QG+T47fD6FjSmtl
	 +pkcSJU/gITM3BgWScNlfJRcpFfnerSsbCkypKpIhiN6mWYW/STp0rBivIvEK44Ln
	 2TVXkV9adwuVyHb7jGGc6cAHeeMbZkO7OD8CtUYaoFrAC6XJsfTTgQ8qNViSXcBlQ
	 pW7efXy+YIbGge+KcJ/BCui8RPm5Ek69oRg33IetKBYI0mQ4bZ209hdnt65R0xV7Q
	 6ZG3tHP/Fz5OOBieAnj6EmBy5uK1UKhbarpVK0GLZnhTRDwKB3LASZ2E+d1Jb3+vA
	 eSTXoUWl4T2LyZd+NQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.151]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSIF2-1srEhZ2lqa-00ISjD; Tue, 02
 Jul 2024 22:55:17 +0200
Message-ID: <fc83c8da-4808-4e52-bfda-6b2d0c5cb553@web.de>
Date: Tue, 2 Jul 2024 22:55:17 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] t-strvec: use TEST_RUN
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <27cdab5f-15b3-45fb-89e1-530a6c0817a6@web.de>
 <c122c0a6-9f38-489d-8286-b62bd4deefcc@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <c122c0a6-9f38-489d-8286-b62bd4deefcc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nPi5dZTO37h1S9JXgphxzd//Zapi6d2lXZdzgiDqRIzyG4E1Z1U
 L+QlW3i8x9Y9ulmy4PPo4EkycwjJHyhoBpbM8KK4eK78fawFGROXXVgxqB9GWi8+IygZ75J
 kCnUA9YrvnJ0adZ4mDeLOVwxor7TtqtFCbO/202oeM5NxNZZuCKOLpuRPab6scQA8nhz/H4
 TOvEjWjAiaJP1x60B4c9Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2auj5J3i8dE=;ebXYWx+EnAydWlpld8mroSwxE74
 m05qcks/chFT7oR/wlOal6U4GIzk8ThA7cKY7USQcjQQR9nkXRYH0COV8Kxxum84UrK0JwRCK
 A9rJR2gbQMwjViRfeCquwl91g0R5ZfXtVWvS4rDtbC3mwDCc9aI3JowE22AnC0L/NHyfREeUM
 5yk8S1cohxyufqc055sMPrJmBhs17cS6yi4W8doc57dzmu6A4yrg1Y/iAq0qORIpUuKZPLBak
 uBszkm9i6le9jUzDb2bcJ59ZQSRgpLV0z0y/kAfUux0a2UCOq4mF25PKdhX+AEiveODJzglxD
 ZkPJGnPuV/RTRSguZP++TfKAjwlY+TIn1UzYbhdvqDEuQFjM6sGPMst++zmPf39EU+0OWCmIN
 1mUQnrfmoPBkiVMgks3ZnT/lIvdT1GJa4yJSpicbBUY7jdjfs52SJaE7mkNxlbWBCEsO3I9Fc
 cIcFhJSkzzggycYDH355K4iNWLlci9piE4n+QqIWmaIz00ATJuE4RPTFCfXPMRrJolTlaxGMO
 hEcHEVGS64d6JaQ0sbZ8h6N9StJMz3u0FZsIVkftnrrKsocj1MzC7FKVd83jPOwXVTL1hY4/R
 FUMXbayc3JkvGN/fE3+AIzXVZj7nGp6rxaNjfMs0g4X4yx2ce+BkeTmgUjKbV01B7Z/4pLfZC
 DwlcCnehKZn5abMT5SKdbcR/sK12+Jz18XH+GOixLbg/0WdnYgs8QZcQm3UcXXnJ9CMEHMrfg
 Etsuui80thJ+/H0NOycarVv+wmFmw6Ty9Ywv0c80/7zTgJP5MHHVSMNo2bMlmZITl0hShrQ+4
 f+2bpI/Z3ZIKE8LHNFOoxjgfqgb//AO6hWefrkDJyL2K4=

Am 02.07.24 um 17:14 schrieb phillip.wood123@gmail.com:
> Hi Ren=C3=A9
>
> On 29/06/2024 16:46, Ren=C3=A9 Scharfe wrote:
>> The macro TEST takes a single expression.  If a test requires
>> multiple statements then they need to be placed in a function
>> that's called in the TEST expression.
>>
>> Remove the overhead of defining and calling single-use functions
>> by using TEST_RUN instead.
>
> I'm not sure what the overhead is that you keep referring to - the
> compiler will inline functions that are only called once so I presume
> you mean overhead for test authors or contributors reading the code?

Yes, I mean the additional effort for developers to come up with
function names and write single-call functions, and for readers to
mentally connect test description and function.  Of course you still can
do that with TEST_RUN, but unlike TEST it doesn't force you.

I don't care much about changed duration of compilation or execution
here -- it shouldn't be much either way.

> This is not related to you changes but while looking at this patch I
> noticed that the existing code in check_strvec_loc() contains
>
>
>         if (!check_uint(vec->nr, >, nr) ||
>             !check_uint(vec->alloc, >, nr) ||
>             !check_str(vec->v[nr], str)) {
>             struct strbuf msg =3D STRBUF_INIT;
>             strbuf_addf(&msg, "strvec index %"PRIuMAX, (uintmax_t) nr);
>             test_assert(loc, msg.buf, 0);
>             strbuf_release(&msg);
>             va_end(ap);
>             return;
>
> Which looks like it should be using test_msg() instead of writing a
> message to an strbuf and calling test_assert().

Erm, yes, good find.  You know something isn't right if you see an
assert(0) or similar..

> The conversion itself looks correct. It is a shame that each test has
> to have boilerplate to initalize and free the strvec but that comes
> from the existing implementation.

I see that as a benefit: You can see what each test does at a glance;
no tricks, no dependencies.  Just exercise steps and checks.

Ren=C3=A9
