Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795463610;
	b=gCqHsCNPkxfF2NzHAmRYeyJTLD2TT0fEG4Krh8FF2WDJS+vGkTx0x1smr0A1cBlAGD5T
	 ohjxvsXHfJIgEazayIMlompwxWeFTxALa6NlD8R55njXkxl+3JcNAOzVZr63SZt3eTfo/
	 MbKDhyLI0htRpb7OqZaFkk8SGp4FKmHbpAofo4/oOJtX3PaPfMlEfVPd8Ej30XZELDaJm
	 QRceMefCX9ENZzN3rhoH076oe1G5/o1ldGpktCrsk43tP4ABMan98VoOB9VgjBFQysrQc
	 9vtO3kg5dqEQyeEesQPARDV6tYGYuIkgi58On6mlOhE9onzb/Y/TTsOXi9m4qhch4cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=aPu317h/gONbYXu8+iTUdpTC1+cHqD2/DaCyHCXL9bk=;
	b=ihverduZ0Wgk0xMgJnxS9O0QDs1XIEWOu3lgddXT81gvz06/Iht0umRj4NXl1m5A+dKm
	 zsCpsRo8incXf4GXOi9bd//V6goA+ioPNqjoULphlbgIFifckuAOW1qz/p/SjQScAWQ56
	 0KaLzQPuQqD1GZlMiCkAZMFPM5brnxN4bPoKFD36cA/fQsmRA2TiTW2WQnP7cJnIrbGec
	 g7fIkg8N3XoNgCK9r6biPRn/swjsODrFP9nzDrGlIafMujeoGuvOa6CvN0V3nITTG0SL0
	 GY51pWOQqHL405gnHIKdayIiynjDhOli/eplKsEr9qQPo+ZBOfxVs2FXApu32kxUwDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l8dZGnN3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAADF606A32D
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 19:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAADF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l8dZGnN3
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7cc2bb73cd9so1377394137.3
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 11:53:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795463609; cv=none;
        d=google.com; s=arc-20260327;
        b=HCtX1b+ueQgEv/j77h81/u/uORKj60aAYEmY+sZIz8UwTmxI5eBNW/uNDXyllbeemu
         W93Au2nSRISNQllPxcLeRkqNQUxGdqsKIwoJvGmHl+W9BTWk3t1FBr6kfdenN54/9hJk
         YJEGOdJdXcyFDzBsDqK0nwTnnhRlMoPu8XC2p1RlyDSECQ6B8EzemJnJYuf6avfXdy7A
         BsFsV3a1Mgo9hvNyRTgFVhiaq1averqFCfg+UyICMUKXhrr6gLu8xoPMLfNDHNATJNV/
         9fRenSXuzzKeEUL1CE2hQhVaeJ+4LWxMfKdUfcg8EaqYstABQsHe/+TErVb1PvyeEo2P
         DJOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=aPu317h/gONbYXu8+iTUdpTC1+cHqD2/DaCyHCXL9bk=;
        fh=ReRoLmYC8chgDyiMMsL7dAaBKxJdZZMIr5FgJesyhBY=;
        b=msjwK6WWvi6SzewsXScoSoYgT0qdLuC/OLeXVaLqJei6gw7TI0sFi9ixFmAZ4Mhp9s
         HUKVLkZ1lSzmoQvRPRqRPp3x6VeA2/ACyYYYDGnVDhE6pDknwwsjIvGjDe6fi7DrHLom
         ZjnO66S9U9T+KxvzfJk3I5F22p7niHhyvP1l/rWsf71VWCxUQ8FtXPsxt80Y5/l23mwF
         6JZ/sk1jJwVynvQJ20K8BItNEc/DJDv/DaFjC/BsfwuGfAammdvEFvTZyGr+4zqvgy8D
         +MIA4K+Zy7wxSQ1MB4MJhvJhZl277MOL3TiNcL7FFuwHNZWEEnnc1c0LnpITt3LZqY1F
         CjAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795463609; x=1796068409; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aPu317h/gONbYXu8+iTUdpTC1+cHqD2/DaCyHCXL9bk=;
        b=l8dZGnN3XstcgMQq+kYohiLLyKcFMA/Xr5k/ajKVxEcVbcEMDrLWhV2xHhUqkP9SXg
         ac8vrz2YpYCF2q9WXnC81TnzQfin4UBH0yPuLCyLr1RzuYU60ocb/hs9jL7JWw6wDQEN
         1IS5+EDooC4oprHD1t0swISDquys82iAeJWO29I2N1kMmZnSXPdSmWnQASPiXoVEK5mm
         h+FDW0UIIWBL/ELm4XQEj0bCSAtbLdKFY6enka9/1IsMCqVNk6QkyulptaZtWpO1o6sH
         2XIImVMDfBrt4RgGzxDcGkuDO8UJTSnInfiSeZcfM0UsJuC4c1OyvSDNXSA4Ug46hFge
         7iAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795463609; x=1796068409;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aPu317h/gONbYXu8+iTUdpTC1+cHqD2/DaCyHCXL9bk=;
        b=MCClU0bKjchxAnDUlPZhrBo1js1o4DPLpSSTVDez7D5LeC1k29TTq8alo6hoXpTfxb
         RgiqAw+At+Psuu7RPS1foWBCkRQrcldXh9a4juMQ3KNFHsnvgQW4mTjcA5j+z2bYZd84
         26xmVIzovuTPpOUlQHgjYWkSVhgM+rSJudXroFhN/YHIl+23toNaP4ptnuvFVSuwiZ09
         Sa+YwE4MkCwSxfNUuuAmB41rCvfFESC4Gc4E9TJ5ue9xOm7PFboD+AZsFWL92JSksAAm
         ysoC6Ud4z+n9usF+vxlvk/KRArsqEXvU4hGWWstbg7PcAKICCnTe9vhLqRP87b9ZDVAc
         lIMg==
