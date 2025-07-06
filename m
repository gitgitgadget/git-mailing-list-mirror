Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF97815B54A
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751830613; cv=none; b=E4SgrmBqjnH7+V/NmnU6Oqk7RPEOHySXlw/AAIIYYC88buxeP+A7wl6cLdCceZgocB1xgNw12scSTSDr234Z3FHjJ1+0xA1jaD4yVraBXxoIZtLiL+g8FEBKKeRPyCdTlXRoluKyqobh1GV1o/m7f8THIHZ9ecIfRcFHKLP31r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751830613; c=relaxed/simple;
	bh=33mg/uls5hGG6cJ2br47h7hrzjALxZPPK8/dauszg5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODveyXt8NnnumfYigrENXjCKLp4xNc7YPpfVA5n5M26ek13UCZwqbBY6aisJXfUkZ9yxlpDvLjJpInoXRamrLm6cmniAbEBqMVD1v1Af8V0kd1DQdQootEdSfninr1YUlP6C+1xTOTowJGnAgEvVajt7PnOHSvvDf+szkBtGVfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvufYhJe; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvufYhJe"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2f75f1c7206so647654fac.0
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 12:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751830611; x=1752435411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6q7pY4gKIpGI/Y9PX3oODBCmSgAcJMzVDIh0Qs3RMyU=;
        b=DvufYhJewL/DlISgTzG6/+T9m/jOlmXt62cwOMgpXVdocR94f3KcKyagMgsbY19hHd
         xP8U0q1bZz6SLjS35d16TVRZ3yNqTs7NDIOp/DJsNyrKJFy3LSozplwsB3Rm928+R7eP
         kkHjoF0EK+PFVgweCzsAW4TBQRx5gUb9TJHo+JnVpe3bIsIX/tEruFEQbk4kM2HwKwiL
         nILnjhPGl2fYkltnIhZoosPIhqoGuGVmrYOSgzAPFIjf8SYxGJmcnUFqNctMDK2o/5W1
         cLUppkqjTID56VzEkXbAZ1GOwGEtMNqLhVvM0trMTeBT0KNG3mmYP5sd0E0t+dGUej+/
         fjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751830611; x=1752435411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6q7pY4gKIpGI/Y9PX3oODBCmSgAcJMzVDIh0Qs3RMyU=;
        b=aLq9a4VNaUt/+j1pR7MdknMCGqV0dIbWfPceQ4wtktdS8tjKknKuRC+q+hLwmTQhsX
         IuNXSZBNoFH8cOiyKUIay/IOkgYQooJruL7+FodY+0DO3m9mfQZtYqopoAMumy43fdN8
         9CHlwZaYB4RBbAXmpmugDQKYlfPmxoYhhJu7hZ08g8YvXRjYKPqJ5IG29epZ2M0qu0hg
         h2Oxft5Aavg0L+hNLbqDJHmxKYYDBRgz8WLh5XreHKqbSFU5i/6Mgnnjoqs1msPwvC6c
         5RrGbbM9WSfOPw6/OtmiMKb30pxXTsmm1K0bEEhwTv++QSNPJjQ9sOBUT5UJoQg0+SFS
         9A/w==
X-Gm-Message-State: AOJu0YwowkoTdTANWTxDcMWO79iNxiISa40Yyyjfj+yR1j8V+NSEjw6V
	o15e7M7PdbMmwEcml4ZhZfj5GFp5GVQRdrXr9pedN1IFSY4Ajihkl0j59AsxLt5OpL+n2B5Ec0D
	yf+uP7iGLV0vIkJAwWbTO09laun/EMv8yYLrc
X-Gm-Gg: ASbGncu5aVt9TTXzdlhwm+Ks+DZUuaa3J7LHe/1qasv4e33Ga2npOz97bQbR7hC2qPv
	C5miEuVMoQXkJ4o1qyLBLTrb+1GiLPFeZBNX5N/fKKEALs4M4FhyDpPNMgb/eyzA5y9YG1dBuPk
	6WebdLDfP6usfFP+p0bBKmZxXsLYQ2P4zX0WESATUlyA==
X-Google-Smtp-Source: AGHT+IFswYqgBnwoSLY+Ex36G6877inTQQyIlx9tJ1rJp1AIz2Y6YQYK4eZ+ZBobPKEUVXsA1nwEBH/u+/VlriNFj64=
X-Received: by 2002:a05:6870:48e:b0:2db:a997:7a62 with SMTP id
 586e51a60fabf-2f7aff300b0mr4830725fac.17.1751830610693; Sun, 06 Jul 2025
 12:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250706163009.335780-1-sandals@crustytoothpaste.net>
In-Reply-To: <20250706163009.335780-1-sandals@crustytoothpaste.net>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Sun, 6 Jul 2025 12:36:40 -0700
X-Gm-Features: Ac12FXz_UObfBIlbyexVgHdmQygDpO1iZH82k2P12p_CszQZY9lEzg0tKjlAYTs
Message-ID: <CA+P7+xrZVG0piKt1gd7heEibdXud8Kt=2eGd0KvHTMwNp7RcWg@mail.gmail.com>
Subject: Re: [PATCH] SubmittingPatches: allow non-real name contributions
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
	redoste <redoste@redoste.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 6, 2025 at 9:30=E2=80=AFAM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Our submission guidelines require people to use their real name, but
> this is not always suitable for various reasons.
>
> For people who are transgender or non-binary and are transitioning or
> who think they might want to transition, it can be a major obstacle and
> cause major discomfort to require the use of their real name.  This is
> made worse by the fact that Git provides no way to change names built
> into history, so the use of a deadname is forever.  Our code of conduct
> states that we "pledge to act and interact in ways that contribute to an
> open, welcoming, diverse, inclusive, and healthy community," and
> changing this policy is one way we can improve things for contributors.
>
> In addition, there are some developers who are so widely known
> pseudonymously that they have a Wikipedia page with their handle and no
> real name.  It would seem silly to reject patches from people who are
> known and respected in their open-source community just because they
> don't wish to share a real name.
>
> There are also other good reasons why people might operate
> pseudonymously: because they or their family members are well known and
> they wish to protect their privacy, because of current or past
> harassment or retaliation or fear of that happening in the future, or
> because of concerns about unwanted attention from government officials
> or other authority figures.  As much as possible, we want to welcome
> contributions from anyone who is willing to participate positively in
> our community without having them worry about their safety or privacy.
>
> In all of these cases, we should allow people to proceed using a
> preferred name or pseudonymously if, in their best judgment, that's the
> right thing to do.  State that it is common to use a real name but
> explicitly mention that contributors who are not comfortable doing so or
> prefer to operate pseudonymously or under a preferred name can proceed
> otherwise.  Use "some form of your real name" since some current
> contributors use shortened forms of their name or use initials, which
> have always been considered acceptable.
>
> Retain the prohibition on anonymous contributions that the Linux kernel
> has to ensure that we have some line of provenance to a known (if
> pseudonymous) author who might be able to respond to questions about it.
>
> This helps guide people who would be fine using their real name but have
> misconfigured `user.name` thinking it is intended to be a username or is
> used for authentication (despite our documentation to the contrary), but
> also allows for a variety of circumstances where the contributor would
> feel more comfortable not doing so.
>
> Additionally, retain the section header ID for ease of linking across
> versions.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---

I wholeheartedly agree with this suggested change.

Reviewed-by: Jacob Keller <jacob.keller@gmail.com>
