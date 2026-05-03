Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEF13126C0
	for <git@vger.kernel.org>; Sun,  3 May 2026 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777807494; cv=none; b=qAUFNWrE21t4BWEf819ZEbKj9NdwDdFeEm4olj8t6BAWfgmjR+rdVxHLXfAKI9BDa917g9GgrUPJ234Yo/BKO8Zb4FEeQT/skf4C+MIoraq+r6irow0rb4DEVKRGtbKpnvtzs0RS1oBrNpY7Xcv5xLxah0XTMD9swUnW+Au5+B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777807494; c=relaxed/simple;
	bh=PWlbf4f/ZI1Ux2BpheVf36Rekqq85bpTxC99UyzQ0jQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Xo/ht3A8fiksXcFWgugo2hytjvI6zGYDkymMQPAtmfH15Yy2Yph6z3381rDUBq0uyQ04f1o1d6ZzRGZBUgx8i7JK4MnsdsmpFRTAyZp/9KNmejzgrhIVBenwm5/Pdww3lOG7WDrqBLSJTUBpyp4pYQo9eQBQ8sciJQH+ST+gNw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=saagarjha.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=saagarjha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so3967450eec.1
        for <git@vger.kernel.org>; Sun, 03 May 2026 04:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777807492; x=1778412292;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iVjiei4HZRvYbLE3au1qwa7vuDQgBNBCsYlBEVq+iCc=;
        b=FVejRdr856/EqXeZmLTtswAGSz5MLSeXW3vdq6Sqiuw1E4Vx35/zXjgF7zOMEhkGof
         QlYUWDvlFqgTph/gul1oIcKz9LZIV3L5+PlXmmwy2Vx0aXmMdeNTJXq+bjsyJ4qxNhwG
         Gj+f/fuHTVDNfbrrx9rrNNUzLYQUNk+MrCizOT75FaVcqvaKSZQpndb8IghW+1cjvZP0
         baoH68EzC8QnRLXr35/VjpX/bwQdSkxeStH5bzw/v2KIezvaj1pDAbNaLjsxHjIO9zfP
         jmXzsueZIVBXm38sMG0d4XH2fuEP6R/dFb/k7ToxhuQ3GOGdsZ5g6FJoV9pfP9UZp/Xi
         BDYw==
X-Forwarded-Encrypted: i=1; AFNElJ/EzusaddY4VrKq2yJOOnaE6noXZkMs06q8rpGLER0N5KVAhsii06SXtwGX+kaSecDdIFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSdco2+VlO3ol278jWbRSnCne83yy4CArsnTcSMk0vnu7tvu96
	WUN2NfN6S17tis4PGIiE3P57IequJ4pzrsEZsEIam77W7vXUdXJ+kxgL
X-Gm-Gg: AeBDievV6o/051jHLqrZMMUwcI1bN6y4tcxLIKyr045oze+anqXypcdObIfcYlUFNFm
	OtmQj+LhhK5g6ku8IJ5Uh+oAJVCVAQAa0ds6g5hbKehgbjbjmnBfsqOqyBDAFMps60p2cNfFg+j
	ev30ThiioykGmmPjxlIthHoduZHbXNmaNGZUYWVL4Lndw2a9Uc2Y4RrgUrB4UAy1OBuFWW/3mO/
	cJRkJOyJadKJo6fgnYBgNOeUWAGwvFtV3hqFM1Qdm2vP64D4oyzZWTh5AiotOqkws0s2BGf7QvE
	ddrZKUUcRBmtzP5e9EbeInkTeJi33M069iLU+jywQ+gj3tVRAvpcc9MBbznvm1TQtp97BdBzG/r
	tyNCHLdBd4UiGaq7PNR2Sep7dl3Zefg6JYF04ll6PDGs63Q02v5CBdpcp2+ydZc5Ka5uc09/6uc
	pvs8ZH/zg8iemDLW/M1c11iu/RPpap0J2HxokWVaSbchXgfNW4xh527ubFVDcGxgt83YgwkS91a
	rONuRiiimh6yJW5BZdsGxUWjtEPCccvkmzCVQ==
X-Received: by 2002:a05:7300:e8a3:b0:2d9:6f2f:9f6f with SMTP id 5a478bee46e88-2efbb28c814mr2476883eec.24.1777807492229;
        Sun, 03 May 2026 04:24:52 -0700 (PDT)