X-Forwarded-Encrypted: i=1; AL+hErFQbCay4XEd0drHMEpODvZth2RZ+Iq/BDA3SoxOGqnHehh2nIeUCduK1mDs34M2K+I4r1w=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dCHDyIKnjtzHwGTiVyrXFiBoF+aVNd8IBB7JoFoSdSmhmOakq
	+nq7Egnc/qJWdd1nuaRKwo8HDfZ5cSirBxT4mdSrMAtEO42hCPT9mP5VBaStj56T/joXiBVGwD/
	QTp5C0PCuljbFsOjp3qqz+NyqyOBKy/I=
X-Gm-Gg: AZFdTZcg9f05ZDz1zxuehiEkdlfcYoDRiYs1rTI5d4gXrCapiZr7i6hsv0ShgZ/fi2H
	324uxasMZxIf5WsmrUey6KYhzqx+zrK8CLZQtePvkWldAbDOV4fGTiaORKRfJnVXgBwcEYgiQ+C
	VgQZuLXZ2D9F6PstJrMzKqnwAe+2GXX0RpoTp/kJJVnVmkWDsMzuOW/BUwij3qBSFkhYwgqtCyd
	8NDBMHXIHPF8ATmZCjIg0JMBYG01aGVbqtoeM7MaUXc06H4T2UEynvWjxjzTuR+QvM9xM4aAL3w
	886gLmPSxCQ3ghnYHGM2QiQ6xQDpdQ1Ttlayv6fmekJmSuOJz5xfQhjsqrNzyM9Bsl0oUT+wguN
	IlCJZ9ATt69I21PcNth/+jZCqHSQnc7XkB+eI/qhMomiPSNGaEx/Bf9Ij5El4n7TwgCozX+YqUv
	rHHDOzeesuoHUsT/2UV3EyyyIA1ks=
X-Received: by 2002:a05:6102:5107:b0:7a6:85d6:8ae0 with SMTP id
 ada2fe7eead31-7d72b368571mr5465116137.1.1795463608637; Mon, 23 Nov 2026
 11:53:28 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Nov 2026 11:53:25 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <8c88dd99-dbfb-4207-bd43-64063795e907@gmail.com>
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
 <20261112-kn-fast-import-tests-1-v2-5-b8c3a0ab27e8@gmail.com> <8c88dd99-dbfb-4207-bd43-64063795e907@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 23 Nov 2026 11:53:25 -0800
