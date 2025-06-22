Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ED0219E0
	for <git@vger.kernel.org>; Sun, 22 Jun 2025 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750612333; cv=none; b=qbNLjk26asjgDMMUsawR66T8tmObM1ONDh0LFfVHWANEY/oVNDOt1RK4DF3Z6ChOOQGSDvaT62xcrwYNtA6Nc5kBe9ZgQEoyDLw10yJgaj/dccriffbe5b7b30GUJItLccWLjIQXv8OfyddI5uFxRDYcMXw8nMwvaTgAuz3OljY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750612333; c=relaxed/simple;
	bh=ds95/5K9MKEwUKUi235NydLOSym0rd/Xj6cehBMTk8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pm5GnZWqC4Dx5jBQGeL0K5J2xRknjb9r5ZOKMnjbuezHNDYzmSyhgt7pUVGGxtGjUXpw0RWlkDjB5LyEGRXPP0yb9N5vHk9c4csV982TV9swORfOu1Xx1uFea2fQayuLKRaDEXPACYMJ5oK37DUTymdma7qRYBsgZJNLFI+U+r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=QZ8g6K8Q; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="QZ8g6K8Q"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32addf54a00so26997981fa.1
        for <git@vger.kernel.org>; Sun, 22 Jun 2025 10:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1750612329; x=1751217129; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ds95/5K9MKEwUKUi235NydLOSym0rd/Xj6cehBMTk8k=;
        b=QZ8g6K8Qr7mMIf1cqx6jDn+2GQ9NncVwQipbcnym/nZQxrinOEswSttpVXRXdDWvpz
         BmZGzr3OcCYu2GBQ33umSniEFJeLfNNh42Bl9uJhHfjpSxrordMQAtW40C8NjfWKGVC8
         1kwP9KDLbnA+MWTKzi+x08JeX+02Q3mNl+2s1/GuvaznW1d+Ly2K2mq8uDeACbPHnTLZ
         FbnXgDme8ZWJgrDi4hJ1RRwcVDV8Xov+e+b/XuDLYS8u9B4L24ykVsaliAC/nE0fBGZr
         PlRGRAQ/FPgKuKdQZclUtFXyRijhj/xb8yAWjnCXZNH4cobATzUW7VABesDWlzoLNZG6
         oNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750612329; x=1751217129;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ds95/5K9MKEwUKUi235NydLOSym0rd/Xj6cehBMTk8k=;
        b=kswVBFC/WhaAiamIzANx8lX8lUgUHuCW7ZAUgTjb0xuaJlBnbDoGc6Kotens3Z0dWm
         FGT/e8aC4cVDL/ffFZuk1ONtC4M7E1lew3G+UL7oY+PIECLMHTCv+A7EmH7GRYLr7BpD
         as1GDvO6jcMyxrzs8vwSOSvXNKgOVGnNSrpAcTq0DXDLKMcxjCGEvJt+wOQWf3QKojOO
         1hPecphxtifmupVSIRHiRde6rGI3RuMG+E2orCknVisPsBAxQs2PLTPRH8LLO7dWLkwA
         4SGJD/AxHgYTlroJeAjc79cME5bNdJo/er1Qk807WC2nfVj3caOOrx7eVIiOz9tAJCm1
         fSbg==
X-Gm-Message-State: AOJu0Yza296cCyHN7ru+/7WrN6z/JlBv1cElpDv+XVAPHRNsTtpFHD7Y
	W6CqD8lJErdpQ8KaDKZzzucK2Iwn7blQ+DLtSvGVxwJWiL3biPa6ptFS11kSYs6z88qKztkfvic
	bGgWE/1p9BSa2yKnwm2rzK8UxTiqca1l3uBriTjDv6iAcn13V/JjppUc=
X-Gm-Gg: ASbGncveFdMgZdgALAo2jULUWSoT3en8UNLNiaZEPWNVQfyvv/U6MexCpSogwoKIF23
	kIXFsl/hTRZjOYRdQorOD8ugBuwcf58sEq81BYyun5iJY6zmCXjENNXcRnXIQMt6MICaw6cZ7GH
	il59UJOH2L+206vG87+OXfJL3+32yOFYubVor6ik2fAQzvCw==
X-Google-Smtp-Source: AGHT+IHafIM0OlbWze/J0qsSMK4P4cg6qr7vYTzeJMerJO0U/tty73G6IorNLsW1lJUlnmDx898aZ10r70YVW1xtOYg=
X-Received: by 2002:a05:651c:515:b0:32a:81a2:ebb with SMTP id
 38308e7fff4ca-32b99163225mr29558961fa.1.1750612328978; Sun, 22 Jun 2025
 10:12:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615122631.41988-3-ash@kambanaria.org> <92e92b77-f8b1-4e7c-b426-be09e3f2030e@kdbg.org>
In-Reply-To: <92e92b77-f8b1-4e7c-b426-be09e3f2030e@kdbg.org>
From: Alexander Shopov <ash@kambanaria.org>
Date: Sun, 22 Jun 2025 19:11:58 +0200
X-Gm-Features: AX0GCFsWDsShlv8n38ttTbPn98-K4Rh3dupVecyqnQroPg2f_9qoFlxLQrY24MM
Message-ID: <CAP6f5M=cYn_XBN=-zw0ezqFskOSjZiVQwQ60f8k4mb2dYqM-vQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] Resubmittimg Bulgarian translation of git-gui
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

(narrowing receivers)
> not .. obvious, even with `git show --ignore-matching-lines='#:'
> --color-moved`. Is there a way to enforce a stable order in the .pot
> file and/or the merged .po files?

Sadly no. The -s/--sort-output is deprecated (plus it is counter productive).
https://www.gnu.org/software/gettext/manual/gettext.html#index-_002ds_002c-msgmerge-option

The default is -F/--sort-by-file which is kind of saner.
https://www.gnu.org/software/gettext/manual/gettext.html#index-_002dF_002c-msgmerge-option

It may cause jumping around in case a translatable string that was
available in one file,
becomes available in a file sorted earlier than the format but nothing
is 100% proof.

Sorting is not enough for sane diffs. As the location data also
contains line numbers -
adding a line before a message pushes its location down.

The way I read your message:
- you are OK with a translator choosing to submit po-files without
location info. This
will make commits and diffs shorter and more understandable and
reduces the growth of the repo
The info is not used during runtime and is easily recoverable -
generate the pot and merge the translation.
- you are at least interested in moving the infrastructure to this workflow.

In such a case next time I submit a gitk/git-gui translation I will
voluntarily remove the locations.

I hope you are fine with this.

Kind regards:
al_shopov
