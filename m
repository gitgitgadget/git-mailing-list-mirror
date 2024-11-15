Received: from aib29agh122.zrh1.oracleemaildelivery.com (aib29agh122.zrh1.oracleemaildelivery.com [192.29.178.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B9518DF7C
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 22:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731708563; cv=none; b=gOgFDmITJOCN7lBxNM8t/uSwsKLc7ixcVly1AROhhlyymYXSmaETWxQvsowdQqgAY5WXxGAoIca8Mks/EiYNrSHw3gKTkMn2O3XyY0/wKUyFxofcrP6SlweIw+9AuIQXwFcZjArKlDLj1+OXRBJ3Xu6UVMTcQ/MprxSQTCz93cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731708563; c=relaxed/simple;
	bh=Hp/4s0scyOS1y/I6d440qbT6bmFlh20QtLQkg1wWTAQ=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=j/UHvawIudsru1kU2tL7UN5f++P04xkI5FBSiP0gBtryvzcaKNOA57SGcHKZPyoAoIOy0FMlUHYMdDHfuaLlS7DNJ7ZbIFdeIOZogeRNb2Lkz4XuuvSxulKO7fEpg9b7IToPqHRxmz9WJoQ3FQ7ons1pJHpbSeofybXPGxSRTzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=eSmQ0hxv; arc=none smtp.client-ip=192.29.178.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="eSmQ0hxv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=Vmwxn8ObAUVa3TP47O0C4JvhrtxX0XOhf6HCbfcDG1Q=;
 b=eSmQ0hxv4U+EaPufeKXsKPSw3ct94Ai3CaB+9jOZqqP2cVXf3ElfR7Gtb+5GMTvUhEHgtDk1LyPp
   JaPDFyWawUJ+jYVWCc/qG6IcVzWH9+el4dkL2qCCOj+3otvCEX5CfYAgo+CrqLlr4YKdeAMnuXLn
   nVza/tfHiwUMRxU2azz2TtrFYJMaC697KbuFHkOBJNrd3filk4Wd0vhEofzwdImHgSjA1qUyRBeT
   OysgPd4ckrWbN0B2Koa/cHGZC8eZSGvlipDQn16oSRKyM4A+aTAjDjN5SqEYXkLZWWDYCanPKkO8
   3QNVbU9sr02G8GY+gXX+f9BolIT2gHmHiy3nqQ==
Received: by omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN000N5YIN0RK30@omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 15 Nov 2024 22:04:12 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Fri, 15 Nov 2024 23:03:44 +0100
Message-id: <D5N3BZOUUFPH.CV9OQ54BVYK@ferdinandy.com>
Subject: Re: [PATCH v12 1/8] t/t5505-remote: set default branch to main
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>, <karthik.188@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>, <ferdinandy.bence@ttk.elte.hu>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241023153736.257733-1-bence@ferdinandy.com>
 <20241023153736.257733-2-bence@ferdinandy.com> <xmqqfrnt3xpd.fsf@gitster.g>
In-reply-to: <xmqqfrnt3xpd.fsf@gitster.g>
Reporting-Meta:
 AAH5dsURVtkRltt7fHCtA9v9yRgPK8NK+EwGIdE3brWl3hpDY6A4kL5ri9dUovbX
 3xt0SWfdG2mB2IkGsF5HZEPDX+JhLMXbvVc6kfp8ge0DzvH/JTfvxHWwmmiBDx3o
 3eS6kXcKFgoiy+1vmuIw2+rwSoZH00s5je8N1Lc8quVQNgIK2n96EiK3qBYOialS
 hxLFXMh990DKfNryPVQLeblBK69SAT56eUyJbN3KS/x1uBSnRak/t4fMDq+uc8et
 WUTVAZlnNp5pmppGKswzFfuZHn6Xr//ajsHTD1va1WWwhh7IykFkT4TD/MnyZuPQ
 gdax0PGNCtEWOLjj1EV1+mH5ok9mYmN6NQB83CvMErTeiIp+IpYo9G/n1F6oSP2a
 gM4G4oOjfAQrMT3M6G5WVkC4vMRAhVclEI+rU7wVv0/kgICHLvMkU6nBgt8tHg8f
 CZ4nCWW8uASReu7+AH5C5un1IvphU/TqL69CZdjdQamYBHaz6lmkqkg=


On Fri Nov 15, 2024 at 05:52, Junio C Hamano <gitster@pobox.com> wrote:
> Bence Ferdinandy <bence@ferdinandy.com> writes:
>
>> Consider the bare repository called "mirror" in the test.  Running `git
>> remote add --mirror -f origin ../one` will not change HEAD, consequently
>> if init.defaultBranch is not the same as what HEAD in the remote
>> ("one"), HEAD in "mirror" will be pointing to a non-existent reference.
>> Hence if "mirror" is used as a remote by yet another repository,
>> ls-remote will not show HEAD. On the other hand, if init.defaultBranch
>> happens to match HEAD in "one", then ls-remote will show HEAD.
>
> Making sure that the hardcoded (in the Git binary) default branch
> name would not affect the outcome of the test is a good thing to do.
> I like the patch text, but ...
>
>> Since the CI globally exports GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmai=
n,
>> there's a drift between how the test repositories are set up in the CI
>> and during local testing. This issue does not manifest currently, as the
>> test does not do any remote HEAD manipulation where this would come up,
>> but should such things be added, a locally passing test would break the
>> CI vice-versa.
>
> ... this description may not quite be accurate.  Don't some jobs of
> CI use 'main' while the rest use 'master'?

True, it's that one specific job, and of course "there may be a drift depen=
ding
on the particular test" is more accurate. I'll update for a v13.

