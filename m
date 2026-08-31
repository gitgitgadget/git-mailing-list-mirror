Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AE046AEFA
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 18:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200559; cv=pass; b=UFkB8n35QVT4H/OvnZ2uDp1YJo21RfiIV0HAUQrj8xlcqzEkMKp9YjdG8BnHESViko2+u1Plb7B3+C4smxK/OcmQ+iecKk1B1PXKTFVlKdERYXf42Eq9O0CCjQQtNNGoBgz7F/h3h6fLftQgL7fGtP6flzJiZAVqzjke4nKy10g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200559; c=relaxed/simple;
	bh=CQ6GxzaJfrJSEqyypOeB7HNsOJ10GUtCr7w2NBEjo4k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOfECPDE+jP0BwpETB7K0QUkzdCTwVHFay7fgESHsdgCDH39DQusgrYbOAPfOGZb/cFxEpG3hXx2ZXGSP4jPChbR2M0BRdzPkTb+Q12jLrrLRYQYU9Pf9Lq9tu3vwvA9QHF3pgEv04md1ODfsD9l7EDgfrAvXQveVKW33XXgApo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxlhYwG0; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxlhYwG0"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-977258a75d9so2310334241.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 11:22:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788200557; cv=none;
        d=google.com; s=arc-20260327;
        b=Je4RlfrPVvdSSqLJn1qPTzLnNT7kwJqWzDVjmNhPSzN+Vw0gnmt86DXq2F5XHpaggE
         K+ow8NeLQwrX4YpkwfzCnbVBgv/BmyC8qnHLcUJ1rmE6xBbxJoixRGOlIYTADDgSMo/Z
         XXUkCNBVA7mJ1jZiXvPaT0ZlatjVhiAQmdCrNg54c8w7fMI/AjO6fVkPXk0fctVwhYyc
         nUQlkwxDa41nhall2MWNpqqJVPY6mnPe46F1P4S4d0OEA/bDAv35l0zM8UbkmJat6CLz
         BLHZEqixpCOalYn457cWX9M5JwVQ8a+jeaDjzTHI4+MYmHAQ4XSZicEzzHiP5Tr1OKTS
         jXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=dAOPFNgYYcsUQezg6x1LTuGYzPbg1ue7H7xhwICgBTo=;
        fh=Rn9EFvid+bDsg8CskbihT0m5GvhnTPnaZZUMwd/52l4=;
        b=VGvkNt+Q7dSNv16GqayKqp8bdCUoE2OVCqXG+b7XBKJ9XofAyiUIOyYxSq7iHmZ2Wi
         u2MVR9PJc3B7bnS3wluQJuwWAXFQnlFNzQbwnNXp7sJyDbD2YThMFF8CDTnIR8jE4sXG
         MpAH0Ek+6+FMer1A0k6azgIRELJ7b0OfVQCSD0iUAlIHrV4EoJPRwlnjTE0wu6B80JbO
         JeqCMfiXLotNmZM6M6s1auTEUHb2IH8pxc5pdKAMSY/Z4nZav8B3/bSkg0hE6+9+g/3X
         KN67H9vz1d8FxQAHLcRtTmo/KyVUBUMFbvoa1Yf6yYPfLbM6x8pS5EEEJFWNCHjtXCvP
         dyUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788200557; x=1788805357; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dAOPFNgYYcsUQezg6x1LTuGYzPbg1ue7H7xhwICgBTo=;
        b=UxlhYwG0uWHMq2dH36SPayOk6eU7VPrhukyYTlUfbbXpvDSvQLkp0h7xI1WnYovchD
         XxhkS2EL33PFd4QnwjYH4drANFSwEgcZJYvvf5Ns90wZuus63tHuZRlFXRgp1olfV5kO
         bIQu2ge5lavAB/eO9nZaYTMHwCAj/Oz3ChbuBPEWc7YgxAf8nnkigHHLMo0RyvDk//ve
         GGbkKhmuODP7PMHDWK5oBji0162fcH91STJJAGV9IxjsqBqtDnjdLJVTIWGtyIVW4/oi
         Cd8gH9M7WLcHN1T16YzuEv1sm+p9bF/AuGrfyDGPADfvKJJOWkytw1sjFEye15gpLJXl
         BmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788200557; x=1788805357;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dAOPFNgYYcsUQezg6x1LTuGYzPbg1ue7H7xhwICgBTo=;
        b=myHs57Z2Ifi7Zdzrmf1ZMZQ1E+bYophjVCvzgBuEZZHRRnLqjYs+vio14Q/iLf/1wQ
         3kXB+7k2UjQdCMiII2gFPlEb3fjY93sYTtf+kB22dDX0wxLl6tz5ymDiS6/Ag99shKwZ
         2ND82tEpaW1UH85q/bx3CKwMAV7M1MXPP+PGT8GNkbgMU+TABteqUhg/jAr8HauR9kt9
         zV6+axjBr9CSQj8+Zu9QHaIWj8qDZVAwc9A8C1BIWeJ4VbcbHcQdaSZ9rhgWGxIOMKGM
         y6/vJycCoJQFBJKVwd8gdAwNlYsB7nnlkHwDv02LvFi9sGh4GWmXWJ/A1SlMslIdQA4p
         gQtQ==
