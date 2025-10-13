Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619081EB9FA
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366863; cv=pass; b=FTBBF/8UVWVc35vk2YMwhzk4s0xhvf8Rqa1h9qP0uKmU/Zhxz9rl5Jvmn9MIML3MNGdsWeMOIqxTB4Cqk36iQJ+TMho3gAaj74w9Z3IWk+v4K/53Dy/Re5Jh/7ft6518P6q7STHs5WLpFGPO87Zm+b0sygOiKmv43u4zmMokXWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366863; c=relaxed/simple;
	bh=y8SXlErD35wvSLcn61QyHsVTGbXW0/FeLR6UPAX5cbg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J7eWoaWJwJAiHbk9TEmbr0fr2XXeIWZQrT9zxGorBRVPDSeGACHhmp+HfbWhEyksrQUg51Sjrl54Fun15YJAuS5HoN/E7KoEAGHlltBbMmL+fkLsLUM5Ed/CXMIUpM5Vf+p2+LMQVbi8HLOlCFCgVwdZ9mHJSsN0lJFLAv5aC4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=O5MoCV6S; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="O5MoCV6S"
ARC-Seal: i=1; a=rsa-sha256; t=1760366851; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=agFrOdGqG8okONT/n76OIp/qmBRlU2mnHyltyN/9Cksv351+1EtKRu789a6sZft1KaQfzbbZU9HObgkL2pihcnrCbIlkho2j03rCFSN215Ezdl8aLEM1MxwCkFxfB2+yuFreltHnEyS1n/B17UvNS2HZokVyDg/8yoMRJu1JaIc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760366851; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0D8iqToU31CA+oxNhcF+O39zfdNHPcumvqRr0HY0AzU=; 
	b=OsG+mgQ0a9ESKR14YyHaoPZT3c20dW1a8dOUJx6l1qL1Jm2ZvXzDIlGqXZ4nGduhYLRrqgWbTCZUW8GECVfcRJpyxJDNPsULr49CWaqvWlWe8gba6w+xvqAZpZFE+EC3iSz9UlhLXE1dOE53wRQe651mc+ON70oPkn5d40vTmIE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760366851;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0D8iqToU31CA+oxNhcF+O39zfdNHPcumvqRr0HY0AzU=;
	b=O5MoCV6S3iAcuMYYHh1X3rTankSnFfUazQNTOCKTeboTaQYybbcv/Ae7MJEmnOE4
	Ac0IEa8heiqP4kLeOwiNDb2b4YtY0f+UvoSVw/igPqhiCNQU0y8sa65ivsYzlZcRuks
	2NbCgj5C48sMkaJ9X0APyW3B9+916EWUnb2oyino=
Received: by mx.zohomail.com with SMTPS id 1760366846545459.86323715093874;
	Mon, 13 Oct 2025 07:47:26 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org, Rodrigo Damazio Bovendorp <rdamazio@google.com>,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Josh
 Steadmon <steadmon@google.com>, =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 02/10] hook: provide stdin via callback
In-Reply-To: <CAJoAoZm6uNtEoo_tdbqjGMSj4OnQuFesxt_iyOTgNHA1LX3iwQ@mail.gmail.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20250925125352.1728840-3-adrian.ratiu@collabora.com>
 <CAJoAoZm6uNtEoo_tdbqjGMSj4OnQuFesxt_iyOTgNHA1LX3iwQ@mail.gmail.com>
Date: Mon, 13 Oct 2025 17:47:17 +0300
Message-ID: <87o6qag8p6.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On Fri, 10 Oct 2025, Emily Shaffer <nasamuffin@google.com> wrote:
> On Thu, Sep 25, 2025 at 5:54=E2=80=AFAM Adrian Ratiu=20
> <adrian.ratiu@collabora.com> wrote:=20
>> diff --git a/hook.h b/hook.h index 11863fa734..8fdbc8c673=20
>> 100644 --- a/hook.h +++ b/hook.h @@ -1,6 +1,7 @@=20
>>  #ifndef HOOK_H #define HOOK_H #include "strvec.h"=20
>> +#include "run-command.h"=20
>>=20
>>  struct repository;=20
>>=20
>> @@ -37,6 +38,24 @@ struct run_hooks_opt=20
>>          * Path to file which should be piped to stdin for each=20
>>          hook.  */=20
>>         const char *path_to_stdin;=20
>> + +       /** +        * Callback to ask for more content to=20
>> pipe to each hook stdin.  +        * +        * If a hook needs=20
>> to consume large quantities of data (e.g. a list of all refs=20
>> received in a +        * client push), feeding data via=20
>> in-memory strings or slurping to/from files via path_to_stdin +=20
>> * will not be efficient, so this callback allows for piecemeal=20
>> reading and writing.  +        * +        * Add initalization=20
>> context to hook.feed_pipe_ctx.  +        */ +=20
>> feed_pipe_fn feed_pipe; +       void *feed_pipe_ctx; + +=20
>> /** +        * Use this to keep internal state for your=20
>> feed_pipe_fn callback.  +        * Only useful if you are using=20
>> run_hooks_opt.feed_pipe. Otherwise, ignore it.  +        */ +=20
>> void *feed_pipe_cb_data;=20
>>  };=20
>>=20
>>  #define RUN_HOOKS_OPT_INIT { \=20
>> @@ -44,6 +63,9 @@ struct run_hooks_opt=20
>>         .args =3D STRVEC_INIT, \=20
>>  }=20
>>=20
>> +/** + * Callback data provided to feed_pipe_fn.  + */=20
>=20
> It looks like this comment was maybe a note to yourself? (Or a=20
> note to myself, eons ago?) But hook_cb_data is used in all the=20
> parallel hook callbacks, not just feed_pipe_fn, so I don't think=20
> this is accurate.=20

Nice find! I added the comment while initially understanding the=20
code and yes, hook_cb_data is more generic than just its use in=20
feed_pipe_fn.

Will drop it in v2. Thanks!
