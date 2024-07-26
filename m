Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D208364DC
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 06:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721975625; cv=none; b=Sw076/LcfRdt2eCpoH4G/6khn2o5u1gwG2lYvVtqSfD097wg2NA1eHT+ni0yL1BBKSyRHT2JvPqNHeX7BotykbtlObS1h6W7dZ1/xAdr707EoDmp6hb20dkNYMNHlAPjx/ZDwXFNsfTc+KWtRjDDUMBirUFG01d/khP8hwyAvZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721975625; c=relaxed/simple;
	bh=acEYPOBW2O47WenbNfRwfxSJy9b26FGwTyRRDjmzn8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OteNq3aR4pKJVZykdpTMb5Of+uPgjRBJl2b4sdzZFma8uFgDY+iIp5mRz47bQjc4ZsUXI/qbzbRDq7zyQ7+pdxWetWkvwJHwpgvcr7rAgU31w9Yx4g70y10yJ0O1IPoLjV0Psyut8y5c6CXh8IWWmWQY9zWO/Jxhpouz0OZcKnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1da1b0c5dso18977185a.3
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 23:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721975622; x=1722580422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acEYPOBW2O47WenbNfRwfxSJy9b26FGwTyRRDjmzn8w=;
        b=TwNk5RdsDieAn8Ni23HKg/iB9tchjpGDEFLQEtVvKJKCInwfkMImD3L38fPYCXGijj
         SZ+JBt6MBqKdeyqt006vwlier+0wZm8WbAOiyT9Go9fpnvy77Ej9tJ3fPVHGtp/PMT+q
         OAr/uJGiiAQRhBhAJ5Aio46b19YF11akDgZHG6qcb1fnkUZMBxZPJ47n5m16t5fOLzHY
         2tBZGAUJ9HLHRwTrK1OndOnSF2rDr3Z2AZVE+ltMVxvmZb1ch1GkJZuJ4Qt/eyoFivql
         tOJqBgBnQL0z4hWoNJOIovLBjYgnmB74nIp5IOT5BzRLCxw+CvvPr1jjMKJeezDOaPmg
         7w2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbyjuEKNJU1HgfJ1fS5hJxF3EbDjJmvCMfLpUxmRm0gkA4lbQX2egmKcnu81A2bRbWEUBPCfgZbVzTI9lyDYJGnCgg
X-Gm-Message-State: AOJu0YyjWJHXCLy/dRBgqVSb9Rq3qCgAKndwcY7mIuWGbXO1av1uMflY
	dFgk8/DEZdYBOntZSZf+tVrePP//iKFhvJzL1DNLjv9l8RH15YBqttI5WhnqF+8wXlVVF/F0Ccd
	JIaWxG7kO/0lvfPZboJ+nw/29chw=
X-Google-Smtp-Source: AGHT+IGIBxqYUG8cVo6xaH/M8u/4Cm1d8K91NXj9XKIgTvrKzcgCLLI3K/iCc84aS//+IhNC4HTeHmtgIfuM1N4+m3M=
X-Received: by 2002:ad4:4ea5:0:b0:6b5:e2cc:4a0b with SMTP id
 6a1803df08f44-6bb408946d3mr49226946d6.37.1721975621974; Thu, 25 Jul 2024
 23:33:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722065915.80760-1-ericsunshine@charter.net>
 <20240722065915.80760-2-ericsunshine@charter.net> <c586f7dc-636b-45a3-acb2-faedfe1068e6@gmail.com>
 <1b672247-c05d-44f5-967a-9861d715040b@gmail.com>
In-Reply-To: <1b672247-c05d-44f5-967a-9861d715040b@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 26 Jul 2024 02:33:30 -0400
Message-ID: <CAPig+cRfMVZv2hMQRtPmy+HYpxV5=4XBWypPHAL4uwmv8WmT=w@mail.gmail.com>
Subject: Re: [PATCH 1/4] t3430: modernize one-shot "VAR=val shell-func" invocation
To: phillip.wood@dunelm.org.uk
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 5:26=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
> On 22/07/2024 16:09, Phillip Wood wrote:
> > On 22/07/2024 07:59, Eric Sunshine wrote:
> >> Unlike "VAR=3Dval cmd" one-shot environment variable assignments which
> >> exist only for the invocation of 'cmd', those assigned by "VAR=3Dval
> >> shell-func" exist within the running shell and continue to do so until
> >> the process exits (or are explicitly unset).
>
> Having seen the parallel discussion about the behavior of hash this
> construct is non-portable because the behavior differs between shells so
> perhaps the commit message could say something like
>
> Unlike "VAR=3Dval cmd" one-shot environment variable assignments which
> only exist for the invocation of external command "cmd", the behavior of
> "VAR=3Dval func" where "func" is a shell function or builtin command
> varies between shells and so we should not use it in our test suite.

Indeed, given all the subsequent discussion, it is now apparent that
multiple undesirable behaviors have been experienced, not just the one
mentioned by this commit message, and that POSIX states that the
behavior is undefined.