X-Gm-Message-State: AFuF++mm5UESKMOeh7EtPy6yadiyIA7SlLJnECMs4xWgs3vAHlBbwhLc
	UJq2eXKBuA31qUVle7CFZdoKabNWbWOHG1K1PwSH+zgsCKjILxxCjraEL8aRWHPaC9b/J335Iyl
	0OPni+DnshSxQkq1rwXtaABD5icW55SM=
X-Gm-Gg: AR+sD10GQOYBVxgpLapnqAXPM1Uvoj6aeJP4deA9rIrhi4JUzPGeteExClTUcaZN5NU
	oOOczHqtO9S1Jos+LuTPd3Gp5fztv2xWMoFxV4+04eSf9pbC+CilyqHH4sDYwVMYYsy5P5cn7tC
	5gNG0wGxevfHvALAUrb0pUTiB7NKGkrFBv6tAB5UyBkcKe2PnsEZC2EIndjl5DuBHq/rpTk4Mrk
	r06ajSbh5caC56uXlYBF8jtbrkHuA8ddBtJPSIv6M0fjHDBDSkXZY95BD3I2Ca8XoRwNI485IV9
	lzpxfchpyqdPMTBWsUKw0GW9ZMFFrEX5i4tgYBkZn2RF15+jPFbWSsjnl0Ri/iq7PNhZehL+7Nx
	xrlQILzoMoSNTlRypbdD/fbktyzBSVFrS3g0=
X-Received: by 2002:a05:6102:8481:20b0:785:b0ac:54bb with SMTP id
 ada2fe7eead31-785b0ac57a5mr6742089137.7.1788200556944; Mon, 31 Aug 2026
 11:22:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 14:22:35 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 14:22:35 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <apUi5iUeNUkqVa1L@pks.im>
References: <20260826-758-introduce-hook-v4-0-6b14975ad957@gmail.com>
 <20260826-758-introduce-hook-v4-1-6b14975ad957@gmail.com> <apUi5iUeNUkqVa1L@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 31 Aug 2026 14:22:35 -0400
X-Gm-Features: AcwNN1Vue_OQOS1f1elbGrrqfAJqs1JVBfwJBVXIX2cBZwdOHdzI-pJ-xeS6Fss
Message-ID: <CAOLa=ZQnQ7QWmWtk5Pg6rbkPunDqFYrB_d==kfkpzqt046kCpw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] doc: add proc-receive hook info in 'git-receive-pack.adoc'
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com, 
	kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: multipart/mixed; boundary="000000000000fbfe48065a5be2c0"