Received: from smtpclient.apple (162-231-240-83.lightspeed.sntcca.sbcglobal.net. [162.231.240.83])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b878317sm12478280eec.23.2026.05.03.04.24.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 May 2026 04:24:51 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] submodule-config: fix reading submodule.fetchJobs
From: Saagar Jha <saagar@saagarjha.com>
In-Reply-To: <CAN5EUNT27bYwjdXRQTffbtHFpkV68rAajqgXtbKHu6OjhzG_mA@mail.gmail.com>
Date: Sun, 3 May 2026 04:24:41 -0700
Cc: Saagar Jha via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AAB01B60-F569-49C7-916D-A03549E6C210@saagarjha.com>
References: <pull.2287.git.git.1777803242592.gitgitgadget@gmail.com>
 <CAN5EUNT27bYwjdXRQTffbtHFpkV68rAajqgXtbKHu6OjhzG_mA@mail.gmail.com>
To: Pablo <pabloosabaterr@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)

Hi Pablo! I figured the change was simple enough to be self-explanatory, =
but I expanded the description to indicate what the bug was. Let me know =
if there=E2=80=99s anything else you=E2=80=99d like me to fix (I agree =
that the CI failure is probably not related to my change, but I can try =
my hand at looking at it after if nobody has?)

> On May 3, 2026, at 04:07, Pablo <pabloosabaterr@gmail.com> wrote:
>=20
> El dom, 3 may 2026 a las 12:14, Saagar Jha via GitGitGadget
> (<gitgitgadget@gmail.com>) escribi=C3=B3:
>>=20
>> From: Saagar Jha <saagar@saagarjha.com>
>>=20
>> Signed-off-by: Saagar Jha <saagar@saagarjha.com>
>> ---
>>    submodule-config: fix reading submodule.fetchJobs
>>=20
>> Published-As: =
https://github.com/gitgitgadget/git/releases/tag/pr-git-2287%2Fsaagarjha%2=
Fmaint-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git =
pr-git-2287/saagarjha/maint-v1
>> Pull-Request: https://github.com/git/git/pull/2287
>>=20
>> submodule-config.c          |  2 +-
>> t/t7406-submodule-update.sh | 10 ++++++++++
>> 2 files changed, 11 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/submodule-config.c b/submodule-config.c
>> index 1f19fe2077..57b190678e 100644
>> --- a/submodule-config.c
>> +++ b/submodule-config.c
>> @@ -1037,5 +1037,5 @@ static int gitmodules_update_clone_config(const =
char *var, const char *value,
>>=20
>> void update_clone_config_from_gitmodules(int *max_jobs)
>> {
>> -       config_from_gitmodules(gitmodules_update_clone_config, =
the_repository, &max_jobs);
>> +       config_from_gitmodules(gitmodules_update_clone_config, =
the_repository, max_jobs);
>> }
>> diff --git a/t/t7406-submodule-update.sh =
b/t/t7406-submodule-update.sh
>> index 3adab12091..234a021fb3 100755
>> --- a/t/t7406-submodule-update.sh
>> +++ b/t/t7406-submodule-update.sh
>> @@ -1055,6 +1055,16 @@ test_expect_success 'submodule update can be =
run in parallel' '
>>        )
>> '
>>=20
>> +test_expect_success 'submodule update honors fetch jobs config from =
.gitmodules' '
>> +       test_when_finished "rm -rf super3" &&
>> +       git clone cloned super3 &&
>> +       (cd super3 &&
>> +        git config -f .gitmodules submodule.fetchJobs 67 &&
>> +        GIT_TRACE=3D"$(pwd)/trace.out" git submodule update --init =
&&
>> +        grep "67 tasks" trace.out
>> +       )
>> +'
>> +
>> test_expect_success 'git clone passes the parallel jobs config on to =
submodules' '
>>        test_when_finished "rm -rf super4" &&
>>        GIT_TRACE=3D$(pwd)/trace.out git clone --recurse-submodules =
--jobs 7 . super4 &&
>>=20
>> base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
>> --
>> gitgitgadget
>>=20
>=20
> Hi Saagar!
>=20
> A few hints before this can be reviewable:
> - There is no commit body which, not only is a must, it makes it very
> hard reviewing because I cannot know what you wanted to do and I have
> to imagine it.
> - CI tests seem to be failing, but the file that reports fail doesn't
> seem to be related with your changes.
>=20
> About the code, I can understand the 'why': the function above
> 'fetch_config_from_gitmodules' builds an struct inside and sends the
> address &config, 'update_clone_config_from_gitmodules' calls the same
> function with &max_jobs but the error would be that max_jobs is
> already a pointer so there would be no need to pass by reference
> max_jobs.
>=20
> But this kind of explanation is what should be on the commit body.
> Maybe not this technical as the code can be easily seen, but a high
> level explanation about what this is.
>=20
> Looking forward for a v2,
> --
> Pablo

