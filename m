Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9073F333727
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770641589; cv=pass; b=q/2TbqEO8RAE424joZINig//hdFYH4onfwqpHWRX+OjmUr0cPvHa0+s/AeNhxkoI9sNfXQ17ZtKmV9hRpXEDn/SbUVKg8ZHJu2udgPhDb+EVzlzekmJsnvmESSFva3Dse8l9yz+sUkokt0JHS4jHaS+tMJIHGKPBE5I8hdyXy2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770641589; c=relaxed/simple;
	bh=hWscWHuh5an6o+ov+8nd2nDcvUi6fwwTmH8e3ASVir4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slbDE1wYd+GKQMr2LeZzBcb5jFmBDK59ivlF0q3MEP2S2xyyI9N1GfWvZdyIxfHSp72eVATSWEOAQcNnY/w5fb3KKO0qktyYb2RUBb/4vtM7c5VfPkPrvUi3VMvd7/Ckf61wA9WK5GnlPRk5Q3raP8TLBExzlOOe1WkSBIUW18w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsxrXPtC; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsxrXPtC"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5fadd5d4319so2525202137.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 04:53:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770641588; cv=none;
        d=google.com; s=arc-20240605;
        b=LhTKuw1tp90pCTzN6n6iayHC5jVIQYkDWIeFSxX14S/JHqcK3XZri/6gxSuV5OsNSm
         JdpQdNbGEv4iLq4OgDwUo9mMife6aQIJptcHKe4e5PFEtUxHW0/WXhlTIzCDLxNl3vTU
         zubb0SR7Tf9kk+k7fR8lant57aE/TcbjEIlU07y8E8pStu30eALgKzCdcGyftwCcqnML
         4gmi9kpkTP0n5/JFL7vWiSdVJlCMnBKqQWF5SCx5fi6usTVQ0TzeS7jflobcEdPFYOet
         IawdcWPJ7p36pQIoF/u6Kv9o0IVxfUT1EXaCsiFLsvKzRX0HPLXCQ/0g7zbGxU/pZ700
         Oa0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=b067BdbIWmf1slrnF3XlwrN5QgYscCTE6IksEyFJbn8=;
        fh=BAAT8bCJLIlrBBeJp2AoJJoiiM/MhVeWVRRlpSQQL8M=;
        b=F2O34VN7uebs+F4gkc5LkekqUMZv+YN6Jz7PzuqI9q4xQLrVJLKr12R3Gp5SiZx57c
         +2zZ9bL2A8CTRjpR7IqmLI4fr195mNsgqohecroRxNxFFHbgMT0ZGvQJh7C2DqLMUbzo
         z2devp2HDG1cpQ1JXFKlzzsx8ezbJ2aUni8AM7kZa7s3MIjSGKyggjFNJctfayzQeKoN
         cBaG43IyV8m+c9rx13D7cGYQ3kNqaOeIWzfYDN++Ig+Z42FDHauIt719eZ0R2WfDB5sU
         QMO7oCe2/SYB7Fl2p7LqXoOBvrimyaJgOubnq1uojsLUI/iAcF6ify/SWI1hfVDWTyzR
         buOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770641588; x=1771246388; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=b067BdbIWmf1slrnF3XlwrN5QgYscCTE6IksEyFJbn8=;
        b=PsxrXPtCjMtEf4prxGPjoGVXax1WVZbiENGzOsFLKZhCEV9Y/v8YCeJH0/sfJKAy0F
         Yr/aPexsgGyqv2za/BVzVDJzJLCKA72KdXoET4zcXF5ET0/ZW8Z2BAY26IvvYduIpucp
         0ANPqpODUZqNKHeW4V/IyAASZj/A0S3EH52JbQYrhk2Dq1lFIDFxSfYoBZcWMqOmp2+d
         DOvZa3l7rjCnPgSMsQ8BwmDN8FXgl4QwbkutCO94uCNHi+WodpwUF/rZACZ5nRohBHfA
         Os2X16H/wqgTXj52vAYt12WSnGOQx4Gk1nCIz0rSej4qxClDkTxT24Xc0s0UrkRYARch
         rakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770641588; x=1771246388;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b067BdbIWmf1slrnF3XlwrN5QgYscCTE6IksEyFJbn8=;
        b=PfHjneMuclsHh1RgVrl0JdfClsRE5fzf9KZDa3BdgPUm3W492p5W9Dv5uer9169IMz
         OEIZz9/gquN0i4D2rM//10TRy0peVf5CNv9oKhaZkvkat/B6Ml3bBJWr4uiMZ+G3f6bp
         h9q6oQsIFs71hs6DmK6Cz5u9QuC4/atScAFYO5+6im5/8WUeRwRW6z6R78PKK273b2vr
         exgGcU8fW+HPu6FZMpheEqFhw3IjL15lAdx8fQXDCeBgZT9se4X1BU89dNhhiwbj0Lki
         pG6V2vCVHFLdTP557A+F52c7uxX/vKtRYHHXs16W/k1nm56N+jz07YoUd3urp76rEcYl
         N+2w==
X-Gm-Message-State: AOJu0YyRJlUzhkwpUcuG1BXRaAhWdJFWSpgf6I6TsXa0OS6Dxy5OBK2I
	WFnEYOpnSqNdt0HvPyWy3iR2QNutg83GoREMP32Bwbn+jYSdO66RhhWHn9iScRfV5477ox5Id2z
	1XUiLu2zafLCNlqLO5RG5ITy89fbET5E=
