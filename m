Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8143B6BFA
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775647761; cv=pass; b=i8+nO5XP2i481+/YDitg3R5Rcs9a9t4oycpnsc7yjeA8yqlzDX7+XAqqBXn4HT+OCWoZUh7Og0oZndul/2Fa9xCamqFqx6OtcNC13u52HtFrdk9b5eCZtHzfdbUHp+B57bsdNwZleA0+v98Mkp9otewp9ctCRWZasvDeNZDa+4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775647761; c=relaxed/simple;
	bh=jyeyIEyhmUMr6iXTw9jyQWMYdr8Lt3MlmDwalEbaksM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rp3g0vnxA6h1EB2Piz+JncDc4NXRH5X07gJ/ZmDESeM2lLiBYnzil9V+QfrBi6mtEplVeciStGgDeIyRwRO7DA8IQvGtDoUk+lKQ/E+rw+tZ4EW39I4ZzYYW6s38De/Ld2ggqNpkOqfrOz33+MBtPOiCypwtM5CsXl/lY2yag64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=E8AnKYbf; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="E8AnKYbf"
ARC-Seal: i=1; a=rsa-sha256; t=1775647741; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MC2eaI2JSf3erdzSX6BY78hHrHJxwUQD+HjjvHgp5cDlSvmwihuOs5R9Uc4GJx890KyE/BidalRyf176/2uJJpNqhf8qfhl78EPrHf1Wq6TAastLgevfONz2zix1TUzKVybCOJbfOUTGzggw043vGgaYvO07gOHH0HXdjHbV4pQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775647741; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QTnZ5vQAqNnzu7C1hALPMNryL3b12O3rWd5eE56ZeSI=; 
	b=lnl4xCUS13PS4AWpdjmbt9Sjc7o+BOxL+aNziL9S8d+8rhFyIspB2JwzmHj1et3132vzhJE+sLp4420kEDPaqt4NmoOKIdF5KCTYwlF0VEo94QWrf7KPHBu93WV3Cy2OC309dC5IYvkVB7M81Od6km3t/FqB78T6MPBBe3cX1ho=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775647741;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QTnZ5vQAqNnzu7C1hALPMNryL3b12O3rWd5eE56ZeSI=;
	b=E8AnKYbfp45RJ3LjvFUFJ0hPbxikXgq2Q1wS6SkgN1Y4y2gsTI9oAiMcROQVZJmH
	YVR1Pvx0HMtclUFCW3BX+G16GZ825DqG0pHFJSqAq4eZiEaA/HJwBfAwLBdEGBjCH2p
	zdU75w8K7tQ57sAWNBJuH+0OXVQh0RV1g0V0Ut/E=
Received: by mx.zohomail.com with SMTPS id 1775647739646346.2250801652575;
	Wed, 8 Apr 2026 04:28:59 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Junio C Hamano <gitster@pobox.com>, Patrick
 Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>, Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 05/12] hook: include hooks from the config
In-Reply-To: <adPh1GHnPH034u3V@szeder.dev>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260301184500.1488433-1-adrian.ratiu@collabora.com>
 <20260301184500.1488433-6-adrian.ratiu@collabora.com>
 <adPh1GHnPH034u3V@szeder.dev>
Date: Wed, 08 Apr 2026 14:28:54 +0300
Message-ID: <874ill3d3d.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On Mon, 06 Apr 2026, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrote:
> On Sun, Mar 01, 2026 at 08:44:53PM +0200, Adrian Ratiu wrote:
>> Teach the hook.[hc] library to parse configs to populate the list of
>> hooks to run for a given event.
>>=20
>> Multiple commands can be specified for a given hook by providing
>> "hook.<friendly-name>.command =3D <path-to-hook>" and
>> "hook.<friendly-name>.event =3D <hook-event>" lines.
>>=20
>> Hooks will be started in config order of the "hook.<friendly-name>.event"
>> lines and will be run sequentially (.jobs =3D=3D 1) like before.
>> Running the hooks in parallel will be enabled in a future patch.
>>=20
>> The "traditional" hook from the hookdir is run last, if present.
>>=20
>> A strmap cache is added to struct repository to avoid re-reading
>> the configs on each rook run. This is useful for hooks like the
>> ref-transaction which gets executed multiple times per process.
>>=20
>> Examples:
>>=20
>>   $ git config --get-regexp "^hook\."
>>   hook.bar.command=3D~/bar.sh
>>   hook.bar.event=3Dpre-commit
>>=20
>>   # Will run ~/bar.sh, then .git/hooks/pre-commit
>>   $ git hook run pre-commit
>>=20
>> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
>> ---
>
>> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
>> index d1380a4f0e..3a95cfe16d 100755
>> --- a/t/t1800-hook.sh
>> +++ b/t/t1800-hook.sh
>> @@ -1,10 +1,26 @@
>>  #!/bin/sh
>>=20=20
>> -test_description=3D'git-hook command'
>> +test_description=3D'git-hook command and config-managed multihooks'
>>=20=20
>>  . ./test-lib.sh
>>  . "$TEST_DIRECTORY"/lib-terminal.sh
>>=20=20
>> +setup_hooks () {
>> +	test_config hook.ghi.command "/path/ghi"
>> +	test_config hook.ghi.event pre-commit --add
>> +	test_config hook.ghi.event test-hook --add
>> +	test_config_global hook.def.command "/path/def"
>> +	test_config_global hook.def.event pre-commit --add
>> +}
>> +
>> +setup_hookdir () {
>> +	mkdir .git/hooks
>> +	write_script .git/hooks/pre-commit <<-EOF
>> +	echo \"Legacy Hook\"
>> +	EOF
>> +	test_when_finished rm -rf .git/hooks
>> +}
>
> There is no &&-chain in these test helper functions.

Nice catch, we need the && chains to ensure we propagate any failures.

I'll send a separate patch fixing this since the series landed.

Many thanks, appreciate it.