--000000000000fbfe48065a5be2c0
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Aug 26, 2026 at 12:19:37PM +0200, Karthik Nayak wrote:
>> The 'Documentation/git-receive-pack.adoc' contains documentation about
>> hooks which lie in the lifecycle of 'git-receive-pack(1)'. Unfortunately
>> it is missing information about the 'proc-receive' hook. Add it.
>
> I think this reads a tiny bit awkward. How about the following instead:
>
>   The manpage of git-receive-pack(1) documents hooks invoked when
>   receiving a push. The manpage doe snot mention the 'proc-receive' hook
>   though, which is also invoked as part of that process. Add a paragraph
>   about this hook to plug that gap.
>

This reads better, thanks

>> diff --git a/Documentation/git-receive-pack.adoc b/Documentation/git-receive-pack.adoc
>> index 0956086d61..4349487e6a 100644
>> --- a/Documentation/git-receive-pack.adoc
>> +++ b/Documentation/git-receive-pack.adoc
>> @@ -236,6 +236,12 @@ if the repository is packed and is served via a dumb transport.
>>  exec git update-server-info
>>  ----
>>
>> +PROC-RECEIVE HOOK
>> +-----------------
>> +This hook is invoked by 'git-receive-pack' when it processes push
>
> s/'git-receive-pack'/linkgit:git-receive-pack[1]/
>
>> +requests. It handles refs whose names match the patterns defined by
>> +`receive.procReceiveRefs` and executes the actual ref updates. See
>> +linkgit:githooks[5] for the full protocol description.
>
> Instead of reinventing the wheel, we could also just copy the first
> paragraph of githooks(5):
>
>   This hook is invoked by git-receive-pack(1). If the server has set the
>   multi-valued config variable receive.procReceiveRefs, and the commands
>   sent to receive-pack have matching reference names, these commands
>   will be executed by this hook, instead of by the internal
>   execute_commands() function. This hook is responsible for updating the
>   relevant references and reporting the results back to receive-pack.
>
> I think this is quite a good summary of what it does, and for everything
> else we can then still provide the link to the manpage.
>
> Patrick

Fair enough, I'll just use this. Thanks

--000000000000fbfe48065a5be2c0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e3373286e773495_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xVnhta1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMDFBQy9vREFUZ2owQkVuSHBncWJvUG9FQ0dOdjIrZQp3b3hTRndVVFIr
bnBKcDNFZXF3QkZmamFIZnUzcUoyRjE3U3pDWVRveDdQRXJzaVZHYlMvM1ZqK2U2YXd3RHNlCmdG
VGRyaHhCQmlKVnJTSmU2bHIrZkROMERKalo4VXhMZWFUblRmU3czZkFCSVdvMnJWMlJvZ0d0blcr
alVzZk8KTVdHbXNOSy9oUEltbG9WZFFab1pHMzVKa3M5dllZRS9mU1Z0NkFhdjZPTENIZ0RpTzd5
dEFuN0pmVmxhZmRXTgpWa0JzaTduUTU0cEkvRjBsOVhheTdGK2RHMm8vZGthT21TeVZMbktEWmJv
K3ZJOVlQZkNuNXB3aE5hVlpyNldUClAxK2xsazBaOG1SUVNtNjBDQ2trZlZUbGVRU0MwbWhTenFS
b0FGbUNqUjV6S01URlYvNzQ2RC9sZUpSR3llTloKbktDbUxjQkRuc09rOWRwNGNaLysyNlFqMHVU
ZVNzYU5BaHhGUUl3bTlqR2ZvWGREcFpoOXZwV3czWlNiTzlZMwpxTDdKNkhQc2puZzJlR0xERFpj
WlAzN3NlejM4UXRBYnh0N2VJWEpCUlhwUWg0QVUzcXlyMlhMK3lFUWtpTUdDCmtSV0Z6R2dRdGdT
MkVRMTd5Y24yalByTTIySi9HRjNOaE8zcWNvOD0KPTVmTk4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fbfe48065a5be2c0--