X-Gm-Features: Aa3M54o16Ju5ZKCYek_bLPlHb_NgVhZw84lojY1BJ3qgOFswhg3cGRz1I8stBVs
Message-ID: <CAOLa=ZTt_MMi-dR2KtUK8__BP4O24raNvNcO4Jywjs3f3GRGQw@mail.gmail.com>
Subject: Re: [PATCH v2 05/20] t9300: make the series V tests self-contained
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: multipart/mixed; boundary="00000000000099c0600660f6f2d3"

--00000000000099c0600660f6f2d3
Content-Type: text/plain; charset="UTF-8"

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> On 11/12/26 23:04, Karthik Nayak wrote:
>> Similar to the previous commits, modify the tests in 'series V' to make
>> them independent of state from previous tests.
>>
>> Move the setup to a 'setup_checkpoint_repo()' function, so each test can
>> invoke it. The tests used to build on the 'U' branch from series U, so
>> let the function create a 'base' commit instead. For the same reason,
>> the tag test now tags 'base' and not 'V'.
>>
>> 'background_import_then_checkpoint()' registers a cleanup with
>> 'test_when_finished', which is not allowed in a subshell, so call it
>> from the main shell.
>>
>
> May be also mention that it sets fi_pid that
> background_import_still_running_ expects?
>

True, I'll add it in, but will avoid re-rolling just for it.

>> The 'no new objects' test needs the 'V' commit in a pack, because
>> fast-import only detects duplicates against packs and not against loose
>> objects. It used to rely on the 'fastimport.unpackLimit' set by an
>> earlier test, so create the commit in the test with
>> 'fastimport.unpackLimit' set to 0.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>
>>   test_expect_success PIPE 'V: checkpoint updates tags after tag' '
>> -	cat >input <<-INPUT_END &&
>> +	setup_checkpoint_repo &&
>> +	cat >repo/input <<-INPUT_END &&
>>   	tag Vtag
>> -	from refs/heads/V
>> +	from refs/heads/base
>>   	tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
>>   	data 0
>>
>>   	INPUT_END
>>
>> -	background_import_then_checkpoint "" input &&
>> -	git show-ref -d Vtag &&
>> +	background_import_then_checkpoint "" repo/input &&
>> +	git -C repo show-ref -d Vtag &&
>>   	background_import_still_running
>>   '
>>
>>
>
> The way this test series is refactored is different but it is consistent
> with how the commit message describes it to be.
>
> LGTM.

Thanks for your review :)

--00000000000099c0600660f6f2d3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c51c06777456adaa_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1zRW1iTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN2sxREFDQmRhQjRDbmcvMXNQNXI4cWhFYmQrVTUyTgpaMGRjNkdBenRT
bHFBQUpody9qNUg4UkNtQkRwRjk0M09FS3YxUWF0RmF4KzNRNER3UWFUc2lmb1pYY1RBTzNTCjFO
V0ptWHc0QlFnTVBPOGpFWnNEcDZEV3duRUJPWDNybWFVN3BMdU0zWktQS2FxWlpMS1AxRWJ2YWJS
UFJtd3AKZnVjNE51MjQ0b3EvZDE2RElCMnhEaWVTcGFZaktTMHI1Zml6a2lmamorUE94SldzWVdO
VEdDVUkvZWcrNnRwMQp5VVJETHFvcDlBcFBnYTFnaXBndVlRWWJDUWNGUFJEY2pWWVZiMnVZSzVz
c0tMcGZvZFdSQkY1S0JoSUFjTlZ6CkdueW9UdkNISWcyeldvNVBVOUV1c2dmeHduQ3NENUcxQTQ0
QU9HeS9QM3YwenFGanREdWwyWGc2TUo3N3RrRUUKaGNrM0JsaUtjSmZpcWZFZmRFVFpoRDBaVDBm
WHNwNm4vNmlETGRJd0dLay9IRlh2dkNNeUR6ZXpYQVVyQS9FTQpyMW5DYTd0N21QQ2c1eitEY2Jl
bGNIMitWL3pHcElhY2tiMTBNaVk3OXZxTHVDZXNlMzNKNFpqYSs3RHhnL29ZCmo1d1F0dnl2UjVF
Q3JqUFRRS0l4eGVKeVZ3eHUwV0k3OE5RcEJPZz0KPVNUaTIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000099c0600660f6f2d3--
