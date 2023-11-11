Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D571170F
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGvbrIkL"
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDE63AA6
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 01:22:52 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c6efcef4eeso35815161fa.1
        for <git@vger.kernel.org>; Sat, 11 Nov 2023 01:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699694571; x=1700299371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1OpDXpv/uzdg9/QirQDcvPKiRy/mbPKH7InJerLjr0=;
        b=HGvbrIkLqMqRDybja5aZnGHrOO/ZvZjVLSyo248TcUg3j820z2ALT6fyqgsnh19WFa
         1I6YvBRTtlUMyDRblT9xfHHVj5pMJmsAA0V5CuY3jqtLfEFncHmqUVYWa84LS4joevuP
         6KQS5OMK7z1fUaaTkClax1vpV+DtMQRIeSNyUS/juHLObFuPOhtN8A5Eu7zuoCn1l1ZF
         JH3WvdD1pYEBlbrgAfJgtAafN7sYYOPMxQvh4uKiLQapa7nHP+wSLLiYLW6HABoD2VQd
         XBC3WL3UEGIXARrNTkvtMzHoxnYB3mL3voLNbt9E96a0725nU9e3plOsFU9mVJEMbNaS
         42pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699694571; x=1700299371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1OpDXpv/uzdg9/QirQDcvPKiRy/mbPKH7InJerLjr0=;
        b=bY9E8ZNWYUV61+DVoGZtAyXZOfGPAFGeGABNjVWF0VE5xo6odaXthN7mhu37AKofCN
         L44ij+5rzPhCDYxJmU5urIDlSDy5R8W90dja7sh+0eVGuJS76CWX3fhFvnGgdfkz3AEF
         RAfIM6RY3QsivORxjOmrFBnsU997EchcBPJK4sR+cYYqkWxm4GADYROAT9QoJ0GfjQES
         tfCHTt9rNGqE78idHlPkJqAP8bzTf2Q0DyueS0YcGDlmGEk25S4EkySh2QkpC87X4U1m
         sRniXmnP9iu26oGiARO+3y8a5LiQ5zvaa3cSEwpeaf+9YE2z2R4h4l64g4nlb/KdaB6g
         BGMw==
X-Gm-Message-State: AOJu0YwhySQjbMIsPBN7ME3PECMOC4Y8WPjCZii9ZtXc2FFYXmz2VJbD
	75ZLM23/3bhboQZ+IBbgsZWmPu1pFaolQDN64IY8OqVl
X-Google-Smtp-Source: AGHT+IGVsiIx5oDRdRqCdx8EyaevhnZCJITym6H8eIGtJt2OI0WQPm4b8cdBgLnk3Of1iHtCMxbQJgkgwLWSecQ/2Rs=
X-Received: by 2002:a2e:3008:0:b0:2c5:1075:5ec9 with SMTP id
 w8-20020a2e3008000000b002c510755ec9mr1000402ljw.13.1699694570572; Sat, 11 Nov
 2023 01:22:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231104000209.916189-1-eantoranz@gmail.com> <xmqqjzqygg3i.fsf@gitster.g>
In-Reply-To: <xmqqjzqygg3i.fsf@gitster.g>
From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date: Sat, 11 Nov 2023 10:22:37 +0100
Message-ID: <CAOc6etbowajhHsctFJN4ZQ0gND0jzZUrhEkep_pLYtE9y9RBCQ@mail.gmail.com>
Subject: Re: [RFC PATCH] status: avoid reporting worktrees as "Untracked files"
To: Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey, guys! Thanks Junio and Eric for sharing your thoughts.

And I candidly thought this was going to be an "easy sell".... :-D

On Sat, Nov 4, 2023 at 7:58=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> What problem are you trying to solve?  "git add foo" where "foo" is
> actually a different worktree of the repository would add it as a
> submodule that causes confusion?  If that is the case, I think the
> right solution is not to get into such a state, i.e. not create a
> worktree of the repository inside a different worktree in the first
> place.
>

I am not against the idea of creating worktrees outside of the
repository... however, I like them to be _inside_ the repository. Am I
the only one? IDK. I might be! It feels completely natural, if you ask
me.... but that's just my opinion, I acknowledge that.

While I was running a couple of quick tests to add more information
about git behaviour with "my use case" I think I found something to
work on so more RFCs might be on the way in the next few days or
weeks.

About adding an error message when 'git add' will skip doing something
because it is working on a different worktree, I think it makes
sense.... will probably work on that too.

Thanks again! BR!
