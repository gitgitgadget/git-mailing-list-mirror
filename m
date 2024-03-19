Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A583039FD6
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710877139; cv=none; b=MeTHGr9cUek81fWT0/4cXehy+wiRkybfc7CcAf/OYWwB3Df1DX0Yc5+U/77BkHLtrl343Hb2bqQP4RRSfhozZ8Tx5hm+1Cf/84yQkQ7k28r+YVggsLYBqqt4TnSFNOvyzVNZzsIN1DKwuvimzAoWcOk7HAZqQ7RMegMJWcsPl8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710877139; c=relaxed/simple;
	bh=o6rSP9vH8RglxFWPX5YHbu53JhO6ogqh66a5H5zy0EU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=XXFnxLN7vck39a7McZjMJxb6lWiwGIwfR7KMtzIzaWdQEAl38kadrGE6QM2vz0LZb3du5QIIpES3NFP5k/bzew70Hc13OIFm2amqG8freq+GrnZ66NAuA6axK0OHddTB1jHJPyqeYe239Tzkc9OhnR/g6glKl97it839wN+lNyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=HdYkEjoL; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="HdYkEjoL"
Received: from [IPv6:::1] (2a02-8440-320a-0856-47ac-4915-fd66-da4b.rev.sfr.net [IPv6:2a02:8440:320a:856:47ac:4915:fd66:da4b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id C9A4B60328;
	Tue, 19 Mar 2024 20:38:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1710877133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OSZh50mZET12HyWudwkNR4ftzXr4Ddn7+M3DUu5ZVrk=;
	b=HdYkEjoL/RMOzHrgvG71jGDlVqCog1Mr/4RHEY/PkuihdCHh7jXnJxD9NE5MvSZ6A2rOCf
	Hl22b31bWq2jCu99iSTMgrb/CAS4FZ1ZyKKYBg1PydtFNG+M4YdfX8nst3Pdl+NkBLFocz
	IFCWKAgalNaI/nIvpjzmK+6xSQFVL6Evd9oqTSKYElFMlFcSdn/9GoxFHm/9GtwDssvZRS
	GhQJoDHPn9efNo22euzs3Onfq5pNRyHOMlwmKZA4fsVcbuS4pSKcHnob3QFgUBbz8kANck
	ySxinyB3owp7mXBFnXiZGgMVRf9WMxJdcrCAPI99s5vdFqQoRgdyZRyWctECXA==
Date: Tue, 19 Mar 2024 20:38:49 +0100
From: Max Gautier <mg@max.gautier.name>
To: Eric Sunshine <sunshine@sunshineco.com>
CC: git@vger.kernel.org, =?ISO-8859-1?Q?L=E9na=EFc_Huard?= <lenaic@lhuard.fr>,
 Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH 3/5] maintenance: use packaged systemd units
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPig+cSWLoRdTgrrU2SBswnKr82L_BPCKtaP6atMyZVDAU=hpw@mail.gmail.com>
References: <20240318153257.27451-1-mg@max.gautier.name> <20240318153257.27451-4-mg@max.gautier.name> <ZfmAfIErHRZVbd49@framework> <CAPig+cSWLoRdTgrrU2SBswnKr82L_BPCKtaP6atMyZVDAU=hpw@mail.gmail.com>
Message-ID: <BA7F27C1-EFE2-47CD-B892-A3F4262394CB@max.gautier.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable


Le 19 mars 2024 18:17:27 GMT+01:00, Eric Sunshine <sunshine@sunshineco=2Ec=
om> a =C3=A9crit=C2=A0:
>On Tue, Mar 19, 2024 at 8:10=E2=80=AFAM Max Gautier <mg@max=2Egautier=2En=
ame> wrote:
>> I'm working on updating the test in t7900-maintenance=2Esh, but I might=
 be
>> missing something here:
>>
>> >test_expect_success 'start and stop Linux/systemd maintenance' '
>> >   write_script print-args <<-\EOF &&
>> >   printf "%s\n" "$*" >>args
>> >   EOF
>> >
>> >   XDG_CONFIG_HOME=3D"$PWD" &&
>> >   export XDG_CONFIG_HOME &&
>> >   rm -f args &&
>> >   GIT_TEST_MAINT_SCHEDULER=3D"systemctl:=2E/print-args" git maintenan=
ce start --scheduler=3Dsystemd-timer &&
>>
>> Do I understand correctly that this means we're not actually running
>> systemctl here, just printing the arguments to our file ?
>
>That's correct=2E The purpose of GIT_TEST_MAINT_SCHEDULER is twofold=2E
>
>The primary purpose is to test as much as possible without actually
>mucking with the user's real scheduler-related configuration (whether
>it be systemd, cron, launchctl, etc=2E)=2E This means that we want to
>verify that the expected files are created or removed by
>git-maintenance, that they are well-formed, and that git-maintenance
>is invoking the correct platform-specific scheduler-related command
>with correct arguments (without actually invoking that command and
>messing up the user's personal configuration)=2E
>
>The secondary purpose is to allow these otherwise platform-specific
>tests to run on any platform=2E This is possible since, as noted above,
>we're not actually running the platform-specific scheduler-related
>command, but instead only capturing the command and arguments that
>would have been applied had git-maintenace been run "for real" outside
>of the test framework=2E

Ok thanks, now I see why it's done this way=2E

>
>> >       for schedule in hourly daily weekly
>> >       do
>> >               test_path_is_missing "systemd/user/git-maintenance@$sch=
edule=2Etimer" || return 1
>> >       done &&
>> >       test_path_is_missing "systemd/user/git-maintenance@=2Eservice" =
&&
>> >
>> >       printf -- "--user disable --now git-maintenance@%s=2Etimer\n" h=
ourly daily weekly >expect &&
>> >       test_cmp expect args
>>
>> The rest of the systemd tests only check that the service file are in
>> XDG_CONFIG_HOME, which should not be the case anymore=2E
>>
>> However, the test does not actually check we have enabled and started
>> the timers as it is , right ?
>
>Correct=2E As noted above, we don't want to muck with the user's real
>configuration, and we certainly don't want the system-specific
>scheduler to actually kick off some command we're testing in the
>user's account while the test script is running=2E
>
>> Should I add that ? I'm not sure how, because it does not seem like the
>> tests run in a isolated env, so it would mess with the systemd user
>> manager of the developper running the tests=2E=2E=2E
>
>No you don't want to add that since, as you state and as stated above,
>it would muck with the user's own configuration which would be
>undesirable=2E
>

That makes things easier then :)

>> Regarding systemd-analyze verify, do the tests have access to the sourc=
e
>> directory in a special way, or is using '=2E=2E/=2E=2E' enough ?
>
>You can't assume that the source directory is available at "=2E=2E/=2E=2E=
"
>since the --root option (see t/README) allows the root of the tests
>working-tree to reside outside of the project directory=2E
>
>You may be able to use "$TEST_DIRECTORY/=2E=2E" to reference files in the
>source tree, though the documentation in t/test-lib=2Esh doesn't seem to
>state explicitly that this is intended or supported use=2E However, a
>few existing tests (t1021, t3000, t4023) already access files in the
>source tree in this fashion, so there is precedent=2E


I'll look into those=2E Thanks for all the info !

--=20
Max Gautier
