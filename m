Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF7184125
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719411889; cv=none; b=PiJMPBfRlIwc14SPQFQCbvi8rktIlIfNq2VyqyEo6ulJSYfQUA6NR/M2u/OZzs8yhbqa2llgXH6B49habs8YY13fYDhXOFyT8LAQbslJykmun3CKZmaWqjpht38bgzCIA3+TgpkxvI0lwq9N4XgmEGT/JcVGNEoNrE2UWAjqLyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719411889; c=relaxed/simple;
	bh=H48wT1E3apuYeL3CxR+MUxETOY4xos4qvFfIJW5viM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hob4pGJp+tqgiLN9ByXjace0Ouml1OtcoOqUubQXCmejAKyOytAYennqFd4ibSQALOQOnR4pSKAzFNV122LeasII0mmEDLuH+zqjtxMmRnHHFwFVOsYGgkTkOFVttTRmUlRmjRyVvMaV2UMU48rO45FEBolDCfzdKaqh2FKNrnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+1RnQdx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+1RnQdx"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f9b364faddso55716795ad.3
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 07:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719411888; x=1720016688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H48wT1E3apuYeL3CxR+MUxETOY4xos4qvFfIJW5viM4=;
        b=j+1RnQdxwGjeu9WvVPiV1Vu5Bo/uG0MVirgrvMAzPRLRafx3uYydUQ5jNXY/FMUEgp
         RDx+frdE5j59P4OoG2VZUmZWmRD3sD1DqSevxgkgmYTHdFom0XJKz3fdW2JRtGHdABGT
         7V+NNpA2Eww4azWOofrk5cPhKeyRPkqxLip2m0GYJeeBPnxFptQlCtECcsxRfvoXoCR7
         dT+DwLxAFU63I0pC64WV3tgTdidhPohIweg8lUX8RvGn93QzpRGe4fgfa4Q9otPRqx0w
         5on6FiSh79uTZng4mZvT2XMUsYkiiJITvmyfa2bWWQ8DMwuOg2teuZFL7vPj7f11WZ+m
         drwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719411888; x=1720016688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H48wT1E3apuYeL3CxR+MUxETOY4xos4qvFfIJW5viM4=;
        b=RW2TkvFkbIWkvk6Xafm7wzJFyPNOp7tdE/7IbufxPstwufuEK1Z6V0tCs4zaaDPI9K
         i/ER6nyL13zyrsI49/V0099OrkooRi7KaliEC3AnwVDpFsUBQfTjmbIJl8Uoe1CiIn/A
         b4NT7vweodgiT5/qQextg/iajmTzkqSJVoRoWa+/mrW6igKHY2KBbvCjfA9rjhfrAf6y
         exl3NMZfRNWIRzjoe948E4EOx3tS3oIL2Rk0lUV6eiLYA0lDcc9lrP2JbtbGVQfgeJB4
         WRJPw6DnRGQBy9wCil9EaunZRPj4jZTniUF+1iPYzY1zCczVb0uXKJkJ7ptA+prMPt/N
         AI4g==
X-Forwarded-Encrypted: i=1; AJvYcCV8R5/VzTUSFRwFkDj9FyUiRciZ98OrXvF1/6U0p+XU2Pek+wrruxkpjJgDym16jWaYKNdzOQX3VKULmiFaCDt0G+h5
X-Gm-Message-State: AOJu0YyGTGaOglrf+pSSYmAtrDyYkZFjsTBPLc+/Wi+CcYduW9hPonc5
	xgstyNvAD6g/ScKZ9MZcOGnSzy97p4d71EPWIzd5CEBgX8A7ple05k5JWdomlKqdWeby1sCvDCd
	pq+jh++BretyMxtOLE7M6EF6l8j4=
X-Google-Smtp-Source: AGHT+IGSUAg2eCIocczR3XXF6CL0vJsuaHK8wFQ/GnIHfM+k++K5AjIoYRD9U9in2jpaGX+Zs4yY9jSQMHZ8KudHkfc=
X-Received: by 2002:a17:90b:b01:b0:2c8:9d1:2de9 with SMTP id
 98e67ed59e1d1-2c86127e2e5mr8321340a91.7.1719411887864; Wed, 26 Jun 2024
 07:24:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240621115708.3626-1-chandrapratap3519@gmail.com> <20240621115708.3626-2-chandrapratap3519@gmail.com>
 <CAOLa=ZSmnMLMoKKWMiM7M4Jw8CJ0Jvrs0oMLy18FHaLv_6s6yA@mail.gmail.com>
 <CA+J6zkSymKxSRnAVx7oeAoPpMxrRsVRPGO-X0tVbc0VtKOe3ig@mail.gmail.com> <CAOLa=ZQG4S6oJ_YTvc9LjV9C+THKcr_4xMsrOB2Mw6CZYfK9GA@mail.gmail.com>
In-Reply-To: <CAOLa=ZQG4S6oJ_YTvc9LjV9C+THKcr_4xMsrOB2Mw6CZYfK9GA@mail.gmail.com>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Wed, 26 Jun 2024 16:24:36 +0200
Message-ID: <CAOw_e7a0_93TAx6qyNQpqJH9J1SqjV2cMhqPGo6LTVm2XyKVdA@mail.gmail.com>
Subject: Re: [PATCH 01/11] t: move reftable/record_test.c to the unit testing framework
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org, karthik188@gmail.com, 
	Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 1:52=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
> But to summarize, seems like we're not sure why this was added. CC'ing
> Han-Wen here incase he remembers the intent.

The copy functions are like C++ copy constructors. They discard the
old data, and copy over the new data into the destination.

If we forget to free() something in the "discard old data" step, that
would be exercised by initializing the record to hold data (1st copy
call) and then triggering the cleanup (2nd copy call.). Valgrind or
similar tooling would then detect the leak.

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
