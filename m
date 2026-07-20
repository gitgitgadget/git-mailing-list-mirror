Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7C33D1CB2
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538812; cv=none; b=jdYKtRwds+nDfNKGbaOzTa/h+yTt0+gSBuOacib8lQ+6JCFUDO3NwLyBXPNcwbVUl9jtwiyJLt1g0o2qqNDijmmXK4VwAldV37WvCH4im96aye/mbUKvekxbzju8tcCME9VL04GdW7pnNdHtjrpUEDTQE6ofBRVMrC14zk3soHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538812; c=relaxed/simple;
	bh=ViNFt6n9WzS23EAgrK2uOTJCQzV3L6Ef1VDVH5EOyGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iu+yGrW8XRU2OPRSgNlcjjjAQBxYPOmdl5Ayku9DEoWH5/W0lK8kixc1lSLX2bZxeBIn/txY+MzMnIKoPNhNCKrbVQXCTWwS7es91XzLvLQnUIhJym+irJ26kO6mBxsmLTNaDY3n6EMGzfkkaCiVQk980N0/wolRx88nwap5NG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=jpwZpbgF; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=W6VK3mj4; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="jpwZpbgF";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="W6VK3mj4"
DKIM-Signature: a=rsa-sha256; b=jpwZpbgFdrF78qPqrGpeiZz5d7boYOsgLW2am4fr4BNSKhEeKl1yM+lJP5CtqgIgmV1t4WqASI9mbARnES6OVjY72ExADPngt8e1jxgn76LV2VDYo1Nl7x1x9cBuWdpy/T2st8cUg1MXOhyKc6u7aUAGszoMG2Hdve5PaqFe/vyzz+dcEEraD1ngA/DbsuiNj4V9fVfe/jkoJEn7auvDGQYzKmznID8ST4Wez6F9pNz4zCibgXt0+fzaQv/anWCyaOZDHhLx62qe5bXsgTHLLlsleXi98+pho0ij3DE6Xu+1FK7emv6bp9pXXHoPDixf1cxozb1EtJq6AECR15QU6g==; s=purelymail2; d=malon.dev; v=1; bh=ViNFt6n9WzS23EAgrK2uOTJCQzV3L6Ef1VDVH5EOyGg=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=W6VK3mj4TpgLL6VXMQCeuYWc9ta7DsS6z5wptPY3BkTD7Prtqti1gfghUknTnouaCCKcMe+LzqsGfATdy54tlIfUc4tC3dQWEhLPxLzFK864KtaIe2oNpSBXbHVxvcjLIkInvbur3F+0chlkIrZ5Ly9Wlm9r6YBMP+xG0lJ+1KEPO7sX9wAm2SEfI8+W4b1gTZaynZOzmaCHpKeWjpj/TlsUVyZDbgfva+nWHdwwJk8Ms2vMoEdzh3/u9wHVvJFlM/JzA3S5a3xO/x4Ly9OO9KrUTsW+ruMZeXDxCC041FD0y/YGMBgGdLtLPL/Nvc0ta1FgQsehigGDz7qiTMfaBA==; s=purelymail2; d=purelymail.com; v=1; bh=ViNFt6n9WzS23EAgrK2uOTJCQzV3L6Ef1VDVH5EOyGg=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1905825058;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 20 Jul 2026 09:13:23 +0000 (UTC)
Message-ID: <8b9528b8-198b-489f-8f0e-fbd0c7d07b64@malon.dev>
Date: Mon, 20 Jul 2026 17:13:17 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] read-cache: pass 'repo' to 'ce_mode_from_stat()'
Content-Language: en-US
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im,
 Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260716084941.1101918-1-cat@malon.dev>
 <20260717063559.1633567-1-cat@malon.dev>
 <20260717063559.1633567-3-cat@malon.dev> <alvNq8rXF/jofqUc@szeder.dev>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <alvNq8rXF/jofqUc@szeder.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 7/19/26 03:02, SZEDER G=C3=A1bor wrote:
