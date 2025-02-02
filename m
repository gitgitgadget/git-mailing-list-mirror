Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818C48633E
	for <git@vger.kernel.org>; Sun,  2 Feb 2025 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738503359; cv=none; b=iE8GNbJ++rG8hdKVqGeZiVfQy9KXdEuKlDvZMxhJe+JPagW0wJp2HVYZWI1FHyIkF0UeEL3l4kF3vGVhoJxVT1n9rNOKWbTi/yLCN34GIHNxbJF6Xar7e6eNvvIPXIbtjI60S+vpRRLSnUHTweGyhwcQGNpvyTMRmf2quWP8wHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738503359; c=relaxed/simple;
	bh=vlFwVFhx0b7Y3Z2wHxRHSllE5jKI34cwFa/NsiI+ec4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUKSjL/1NWGO/krpQuSVQDHTg3a8BrxsaPbnb8PyUmUtLGxzJgCyajcEPxRdcQaWL4IOTZDG5ZS8XFnTW05IRxBuqgm/unp0EanMCic6NWvaFg1G3gt52uqou2oh2Q6UtceWfacwhYDvJgyG5yoYkiClsN5PfYU9ldGh1R7GohY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6fd251d7cso37113085a.0
        for <git@vger.kernel.org>; Sun, 02 Feb 2025 05:35:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738503356; x=1739108156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90EmtbCBMSzn8hAVkMX8YgKpB8BN4uhyd+py5eicwLY=;
        b=braxxQXCjmm7zs+v1xNO/VrQ3Jz7FwOT5SSB6PQ1vzJwzOoPJjXghv9V37netXmzf8
         46Q4E/M98uNPMk66Bf5J3UL7vAPKbO8FUmsBj92HxmVofMAQImS/xIxaU7x8F8uQX94/
         ZacaAWrQyzS1Bu5q3KFEsXe4xoTe47MBjLHfMzOXMMgMae6PXX8h0VJTEIG453UAry9S
         2L35X0axhsx6zDt3yk9W4uwACkT2SLwRCqz6tLDZY6hvW3t0Dnra3aPcbM0Vsq+CQYbg
         dAbQAd23yUpFZrcARllDPVm/tNigdftvKckuxnWcaA8Cg+rWqHtP+PQB6F8KRxq/ZFmc
         15sg==
X-Gm-Message-State: AOJu0YymvmgQDA2V+FrWIL7rdbH1aLdlo5ED+C6dcbq0+/m3PCV2QPql
	wGO7wOG+rrlD2rk5zYZ+lYhjbmrpEWNMktTxXHaW++/T0CiQco41LZSrs4jZKMTJybv3loq+g1n
	W1i192kQCkbNj8kPdTWWNUkW56wI=
X-Gm-Gg: ASbGnctDK/8B5Qe00TG+etuGEsnvUabo06mKiyLIDs81uJ0vG5nFdCz4V+C89srHWql
	iFhgb0eesbFLi7ivs5rX5FCUNFFEjTY0WG9LilZqd/1XgoiXL5/u4reYxZxB5kvJJAp0HS1tEYN
	Qe8L+ia5UR3WVpkW6ZmA14kePYag==
X-Google-Smtp-Source: AGHT+IEs8z4bGhnZjsnTqTUwliQLMEjCTViWXoLI76nnzSqxxt/UJP0Xg2e2p+Yr6zl/rfTaOkdxhXCcIe21Nvc5N/o=
X-Received: by 2002:a05:6214:2348:b0:6d8:ae2c:5053 with SMTP id
 6a1803df08f44-6e243cae3fcmr90930706d6.9.1738503356311; Sun, 02 Feb 2025
 05:35:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250202120926.322417-1-ayu.chandekar@gmail.com>
In-Reply-To: <20250202120926.322417-1-ayu.chandekar@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 2 Feb 2025 08:35:45 -0500
X-Gm-Features: AWEUYZlPMTe7a4dPlHldIqn3b4Z05gHCKO2t5bKoTZPxwG-A2SOMTbcILWFqbhA
Message-ID: <CAPig+cSBi05Kq1ohxQJ8BwTsis++fAAaVCd8Ep8k=8cLS74jsw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_t6423=3A_fix_suppression_of_Git=E2=80=99s_exit_c?=
	=?UTF-8?Q?ode_in_tests?=
To: ayu-ch <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org, =gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 2, 2025 at 7:09=E2=80=AFAM ayu-ch <ayu.chandekar@gmail.com> wro=
te:
> Some test in t6423 supress Git's exit code, which can cause test
> failures go unnoticed. Specifically using git <subcommand> |
> <other-command> masks potential failures of the Git command.
>
> This commit ensures that Git's exit status is correctly propogated by:
> - Avoiding pipes that suppress exit codes.
>
> Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> ---
> diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-d=
irectories.sh
> @@ -5071,7 +5071,8 @@ test_expect_success '12i: Directory rename causes r=
ename-to-self' '
> -               git ls-files | uniq >tracked &&
> +               git ls-files >actual &&
> +               uniq <actual >tracked &&

I was curious if the project has a preference between `uniq filename`
and `uniq <filename`, but apparently we haven't:

    % git grep 'uniq <' -- t | wc -l
    2
    git grep 'uniq [a-z0-9]' -- t | wc -l
    2

Though there does seem to be a global preference in the project to
specify the filename directly to the command rather than redirecting
from stdin. For instance:

    % git grep 'sort <' -- t | wc -l
    54
    % git grep 'sort [a-z0-9]' -- t | wc -l
    140

In any case, what you have here is probably fine, so no need to reroll
just for this.
