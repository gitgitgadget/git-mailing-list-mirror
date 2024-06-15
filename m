Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F961DFC7
	for <git@vger.kernel.org>; Sat, 15 Jun 2024 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718469408; cv=none; b=XnVDR8M4sP3lskHgitMlFP6/9W8OBhDxskTSfJ+eFkvlb4nDTZdDbtHzA8wUtHNapY4TuilmgWvlL+dGrVc2Ru4atZW4+3g48JrFiP2iAbtUunHZitMRyOhl/CJnqHDbm95MqfeleK5PE8/EMJuYMeoCnKFRHyTNVutl6npRk7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718469408; c=relaxed/simple;
	bh=GGN1RUf4UeTfmQbmiBESneU+RoJLYh/FE/ZUeqBRQ4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jryHPlZRVy7KEPV3dNBZ+zDcxqCF0EP/NxWHUAoodabLKTEV6kvMO7Vc/JBhYD8iQncLZO5qc6/ntgUmt7c2xDTLOXibzSISoJS0LUikW0zr04pRykh76dsjGmSRMliQQhf6+97YsL/4L46jDrZYEaczdRqj9tK1pt917QeASNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b065d12dc6so16233406d6.0
        for <git@vger.kernel.org>; Sat, 15 Jun 2024 09:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718469405; x=1719074205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGN1RUf4UeTfmQbmiBESneU+RoJLYh/FE/ZUeqBRQ4w=;
        b=LI4/26Fr4FCuwZuuy6KbUQYSH0WN/ES9WSSUcC1cI54/uJrdytHhIOzx17LbCezA4g
         movxDEplm4tBoYE0FAXtzNCBxYoMNIaNe4zSC3YNR9RAu1dk5W4/dGn/s4oCmUHmu/Ux
         a3AXp/epp2fyxKUZSfuhTAuhzO/y0de1HxhAxkQ7SNPUV7DSeLHPb5PzpYYJiWQc3a7I
         +ng7hKa3PZGWDUyVj3qaKQSZasA2vzQMOmgp/OSEbm5oiWrxJFRABxLmcQbXUgxMoM99
         R4B1YSDtG0simaSmyMrRfmQyWXd4/6MsR/kr18Ujxkc6IiZLTka6pJ8gpMkbog5hBllI
         Evpw==
X-Forwarded-Encrypted: i=1; AJvYcCXp4t3tKw0aXXiK2B3Clvc6KOfLLKPXUmvNeuRIb4mabPECwEE1/Y0IPivDAQ6zbaH5W1R9EhjvpJV8RysumoVy3tcL
X-Gm-Message-State: AOJu0Ywm/pPuJEipI/pTNLGPKOaPSGUl33ZCdFcwgFaCOBBmCndQYHwQ
	hsyfyHGTyFeB0UpaUEMLBwZblSU+4sbbCk4ohWF0n8lw32DzUBHJBaloDFs1fhJIUsko+ct/4vL
	vbmtatlrGoBIBh1HSbEg4910QXJQ=
X-Google-Smtp-Source: AGHT+IGCIIAssC+kyU0TN76Q02Sm9JgSgduHx/I8tYH/c1+/LNSyvwlwgmmCz2wja3aACuJIjJCHYiB7uf1kTUte3K4=
X-Received: by 2002:a0c:e80e:0:b0:6b0:7c52:ae4e with SMTP id
 6a1803df08f44-6b2afc9a89bmr63368036d6.24.1718469404839; Sat, 15 Jun 2024
 09:36:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALyzih__9sZD31SVMECcxk55+MAMjkfgpLzecoHo0xUoauerqA@mail.gmail.com>
 <CAPig+cRGnAcfpr4JWp9WWC0b4yvjKx-_0up_S2iaXCBxgcSLjQ@mail.gmail.com>
 <xmqqbk43dyln.fsf@gitster.g> <CALyzih-5qtezCnizj07Gi0MyoeweXU1Kw5-gnv7YwSg0DC965w@mail.gmail.com>
In-Reply-To: <CALyzih-5qtezCnizj07Gi0MyoeweXU1Kw5-gnv7YwSg0DC965w@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 15 Jun 2024 12:36:33 -0400
Message-ID: <CAPig+cS0LhojBYtc9rEDo0Twb+1yjLy5fodCPOF6++1gmx2MWQ@mail.gmail.com>
Subject: Re: git grep bug replacing - with :
To: Rickard Andersson <rickard.a1992@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 6:22=E2=80=AFAM Rickard Andersson
<rickard.a1992@gmail.com> wrote:
> I tried to reproduce this in a more isolated way and did Eric's setup
> where the issue was reproduced again. However, I realized I should
> test this without my gitconfig and could then isolate the issue to the
> pager delta. I then noticed the issue is reported there already:
> https://github.com/dandavison/delta/issues/1674.
>
> So this is clearly not an issue in git, I should have tried without my
> gitconfig before even sending this bugreport so I hope I didn't
> take too much of your time.

The benefit of having posted here is that there is now a record of it
in the Git mail archive, which may benefit the next person who
encounters the issue (if that person searches the archive). Moreover,
those who followed this thread are now better equipped to point future
reporters at the Delta bug report you cited.
