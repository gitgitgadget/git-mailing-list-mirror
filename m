Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4522AD3D
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764528003; cv=none; b=RkXjTF5hm0J3w3+ouDyIW8Shc8yOTqTqbpNEKODDm46uNY1+X9+EJIXBbzbQxcptf9evtJol00FbUD+xenZsOsyDXCj8lallbKUEMxT2kVcmn8BaMw++qo3Qak232UUt76xcYGnB/oXyBUi1uUJdkPjtgqVielMv653h0sunHl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764528003; c=relaxed/simple;
	bh=cjBPnik+tOtntH0X94iXbojMGLLfijiklAeglfQ09dY=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=bXv/laHjJuUrxaKzKunwD0SnE/PbdN05KX1GJmYfR7HLutqnvcwBsQtOcPJ8HsyIoZ5mCRNaNtYZk+e4XYb8iBqrxKsvzJwYNHr9t5YqBKfEzQcptKUTj0mpiRCUVLbcOf+fCmhyh0U2+3ZKKgcjw52pkLnn3p332IvhVb36nvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdUijqen; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdUijqen"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-787e35ab178so25863627b3.2
        for <git@vger.kernel.org>; Sun, 30 Nov 2025 10:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764528000; x=1765132800; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3KUZDyIS2J+9yM/p6DTZ6eHOIQvyC+kRFV8fy1zgO8=;
        b=WdUijqenoMp/FC6dWzIydo9p5hlyUSGI22x9/CdeBO5cGEjBr0GSfFZ+BOJ9OZtXo+
         4hJEfBL6ssBd8tHDzJkoXCyDG0IpZXapeG8uEnSMcX6sQvEhMjTtR63MJ/pszntNqp1w
         w738ul/IgQ0mXDsPPjg0Cv5MmfFZKFtu21bG9as6KJ1VZzzTclKxFUnq348BHuW/8+MG
         OhfXhk2mZ+dITZgJXyj1KSdeF5b/ObV+obxGCtCQHh99zF84R0a+ziVTlbnChMH6R6vl
         b12LIEwUdlDGXPStP2KUOeTJRWV7M+TotZO9WKbFGHwqOxS7M71LUqgOFkrtTpl7vMXi
         /7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764528000; x=1765132800;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t3KUZDyIS2J+9yM/p6DTZ6eHOIQvyC+kRFV8fy1zgO8=;
        b=LKn9oQOR0WgrC1+TSmWMPcWfFz2KvgcMtUFS/3Y90QjTJrQprjFg4d8j0VKuLawpRJ
         SxpCcvLPdHSRUAtvqFsvuWaZUTLaQkxmx538Kb4UuIRxsaGSVbBXGf2CK3lV3bOcNKWE
         qhhu7cPtObbbJnc7/e2Zd92cjr3gctGhhqIDDaVPmk0cJgJbjj6vRPZLRXyW/OsnlQJU
         ujBFp7YZTswTsISfcoyjbmJjhChqP6mMQbXYhXp/dkiCt/6nFOPBxhDGJdkhk+UqSLzc
         uyXFVFoLUimaiIQyE54sF0OxtMgIO9qJeBMC94qYWrZ935GCRVlb0Ijpc00YW0WWb6wd
         ObXw==
X-Forwarded-Encrypted: i=1; AJvYcCXyglwto+qxWur/XvQsKOuBB/zPFN/XosMxYHTm0fjxlYHk5h2kofphi4YBdLW0etWZKOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzefUGmp5YAihhqWzIm1zjjawhhBjPhW5FR/wRamDhnQwUifbDP
	BTTMfeUvCs2Npe6PG8xtoajZS9C6HZl5/p7WStzfz1+bloopZWJ1cQOyJIYeffvK
X-Gm-Gg: ASbGncvEgXqJUlpsXa5oIKGEcqB9c+iCnZgxtCqHkM3Ogaztw907CaLOSHzKbmVzlwx
	h/LPtN18d5QWh2hxglMVCA6srvgaflw+zqUh4PSirPRhh9fjBVSrzZ49ycW2Dbbn3MSbfc3vOG9
	OVFn7V6mVh30sgRrZHLuf1hDQawWd76I8xyGIU4+cScbrmZBNGcrll6KjEgpjD/T6V82b1NmiEg
	IeRhtYDjcToP4OhOZCxSd3hmqid+GjMr2U9vO5gtdtJgM61Y0CR4SFCbcfgmCkL8nQ+ENbSLoML
	elikJw/dE5nGkPvfjOj107ZGuF10s6O3XHw53qkZnmD4MmIB8K6yCdm3gGpCHvEoTt37oYKtNbY
	fUMlu9jMMFMxQQp0eusLuFoXZgUdWZqLQHZgw+DJpjZszP0MyS7i+yzyajSwQOYVxT35qMEZFfg
	7RmfXmM+j5Ar6kNmJIHiiKSV4TFJFMUu66gQjeeKWe6xCqpKTEHFkRETM=
X-Google-Smtp-Source: AGHT+IH4tp1uRKa5oZZgqmAPsRXRur0nTPyFZnvwB5oRx2sqF1a4l1jTDbHsajQmoaCx/OAxPyH97w==
X-Received: by 2002:a05:690c:4807:b0:786:7a54:4615 with SMTP id 00721157ae682-78a8b478b10mr312396617b3.4.1764528000210;
        Sun, 30 Nov 2025 10:40:00 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:7160:681e:efbe:a946])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad1043a08sm39496727b3.52.2025.11.30.10.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 10:39:59 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/2] Update documentation/discoverability around `scalar`
Date: Sun, 30 Nov 2025 13:39:49 -0500
Message-Id: <7AB80AA4-D3B6-46F9-B02C-7A60A9A1C5EC@gmail.com>
References: <xmqqqztgcu67.fsf@gitster.g>
Cc: Matthew Hughes <matthewhughes934@gmail.com>, git@vger.kernel.org
In-Reply-To: <xmqqqztgcu67.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 29 nov. 2025 =C3=A0 18:09, Junio C Hamano <gitster@pobox.com> a =C3=A9c=
rit :
>=20
> =EF=BB=BFBen Knoble <ben.knoble@gmail.com> writes:
>=20
>>>> Le 29 nov. 2025 =C3=A0 13:33, Matthew Hughes <matthewhughes934@gmail.co=
m> a =C3=A9crit :
>>>=20
>>> =EF=BB=BFA couple of changes following on from a discussion around the
>>> discoverability of `scalar` config changes[1].
>>>=20
>>> Following that thread, I was additionally working on a patch that would
>>> involve commenting each of the changes and why they're set. But that was=

>>> taking me longer than expected so I figured I get these smaller changes
>>> up rather than waiting to complete everything.
>>=20
>> I think Stolee implemented a few similar things in GitGitGadget PR 2010
>=20
> Also known as
>=20
>    https://lore.kernel.org/git/pull.2010.git.1764195516.gitgitgadget@gmail=
.com/
>=20
> queued on 'ds/doc-scalar-config' topic that ends at c483f0a5
> (scalar: document config settings, 2025-11-26).

Thanks. If I paste URLs into my phone=E2=80=99s email client, the message I=E2=
=80=99m composing is no longer plain text. Ditto if I paste the message id f=
rom lore. And this was a long one to type by hand, so =F0=9F=98=85=
