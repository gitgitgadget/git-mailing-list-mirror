Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B736171CD
	for <git@vger.kernel.org>; Mon, 12 May 2025 21:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747084907; cv=none; b=g3u5VCdX+fD6sNO41p7FF42YZr3qLNCktT/B0VHX4pWIt4twfy6/KROAb4xUjltW9tYRf2y7S4KP1hO3AJY1m3Y8zY/FesCeouo2XErTuSDYn0/Jb+L+29mKjSHM213G140ITdxvSsldxbstEO5dwr4ohRJ2KUMuJJUAGnFwwAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747084907; c=relaxed/simple;
	bh=+/WXzdHklQoXVgL0jAM157CNH7rua6UUZOnzrvHXOAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NStnJLDanq5s+EscAXFvwAGzQbQ2vCkQkqmqMnDxNbLuL48EWGi/SyQY+EXQDiLL7P0nI0p/SaYFtfssRD5zSZmfrMAmTG7gqR79eQKGh3s5znBTB54kHGhzf9nNPO0Cierrn9C6zMjfDd9UNbp5oApYOldvyswiabULBgmGicw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbksWiHh; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbksWiHh"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3da6fb115a6so44465065ab.1
        for <git@vger.kernel.org>; Mon, 12 May 2025 14:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747084904; x=1747689704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weOUGhnmSl8Kr8ZuIVc7yFjJuSb7fQ6K5A9nSGYwl4Y=;
        b=cbksWiHhzVCpdyiAQXQhVwJjKcjS4COp9JsYair0+kk6ImurQ7XnXVod/Euihnvb6y
         17tgbnEImXYqXEVgq97BavXRn9CCgF1cglR+DWaGo8U5NNDkDip4pPpxmjM7vAOyVBtA
         KcgJfxJntG74LhBAP6N6knpucyLhlBqF8FWrmRGNJHefYDh1Svn6PmPL+c0VSKtUuxTU
         PqDgolORb5m9V/NNIORzUJSBPltIdFWjesLDBtUBW62q8KhOgJy0vpnojjaFiAzTQBHr
         E5R1MWMWkc9tTOfxqoA0HsdeIWo/FypFrmZYtMW91k0a7pjzXXyP5lBH9KzCmwH/OwHT
         9ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747084904; x=1747689704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weOUGhnmSl8Kr8ZuIVc7yFjJuSb7fQ6K5A9nSGYwl4Y=;
        b=Su912PevfhUEFWahAp3X14PMwE9x/EJrZ1UBcmbxoFBN4JhahZuzt638x5TlHS1Jsq
         hRyC0ehE0bMjeNCAMFthqW1n8EKCWALCRlqprLYDOG/JeXKCoFlJR66jKX+7Uhi4gYNH
         tVhNcB3xd9h8AyP5zi43P4nHBf51iLPlaK9e01R/glSIjAJ+dTwg3Oif6AVIdbvsce2R
         ZAJ7Y9xSyuWkdNfslx+j6Ofi9BRQYnWxAkFDQdTzk3M9ilkgcLpub10DymURZ22Nn7RA
         OuFGvgTvSYvIhp5N27c5OXxi+N08bgUgATmk4ghBqatAJuYG7vjFr1CP1YUv7Kd60I0V
         oC8A==
X-Gm-Message-State: AOJu0YwEmtUcF1fNGXu6T+nakR2DCm8Pzi3k+BO2CVVm47dVDMb+enz9
	EDzEkuX5DQFCZPxzrhpT/SYEMvwUi5m6BfdNv1pxzupdDLshTpB4GI8/Vuqh7Do8oXf6N7rNT7/
	FpRAqgogG58dJFbQIuXTLNX/jRhSbPS0U
X-Gm-Gg: ASbGnct2lBTZoAEMMAhtsIrdTOtQxvj/OUg1IBovt6VKwjo/UVmcgFjg8eRGMfvU4jq
	JPfSzgzuShPwa+lzFOuX9mDQlEP13BaDwxaIJ4orgd7AmbOAGLHR1egXzeVs5VCCikF2lMTSTSl
	kDzEZg/vs4VEEtyromUCT3liFeHFe6aJXwtmJR1aNW0CzYF0lV/PkgxXAPceO2leAOzkRCJxsN1
	bmm
