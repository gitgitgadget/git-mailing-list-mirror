Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F11E39AD51
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542369; cv=none; b=t2L+Fa7RkOCaPbg2dLuHp1ypXFijpsRQIYQ9RzWxq6pAWtB0Spg/0byaADzNbOSoJyMkSi1jN/ulRR+9hKI8Df6gHurRTgovs294HiG3y2YMpfrLk2OZngeYvLw7wNokA/JLLqFOvC07u6r/cJrPgUC4vymZZR4bpysRYGxjVKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542369; c=relaxed/simple;
	bh=ajl+bJKOnRQno4Y9hWZrKoAOjs3A5ut4Pi0m2zI4B9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bkt1flglVhymKYG2YwlbVGUK1akz4rpOu//3AEH3E237xnk9Fs13s4Yd+3QihYOyEe9HFxa51SKwcTW4yb/N6BN6GxJHrr2YyeOh1hXdN0S+/DwkIBXyvMAEzz45GDS0Dz30DJ6tnI1OJ7RSqO8fyziedZZqeTBGE0ONIBV46Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=qAh8vsUH; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=VYpAaZAk; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="qAh8vsUH";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="VYpAaZAk"
DKIM-Signature: a=rsa-sha256; b=qAh8vsUH6wT0uPXUWv04O+SfsQDnucFuZJ2LHgmBpB/XloEEJ65bS7WnXX3Mi5YmoQRcIlFaF+vITVL12+iY/CAFhA+liQic+IYHh6gLc/fZ7mBcWdLBtTIP3GNhobft2d7Gb/nvkyBGwPzT/ig/og4+cT1vXiQqwjA6nygDcMJLnnBuMlQAiZrNAcrCvYUmjGADGe4SEJIuz48QXfmp6R/EGX6AZkcVx7/N56+YwttxxhiTfdHY8fuCZVr7fU9FjdQ01YjLqWAHsZM+9uB/sxIPBSlWn5QEXGx6huNZwVM1TpqtnHCN6+sQ1xthaZe04bQjm9PErWb8RFiMs7/D/w==; s=purelymail2; d=malon.dev; v=1; bh=ajl+bJKOnRQno4Y9hWZrKoAOjs3A5ut4Pi0m2zI4B9A=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=VYpAaZAko4wdIJTo1qOjkWusfv4KtDwaxQ9pe73O++4D0uTiDCDgxGJZr2r7GiPaqXYUq9CYEnPMLLCslyHdnlMk52O5dTx4Ss4nMNkSmNJ65z2698SB3FGFgYkTAnkIUqEH+VMwPlhhjGZuCEIjxxv9p+WcXVVq2v6hJGByBPPbAURM2wfybubwCWPxrY4neR0Qr6OvVE+Fv/LTYlDuESt5gSGQxMkNsUEqvmrh8b6F1i8ff/KeMoP2naxAkQHM4b6eg7ESpFeW/QWr8W23OgtSCW3+ReCF/bW1ifPPcW5cK19ifLvTX519dRs68ej2r4NY8jmVLj+4lyGl24MwAQ==; s=purelymail2; d=purelymail.com; v=1; bh=ajl+bJKOnRQno4Y9hWZrKoAOjs3A5ut4Pi0m2zI4B9A=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2113826742;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 20 Jul 2026 10:12:35 +0000 (UTC)
Message-ID: <6407614a-156b-40e1-bf70-e54ce84427ad@malon.dev>
Date: Mon, 20 Jul 2026 18:12:30 +0800
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
 <8b9528b8-198b-489f-8f0e-fbd0c7d07b64@malon.dev>
 <al3v0NVZJYS9SVZF@szeder.dev>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <al3v0NVZJYS9SVZF@szeder.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 7/20/26 17:52, SZEDER G=C3=A1bor wrote:
> On Mon, Jul 20, 2026 at 05:13:17PM +0800, Tian Yuchen wrote:
>> On 7/19/26 03:02, SZEDER G=C3=A1bor wrote:
>>> On Fri, Jul 17, 2026 at 02:35:57PM +0800, Tian Yuchen wrote:
>>>> diff --git a/read-cache.h b/read-cache.h
>>>> index 043da1f1aa..94b8d3e547 100644
>>>> --- a/read-cache.h
>>>> +++ b/read-cache.h
>>>> @@ -4,15 +4,24 @@
>>>>    #include "read-cache-ll.h"
>>>>    #include "object.h"
>>>>    #include "pathspec.h"
>>>> +#include "environment.h"
>>>> -static inline unsigned int ce_mode_from_stat(const struct cache_entry=
 *ce,
>>>> +/*
>>>> + * Determine the appropriate index mode for a file based on its stat(=
)
>>>> + * information and the existing cache entry (if any).
>>>> + *
>>>> + * This function handles degradation for filesystems that lack
>>>> + * symlink support or reliable executable bits.
>>>> + */
>>>> +static inline unsigned int ce_mode_from_stat(struct repository *repo,
>>>
>>> This new parameter is not yet used in this function, which causes
>>> compilation errors in all source files which include "read-cache.h"
>>> when trying to build this commit using DEVELOPER=3D1, e.g.:
>=20
>>> I think the new parameter should be marked as UNUSED in this patch,
>>> and then the UNUSED should be dropped in the next, where you start
>>> using the parameter.
>>>
>>>> +=09=09=09=09=09     const struct cache_entry *ce,
>>>>    =09=09=09=09=09     unsigned int mode)
>>>>    {
>>>>    =09extern int trust_executable_bit, has_symlinks;
>>>> -=09if (!has_symlinks && S_ISREG(mode) &&
>>>> +=09if (S_ISREG(mode) && !has_symlinks &&
>>>>    =09    ce && S_ISLNK(ce->ce_mode))
>>>>    =09=09return ce->ce_mode;
>>>> -=09if (!trust_executable_bit && S_ISREG(mode)) {
>>>> +=09if (S_ISREG(mode) && !trust_executable_bit) {
>>>>    =09=09if (ce && S_ISREG(ce->ce_mode))
>>>>    =09=09=09return ce->ce_mode;
>>>>    =09=09return create_ce_mode(0666);
>>>> --=20
>>>> 2.43.0
>>>>
>>
>> But 'USUSED' cannot be used here since the corresponding header
>> (git-compat-util.h, or more specifically compat/posix.h) is not included=
.
>=20
> UNUSED _can_ be used here, because:
>=20
>    - This is a header file, so it's not supposed to be compiled on its
>      own.
>    - All C source files including this header file must start with
>      including "git-compat-util.h", so by the time they include
>      "read-cache.h", the UNUSED macro is already defined.
>=20

I see.

Thanks, yuchen
