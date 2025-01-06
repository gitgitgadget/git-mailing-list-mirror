Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD5815DBA3
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736205451; cv=none; b=fHbOQty7CM2PRiME/S1yT6bzdGTbRc+WIjHiNbC6lSHvzLWOqlKFwnFmKJSFQ9I9S/PLdgQ5ZoAXmOKXF+7iRJ91nzFRQprcA+ndl8qXHL8b3tzDAiYCecG9NGdta2po72fc5RD7fvZ3356SEPc4CTGczdNKxnEWaABGAcsKISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736205451; c=relaxed/simple;
	bh=5dJvpGYfbreJJng3eqVhpS45K/yNzWfCBtS2QF3/7Uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhjkvNDoxf8lpNJ4iABNlxTUfpu606+8O4guQoYuXti3AqaGd3JRT4w10gYZ0O4BOu/6MKHmAkPhDj+epjcdQTG8rlrgNK1fGvYA95BS4M4O6ytadJlz1byjT1wGZXcrrMZT51q8KhoQQ+kTPcqqqh6wgKtlELMdnHwoLBsA6bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b854e69bdbso170414185a.3
        for <git@vger.kernel.org>; Mon, 06 Jan 2025 15:17:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736205447; x=1736810247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhUVo8Woq0QW35CFDm2rxEr8jq5P+xg2DwOiQ017/Sk=;
        b=NSidehtn8j7MkwKgb8PadRdb8rpgKCeZGKD6JiGlKGD6wKx+qzaqFOpf8wqUYC6u7U
         kgpsEV+UCWNfrG3Qd0LNsxKX+U8EYLAL2DLqQsEOxaiQQIFNOcmPt8yFPsHU5BCwrLL6
         L9gSqvdKNDINWGkwPxb/vZDDniEFoDz2vfEQ4DCffgzVb1IZ/0L266Np98YZvGWvCbgw
         J50DXR5zrvxVPFbq8HOrtP7HjvJRM2/TrFv2m2qyQIV7PWTTNP9NGUf/L4Jx/oLlh+Ym
         rIbfSxf2Xe/cwqw5szyPfRUDvzvsaJqTv2ignUCS3lUrht4bUvdQuJoHpwstI90WMeUZ
         fvSw==
X-Gm-Message-State: AOJu0Yzh01CbTyTLHrlYzwPMypvcZtcq4dIQK5RwsNXjwxokEUWUHVEW
	HxE+jBiqfxGFD0dQBDw/lvY5fQHPpqUTJJkEBJVkYi9faTTAHSt7lw3reIckCDAd5x83jNUoLNS
	cxEKOXAxWIbzXkYKWB5OGyBBUI5A=
X-Gm-Gg: ASbGncspU7iCTNRWt8PuoWGHx9rXHupG2MMwunR/vDdO8C0PqoQMDJuZzbtH9B5CrGc
	B8ooOu3Ln5YGZt+zKCJDud0mUjUNIBYiAW5BDVy8YujIhR8czH/bsZw2zYkBhzOy4c91qd0g=
X-Google-Smtp-Source: AGHT+IHIY+z0A2QqkFOsvYnrArDEgKr/25hxaR6ucnM7mmgFenQDGQPNDXKi9N+Gm18CK9dcvKwZ7YmeNdfclWYk68Y=
X-Received: by 2002:a05:6214:3112:b0:6cc:12d3:b589 with SMTP id
 6a1803df08f44-6dd23335b8emr335835796d6.4.1736205447031; Mon, 06 Jan 2025
 15:17:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com> <20250106103713.1452035-4-usmanakinyemi202@gmail.com>
In-Reply-To: <20250106103713.1452035-4-usmanakinyemi202@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 6 Jan 2025 18:17:16 -0500
Message-ID: <CAPig+cQJM1TOad=buG0h2-3OnxEH6SUBz23y+wYq9GeUzhMwaA@mail.gmail.com>
Subject: Re: [PATCH 3/4] connect: advertise OS version
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com, 
	ps@pks.im, johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 5:37=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
> As some issues that can happen with a Git client can be operating system
> specific, it can be useful for a server to know which OS a client is
> using. In the same way it can be useful for a client to know which OS
> a server is using.
>
> Let's introduce a new protocol (`os-version`) allowing Git clients and
> servers to exchange operating system information. The protocol is
> controlled by the new `transfer.advertiseOSVersion` config option.
>
> Add the `transfer.advertiseOSVersion` config option to address
> privacy concerns issue. It defaults to `true` and can be changed to
> `false`. When enabled, this option makes clients and servers send each
> other the OS name (e.g., "Linux" or "Windows"). The information is
> retrieved using the 'sysname' field of the `uname(2)` system call.
>
> However, there are differences between `uname(1)` (command-line utility)
> and `uname(2)` (system call) outputs on Windows. These discrepancies
> complicate testing on Windows platforms. For example:
>   - `uname(1)` output: MINGW64_NT-10.0-20348.3.4.10-87d57229.x86_64\
>   .2024-02-14.20:17.UTC.x86_64
>   - `uname(2)` output: Windows.10.0.20348
>
> Until a good way to test the feature on Windows is found, the
> transfer.advertiseOSVersion is set to false on Windows during testing.

This is because the uname(2) you mention above is not actually
system-supplied but is instead faked up Git itself for the Git for
Windows port. See git/compat/mingw.c:uname().

The typical way to work around this sort of issue is to ensure that
you check Git against Git itself instead of checking Git against
"system". To do so, you would implement a new "test-util" command, say
`test-util uname`, in git/t/helpers/test-uname.c which internally
calls the same uname() function that other parts of Git call. Doing so
ensures consistency of output.

Whether or not it makes sense to go through that extra work for this
particular case is a different question.

> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
> diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.sh
> @@ -123,9 +123,19 @@ test_expect_success 'git receive-pack --advertise-re=
fs: v1' '
>  test_expect_success 'git upload-pack --advertise-refs: v2' '
> +       printf "agent=3DFAKE" >agent_and_os_name &&
> +       if test_have_prereq WINDOWS
> +       then
> +               # We do not use test_config here so that any tests below =
can reuse
> +               # the "expect" file from this test
> +               git config transfer.advertiseOSVersion false

Should this have a comment explaining why you're disabling
transfer.advertiseOSVersion, in particular that you found uname() on
Windows unreliable, thus need to disable the check for this case?

The comment you did compose exposes a fragility of the tests: in
particular that subsequent tests rely upon a side-effect of this test.
The fact that you had to include a special comment explaining the
problem argues for a cleaner solution, such as splitting out part of
this code into a separate test which comes before this one:
specifically, a "setup"-type test which creates the "expect" file
which gets reused by multiple tests.

> +       else
> +               printf "\nos-version=3D%s\n" $(uname -s | test_redact_non=
_printables) >>agent_and_os_name
> +       fi &&
> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> @@ -8,13 +8,23 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  test_expect_success 'test capability advertisement' '
> +       printf "agent=3Dgit/$(git version | cut -d" " -f3)" >agent_and_os=
_name &&
> +       if test_have_prereq WINDOWS
> +       then
> +               # We do not use test_config here so that tests below will=
 be able to reuse
> +               # the expect.base and expect.trailer files
> +               git config transfer.advertiseOSVersion false

Ditto.

> +       else
> +               printf "\nos-version=3D%s\n" $(uname -s | test_redact_non=
_printables) >>agent_and_os_name
> +       fi &&
