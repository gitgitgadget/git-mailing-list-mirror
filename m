Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE7C78F34
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735412287; cv=none; b=MmMigohReurT4y7Ra0GMai1QzWeKh/rB3zS+z10wMV+UhyMD4cdWItW69yaLdxjF1OThdrtxx5QTeV3TIdoggQprdvt3kW+8GJsHUj4qjzd4cIhYUu2nHlBxjVQqbGPesoA6kuup3WUB6CEzNtGL1alZsWib47BFDtMOYjc4XJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735412287; c=relaxed/simple;
	bh=lzJGXONi3IEbWLndo0SAAQLnyTNP7mC+3fE4IpCzSzA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=bX+wwm8OpfybpgNGsGrQv2Pf3Kj/hcvjd/bAHi2fet14LFUS8oBXSYkmD9H5BXX+19jfph9YnHkBCV8NvK2Bmt/JkTKtugHzwhi3ghjdkM2IzqkkfCd/16CJ/ZEViPNDpmMyyzxGIkkirhctYByKvosKcabkRBmLkOb6Nn6Sjl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=byoungchan.lee@gmx.com header.b=h8KuPQM4; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=byoungchan.lee@gmx.com header.b="h8KuPQM4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1735412282; x=1736017082; i=byoungchan.lee@gmx.com;
	bh=ySuDck6ZqmPn2IN8TleofKuVBV7htZErgzYqkQih6kA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=h8KuPQM42P3VWLru9uQJnX5Vmmdd1l7K6RRce+HwaPM69CUpf3jBXGNeZd5jHO1y
	 CxZZr6DTNhrlPMcEbI7FRHb0EzlNED9NvtoQopCmUBJhUCBRhlSGk5ZLMKeSoaChX
	 pYOY9AfG7/GHM17a3kbQoMaCGBLxeb5HAb+Olnt4VQHyTq/XjrgbucIGH4jzGCbka
	 5RXo05Wb8FnBhwJ+b50aYV+DBsKN6mqSjcsVw/FQdm05Fk1rcQQPrf8i9irLDKBkn
	 Ff9jnxWAmVha4RsXZ0vnHJjjTY6SRO6X6GbsO7Hq/sBuWFUhkSyQd+y6lAlN1O8Bj
	 NYjw8AHCbVOQXUpNcw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.2] ([220.70.31.140]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVNB1-1t36je4AYZ-00SbPN; Sat, 28
 Dec 2024 19:58:02 +0100
Message-ID: <24ba736c-6700-4037-8147-40ae8c789969@gmx.com>
Date: Sun, 29 Dec 2024 03:57:52 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: gitster@pobox.com
Cc: byoungchan.lee@gmx.com, git@vger.kernel.org, stolee@gmail.com
References: <xmqqmsgf3faf.fsf@gitster.g>
Subject: Re: [PATCH] builtin/gc: Ignore random minute field when registering
 macOS services
Content-Language: en-US
From: Byoungchan Lee <byoungchan.lee@gmx.com>
In-Reply-To: <xmqqmsgf3faf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NHiNztGO5bOK8tCkyjUyLvK5VqhEsrfOiyS5qOJGJInDJ3t1+Oq
 tqjEOESVmTijSG9G1zUCJO0/xf6RVJCh9q3vJi05Rgy3CMFPWSGMW/uMDZl0AlbwXOmX9Ig
 TISIJltOgOpjDe33zt8d/X3M/fmqeNcA8PlY/WBlNEQgBhhAczhK0jdc72w4eMc1krwXL6z
 uW0rwSeVOGZN+W1b+54ag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+ojZhoev7B0=;pQLIXyhoSKZPwhDvBvqaPysWVOI
 MWT1C/kuLQIwH6SAh15+ibaw3u4750JzO9yN7nTqPWkyytHFRhsXAsCa4Tz3deT+oUDrGtTkH
 jqxLUCAASvKyjcs2cEdEw3rsZ2XKUnTnbJeVLI9XtEwx7+h7IumDUGb7UBwQAZ1Y2stTq7JHD
 3UuJoJq/Z8ihMltZd3nBh0tKwmP5vs+Hd40bpRFONv1zpAOD4UD+Xx17vqPT3/nUiXcS9ykoC
 8WEQJBL2/H+Pn+Htbp7Q/nPgrZjLeyhXHdgyW8BiSBhU+TntRcZZzgNGzSt62iXe8OBC+O2Ni
 JqDbw9iwaLWzIg9Ddd5q6GaTMmmRfXo2pnI3lBXsvlrsA2QWJwqWHWb1UJC/+jiuqarfaJvlB
 YK5zqVCtGjXlLCWgwxf/4oLzKLHJGnyiEC5NpuS3RAHcB2Kc494qpLp/SP8Sl1tzIZzDQ6K1l
 cRA7itL/BxH4XSWyNDAnNFaE6ujtOmYDovgBTU+UFxOxu7AjGFF4r3gYmpuz1xdp538oXD0s6
 3bU5nVxGxLp1ygdWr7qMwrwRo4fnSBnk9e36WIU/rBnB1IAwz6pB8TLGVxvq/1Bmmjed1VUcZ
 6jEFXBkNL1aMSwTq94O9umPG4UTpAOa2HPqlKlT9Xx0YmnY9EV3f48ML35HixUUokcwohjY5p
 6HNyKVnEcu0/bica/QoIj9UArBM1oYH1JYoHTQ9URJqPz5mt6Vc0hSEpcQi3xlO2wwuepFwYD
 qABKjC2pciRsC9gFTUVrQnMCo3raNtn/PFAGHDZhnsdBz3Yy45PXpBoqWEgkL7vrv+IXlhYm+
 UO7EYA/gFJwAg8iU9uZbxcIJUQpGu0WuyH97vYPH48Gii+MNM1vqC/oEjYXxsO1zcsrBxz0nR
 klK1crJCgb8FP/BI6rygjJ85ZGTsW7+34UWtzamjjgjkXHP1AAOkVFzmagXTEWu4SIH2BySfl
 YrYTrno1mD88U3gqPYg74za6YPShpsw/ko1XUhtBTGxDk7jAfNKEy+XAGdVBh6zN+p8XUbgSE
 SfgOWkiy84zRO/hPxvrhl9/ZKICtUJ2GKPCvKThZ3OKisDKX0QmTcHq/CbjZp0gkXV1HhjoCw
 VS4BUyNYdekobUu2jySxWDyJvmlXpi

On 24. 12. 29. 02:09, Junio C Hamano wrote:
> Byoungchan Lee <byoungchan.lee@gmx.com> writes:
>
>> In macOS, `git-maintenance` registers several launchctl services
>> to periodically run Git maintenance tasks by creating plist files
>> in `~/Library/LaunchAgents/`.
>> To avoid re-registering services unnecessarily, we check if a service
>> is already registered by verifying the existence and contents
>> of the corresponding plist file.
>>
>> However, these plist files include a random value in the minute field
>> to distribute maintenance tasks over time. Because this value changes
>> with each registration attempt, a direct comparison of the entire file
>> (via `strbuf_cmp()`) often fails, causing services to be erroneously
>> re-registered. As a result, users may see multiple services registered
>> and receive repeated =E2=80=9CBackground Items Added=E2=80=9D notificat=
ions.
>>
>> To resolve this, introduce `launchctl_plist_cmp_ignore_minute()`,
>> which compares the content of the plist file while ignoring
>> the random minute field. This ensures that services are not
>> needlessly re-registered when the only difference in the plist file
>> is the randomized minute value.
>>
>> Signed-off-by: Byoungchan Lee <byoungchan.lee@gmx.com>
>> ---
>>  builtin/gc.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 47 insertions(+), 4 deletions(-)
> A few comments on the design.
>
> "ah, the minute part needs to be ignored when comparing with the
> existing configuration" smells like a poor strategy for two reasons.
>
>    (1) maybe the part that gets fuzzed would become different over
>        time and this new code may need to ignore differently.
>
>    (2) the need to compare with the existing configuration would not
>        be limited to macOS, would it?  If anybody wants to avoid
>        re-registering with the same configuration again, such a
>        selective comparison needs to be reimplemented on every
>        backends.


For justifying my design, I believe we do not need any additional
randomization.

Minute-level randomization is sufficient for tasks repeated on an hourly
basis,

so no further extensibility is necessary.


I also aimed for practicality, because this issue (the repeated
annoyance messages)

only occurred on macOS. I also use Linux with systemd for programming,=C2=
=A0

but Linux does not bother me. I am unsure about other operating systems.

> I wonder if we want to tweak get_random_minute() logic to be
> deterministic to avoid need for such a fuzzy comparison at its root.
>
> A few possible ideas are to read the value from the existing
> configuration and reuse that instead of coming up with a new random
> value, or to hash the hostname (or something similar that is
> reasonably stable) to use the result as the seed.  Derrick, what do
> you think?
>
>
> As to the patch, as I suspect we may not want a code with the
> proposed design, I won't look at it deeply at this point, but please
> consult Documentation/CodingGuidelines and/or make sure your patch
> will not be whitespace damaged during transit from your repository
> to people's mailbox.  For example:
>
>> diff --git a/builtin/gc.c b/builtin/gc.c
>> index a9b1c36de2..6405f4d332 100644
>> --- a/builtin/gc.c
>> +++ b/builtin/gc.c
>> @@ -1951,6 +1951,51 @@ static char *launchctl_get_uid(void)
>>   return xstrfmt("gui/%d", getuid());
>>  }
> These two lines are supposed to be what already appear in our
> codebase, but we of course do not use a single-space indent.  There
> is something funny going on.
>
> Thanks.
>
