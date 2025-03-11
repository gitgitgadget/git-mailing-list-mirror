Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D01263C84
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713663; cv=none; b=ZXwECmgfqYoq2CiOx5n3McW3IQbd9vpsS+r3KTzVLo6OgD0Cd+wMXpwrZ2iJvmH2zBnxFKDMiTFE31KpBm92pcTfMF3wcCuf1Al1kZLppcwuKNadMNwa8CRZoOwZT94LAq91gT7rUn7g9cKLcQZ3VmC66hQ31AWs4WsbFnscv/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713663; c=relaxed/simple;
	bh=hQt/XYt3lZvtbVEUuEr6/Z/WcCKnHFNq0nvL0dAVttE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvgtVIdAYpMlst3mKLGKNdDmxCJRc9Z4lpR0XfRX1jbqOk0FFJtoBRxaeEEuRPH7LzobHAJsadonHwKVv9YNbPuW7fBfhALRCV9mnRByL9rn0j7eEJFgpV64xjkhDShACdrfW6MbzHPdC9YnmPWkG3mFqNtjA7euCfpIzJKWJWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juYCGyOu; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juYCGyOu"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff6ae7667dso10975222a91.0
        for <git@vger.kernel.org>; Tue, 11 Mar 2025 10:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741713661; x=1742318461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQt/XYt3lZvtbVEUuEr6/Z/WcCKnHFNq0nvL0dAVttE=;
        b=juYCGyOuTqSORat+hn5wKEJ53sbZTTJYpYeXoIJ9ubIcpkpcuOkNkWTAV4XfmfKWjk
         koO8UBIwbWEQgGc2ODM2hXx0UQkUiuCjMM8bYsYc+Fzut03VTL5yU9ANKTp/R4o4PzMF
         oW8pL0AMqmySfhZfBAutGKgIQEe19PSe5/hHEwfUz+zHmrfsBCFB/VscPEKJ7uXo0iaM
         BRd9Qaf7V3meGLW1ZjWwGcLZzz542RmZY8xBnhBHLGtOKfRxvxZ77rNJUsFgPDOZOjaX
         cia3/NPfXSd+a3IVwXvVMh+2We8vYtcIrih6GeKKgkDHSKTm0c0p+Kk6YY3CDVboU8aV
         OsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741713661; x=1742318461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQt/XYt3lZvtbVEUuEr6/Z/WcCKnHFNq0nvL0dAVttE=;
        b=O0aBEH2ro1I6fB2p2dS5MKPrRl8QFipMuz2QyJ7Act9DRrso6JD4X6qxnKMhoeabIo
         Ija/OxHBAK10u1p55+hXTa8HbRVrb9I0wpj2jP2s0UFDnmqShpb7VQiVrMBAv/QJ7A7s
         xuI8plEBYq0ZNzIUWdRBgRSDLyE7qDFzPBBkqfXYA4PvOdDZffK4oAcypFeNe9lA7Fqg
         rP0R6WKKMYXuOlLjyxjrYF6NAskjZBizhRSPD1BYf+tLfJmBnqZr4bHPXRAGgYSQA3DM
         WTkH7bs6qeDJHbR2xDHuzZYtEditzfnylAiJKXbFIJuWiG2jzWKNikZ4Mwjt/A1g8PDu
         RTew==
X-Gm-Message-State: AOJu0YzNhpON6siH4R0uOy0ikO2vfei2TXtusBM3CkjuagY9QmWy5j8+
	iISu46tZFc2elYznNrnDbKFFdUop94Wq3bhtrOgkeHaJWT6h/9jbwQrMM5kIFnpRZk6IuB9GLWE
	2B4OXnHsIVFJp2z1zWGf3Ui/66WFBWQYjXGLoMA==
X-Gm-Gg: ASbGncsKtr40Qv0HFb8YDNcgvfKvEI+46zvCm6o16YrtZ6KB4zIknUUq5X95Lo79DUZ
	HeO7GTv9kpundWehHb1lVuaomND8dShpLaTsmnb66govYh85RTHwnFbYfVQhsBsaDfny2pmrlKs
	jJxfMFVPjIAUyvKbeBldBqM6ysJi8=
X-Google-Smtp-Source: AGHT+IGURAz4RKPOhAZA1Ah215wHVSUJjy+9d2wE4+Fpj6BIrYb7A57ju9NBOcz9yUTUXRJKnbqG7Q1tAlAAzyRRQT4=
X-Received: by 2002:a17:90b:17c3:b0:2fe:6942:3710 with SMTP id
 98e67ed59e1d1-2ff7ce59681mr25521461a91.3.1741713661543; Tue, 11 Mar 2025
 10:21:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309153321.254844-1-ayu.chandekar@gmail.com>
 <20250310151048.69825-1-ayu.chandekar@gmail.com> <20250310151048.69825-3-ayu.chandekar@gmail.com>
 <Z9BLMLXJ7Desl-n6@ArchLinux>
In-Reply-To: <Z9BLMLXJ7Desl-n6@ArchLinux>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Tue, 11 Mar 2025 22:50:50 +0530
X-Gm-Features: AQ5f1Jouj7uhQm9IXdGcfH93pG1m3l31psUaR5ARK1RxJ_8-GqTH8_R7uJfyMbg
Message-ID: <CAE7as+ZROO1GiEhXYga5Nqmrs5Xr=k9zsAiP2y0xzuny1ws+UQ@mail.gmail.com>
Subject: Re: [GSOC PATCH v2 2/2] attr: use `repo_settings_get_attributesfile_path()`
 and update callers
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> If we use "istate->repo", we don't even need to change this function.

Oh you're absolutely right about that. I actually just got to learn more
about `index_state` from another thread where Junio brought it up.

But now with his suggestion that attributes may not belong in the
repository struct at all, I'm a bit unsure how to move the patch forward.

One thing I did take away from this is that we shouldn't be cramming
environment variables into the repository struct. This discussion has
definitely helped me think more clearly about the design, and I think
it'll guide me take better decisions going forward.

I=E2=80=99d really appreciate your thoughts on how you think we should
approach this from here.

Thanks,
Ayush:)
