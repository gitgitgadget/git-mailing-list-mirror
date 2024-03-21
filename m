Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3974D12BF16
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711050749; cv=none; b=ev5wt6xSXWwvYfbetiXBfHIgw6G+yNh+lSE8SHggclOj7CCtQoy3o2np/Cl2yc5jKMiiYklB1ONTAx+mWB5K6Qb4OKOvfbckiMZ9iCnyGgNr1Z1Ap3nyHNPlsghs5Kh2G2wwHijsgA1ylWic4HWQ2POcIpSXl/UtR0o5j2UHUZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711050749; c=relaxed/simple;
	bh=hFXaimd1tfzMgFdlnop5/H2Jt1sKA9ArgasN9+UTgJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmIlnb+OOR6YecDjSIi6ThU0/mZJxyHoDEdJ17vuex+l5AmAfSWCnNEHGfdkAWdj/rxzPEdOG0p+GjT6Rd15jH6n2KR8pV8ffWq3Saouc9GAtMuGZPK1mePXt64CluRy+v+p/WhyTSxeW3/C+N758wTX9eqM77XRxFr9hLWCy0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-690cf6ecd3cso8785606d6.2
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 12:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711050746; x=1711655546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asA+QXxyGlQDinIZ6XDj1ug8vrnCE918YFMFc9jt9y8=;
        b=akSW2GI/zCXBIil77nholnX5UEEwq9rowmf7im8zc7hEVQRHbcQLbAkg7M5uZ2DyTO
         RP5+OItD+6cPuvQOlu9uAxCjLzG3K1jUrOym14YOpB3OBliX7aAj9lN6PNJcbNwyFb7h
         s/sG1qLJl9bS+5sOGybmoec8J4y//YBZ54/c85VvPFEc0Nnt1vukfzhJoTIjPyfQpzY9
         BHpFAniBf1nbqRavSya/mV1Z1T0pL4EQyDwcIGHfHf9S3G2KKCjjHnQnB4s8F8qh0DUM
         qeaTnpoyLSNQ+4xdzExXiyiCjP+MyrJGq9iT9CevUjfLN0PIlgvAz6D6SRzcN6G6cK36
         sPNA==
X-Gm-Message-State: AOJu0Yw5TBWVwheWb/b5GeMLW0YNCb01DlYAW91mCv7xL3dwZu3AEsWP
	LWzWLJakwY8/06TX4eZrOfXMdaDQe7m2paGvc4XrRQbv+drJPy7MD4h2/SAUsSLedc/BzUKFrHV
	VyvjXZVK3CEOpkEmwHWt2b6A+BkoO2YFr
X-Google-Smtp-Source: AGHT+IGhv18Hzc59iRkHWWHRUPW05V7PM5IsZWtS/Vjx6fJjSKlo+f/7uDCNlMJ3bxUNZU9VUG+UTZVHfeIenC5b96I=
X-Received: by 2002:a05:6214:f23:b0:691:59ad:ffdf with SMTP id
 iw3-20020a0562140f2300b0069159adffdfmr156313qvb.20.1711050746052; Thu, 21 Mar
 2024 12:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1691.git.git.1711049963.gitgitgadget@gmail.com> <b8d0620d4104106210ecf6a34ada591adf01cff8.1711049963.git.gitgitgadget@gmail.com>
In-Reply-To: <b8d0620d4104106210ecf6a34ada591adf01cff8.1711049963.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 21 Mar 2024 15:52:14 -0400
Message-ID: <CAPig+cRweMree1LJ=qpOJZg7HYvgE9XX8iFvMKcAGYJpAFGFDg@mail.gmail.com>
Subject: Re: [PATCH 2/2] t9803: update commit messages and description
To: Sanchit Jindal via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Sanchit Jindal <sanchit1053@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 3:39=E2=80=AFPM Sanchit Jindal via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> From: Sanchit Jindal <sanchit1053@gmail.com>
>
> replacing `test -e` with test_path_exists,
>           `test ! -e` with test_path_is_missing
>           `test -f` with test_path_is_file
> These helper functions will run the `test` command with the
> corresponding flags and will echo a message if the assert fails.
> This will provide better debugging logs for test, instead of the
> previous method which provided no message
>
> Signed-off-by: Sanchit Jindal <sanchit1053@gmail.com>

When rerolling a series to address reviewer comments, you will want
the fixes applied directly to the patches about which the reviewers
commented. The way to do this is to use `git rebase -i` to adjust the
patches as needed. In the case of this simple series, you just want to
"squash" patches [1/2] and [2/2] into a single patch using the `git
rebase -i` "squash" command, and adjust the commit message of the
squashed patch appropriately. Finally, to resubmit it via
GitGitGadget, force-push the revised series to GitGitGadget (using
`git push --force <whatever> <whatever>`), and tell GitGitGadget to
"/submit".

Regarding the commit message, first explain the problem the patch is
solving, and then explain how the patch solves it. Thus, start by
explaining that `test` doesn't provide any diagnostic information when
it fails, which isn't helpful to test authors. Then explain that the
patch replaces `test` with the test_path_* functions which do provide
useful diagnostic information.

The From: and Signed-off-by: lines look good in this reroll.
