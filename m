Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16AF282E1
	for <git@vger.kernel.org>; Fri, 16 May 2025 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747383620; cv=none; b=GOYLbTA8V416fup3v3Ok3RKmXkTy16ryHKUKUaMOtlUnxA9UFmmpwu1FO5rTbuTIMGCXTq1tM6CXQd+RPjnMz7w9gZg2qawVmDmcEOgz/EpIHZPvJO+zZxY1opBHt7hUCo/5bMhLF9Dz0P4w1rH5p9V0FwvA29aVrATpk3rVgxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747383620; c=relaxed/simple;
	bh=wC/49wl4Lf5zN/x4t3ETziv6wN5V655uK8nXgRgCbcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIkJ3eVusV+THavYhLDulMTBG9HN5mlMNypbDT6nb7E/ZHN8KhHlR0ibIp3nt8fwBNCWxDz3zS1kaxSizhKTzv1WuhL7h+6tOcADP9oIRyHmBBbjMzJoz9CE04KC9p4mXPJTWR0n7qs008eG4j5SOIoKecdo1w2p96CPNGscHEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6Ki3+kO; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6Ki3+kO"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4774ce422easo18794241cf.1
        for <git@vger.kernel.org>; Fri, 16 May 2025 01:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747383617; x=1747988417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pD0yohHkjMXT21+OUVPDGtIt54XmbnQAfPwiJgC4KEE=;
        b=k6Ki3+kOP59Sac6Mx9UF0fJCQXdWynj9ATRa8FSSP+FdvcjPuVOwVO8sHUqSLYH4xC
         px/q86fd14eWEV8dhukf4ojMAoJ5fpOzOGUP/dwOgGMRWY60YY6mtHbcRbmavBDPlqLO
         ft+y2GYP/QPOxEPAD6SjV9pbS+2TZmkIJRiJSA8JW6aZ+0yWnzJ/5LcfDfqPWQWOsAjj
         naeYVpSZHdPmZ+TAbUsDGLB92PfRv8JBkKjgrZvIsAsT2Q9fi6NFJFP8s5IYWiDyVjy7
         +9eeGG6N2NmUxE/+vGrSMLGQtbaUEucZxloXVVtinx7pZG48bfbomZ1uK/XhhagLUkVR
         cXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747383617; x=1747988417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pD0yohHkjMXT21+OUVPDGtIt54XmbnQAfPwiJgC4KEE=;
        b=k2s6JFJqfVXMhhY6xiOw2XkyiPf3Cenx+puu6aIf1F6eCMzAfp+W/8t1Im4YzTirpP
         VslJqh8eN8Z9nPBOyz18xAYtktuSoyiKd2q4txWT5XhQReW5VOIR+n+nwkVkPSAI23mz
         4aThC6MHpkgzJv/SvcZpQnr2wVUGXvhV1BnXiKs8wcOCPBTJ3E849y2MnvOHjvpgQTZX
         k/FwmRx/7CNtXZKxyxRkl6k8ZGl4dtL3r3oa+vCZAA6SsP10GHuvfEMlRbjBH+0AVdZO
         JdVu90fjRJI2I6+jKD3ZvfBm1JO4BvMK+YTxNBWd9cNdIWeISSiK4E/5i/IwQnatmnEv
         xZnw==
X-Forwarded-Encrypted: i=1; AJvYcCU2ucX+sNXmdk2kj4iDdkyaNFL4nlLxSb2XwrpSJ/DV+5J7NtB59haw2Z6Pbkl0n4kODKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb4jIz3/fVVoQTfWUCzI541t9WjoDOPxhaMncWvees40zEKABu
	q5RSvSXYy0EWTeVMC/so/PhHjJ8tlCAVe4rjA/nNMVF3bT5LbtjtFbzQH//fFmjDnM7exns72qh
	UxugnHwTawGt5mUpE3j3ZGzJJhyqf3yg=
X-Gm-Gg: ASbGncsgUb+EQ40Az/SnmwFHma72hpZeAklpdSn5vOyjN9IFqo4qehtXCm27weyO5W6
	08mdmTBP2hkBCE+G9Sy2hBKIEGmKNWU/pkCJwreNTlxW9RbEjoGQW/WsGOpZI+VuyzuwuA90sI2
	PI+aw5Fgiu0+UMDofvlbuceQ1MkRRcOXkFuCERAvUJRUPM0XSwWbBgDJmYTNG54Jl1
X-Google-Smtp-Source: AGHT+IG4pwMI+IEOKTIqt/4GXo7o0/qNGFZo0CpeMGuqIDldzwVzIbVDwMngSulOVRszkR9Fo9nToTwtCMwQxlUJzjM=
X-Received: by 2002:a05:622a:4005:b0:494:48b1:a03d with SMTP id
 d75a77b69052e-494b093a12dmr33185791cf.34.1747383616676; Fri, 16 May 2025
 01:20:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
 <xmqqr01si441.fsf@gitster.g> <CA+rGoLfbshrkPvvQorMq4n1RkVnyL8XfJ9UjMFRA-6dG4QKdcw@mail.gmail.com>
 <xmqqtt5ncq87.fsf@gitster.g> <CA+rGoLfcJ2r8S515msG5L-59=0nOBvdOX2TTn+-iaHw8v6Ndtw@mail.gmail.com>
 <CAJoAoZnYOjqgeW8Stuj5T9qcxmUBE=_j_ufO8Hdbn3GV8LmMzA@mail.gmail.com>
In-Reply-To: <CAJoAoZnYOjqgeW8Stuj5T9qcxmUBE=_j_ufO8Hdbn3GV8LmMzA@mail.gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Fri, 16 May 2025 13:50:05 +0530
X-Gm-Features: AX0GCFsAPDBZra0kZ9JsyUjn_5f7oXVzy3xU6yv2EY_3tLu1l5VcG4-sOvyDkAE
Message-ID: <CA+rGoLf7jf5r3C2mN7X84HNrWqsA9mMueEkCowm7Ftsgcd5EbQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] update MyFirstContribution with current code base
To: Emily Shaffer <nasamuffin@google.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, levraiphilippeblain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 4:09=E2=80=AFAM Emily Shaffer <nasamuffin@google.co=
m> wrote:

> Mostly I lurk these days :) I do still keep an eye on the list. Will
> happily take a look at your series tomorrow, I'm out of time for
> today. But per what I mention below, if you don't hear from me, please
> don't feel blocked by the review, as I think the MyFirstContribution
> doc is comfortably maintained by the whole project by now.
>

Understood!! thanks for letting me know

> > So for now I will cc Philippe
>
> For what it's worth, I don't think it is harmful to CC people even if
> they will be inactive. CCing someone is not necessarily the same thing
> as saying that person needs to approve your code change, right? So I
> don't see the harm in CCing with low expectations - in fact, in my
> case it would help make the email stand out, so you'd be more likely
> to get a review from me (I missed this thread going by initially).
>
>

Oh, ok I will keep that in mind next time.

>  - Emily

Thank you,

-Jayatheerth
