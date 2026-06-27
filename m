Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0423A7F50
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782569609; cv=none; b=kXOuBZZ9ebh9l7co5dBwE66fg4DtbpfjEpYkOAOA7U73awWjCSpB4xPnG47+i54OSNfRYk7WN2QCHMMgMYwb2pLjxYJ7Zx1ge67hdURe55ONcYPWXhD0SZmhwG7jYi9c9p+2cOjKPFrtqPhMjda8JzC/KcgCgUDb6d3vLt5MIY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782569609; c=relaxed/simple;
	bh=BPCGm0GxJHUMGWI6H2eaOzur3CQs9v2Eg0TlYNSTnuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=doI+vWkYe1IvS5770ipBuVxAdyz7KPub/vS4W+LNcy4FFPfvXY3T5YzekoYs2NOukZnhegColq5sVPTby6px+7MDdLcc60S3fjNrt0pWFy6vJTvcOH5vVai+m9DKn9V9zKRWl/EENkPPSDGGfaHH9aVI/1ZQpSeA66hfiKzNY98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=Coulhv6B; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=OgmP/0vr; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="Coulhv6B";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="OgmP/0vr"
DKIM-Signature: a=rsa-sha256; b=Coulhv6BMHrTGPOA2+JnIpod5WqbzQqCnAxHMOpOJ5unaWgV7KBY7am66q9D3YHtppis2hb26zCY2AoYWxt2SyeXt8vH9uo04jrW3qJjzxitK1X0/omeT2GUgpYlh7/0PN1Oy4efpC1+bRLrS5M49lqgvlxFMrGa+HIcrwhPxR4qmkVjjubf27EVFUWhwaFpO3NInwAghzrRyVAHzlBjiZe97ki+WrRNHJLAEVPWGQo163Ke5ogqy2Gh/yVyoE99833t7A1BudO+HkCBXrykj3+uCTG0d6xTiuKHCgngQDWb2hniWaBoOg/5NNpEYVdV7KHJBPYROh7TiWgc0Bjy4A==; s=purelymail2; d=malon.dev; v=1; bh=BPCGm0GxJHUMGWI6H2eaOzur3CQs9v2Eg0TlYNSTnuE=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=OgmP/0vrC73ppNfiazMFZYRzTGbY9nbYTy9wMasmX0xWcyiqVZTNru5CBgtX0j1d1DKcDPqFuyQ3nLLeXfBfaVNjGaeKng/dEqIzwFNdKcIJ9epnkdZ0xM/F5LMlKz8rLI2IR+XqOBOj9ahBLD3sVC3t3zVtcnnWeeC3sH+qB9fdhVrC1raRPeuf4bM1M9fdq2/2skDt6uB5lpTCp4ulNmlbUEHW8XpAvlq+tkYaqPYjzid32/SWnz7K4L1miY+lXdlUZ7sWM6q1BMyyKTu1/T4VHM9iAUbnDw2U+iuQnPzrNtZi8ANwkDuVZiTBT/ybMs7qK3AeFF/ZLNHwpvJU3g==; s=purelymail2; d=purelymail.com; v=1; bh=BPCGm0GxJHUMGWI6H2eaOzur3CQs9v2Eg0TlYNSTnuE=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1199534836;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 27 Jun 2026 14:13:23 +0000 (UTC)
Message-ID: <8a559dcc-43e9-46fa-93a1-08e360a3490a@malon.dev>
Date: Sat, 27 Jun 2026 22:13:16 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dir: encapsulate excludes_file lazy-load
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?=
 <szeder.dev@gmail.com>
Cc: git@vger.kernel.org, cirnovskyv@gmail.com,
 Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260626075037.532164-1-cat@malon.dev>
 <20260626075037.532164-2-cat@malon.dev> <aj7rtj9NsejqN357@szeder.dev>
 <xmqqldc1563l.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqldc1563l.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 6/27/26 05:45, Junio C Hamano wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>=20
>> On Fri, Jun 26, 2026 at 03:50:36PM +0800, Tian Yuchen wrote:
>>> diff --git a/environment.c b/environment.c
>>> index ba2c60103f..8efcaeafa6 100644
>>> --- a/environment.c
>>> +++ b/environment.c
>>> @@ -134,6 +134,13 @@ int is_bare_repository(void)
>>>   =09return is_bare_repository_cfg && !repo_get_work_tree(the_repositor=
y);
>>>   }
>>>  =20
>>> +const char *repo_excludes_file(struct repository *repo)
>>> +{
>>> +=09if (!excludes_file)
>>> +=09=09excludes_file =3D xdg_config_home("ignore");
>>> +=09return excludes_file;
>>> +}
>>
>> This function has a 'repo' parameter, which is not used in the
>> function at all.  This causes build failure when trying to build this
>> commit using DEVELOPER=3D1:
>>
>>    environment.c: In function =E2=80=98repo_excludes_file=E2=80=99:
>>    environment.c:137:51: error: unused parameter =E2=80=98repo=E2=80=99 =
[-Werror=3Dunused-parameter]
>>      137 | const char *repo_excludes_file(struct repository *repo)
>>          |                                ~~~~~~~~~~~~~~~~~~~^~~~
>>    cc1: all warnings being treated as errors
>>    make: *** [Makefile:2922: environment.o] Error 1
>>
>> Please make sure that all commits can be built with 'make
>> DEVELOPER=3D1'.
>=20
> Good point.  In this case, we can start with UNUSED in step 1/2 and
> then drop the UNUSED in the second step.  I wonder how harder to read
> it would become if these two patches are squashed together...

That makes sense. I think these two commits can be squadshed together...=20
I hope so.

>=20
> Thanks.

Regards, yuchen