X-Google-Smtp-Source: AGHT+IG9qVx9FrqCKs8rU/N7cgwisKyaOJS0RqmFQ8TOXNehGx6mMQYKDUiSUFKVnVpjvb9yZcThcUt8qaQKG+Y/z6U=
X-Received: by 2002:a05:6e02:1d8d:b0:3da:7161:23e5 with SMTP id
 e9e14a558f8ab-3da7e1e273cmr173575845ab.2.1747084904487; Mon, 12 May 2025
 14:21:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503005814.3030099-1-gitster@pobox.com> <20250512190311.1451556-1-gitster@pobox.com>
In-Reply-To: <20250512190311.1451556-1-gitster@pobox.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 12 May 2025 14:21:33 -0700
X-Gm-Features: AX0GCFu5u3P5euEZYfmeDOzubGUIKF6Jtsk_yvmsiwVwU31dEo_nG41Cc6Hp3rk
Message-ID: <CABPp-BGUAyRWsnRc+rrsBfPg4hzAoKPMBiD0aH4jxwdO4mEk0w@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Nominating "whatchanged" for removal
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 12:04=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "git whatchanged" has outlived its usefulness when "git log" with
> various diff-related options more than 10 years ago.  It is not even
> shorter to type than its rough equivalent "git log --raw".  It is
> high time to start seeing if it is still being used, declare its
> official deprecation, and announce its removal in the future.
>
> This iteration is more complete than the previous two iterations:
>
>  * The first step is to refactor the mechanism to show the message
>    to ask users to contact git@vger that they still use the command,
>    out of "git pack-redundant" implementation.  This message is
>    shown when the "--i-still-use-this" option is not passed to a
>    command that requires it.
>
>  * The second and the third step are to remove unnecessary mentions
>    of "whatchanged" from our documentation and tests.  With these,
>    we have fewer places that we need to adjust when the command gets
>    truly removed.
>
>  * Then we start to require that the "--i-still-use-this" option is
>    passed from the command line.  This requires adjustment for tests
>    that protect the behaviour of the command, as they must now pass
>    the required option just like end-users.
>
>  * The last two steps are for a future.  In order to make sure that
>    we can cleanly ditch the feature at some future date by removing
>    it from the build, test, and documentation when Git is built with
>    WITH_BREAKING_CHANGES.  And finally we add "whatchanged" to the
>    list of features to be removed in the BreakingChanges document.
>
> This iteration incorporates updated log messages, and a missing
> period in the documentation, helped by Elijah.
>
>
> Junio C Hamano (6):
>   you-still-use-that??: help deprecating commands for removal
>   doc: prepare for a world without whatchanged
>   tests: prepare for a world without whatchanged
>   whatchanged: require --i-still-use-this
>   whatchanged: remove when built with WITH_BREAKING_CHANGES
>   whatschanged: list it in BreakingChanges document
>
>  Documentation/BreakingChanges.adoc           |  9 ++++++
>  Documentation/MyFirstObjectWalk.adoc         |  4 +--
>  Documentation/config/format.adoc             |  6 ++++
>  Documentation/config/log.adoc                | 11 +++++--
>  Documentation/git-whatchanged.adoc           | 10 ++++--
>  Documentation/pretty-options.adoc            |  5 +++
>  Documentation/rev-list-options.adoc          |  9 ++++--
>  Documentation/technical/sparse-checkout.adoc |  2 +-
>  Documentation/user-manual.adoc               |  2 +-
>  builtin/log.c                                | 19 +++++++++++
>  builtin/pack-redundant.c                     | 10 ++----
>  git-compat-util.h                            |  2 ++
>  git.c                                        |  2 ++
>  t/t4013-diff-various.sh                      | 27 ++++++++++++++--
>  t/t4202-log.sh                               | 34 ++++++++++++++------
>  t/t5323-pack-redundant.sh                    |  5 +++
>  t/t9300-fast-import.sh                       | 12 +++----
>  t/t9301-fast-import-notes.sh                 |  2 +-
>  usage.c                                      | 12 +++++++
>  19 files changed, 146 insertions(+), 37 deletions(-)
>
> Range-diff against v3:

The updates to patches 1-3 and patch 6 all look good, but...

> 4:  2775f628c3 =3D 4:  01d4ed9acd whatchanged: require --i-still-use-this
> 5:  b3d4d1f46a =3D 5:  a7aca55d5d whatchanged: remove when built with WIT=
H_BREAKING_CHANGES

...I was surprised to see no changes to either patches 4 or 5.  While
I didn't comment on those patches myself, Patrick did (and since he
already called out the missing word I also noticed, I just didn't call
it out again).
