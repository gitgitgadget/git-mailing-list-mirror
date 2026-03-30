Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971EC389E07
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864273; cv=pass; b=P+mTiFfxQa4M/iJ4thgROKdD4rl37syMUFIfzWWU2++13ij+cR9sRtDJo3tMtSuE9bD5zs+2mX4q6B+M+rcJ7CCYZqtV5lJh0ccX/7w2plByQxHMviXgP8LUK2t57exS4j8gyVEsM5LV5p0wmpgu4domDewcUDF2Cy6NZf/jZek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864273; c=relaxed/simple;
	bh=Y9eGgY4cGYjCBrQFAS/vX1OvQeIjCLSEJUq5Fh4qRh8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JV5dp7psgPgfO+cVrxr1gmNVq1NhivsE3GrJlElPVaLZ1o9eeR44BxPrnshOhkyOc1DyadmOwcecBw6WwHXRMeoGr0ylDcwMChEXQ2w3CjfHHuJ3Am/zJlVBoZYXt8xj9qxGT25yJl0IXJEt5CPMpvjkb3Pl3gP/Mgk+WiIWdaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRF4nUPM; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRF4nUPM"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-953acf7ae20so954302241.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 02:51:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774864271; cv=none;
        d=google.com; s=arc-20240605;
        b=Eq7qndaR2Kv8e7i50qZwZPmu6JYUtBdbvsSPieFNBKSFIT9aFlMaRxTlzUjzBP43Ly
         4fgestVXanxjAkOPhknWn2VH2QZZSVxNACLpNeX0uKc4h/ub8aXnsDpNJXFljbgZZAt0
         Oy7IdYPI/2n2WjsX2MepcSJLy3bc/HXqmaPd0UkHXlS+oEumKOnD+tiySh1qA6UEA14R
         IMz12J7oQXu2P9ah/zdNdYM/HS4ALW2cBZ7MvaW6WsF8ZEX29cT3iPm7gy4ZHfJSLGNd
         eDX1EOCedbkTuhSGPK8kZHd02tN/Zv8tlD4nial/459/n/a+xkYnoLwZ8ZyYiMZlJBY5
         6SlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=I4gAaClM6hfJVn9bGea1U49L8GY8xGyYA+QqiiwFNkc=;
        fh=Zdgp1mnl6tx8USHKbGsZfv4LNxqO8JoBe0YaVblnl8o=;
        b=ghpF983fwb6yccRb0f54GIZjLzRn7m3sSHiRB5ROv8OXO4n6ipcDf77jFnX7Tf0DwD
         s7g77ry3u1UB9ULx/1Qpy52y5sL/hsGbboAYlXFvMOicmU1OF7xq66PvJVZHueGLKu4+
         eO/FL7uwe3KRx4c+lXEZDipHPCI+LlTpkKzm3k+wjncZcrqJEz5jR1bHROv1RWK5w4Sy
         YPs6Io+HhtsBn7OYYlqsfyKu8+CqmVKh5vBxyXQQoJRwMmrJuu6VWIQ4mXbWohfuRKCL
         i9DN8jQV2ZLXK95ZCSE0wKiTXI3sMzlbSiVoHNPrwkUEzSWaJcEtxcvMmoQ9YZlE79NQ
         SlVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774864271; x=1775469071; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=I4gAaClM6hfJVn9bGea1U49L8GY8xGyYA+QqiiwFNkc=;
        b=DRF4nUPMFo3XT30jbKTlA5A2YlALrAwhkW0CZbTSY9HYp5TtkbIIPozd3/KVPtIpEF
         FSqMKqqB4dBJzsRYACZ/KqaoO6yUFPQDz5Hx7Z3tVMNREyZvF81lktMa+cfFxOsCh8Ek
         IOMtX2eW3g8+Pgd2dBDuXs5BGTxqBuYX01CUC7pANMi/6xuK48DtwdD0HUv/rR4duCUf
         8e1gtDxYwh2L7RbQaNreEV9RAgM9l+nK1ZY+0wrPw2xsoG8jMT9n1uW+tSyVoNskLczf
         yySzdTd10/2c9DSAmZtMzItfqCvVe7uhamBr4CZoeTWVoquzF4Rd1gbl03Ams5VbOtOO
         gRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774864271; x=1775469071;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4gAaClM6hfJVn9bGea1U49L8GY8xGyYA+QqiiwFNkc=;
        b=ODV8tircxVcIUCli+XUCVY1lHW0oYyalEw9BWTDpnKMVvdT85ezu4YyqybnCM6iLKg
         olrSP64K0CuZtxc/GrJPnnyt1WeCGXMvxQ9bM2rUu4Zjrd/GIzja7R1UJab7xGVfsnIE
         kgrwnEx/VwTL/aeh1hboRVYh/omjHgUcSwYrJ0KxTyd8MHUhbjUtBJaNb4euXLP0lexw
         cnHnR7TpXjhM8iZ5DbHVh3vCl3eqBOzb8fL9av89OZlw8clLYUgQRtCiPD4pgf1PKk84
         V90u8egPCs8cEUcj8QAsHpGOVK4Inl7fPCXCm3ZTmBMVblSQAH6bh/DimqfBcBKq6PrS
         GKRA==
X-Gm-Message-State: AOJu0YylP3ICUmdPeSIy1KH5eoqEQ607kekGZABNuhIlbHweCzl1vm20
	b6ySnaIxX8dDc5XyOF4b4Fm2bAzmSMIFRKfBBX6gxPRaNzgjclwmZGn+wilAWNZrGcrPh2j7PiK
	H4h4t3NaSfb2uSjL35STdFNQej8K/uJp1EQ==