> On Fri, Jul 17, 2026 at 02:35:57PM +0800, Tian Yuchen wrote:
>> The ce_mode_from_stat() function is a performance-critical static
>> inline helper in 'read-cache.h'. As we migrate configuration
>> variables into the repository struct, this helper needs access
>> to the repository context.
>>
>> Update the signature of ce_mode_from_stat() to take a 'struct
>> repository *' parameter, and update all callers to pass the
>> appropriate repository instance.
>>
>> To prepare for the overhead of replacing cheap global variable
>> accesses with getter functions, the boolean expressions are
>> reordered to evaluate 'S_ISREG(mode)' first.
>>
>> While at it, add a comment for ce_mode_from_stat().
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
>> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
>> Signed-off-by: Tian Yuchen <cat@malon.dev>
>> ---
>=20
>> diff --git a/read-cache.h b/read-cache.h
>> index 043da1f1aa..94b8d3e547 100644
>> --- a/read-cache.h
>> +++ b/read-cache.h
>> @@ -4,15 +4,24 @@
>>   #include "read-cache-ll.h"
>>   #include "object.h"
>>   #include "pathspec.h"
>> +#include "environment.h"
>>  =20
>> -static inline unsigned int ce_mode_from_stat(const struct cache_entry *=
ce,
>> +/*
>> + * Determine the appropriate index mode for a file based on its stat()
>> + * information and the existing cache entry (if any).
>> + *
>> + * This function handles degradation for filesystems that lack
>> + * symlink support or reliable executable bits.
>> + */
>> +static inline unsigned int ce_mode_from_stat(struct repository *repo,
>=20
> This new parameter is not yet used in this function, which causes
> compilation errors in all source files which include "read-cache.h"
> when trying to build this commit using DEVELOPER=3D1, e.g.:
>=20
>        CC pathspec.o
>    In file included from pathspec.c:11:
>    read-cache.h: In function =E2=80=98ce_mode_from_stat=E2=80=99:
>    read-cache.h:16:65: error: unused parameter =E2=80=98repo=E2=80=99 [-W=
error=3Dunused-parameter]
>       16 | static inline unsigned int ce_mode_from_stat(struct repository=
 *repo,
>          |                                              ~~~~~~~~~~~~~~~~~=
~~^~~~
>    cc1: all warnings being treated as errors
>    make: *** [Makefile:2921: pathspec.o] Error 1
>        CC preload-index.o
>    In file included from preload-index.c:16:
>    read-cache.h: In function =E2=80=98ce_mode_from_stat=E2=80=99:
>    read-cache.h:16:65: error: unused parameter =E2=80=98repo=E2=80=99 [-W=
error=3Dunused-parameter]
>       16 | static inline unsigned int ce_mode_from_stat(struct repository=
 *repo,
>          |                                              ~~~~~~~~~~~~~~~~~=
~~^~~~
>    cc1: all warnings being treated as errors
>    make: *** [Makefile:2921: preload-index.o] Error 1
>        CC read-cache.o
>    In file included from read-cache.c:34:
>    read-cache.h: In function =E2=80=98ce_mode_from_stat=E2=80=99:
>    read-cache.h:16:65: error: unused parameter =E2=80=98repo=E2=80=99 [-W=
error=3Dunused-parameter]
>       16 | static inline unsigned int ce_mode_from_stat(struct repository=
 *repo,
>          |                                              ~~~~~~~~~~~~~~~~~=
~~^~~~
>    cc1: all warnings being treated as errors
>    make: *** [Makefile:2921: read-cache.o] Error 1
>=20

Nice catch.

> I think the new parameter should be marked as UNUSED in this patch,
> and then the UNUSED should be dropped in the next, where you start
> using the parameter.
>=20
>> +=09=09=09=09=09     const struct cache_entry *ce,
>>   =09=09=09=09=09     unsigned int mode)
>>   {
>>   =09extern int trust_executable_bit, has_symlinks;
>> -=09if (!has_symlinks && S_ISREG(mode) &&
>> +=09if (S_ISREG(mode) && !has_symlinks &&
>>   =09    ce && S_ISLNK(ce->ce_mode))
>>   =09=09return ce->ce_mode;
>> -=09if (!trust_executable_bit && S_ISREG(mode)) {
>> +=09if (S_ISREG(mode) && !trust_executable_bit) {
>>   =09=09if (ce && S_ISREG(ce->ce_mode))
>>   =09=09=09return ce->ce_mode;
>>   =09=09return create_ce_mode(0666);
>> --=20
>> 2.43.0
>>

But 'USUSED' cannot be used here since the corresponding header=20
(git-compat-util.h, or more specifically compat/posix.h) is not included.

Can we write..

=09(void)repo; /* TODO: use this parameter in the next patch */

..to keep it simple?


Regards, yuchen
