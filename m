Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2473A257C
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070800; cv=pass; b=CbdV8a/OyrZyzlYzpu6wJ0d70zCXQNL4ObaS5+Z2DHca4Y6jExWbr1iOpUXNbPSTeeRXsCTDRFUNIUpKK95m6OTOWYqdEnlEnfiLBUtjOc0AVq0+2bupZ/+knbvL+zMCeOeJ689bHWtfPuHS4PnFtG6Q8vxGl47hWnxKUXLRwuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070800; c=relaxed/simple;
	bh=9hpYtBT547ZK8FF6+PW+a4QzfJG8PMIg3hKGRDampd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvwG3mke28UDMhyRm14gd0lCSqhZI71wKNbW7+JbSsjN+NM25+jcuieedqDmYMB85FchgZnQZK/H87qgtGpOvE/vdg+Y85hVTrLW127M4IAomtZ/8Ivcu1AG62eUPYUvf+U+kPdB4kU1VMcLk7vL4upYC5jis0WrfP8r9vkhqD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ul6v/QIj; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ul6v/QIj"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4a45b3f0becso95302b6e.1
        for <git@vger.kernel.org>; Tue, 18 Aug 2026 09:33:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787070798; cv=none;
        d=google.com; s=arc-20260327;
        b=brOJvWmpST+BP5qf0v87lABHM5AcUQIlqNqEch8onlFdVKiW8Pxy4IzyKMrj3e741j
         ZrK7eHFuI6C9S3HW3//F6M+NSqtOZ2iJ8/gwxqgzfTrldHG+ETMKGRMAscP0CzYMLvyV
         B+/4a8lNHPiHmb+RBsti5Ge5GBIbYjZ2cG2h+yQturA6NmFZUGwGNC5HRmrU4Tbk3xE9
         5Wpq0FtC9xn1iAZNwFEg69QSKjnG6kIDX8N0x1Jq3EiSCiq1wtuTgFNdQ07mMHjwmTg2
         U9nDxxaS9Qn4kHg68RF4O3G/ifwKhij6yOaGWX1FFLbxMxn6K3rU1AGuul5Qi/F2Kr6i
         M4Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9hpYtBT547ZK8FF6+PW+a4QzfJG8PMIg3hKGRDampd0=;
        fh=2fKBGui0CPLp/DkOGwBJS2c6k6TbQqR+qLNrnXY2Uzw=;
        b=ZttcpJFBWxxxEwq6TkM152qr4bdvC1sGn2zcMdw0ARVTJHiO/cUEkLuqOBbru9pEPL
         /vEFS2XNx2gzEfaQsOsUkM7GzTJfLrxORx4eVJXO9CXXUEQk3sv5h00sHqkLeusPcDYM
         JH5gXoc7J0uR5Q571fACK2ddpPKWQkUZDrBOXeXJcjxPm6ir5HdGNFFeDqS1rcgQBQ4P
         W10JwM1KIRft9qm32KUcBfNsdNeWsaK+Vz3XVVSvBmSlAsgSLPMEpBlt1LXxuIMs32gR
         dg265g1mjUh+JkBKUka7jGc5Wswdu4iIrJVpEVQ2N82OsE7RNlAX4Ug7pxl/jZUsPs5G
         FccA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787070798; x=1787675598; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9hpYtBT547ZK8FF6+PW+a4QzfJG8PMIg3hKGRDampd0=;
        b=Ul6v/QIjElH7qtE1mPquw4QBcFmRxpi/5XDGw6ZV5mv6lmNBMITle9G45up/P2qSSB
         qyDs/1O8ItUr8R659QobobFoTXQWcYYZIeHD9Lr9jS+xO6z16sjjcx3LPYyf4H9kvBpv
         B7Smj64pNujdl91QGOe9BZUBGuvWT11lVVTs4YXxmp4QuFcjTl4mWN3RRIhNxyoFnjEc
         bPEVpUyz304BgZePZvDfoiGGVOTibPaF7cccXgKay8in7GfDLlYYWP7vJ5hXm2JXkZ9y
         WNERxphRQOpdDjWh2lgWExbqH/cF81Dy0GHKs7epUd1++NyGXIV6CgFf99zO5z7C8rRI
         /TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787070798; x=1787675598;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9hpYtBT547ZK8FF6+PW+a4QzfJG8PMIg3hKGRDampd0=;
        b=kqnxx+jX/oisot+zEuhwDL+WDdNfHPncuN54b4EOB4419edeY1qkap6tb+RcTjUDwq
         iJOweZK9ZF2W1e76wM2kvfKdICXQ0ezK0UXYgfgx8+Ib4yjzkaQJCuBDVZx8QcQTQ2Xt
         W0FPg2n4d4wRyqLa6FMJBXu251pbnukrLcObc1oeWr3ykVg65adyu6iG7z04XX1L0qq9
         /05tgxHdr7lsZtPJ7l+Vk3W53rC3oHBfvxnDneOsWSMXi53hg9QFRt8MUZOEd2mImCd+
         O5CNqqELsQdakdWB2Zg5IFlKlrKk0DDf8mLxZq8UMJke8lN+i6yzCivuRVHRFDbTODoM
         B8Xg==
