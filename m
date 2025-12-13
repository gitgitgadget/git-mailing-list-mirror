Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C0F217F33
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765634599; cv=none; b=akMOzz+RvUIyBDx2+tZo7k5vZX50NCHfB+3AZKGZqqB4Yy16MHM3DHD6CLhkY1cYLASRKOheG3PIQfdfZQ4epEjG3f3UV0wWaoder1rbMtAk3lih1gc+qqrCjzbqyaKHRUzVs3LjmecEFtdFXP7CkAz6/0tLe0wYoDM8zLxng4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765634599; c=relaxed/simple;
	bh=DJ449pYfG8BxH87nbu9u3J4qgPA5sO9rMhffSmFgYLU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=fAZWvmwdUtfP9+8QB45ULi5GQWbZRLyL3IGjYIir5YVB8k1zulJCWnecbBq/GN0vT/hzlFvV0ZI3qsCBGUyI1OUCnT5FlmLh2WxPvaPLKwdlZmI4RpnZLMW/reYd8XF4lqqcA04NGnukk8rwmORCX9nWZ4nsZo/ebrNtv4GF1vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maO//y6f; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maO//y6f"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78c6a53187dso22814077b3.2
        for <git@vger.kernel.org>; Sat, 13 Dec 2025 06:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765634597; x=1766239397; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJ449pYfG8BxH87nbu9u3J4qgPA5sO9rMhffSmFgYLU=;
        b=maO//y6fIf++mAVFMWSEq2X8zvNAI2ihFdkqW59lUwmAJEUsn7lmoynhx8Fvrv4VHy
         p7gbrLRY1o3MuUJrjs+2f+09wi6mHYngCPHFvHjClEBNL8io5L6aLy2PjNWZUjpgb6wj
         WNb8g0+sCzMUpZFA6zwi/rpANhkHRMWL1BU2vNG1sp8lzI7F9sb1Cu0JIsU5CzryZO2M
         kL3TbZJ0PGOZ1ILpubkqe4YHx9gBL3W6w4LO2l2jPVhyGfNC7baY8QGhAVlTPD2jujDF
         2mo/b0bQ69gCubtRQNTT3lQjOiyOj5WmiKDFEJJrlt1U/R/mTKqW8hbPzwHsIc1COTWc
         IiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765634597; x=1766239397;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DJ449pYfG8BxH87nbu9u3J4qgPA5sO9rMhffSmFgYLU=;
        b=MHnh8BUtCfWqnL8GG3mvGBqt/MQbm1pS6rJtj8msLzHgkGWBWlBnMgWb2s2p5m5EfV
         8aTWEcCe2aTk2lvSrkqrlJmXml8mfpyDvdeGNVTsRMqmaXzbqjuCx7D7Srelz08BQwCG
         chWVqzHjUBbUNiMhhBIHCgVbQqlx6vtvTL234OrphZfCLIuzb1li4A22j0X8m9EUplhn
         uKFlTkzbcRUDSEtT7Z3dw55FQTh7qY/LI2tD9jzDmqV8w7L18RuWAX98THTmKFiATQ1/
         XkshkNSKdrc3vuud4Vwe1MbPFO4wyHUbI7PqKS6JzW5uc4Vqtc3XsCSDZZclsCWD35jv
         qUnQ==
X-Gm-Message-State: AOJu0YxRCwNUd0KXrF7k2pa3u3XWcNIMW9nn/LmT3d2xZPJEyjjsPKrp
	SyBzrgGGv14Ebu16d7IVeCUI4j1ABav8DIZwtXTYFrG4vMV2AMMjscEL
X-Gm-Gg: AY/fxX4VpPWRa8J5C3nG6jUdKYmgjP+kJa3x1lI5QMG598RKZRNGqhGaqVxVAKSM+dK
	f52dyEmrZxe+StfYypqHC1UBuNJ+IM1RSSlfzd6T6rFJREsYI5Ea+BDBftvfpLETBBy7HdYkPMU
	itABdKNdPgQFzf8YMaHYFdG3vuhLgAwJHt3mfwH37eCybGKigiRYKczKn4cz15JlVTGcXlG1rKf
	i/3qtq3ZSG64zMwQ5bXRO1kcwuagiINcWXBfsmJ1duuPaejltqt+oQt788R0ScpRCOW7eP5wzEc
	PfWu0tWl1HS48VoQU5I/8qKGQdJX0JGllhQc8IPbDWPTY9FbD7QDLHtfn0ikg7YKuqQrb5WYW1o
	iS1J5TRS+1fLaWwaUrP0rGa7meM3+/59sQstjdaEqldm+jqIPdNPv/8+YUN9tr/YmativHlvf5R
	p4NN4QNBH7mp942GhrKEKfku4cl5zMot3HvgMBX3BoAVZD864+8A==
X-Google-Smtp-Source: AGHT+IFMu2/hNMaQ6cDNAE7bfXy/5be5LBpOb/J/8kl/YgJfKRj8quMghFOjC8QhVE7oJkCJjx4Wlg==
X-Received: by 2002:a05:690e:4289:10b0:63e:3994:4ae3 with SMTP id 956f58d0204a3-645555fcadamr2929355d50.41.1765634596840;
        Sat, 13 Dec 2025 06:03:16 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:69ef:b975:8a72:4646])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e748ef7b5sm7490347b3.14.2025.12.13.06.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Dec 2025 06:03:16 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 00/10] Add submodulePathConfig extension and gitdir encoding
Date: Sat, 13 Dec 2025 09:03:06 -0500
Message-Id: <34DD8798-5C69-4092-B6C9-6609E688FBE8@gmail.com>
References: <20251213080817.347922-1-adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
 Rodrigo Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>,
 Junio C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>,
 Jonathan Nieder <jrnieder@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Josh Steadmon <steadmon@google.com>,
 Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20251213080817.347922-1-adrian.ratiu@collabora.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
X-Mailer: iPhone Mail (21F90)


> Le 13 d=C3=A9c. 2025 =C3=A0 03:09, Adrian Ratiu <adrian.ratiu@collabora.co=
m> a =C3=A9crit :
>=20
> =EF=BB=BFHello everyone,
>=20
> For those new to the series, we're implementing a submodule gitdir
> extension which allows us to have a unified way to determine gitdirs
> and do things like encode submodule paths to avoid FS conflicts.

Hi there, I admit I haven=E2=80=99t followed this series closely. I use subm=
odules quite a bit but haven=E2=80=99t yet peered into the depths of the imp=
lementation.

I read over the documentation changes in this series, and it=E2=80=99s not c=
lear to me how or why I would use this new feature (I don=E2=80=99t mean the=
re=E2=80=99s no benefit! Just that I=E2=80=99m having a hard time parsing it=
 out.). By =E2=80=9Chow=E2=80=9D I mean: I can see how to set config and run=
 the migrator; what does that unlock for me to now go and do?

Does one of the previous cover letters explain how this is useful to submodu=
le users? If so which, and perhaps the docs could also contain a =E2=80=9Che=
re=E2=80=99s when/why you might want this extension enabled and what it allo=
ws you to do=E2=80=9D?

Or maybe this is meant to be not too user-facing, in which case I=E2=80=99m c=
urious who would turn this on and why still :)

Again, I am mostly curious, so please don=E2=80=99t read this as an attempt t=
o hold the series hostage! :)

Best,
Ben=
