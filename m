Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB131D554
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689690; cv=pass; b=SRZaaq7B81LwCMtDeZLBLqxRAMvsKA5ZMATqg39xuffciTYUoG1d6tDSGc/4WBKOzQ0jyQl5Lc3/1yrQm2tITyXL6ZDcgyb20Nhr86juHfkTSMI9QSyFds231Zgaz4i4IespGuIPOuZaSNysTidmn4jwOXwG93NIT8uSH2bT+2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689690; c=relaxed/simple;
	bh=XxQd5asea5ubp1NbrrcT9x9eIbP1FJqu2Gs2iyzdJGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rUSOGaKdBarAovRG2ydNgJANnyuB5cQabZvVtFaauNbU/slIm34REzzqpJJVqK6Mowy1VAVqkNqNEijQHH8cFbE+8jpB/gZtfOLVkc0Xa88p7uYc8m7i7S9l0CUorDiL7G9YHm6wf/YJipbA7i7+3HeAc27BJnzkmij0FL9lejU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=CpqyNKQ4; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="CpqyNKQ4"
ARC-Seal: i=1; a=rsa-sha256; t=1760689675; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=l7cGIdtuBHDhqH2X7fptuKMyBlylWHFlCspnPvF9zmlUxbCMi87zNvd9DnCtjz8PVT006XV//WktKfNiQhl3DG8tTIncOgHuPBqp6I9Dql5ws1Mz7PE1ntBD3/1JGQnF8fU6OYnVmz1NTubjV6NzXKHBY/YZjGZH5OAFpiybuMI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760689675; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GmuJaivxU1GhHs/RbHz8JxKl2ciNUyixoNSV+oZebT8=; 
	b=QDlcICDAz4aOhZT8VQCv9ynJWuAVih/H4cauuxuLXA3ExTsDZNYAdaKhDkcv3Rcg8uvRen3g5FE1G2pAEB5OPdpLP8XrqD6APcJXleUw9ytILMibtcivxbLnis6zfykAR0uX5oB+aQ5lDHbEUonCmIqdxfesRNMxW0o02dq85Do=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760689675;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=GmuJaivxU1GhHs/RbHz8JxKl2ciNUyixoNSV+oZebT8=;
	b=CpqyNKQ4071ryauOtwyjiS2Ej5W9rTCMi4inZ9bo18Nyh3OSrOZMZ+BRCO+hGucc
	7sfDta0SsUiOjgI0eJBlchaRPV6X1xZxRIM8Fj3r/CTlnNCUOR17RB+ig0CKj2MItG0
	f6l3T0+7O9+DOHF9obh6DNfkcpm9YOdF7TloOIdo=
Received: by mx.zohomail.com with SMTPS id 176068966890966.01486940204302;
	Fri, 17 Oct 2025 01:27:48 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org, Rodrigo Damazio Bovendorp <rdamazio@google.com>,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Josh
 Steadmon <steadmon@google.com>, =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 08/10] receive-pack: convert 'update' hook to hook.h
In-Reply-To: <CAJoAoZ=HRKjjU-N6y+kHo6vpOY6jN4Q7nDdDRpT=cv0k0PtxGg@mail.gmail.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20250925125352.1728840-9-adrian.ratiu@collabora.com>
 <CAJoAoZ=HRKjjU-N6y+kHo6vpOY6jN4Q7nDdDRpT=cv0k0PtxGg@mail.gmail.com>
Date: Fri, 17 Oct 2025 11:27:37 +0300
Message-ID: <87bjm6szk6.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hi Emily and sorry for the delayed response

On Fri, 10 Oct 2025, Emily Shaffer <nasamuffin@google.com> wrote:
> On Thu, Sep 25, 2025 at 5:54=E2=80=AFAM Adrian Ratiu=20
> <adrian.ratiu@collabora.com> wrote:=20
>>=20
>> From: Emily Shaffer <emilyshaffer@google.com>=20
>>=20
>> This makes use of the new sideband API in hook.h added in the=20
>> preceding commit.=20
>>=20
>> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>=
 ---=20
>>  builtin/receive-pack.c | 60=20
>>  +++++++++++++++++++++++++++++------------- 1 file changed, 41=20
>>  insertions(+), 19 deletions(-)=20
>>=20
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c=20
>> index 1113137a6f..d5192ce132 100644 ---=20
>> a/builtin/receive-pack.c +++ b/builtin/receive-pack.c @@=20
>> -939,31 +939,53 @@ static int run_receive_hook(struct command=20
>> *commands,=20
>>         return status;=20
>>  }=20
>>=20
>> -static int run_update_hook(struct command *cmd) +static void=20
>> hook_output_to_sideband(struct strbuf *output, void *cb_data=20
>> UNUSED)=20
>>  {=20
>> -       struct child_process proc =3D CHILD_PROCESS_INIT; -=20
>> int code; -       const char *hook_path =3D=20
>> find_hook(the_repository, "update"); +       int=20
>> keepalive_active =3D 0;=20
>>=20
>> -       if (!hook_path) -               return 0; +       if=20
>> (keepalive_in_sec <=3D 0) +               use_keepalive =3D=20
>> KEEPALIVE_NEVER; +       if (use_keepalive =3D=3D KEEPALIVE_ALWAYS)=20
>> +               keepalive_active =3D 1;=20
>=20
> This hook wasn't using the keepalive at all before, right?=20
> What's the reason to use it now? I am worried it might be going=20
> to a sideband consumer who wasn't expecting it because it's not=20
> documented in githooks.=20

Indeed, I just picked this up from the branch I'm basing my work=20
on [1] and haven't thought this through enough in v1. There was no=20
keepalive before the hook conversion and really there should not=20
be any need for it AFAICT (it's a short lived hook).

You raise an excellent point about the behavior change, so I'm=20
inclined to remove it in v2. I will obviously test to confirm=20
before posting v2.

[1]=20
https://github.com/steadmon/git/commit/6d80376bea4e476b1af1d8649fe054cdfd92=
95dd
