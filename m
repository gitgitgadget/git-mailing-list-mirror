Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1393F1AD3FD
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722444543; cv=none; b=jQNhiZUOdvw+RvjBW2gIphvWRYc0xPs6RKWbkh0+8aNF0rq6ieFvHjQwOGFnI+Uip0XevcUwbDGs+rpd8B8EadqPqCqpQKXW4rOy+TiyQ1Kc3a4w4ojJRAV630NmWjiNKz/YVVwX/I3OoLnCk4V9QFQkOCgUIT24CcueGmYKV38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722444543; c=relaxed/simple;
	bh=wY4cq81Hy01g4DRKDNJkuAsZOYdMn2UByP1G/pVcQRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FqcHUKrgzfWf5fG1zq8/bqOU1CuciVTi5xVk1oziurf3zuY7RArtsiFqEbhO1q/CF3Sy6Tt04UeatYas324MOZ0QHjQrnNIZVNivYisOqAxceieCeqOnIcbqgCWKEUNsdRhBWrtrIBVaDuXhrg72ONXLMUoN1lcH+7EfijeKVDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=o0lAHRUe; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="o0lAHRUe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722444514; x=1723049314; i=l.s.r@web.de;
	bh=VvfUEiUSd148qvfWipMUooNoKcLsfEyxD7wXenxgDYU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=o0lAHRUeAgS+pI+UeVARq3QMFqLjCYrBrhTvCoMSWBPqRvcoNWQLXSyh+hjZ/RkT
	 CEAAEHTpHPj1QLQPjh10aurt7CVcAp14Htc9q6ZaxAmC9cuUU/cHUwzH6LB4nq2Oo
	 aHoKMrfLcZUZ7jeV/xvNAJE7ESExomu5OQYX4OLIhB8IehCM08uzMoP4QSoRyl6pS
	 1Qzc3Zvy/ug9IxF+4cVYvfn7IZGzpYCbtdroKaoQepqnA/yIKokz9RDded+CWTMe/
	 HDJF0j+OW1IRwd2bC3CdEGYndfYTqU9HO6sp0BKCg/8gh8WHQHrr8oDyjQxWQcT/I
	 9QBifplpQbriSW5gkQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.126]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoNV4-1rtVxS2eoC-00hbZy; Wed, 31
 Jul 2024 18:48:34 +0200
Message-ID: <85c4f785-de27-488c-aace-c93c2c2a84ac@web.de>
Date: Wed, 31 Jul 2024 18:48:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] unit-tests: add for_test
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Kyle Lippincott
 <spectral@google.com>, Git List <git@vger.kernel.org>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>
References: <CAO_smVi2rJd5SDMsbbxzFUj28a_1KTgdHMz4DTKMsii+Wt5H_Q@mail.gmail.com>
 <xmqqfrrxjw8f.fsf@gitster.g>
 <CAO_smVhq=MkQV3a6qJtDiFykvR4im7AX4hMfKMNcL5SegnOSLA@mail.gmail.com>
 <xmqqv80szxgw.fsf@gitster.g> <ZqOc9vxdD4qttkFs@tanuki>
 <xmqqed7gxhyz.fsf@gitster.g> <ZqdldZE2MV-Pkuu-@tanuki>
 <xmqq8qxkhvt3.fsf@gitster.g> <Zqhwwudf-yjvJ_By@tanuki>
 <53c1eaeb-6106-492c-9c44-13a7cd1bd0d0@web.de> <ZqnJcawtpzvguxtq@tanuki>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <ZqnJcawtpzvguxtq@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y1AUWLOuTRG5X6ViNSpk0Vvx4EyACEAOy9jcDzQWJNqZqi49BfA
 sLtttgkgoumK8ZhIW+rGBn6OS1gLPR8cf/ZVVHdmxvAL9pPjkw3eicH1K5rno357rSTCfsq
 iQ2ITL50jCzO7wx2PbXzEX+cTYQRLJN+DvNEMVKeRRZP6CijuTzMlybJldowvI4mLFYCaiG
 csZUCUdC7Dzbownu6Dk7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2U167RBuSI4=;KeM/WjzyxM1+ycSPGvyqs6CDfEu
 7BRIQxaNHSv0rf68S5KMpF2awaoHkPsjHH0th1J61QsMhctl4MmJQa73o9YJMXxAxWCyE7nXM
 wgr5w3N1qkNohlA11+7nfJ7c4xqTowcLeVF77AOBPMYus7+nlkZR0D0cB6Ch86uPtytv3Ta+A
 8X5w3xp2gFZNA7DrnfJYcV4Vp4g1nUpXVqwpgprg+mOgbx9M4TyPA5rzvwYUVGbTPSvlA2uGh
 RVixAo57WU8dbumiNVzSFcUjqhURqfWM041t3Ou5tx7v6qR4keL9f7GVnDBAj/uIHADyzjXdm
 lrpOelRaAsf01j8qXPFFqRvxJcu4z69Qau2DRBg+oLfCn4l4CZ/r6Os7Ju0dUKNr12cUVXpRk
 ruTk85vlj1QOiJXaowy8bzGV3TRp6wtGnUGuQFPlnkIgmo0fRWnZ1NCeAVW+NxjbwT5TOFTQr
 dnc60GAu1SQNLko9G+15EjfZWgtsM0rhwkikw8JKBd3BcdkdRrsXgs0Tpj9IbQWQTpHzj8v0l
 4KkDfR3/oCgmHb1AYX+DBHbbgWannIqlh2hjwlXi2rdqynv6hGihmWENlIPjAkxOEAUwBTm/3
 ewEN2i2Y+EvOqicK/KbyDjgiMJ3ptx7M2s0Je+sf/MJmFFku/BaYYKfPcaP3Q7K7cGrPQBA9W
 D7iW8tp2eBwwg+aTAkY87jNJW6M+YYVbsLqdKqYEA/JJuIMI3Sry4VOw7e4hciSgPO5AVtzAh
 eDEMNx9Eguvj6bEifsWwVr/5oyEbNtcv7WfqgoHOD/WlvgTz2aU2zyGlyX4IRg2HDiPqMZgNn
 3cr6YIrTfBmoPrr3CMwPkEHQ==