X-Gm-Gg: ATEYQzzXlEHVSIHbnrdsG/b32nKjW/HmT0DYjPoMcjdTrc8LnN4R/Q1ojt6+DDto6Pl
	SYZ7M7HJWGrT4RfEFiWewPBizAu6luu0bi6ntF4jZVYB0cTkMjglPCtIImW2GYc6hdM2GIteCIi
	m4H/eV33g2xZlqAN7DwE/AeuC93+rdTIp5cuS6RyWveEBgD88v2JodaLk/LvxzeNtDLbG1ATP0e
	R9ZNT3EBuxK0+yihbYzAF14r31g+vlNiUOkkfbpfkfZLKjsA7xWozTQcaMyUf1i2hojluiEPgKi
	sUfXIDU8XPBwnRRm/lawJYDEjP0d+5WeRo8nDJIa6wQU5ZdykYUg
X-Received: by 2002:a05:6102:5a93:b0:602:78da:f4ee with SMTP id
 ada2fe7eead31-604fc19d378mr3974339137.17.1774864271574; Mon, 30 Mar 2026
 02:51:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Mar 2026 02:51:10 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Mar 2026 02:51:10 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ftwnrutdbvyf7phr4ad76agt2jvzgieqnxprvmoyw2vzwbhgqy@z4x2g2n3ft4r>
References: <20260328200255.247759-1-vikingtc4@gmail.com> <xmqqpl4nh3b3.fsf@gitster.g>
 <ftwnrutdbvyf7phr4ad76agt2jvzgieqnxprvmoyw2vzwbhgqy@z4x2g2n3ft4r>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 30 Mar 2026 02:51:10 -0700
X-Gm-Features: AQROBzDfgRLm-Jxr9QQ80JO0XI3XsgD_qiw455-2Gq_W1Fhdi5LJAle4KWLoggk
Message-ID: <CAOLa=ZTqySjCZitN9-ZWxMuwTaOg1TR8hiLEohWVwp2=coSQtA@mail.gmail.com>
Subject: Re: [GSoC PATCH 00/16] Microproject: avoid suppressing git's exit code
To: Trieu Huynh <vikingtc4@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000006e9e8b064e3aca4b"

--0000000000006e9e8b064e3aca4b
Content-Type: text/plain; charset="UTF-8"

Trieu Huynh <vikingtc4@gmail.com> writes:

> On Sat, Mar 28, 2026 at 05:44:48PM -0700, Junio C Hamano wrote:
>> Trieu Huynh <vikingtc4@gmail.com> writes:
>>
>> > Piping git command output directly to subsequent command (eg. grep)
>> > hides the exit code of git behind the pipe.  A crash in git would go
>> > unnoticed because the shell only sees grep's exit code.
>> >
>> > This series extends the same fix to 16 more test files, following the
>> > approach introduced in t8003 [1] (redirect output to a temporary file,
>> > then use test_grep on that file).
>> >
>> > Note: t2206 is a special case -- some tests cd into a subdirectory
>> > that is itself a git repo and run 'git add .' on the whole working
>> > tree.  To prevent the temporary file from being accidentally staged,
>> > it is written as '../actual', outside the inner repo.
>> >
>> > Related-to: https://lore.kernel.org/git/20260328132955.172262-1-vikingtc4@gmail.com/T/#t
>> > See-also: https://lore.kernel.org/git/xmqq4im2sjnu.fsf@gitster.g/T/#t
>>
>> See also https://git.github.io/General-Microproject-Information/#:~:text=Only%20ONE%20quality%20focused%20microproject%20per%20applicant
>>
>> Thanks.
> Ack, I missed that point. Could you clarify how many patches or
> files changed are considered appropriate for the microproject?
>
> BRs,

Hello,

The microprojects are meant for contributors to get a hang of
contributing to the project. As such, we expect only a single file
change. This is also listed in the Guidelines [1].

Thanks

[1]: https://git.github.io/General-Microproject-Information/

--0000000000006e9e8b064e3aca4b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fcb5e0163fe5461e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uS1I0d1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMUhuQy85YTJWVzI4SEVYVjliblVGMWtMT1dpa0Z1NwpXNnBjaUx3YnY3
TlBCejFWdzBFT0tiTzUvdFhiTkdZY2hJUnVZazgrWFljd2Noakd5VVJxSHFXbHF5UFoyK0FCClJS
eHord3V3cFV6dWRsQktEbmtpbUJyU1F0VlVMS0VUMllpMGN0V21QRW5vTzd4TVpXdXNBTFZ4Mkgy
a2U4ZEwKdGFxaW42SzlTVmtqeUlXV1plZGZCYmtNYW1LSGpxR24xZzFCTVRQRXRUVGxmWFoydk1E
SFhhVEIyRzB2U3BPaApXTk50dGErdmYzeFFjVHpmMXhjY1FHc05lZkRFWVZIbk0vaFBDSnpwWW1E
TGE3SDB5YnloeHUydDVSZnhHRVUxCmZEVkU0MDBSNDVldGFLQWpESDVRQzhYQU5BK1RZQzQyOWZV
WEt3bmF2YnA4NG8yN1BGbFE4MGxWS09tRThhczMKdWh6SXRIb2wrMHZnRmZUanN4bVZ2V2c4RGRu
MjlDYytIMG5pM2xkbjJJMUpvWkM5eU5maUgrWmxOMnNxNlFTaApzWkZVY0FnRXkrY3V3dXVVbnJU
d0VMZDVhQ0drOThXTVlmYlZKVWRRRzhhUmI4c1B5cWVuOXZHaVhaazlZZG5VClc4QlJjNlFyS2hM
Wlk0eDZhckZOdVRIUXdqaFY4YnRXZTBwall1ST0KPW1XUVMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006e9e8b064e3aca4b--
