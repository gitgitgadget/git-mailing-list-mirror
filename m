Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA12D30E
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1G8K7dk"
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8009F1728
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 23:54:35 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so11227939a12.2
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 23:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699430074; x=1700034874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sBdrwb+Wfu0U8zcutLA2OMJ32G/QIZ4HlB8hwPzpIM=;
        b=U1G8K7dkcVbwNXmd2JbVwElVtL2TV07qF90ob7iAKrZzEHeF2JCmz6o/NkTgla8n+Z
         LHrTvu6xq5/UB3sqSC7o41JUtenvyzWjLVyL1eqJ4GBnGAq1eAsuqiBtrCctKzdUJRBU
         8C+egjLnt5Bsi3QqAUrkU5oQZ9irqNO8AjsEB23nQ5kD0fNzjEHVCT/PkgV598ueR/jd
         NVwrm9Pa5BFljxoZ/cU0B3j1Ry7vmAF+hMZF/o7CMW2CNLEW5Yz/ISzIjOocS7iQeMLM
         kChJ5fm8HwHZlfARzpyTTS4gbmihTGKCaBDwhJQvdTBGiRIv/1aVoq/aQkqKdEamB+HU
         TcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699430074; x=1700034874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sBdrwb+Wfu0U8zcutLA2OMJ32G/QIZ4HlB8hwPzpIM=;
        b=sUvNlG5OOpRLy+s0PVbM29ZzMqYwv+X1cSadC7E/StT4bOejG5TVdbJJ+wz76TWhsd
         /9SY86j0qsKpTilQFLESF+icscauzeKA/bL8Csnr5XYigk6+PeCOChys8j2yWWU49uD4
         gKan7/4o5wCcG8TAcBwiKD9ClTGouRjJBRXPkVDKj3No23bz7PaL63oB7LU/zGsl/Xhp
         rpb/7NOpIfaedP4hjH6isZNUkwY1BYKdXzbweL4cfE5WZ/RBG7dZT9nYasIqQhvqkxYv
         2DbenftTMLpaNxvTIuVLSRXSVMVHC9sHQ6YGzARHZqhUIhU9cVrwL3cOgFdtGNc8NCZv
         MWmg==
X-Gm-Message-State: AOJu0YxCE89XiauYpQyEHrc7/fDxQLSjmQZz2GgCxvbcERdLo5LSqAKP
	aA5ASidagyPvrMCppYKOSNVa7p3X7NvWpoJufZAwQWBwsBmCJQ==
X-Google-Smtp-Source: AGHT+IFQ7AXFqHeMXJF6D3ebrrfdsmr2u0Y9iretT6AoKZyjpoTTqlrdORWM6cpBnI65Z9mCzvB3Ts55dfiO3TYXH6Q=
X-Received: by 2002:a50:d696:0:b0:544:a163:f21d with SMTP id
 r22-20020a50d696000000b00544a163f21dmr694131edi.4.1699430073757; Tue, 07 Nov
 2023 23:54:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <88eba4146cd250fcabfb9ffa9b410ce912a82ce7.1699320362.git.gitgitgadget@gmail.com>
 <20231107192326.48296-1-oystwa@gmail.com> <e166abeb-3566-4acf-a252-bc493ee37f41@github.com>
In-Reply-To: <e166abeb-3566-4acf-a252-bc493ee37f41@github.com>
From: =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Date: Wed, 8 Nov 2023 08:53:57 +0100
Message-ID: <CAFaJEquUBYUO=scjHw2qrUyP-4wZJWtdmWAtRrW0mH9x9PbZZw@mail.gmail.com>
Subject: Re: [PATCH 2/9] for-each-ref: clarify interaction of --omit-empty & --count
To: Victoria Dye <vdye@github.com>
Cc: gitgitgadget@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Nov 2023 at 20:30, Victoria Dye <vdye@github.com> wrote:

> Since the interaction isn't clearly defined at the moment, we could proba=
bly
> still update it to work like you're describing here. I'm happy to drop th=
is
> patch and implement your recommendation in a follow-up series. Let me kno=
w
> what you think!

Regardless of whether the logic is changed in a follow-up series or not
I think the current behavior is worth documenting even if it doesn't
exist for much longer in the tree. So I am favor of having this patch as
part of this series.

I am also in favor of changing the behavior but that warrants a separate
series and discussion.

=C3=98sse