X-Gm-Message-State: AOJu0YxVX7z/wCQV5tXQxWDLUkeByBS7qmJrA54Pq5b2pqNhrph8KTX+
	W1FBilcSpbKYALkhNmjoMRtFer8r6P/toA9019fQ30dqMa1KKxlR4JkUXiQEBIwbyd680PaiC0x
	nTcZ+O6PcQoAGqbGk4JJIf1GWD4shCDY=
X-Gm-Gg: AR+sD1157nBEknh8DRZyZBDnCIj5wsoCQAF5eTLR2uYQpVe6nrmEspIJY+2aCNdIvKF
	5K7XyCsw5BHlSBlSVy9QGj3AaUEKseMSBDbjhzpIgGDZR+qBVrZ53TkkzvEQ7fJ1w2j3Djpl14C
	/ct6QIom3q59u0u5ssnB9Wid/ZbibA0D/cIqKBYETfd94dtbWhtrRC9r4L7AgXEB2kzhqLKzpOU
	wuoInSHZbrzyhog+x7lBNg0cz1qSLb+SLwMIu1Qrs5ZhWSuxnivvqyR/RAJ4qJ9AmGgWXifkYGT
	GsPoXj7aUJS+Vr0slRZcftXjOdABXlcGFXey/QLF7wODF9E5tdJYgTvL1wUL4nPBpo5bQGYfBta
	XtTT920OqEvWKTTxHBP5rauJPSV6tsWDFDnqXHjT14gtShFSt67KB2OCdiuWrrq0=
X-Received: by 2002:a05:6808:6783:b0:4ab:32ea:95f6 with SMTP id
 5614622812f47-4b297738ea9mr9069459b6e.13.1787070797677; Tue, 18 Aug 2026
 09:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260806101556.162940-1-jayatheerthkulkarni2005@gmail.com>
 <20260806101556.162940-7-jayatheerthkulkarni2005@gmail.com> <6E2B0ADE-2101-47AC-B11B-315897AC2AF9@gmail.com>
In-Reply-To: <6E2B0ADE-2101-47AC-B11B-315897AC2AF9@gmail.com>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 18 Aug 2026 22:03:05 +0530
X-Gm-Features: AcwNN1UtSSfzSdskHoEMqYRrJSJPz7Sk4xm0zb_oVAPhCZED_FS2CLcEvaY3oSM
Message-ID: <CA+rGoLfPJb_Pxjm_Bkqd2Ni0BA1vT2LEObwj4EjUaSRRNyRv-Q@mail.gmail.com>
Subject: Re: [GSoC PATCH v4 6/7] repo: add path.git-prefix
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 6:24=E2=80=AFAM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
>
>
> > Scripts sometimes need the path from the repository's working tree root
> > to the current working directory. While this information can be derived
> > through existing Git commands, `git repo info` does not currently expos=
e
> > it as a scriptable key.
>
> Even though I understand that this is a relevant info, it seems
> to me that it's a little bit out of place here... This is
> a "current directory information", not a "repository information".
> >

I agree that path.git-prefix is technically current-directory information
rather than repository information.

I included it because it is useful path information for scripts
operating within a repository,
and it is already exposed by git rev-parse --show-prefix.
I thought it would fit the purpose of this series, but I can drop it
if you think it is better kept separate.
