Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D90081AB6
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069691; cv=none; b=m6zePM5J5pyvCZk2VQYZdpQ3Zi3oIm1/iSDDX6I05VdpkN8VQmEGX63sk3DgciuxUdvw/bBMC/jj29oGBx5BHRUxy2r4Y9OL4/byPeszse+L9N+4DMIjbY+xgAl71xy5gSwhcjcYNrw/Pf9HqxzQRi6xn4Ii/wefTRIfmfndfvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069691; c=relaxed/simple;
	bh=mtuYsJjzWBQKuD6TU2Isc1MCYdAzRmb0sh++OjtMc1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HEd+UVmS8NCGmJS8It+hGIREsg07+EHyP6VHg6eUo0tt/GdbUe5v1StAzBB/2axPkEIrEjw/Kw5tFv6EHm+ssHKFQqL+o0ylN7u20V4qXVsYm/gxEKjlZOG0A+riRTHUMVUq0GOw3G3VmWIBeySiR99I57eIaXYT7U1HHyv9tMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=koordinates.com; spf=pass smtp.mailfrom=koordinates.com; dkim=pass (2048-bit key) header.d=koordinates.com header.i=@koordinates.com header.b=jb7XylgM; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=koordinates.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=koordinates.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koordinates.com header.i=@koordinates.com header.b="jb7XylgM"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a44ad785a44so597679266b.3
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 07:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google; t=1712069688; x=1712674488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWsKi5POs+Bia6j2LnQuyomI27cqYUYHQDXTGcMSHGo=;
        b=jb7XylgMrH7KCy+KCM7QG0SUBqz/lNbKjGO97V/GycbLB+V1JZIOvccQDkydUXXnlM
         knaY6ahYXOWZ6MeeIGEdsTTzubGc8GaqPioye3RbmYslBdvkqaDDOSjOe9FbxGGTMP0Y
         YdLDZitCGjB/553fzSDcKoe57/0bXxtQ9sJZYLaMpL95bbLcbH3efiTWHZOB3km0TRsW
         TrOb284pANWhdTwN9hlsndG5eaEvYG8XT9xXjf7rnAJ4dAt8BnGygw76TB8iAdw5heki
         Tw+jdYM/Yhhp4Q6VJyfBmsL0TWUhw8GZV9eu5319HYAYS0eCKIaYiH9otbeqRS4nNtIm
         KBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712069688; x=1712674488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWsKi5POs+Bia6j2LnQuyomI27cqYUYHQDXTGcMSHGo=;
        b=DMTw+aDSFx+2v+v5lahnIaJOUTRDUC0IkINV4f/+xkExAahRfhDNfGu7wgJMLGAfSl
         9rXFRvEkT+UDbhX1u/gfZJ3F9wOjYPYEjNUTVPVIzZE2XsUg/E5Dq+OenhjsbPVv7AMc
         tr8+IBSQZKuhAsTU7QzoNQslrUR7fgf149InEP3S1m/2ARtyXpwNoJ+i6XROQq1SmQgI
         1ELA4XAR8pQ7ghEp1pUy5mVZFMay1xq9wSndgvpRYzDY2meDO6xO1mr1mv9IZyzIZipS
         oOnm6uWLEGcsnf4VsoTeRbKuvhx9FDJiUckArX4+CsWHM6ee+RY5oNrRufB6qMrzBjps
         D0ig==
X-Forwarded-Encrypted: i=1; AJvYcCUck7a49vostTxAKFSARbBau9y5Wu4UbuidgHotLdWKkNklKZP4Q01nDEOQP02+JjUMP0LPaOblhl+tdKnuf3lJ4sdi
X-Gm-Message-State: AOJu0YzEvyyORMKjlj5AdLF+eInJ9kdYjX2pynvwDBlHNg7LYxuoEnLS
	KjI9nmgywfoT9S4/YQHdgWSyUHt/8QqwelbpYSwHAuNWeRQsmr6t1BPE7OkMuIZLqrfKkVHFRlD
	7ZXXyX8bK5NoFw/QIHV+XnG+Z4xzxL1FJQQGAvQ==
X-Google-Smtp-Source: AGHT+IG38YgcE2do4k5b4H1Z/TrrtrbKEvOvaJLbrTFJ324gs4jHcuDUcph3r/ntdh2zaUkNKNA9HS8JJJRWHiRK/tc=
X-Received: by 2002:a17:907:7da7:b0:a4e:6a49:c09b with SMTP id
 oz39-20020a1709077da700b00a4e6a49c09bmr4740251ejc.29.1712069687673; Tue, 02
 Apr 2024 07:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
 <20240218204044.11365-1-mirth.hickford@gmail.com> <CFC1A507-A9EF-4330-8C98-34C2B73BC036@boanderson.me>
 <CAGJzqs=wQA=t4CMVu-kap1ga4DX+KnaVMGy71ewmZ7QkFHF8sg@mail.gmail.com>
 <20240307094708.GA2650063@coredump.intra.peff.net> <CAFLLRpJZg3UhBRfihtjUsXcGSod4FhDCs8fD1k-=5SLnAdHeQw@mail.gmail.com>
 <98F1A6E9-4553-48BE-830C-8FDA9F3B5744@boanderson.me>
In-Reply-To: <98F1A6E9-4553-48BE-830C-8FDA9F3B5744@boanderson.me>
From: Robert Coup <robert.coup@koordinates.com>
Date: Tue, 2 Apr 2024 15:54:31 +0100
Message-ID: <CAFLLRp+Dd5M5Y+uoSpPk8-xpFHc_kBJJQfiHr4rt34ey0HAXbg@mail.gmail.com>
Subject: Re: [PATCH 0/4] osxkeychain: bring in line with other credential helpers
To: Bo Anderson <mail@boanderson.me>
Cc: Jeff King <peff@peff.net>, M Hickford <mirth.hickford@gmail.com>, 
	Bo Anderson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bo,

On Tue, 2 Apr 2024 at 14:53, Bo Anderson <mail@boanderson.me> wrote:
>
> The test script does not interact well with the env filtering. This was t=
he case before this change too.

I guess without writing a helper-specific test or having some
per-helper-setup thing it's a bit tricky.

> To interact with your default keychain, you will need:
>
> GIT_TEST_CREDENTIAL_HELPER_SETUP=3D"export HOME=3D$HOME=E2=80=9D
>
> This is because the default macOS user keychain is local to your home dir=
ectory - that=E2=80=99s why it=E2=80=99s giving errors about not finding an=
y.

And with that, the tests all pass :-) Comparing with master where 7/21 fail=
ed.

Tested-by: Robert Coup <robert.coup@koordinates.com>

Could we document that setup step somewhere? I guess the simplest is
probably just to put it in the header of
t/t0303-credential-external.sh; maybe along the lines of the patch
below.

Rob :)


diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-external.s=
h
index 095574bfc6..e4e693b233 100755
--- a/t/t0303-credential-external.sh
+++ b/t/t0303-credential-external.sh
@@ -27,6 +27,13 @@ timeout, you can test that feature with:
 If your helper requires additional setup before the tests are started,
 you can set GIT_TEST_CREDENTIAL_HELPER_SETUP to a sequence of shell
 commands.
+
+- osxkeychain:
+
+  Because the default macOS user keychain is local to your home
+  directory, you will need:
+
+    GIT_TEST_CREDENTIAL_HELPER_SETUP=3D"export HOME=3D$HOME=E2=80=9D
 '

 . ./test-lib.sh
