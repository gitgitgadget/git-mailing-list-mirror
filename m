Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="jnDVu+MY"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE31FC3
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 05:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1701870475; x=1702475275; i=l.s.r@web.de;
	bh=+crQU9Ow9cnw5t+vZ9x5nL1wi0PQx67LkXHfDSuoGiU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=jnDVu+MYac6upsyveWu0qMNPrj1OgtDja0dBoJRycUdfzytfiJkFbJrFiJEJ284W
	 NbAI/xrS7mEDb97/Awz9TIp1s52heFOM7eH1x+dnUFWuEMmdlYPrfKoHHELLdE+fF
	 VHfrYRLKsPhTz7mVJEE/QqKI0RMvUHzL9nUwNkxF0CffCzaasKARaG47i4UmM2Wu6
	 TX0IRx+XE1qpKuBr6du/9wfOzxhZh8VELI+bbdiWsrNaqWJ2xlAqNJmFbQ5sDT9NM
	 hW+/CEXnmF7croeru1njBz5JB4qxLO/AsbzKCouBvaw3Izvxuv/h3S5hIzEt91Jzh
	 slfHLK7ivykUlvaDqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.29.38]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MvKXV-1rSoby03NZ-00qtMT; Wed, 06
 Dec 2023 14:47:55 +0100
Message-ID: <382fac73-1afc-4b89-ad0f-3320c7a64838@web.de>
Date: Wed, 6 Dec 2023 14:47:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] revision: use die_for_incompatible_opt3() for
 --graph/--reverse/--walk-reflogs
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <20231206115215.94467-1-l.s.r@web.de>
 <20231206115215.94467-4-l.s.r@web.de> <ZXByNGuQTaOQ3sKW@tanuki>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <ZXByNGuQTaOQ3sKW@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V3vXh2XG8ZaOLK8JWOriDfiI3dHMl737bYm9a1agilj3ZURBoFZ
 knYpHNpj3LFepW4dHfAhPGGKPEPceMp6plT1NypaBSSjQCGUfm3sRf5xQltBFnMPrlUA0jx
 tMi4KuT4hpT7YL0vdQM03ZkSyFj0y7y2nerOsrim4FHeqmaXMBmYMO8V3kdnlZQcwe32xbU
 wkjG16ZZdLpwosyx/gs8g==
UI-OutboundReport: notjunk:1;M01:P0:VfiRnvekcJU=;doHlksQxlA0+mSdVw/PRmzJ6MSI
 nE5ojSJmEt3fmgpCSHmRJBq+G4eRitULrVxZFHearytPq0f53gMOuLVB1FMUBmtA318ScElOd
 dyB4rMmb+4OGqLAHSlBQQRikSitxLCqNld781gTO8STF/gp/psBR5sEXOj6Y6196fdeLpmnzC
 WaWvPh/YFwSm9ILgSLG5fMGvmHj48974rDVaNnPnl04b08A8XXsgfjRFWWcCQNmT6/jcDV1lo
 aD2nw/58lAASHn/oxkKb/CfLxzLtHG3ihiUZ5hj+4VPLPsQseH+ZXGBnjkCIeNIRd5JrDuFsM
 Kr+QngADCPLSUKZJ/iz5d+CYmETgCuylK0puPnOuC+V0PlHmNkSKdK2LY8NX6XPvNMB/75dJ+
 iC9l2npycNziWfK5nZHodGF/wuk3f9aGnYieyvpsG0XuIFtKw7GoRGXtHSKAhwzlg/mWc1+3p
 PeO2EMXgQSZJWnyhX+oYz7IV5sNnR6P8fFHab69oyTarr23288gvupqwvVnxDmSjXq96B2Nej
 Ip348n2tXgRH28nwowIh4ENxDR+QwCCMxAsiEJ2cL0EWqA/ryHIpDge+nKBcLBwumfuDOY1vk
 wwyQI2s1D2WDlWGmVmTN5/t8OQImup2y0pfwjGWMYJF/g+StZ7HhTropHthfK1ZrZkFvasIPJ
 WtPBpZ8E8ad5uBro2e4mXQYe6a/Ev7aMlP2RuzRE4tXuMtB6IHiPzH8Bdobpo6EPsmcBzLoFj
 kGNlLc63U5LlV3XjzsaLdjwty0HThqK667ek1J2Digepn1VutbodGEPsRM2tV1fJU42fd0vZN
 lFkBNTtxK4np5A0sGSjkHfXHrFIEBC1s6VATB/u9bbvLq3utQsBeLYdS0/cmyGf33BG+xMUua
 KMEVxvKJy9/69PvXoflJIdFZBbfpv3K82Y3YqVz4r4CO6C8iXKbL05W2GBXhYLY4lck6EUaak
 j3EmiWTzj6mmLwj40VS/+3ZV5m8=

Am 06.12.23 um 14:08 schrieb Patrick Steinhardt:
> On Wed, Dec 06, 2023 at 12:51:57PM +0100, Ren=C3=A9 Scharfe wrote:
>> The revision options --reverse is incompatibel with --walk-reflogs and
>> --graph is incompatible with both --reverse and --walk-reflogs.  So the=
y
>> are all incompatible with each other.
>>
>> Use the function for checking three mutually incompatible options,
>> die_for_incompatible_opt3(), to perform this check in one place and
>> without repetition.  This is shorter and clearer.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  revision.c | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/revision.c b/revision.c
>> index b2861474b1..1b7e1af6c6 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -3036,8 +3036,6 @@ int setup_revisions(int argc, const char **argv, =
struct rev_info *revs, struct s
>>  		revs->grep_filter.ignore_locale =3D 1;
>>  	compile_grep_patterns(&revs->grep_filter);
>>
>> -	if (revs->reverse && revs->reflog_info)
>> -		die(_("options '%s' and '%s' cannot be used together"), "--reverse",=
 "--walk-reflogs");
>>  	if (revs->reflog_info && revs->limited)
>>  		die("cannot combine --walk-reflogs with history-limiting options");
>>  	if (revs->rewrite_parents && revs->children.name)
>> @@ -3048,11 +3046,10 @@ int setup_revisions(int argc, const char **argv=
, struct rev_info *revs, struct s
>>  	/*
>>  	 * Limitations on the graph functionality
>>  	 */
>> -	if (revs->reverse && revs->graph)
>> -		die(_("options '%s' and '%s' cannot be used together"), "--reverse",=
 "--graph");
>> +	die_for_incompatible_opt3(!!revs->graph, "--graph",
>> +				  !!revs->reverse, "--reverse",
>> +				  !!revs->reflog_info, "--walk-reflogs");
>
> I've been wondering why we use `!!` here, as `die_for_incompatible_*()`
> doesn't care for the actual value but only checks that it is non-zero.
> Is it because of the type mismatch, where these flags here use unsigned
> ints whereas `die_for_incompatible_*()` expect ints?

->graph and ->reflog_info are pointers and clang reports an int-conversion
warning without the double negation.  ->reverse is an unsigned:1 and so
doesn't need it, but I gave it one anyway for aesthetic reasons.

Ren=C3=A9