Am 31.07.24 um 07:19 schrieb Patrick Steinhardt:
> On Tue, Jul 30, 2024 at 04:00:07PM +0200, Ren=C3=A9 Scharfe wrote:
>>
>> From the point of view of a "minimal C unit testing framework" surely
>> the implementation language with the best dependency story would be C.
>> Perhaps it could then also test itself.  On the other hand, writing a
>> string handling program in 2024 in C is probably not the smartest idea.
>
> I certainly wouldn't want to do it ;) I think Perl would be perfectly
> fine given that we already rely on it rather extensively in Git.

Right.

> clar comes with
> some niceties like being able to run only some tests, all tests of a
> particular suite or to exclude certain tests:
>
>     # Run only submodule::add tests.
>     $ ./libgit2_tests -t -ssubmodule::add::
>     TAP version 13
>     # start of suite 1: submodule::add
>     ok 1 - submodule::add::url_absolute
>     ok 2 - submodule::add::url_relative
>     ok 3 - submodule::add::url_relative_to_origin
>     ok 4 - submodule::add::url_relative_to_workdir
>     ok 5 - submodule::add::path_exists_in_index
>     ok 6 - submodule::add::file_exists_in_index
>     ok 7 - submodule::add::submodule_clone
>     ok 8 - submodule::add::submodule_clone_into_nonempty_dir_succeeds
>     ok 9 - submodule::add::submodule_clone_twice_fails
>     1..9
>
>     # Run only a single test in the submodule::add suite.
>     $ ./libgit2_tests -t -ssubmodule::add::url_absolute
>     TAP version 13
>     # start of suite 1: submodule::add
>     ok 1 - submodule::add::url_absolute
>     1..1
>
>     # Run all submodule tests, but exclude submodule::add.
>     $ ./libgit2_tests -t -ssubmodule::  -xsubmodule::add::
>     TAP version 13
>     # start of suite 1: submodule::escape
>     ok 1 - submodule::escape::from_gitdir
>     ok 2 - submodule::escape::from_gitdir_windows
>     # start of suite 2: submodule::init
>     ok 3 - submodule::init::absolute_url
>     ...
>
> So I'm not sure whether it's all that important to be able to recognize
> things like #if and #ifdef given that you can pick tests to run on the
> command line.

My only reference are the regular (shell-based) tests, and those have
to deal with prerequisites like PTHREADS, PCRE or LIBCURL.  Such tests
wouldn't even compile, and would thus be #if'd out.  We'd have to move
those into separate files instead and skip the whole file, it seems.

> The alternative would be of course to hook up LLVM and properly parse
> the C sources. But that feels like overthinking it ;)

It's as simple as calling clang (or gcc) with the option -E.  We'd need
to disable -Wmissing-prototypes as well, though, as there will be no
declarations before we generate clar-decls.h.  Not sure how to do that
all in a portable way.

Anyway, another consequence is that adding, removing or renaming a
single test function requires rebuilding all unit tests, because
clar-decls.h changes and all of them include it.  Not a problem right
now.  If we ever get to the same number of test files as in the regular
test suite (ca. 1000) then this could become annoying.

Apropos, I wonder how a Clar-style t-ctype would look like, but didn't
dare to even start thinking about it, yet.

Ren=C3=A9