X-Gm-Gg: AZuq6aJEBwLvWqDGePDiX7qaFTAezRina7ZVJpxNmAJUHegP0mBzTTLuJ99xNyW7bc3
	KSK8DJpER1H1fVASVlTDWc3YkWFvoR8NillWe1knnGXgO9zrr9//P+/2Uyh4T1AnSJ11/y3aKhS
	Xodb6hdh5B02jfF8RvkRx5Duea/sQCtHcrARZRcpy6uxhUgpRTzJ5+tE9slTU0bhnRqgl756I4j
	AgnX14SbjDDwVy8csK7YNp5F29UV8Hutaz/m0epQ+HhWIuql1gw5iFOEvyg2TrQ0psY4LIfRNJ6
	vnRm1Y/3f18JBdr0jDrlt9k6odKY+eZMrn30bN8u
X-Received: by 2002:a05:6102:4407:b0:5f1:4fb8:6b9a with SMTP id
 ada2fe7eead31-5fae8c92e05mr2989183137.42.1770641588433; Mon, 09 Feb 2026
 04:53:08 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 06:53:06 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 06:53:06 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aYX7yZofAhc3xYkm@pks.im>
References: <20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com>
 <20260202-kn-alternate-ref-dir-v4-4-3b30430411e3@gmail.com> <aYX7yZofAhc3xYkm@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 9 Feb 2026 06:53:06 -0600
X-Gm-Features: AZwV_QgOFyXaU22RN0vJf5iaDZTvzz8hH_BhU_tqS54b9Hxh77U_bCkaet52TZU
Message-ID: <CAOLa=ZQxU4Lkd=px_KmpKgBn1A2O7bjKVRu=QFDCYT-Ntbd=Dg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] refs: add GIT_REFERENCE_BACKEND to specify
 reference backend
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: multipart/mixed; boundary="000000000000e75632064a639e6a"

--000000000000e75632064a639e6a
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Feb 02, 2026 at 01:26:33PM +0100, Karthik Nayak wrote:
>> Git allows setting a different object directory via
>> 'GIT_OBJECT_DIRECTORY', but provides no equivalent for references. In
>> the previous commit we extended the 'extensions.refStorage' config to
>> also support an URI input for reference backend with location.
>>
>> Let's also add a new environment variable 'GIT_REFERENCE_BACKEND' that
>> takes in the same input as the config variable. Having an environment
>> variable allows us to modify the reference backend and location on the
>> fly for individual git commands.
>
> s/git/Git/
>
>> diff --git a/Documentation/git.adoc b/Documentation/git.adoc
>> index ce099e78b8..ed3191e8f6 100644
>> --- a/Documentation/git.adoc
>> +++ b/Documentation/git.adoc
>> @@ -584,6 +584,11 @@ double-quotes and respecting backslash escapes. E.g., the value
>>  	repositories will be set to this value. The default is "files".
>>  	See `--ref-format` in linkgit:git-init[1].
>>
>> +`GIT_REFERENCE_BACKEND`::
>> +    Specify which reference backend to be used along with its URI.
>> +    See `extensions.refStorage` option in linkgit:git-config[1] for more
>> +    description. Overrides the config variable when used.
>
> "for more description" reads a bit weird. How about "for more details"
> instead?
>
> Patrick

Will make both changes here.

--000000000000e75632064a639e6a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c01569fe63122431_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tSjJMRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN05FQy80OE14NGwrcFF0SUJ2d1VJTUhQRE16ZloxaApTb3pSRFdFdmI2
TDJmTExTaFhWM1lQQmFFWEpiVUFpdUcyZEJXN1VwODQwQThVK1VNUTF6LzhSNG8rTTNkZklIClM0
cEdsUlN5cVNvL29rZXJISWVaZ0FlbFU5bkxabkVTb0htK2h4TEpQQ0NXeWczQWt5SjlFQXd5N1dy
RUpGMUwKT29ScXlBZi9DNjhHVmJTeXMxRFM2UE0rVUZoZDUrTW9DY0VtcklpNHNidTRQbkl5T2FZ
dE1JYkxpSW5uQW1oWgpyNnRCMWFEL2lUejdEbGZvSW1zWEpneDZFVllBSkVYWUZ4SFZiNFQ3S3dM
cnA2dGJSczNReDR2dkVvUDJKWTYyCkhuY2VaNlNnd05pUGtXTjdCc1A3MFEyOUl0em1rVzRRN0I4
UVZXMWlZZkRPOHRFanM2NTI4eC9QUkRocXFpLzMKc3MwelhrbDlmemd4MG9mYXB3ZHhLcVpZOWNN
bUVKUkFHSDZKUGpDRXBlSG5jT2J5ZlVqbHRzZVd6UGpDR3hhdwp6K2w5QVRWS2d4WHRUZ29SdkFx
Z3hzV1Awb2JWb2tleXRpYVcrN09zZjMxNHJQUlRUTE5yMWxMNUxlMkplTlVZClkveEFLMml2dE9X
d29yL1Y4UUlMdnBBMjNDMzcwa1daUjVleDArQT0KPVIrTG4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e75632064a639e6a--
