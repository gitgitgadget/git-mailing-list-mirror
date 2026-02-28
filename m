Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461852DA76F
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772298145; cv=pass; b=NFMrhgvOV1nsWEmCrEieax/YxQg/dF7J8QW5GMG3nfhhcNVx83Bx/teUUWDsJ1H67/OMhJiIsWVvLEVV6xAbGi+yc/AozkJ5nnhmsWyXIq8+28GBimlIivV+/vPf4V3JOTUo3M4njT7JTcQHWDdNKqC5z49tAhT2lFNvI8czBOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772298145; c=relaxed/simple;
	bh=gQZdTFuoldRNCftOC1YmscbZmHUmlXR0BJ6eELr0D60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NF3fj7sfFm2FPZ7pTawlElp3JRGCHGG+jl3Zqv1LEAjaus7AB76KQQ/HSLakwX9rjrcm2TcRP28ppLepe15+mXde5v5xlZ5OYbsm0h2iv/fYAaku3aVq36bhiWw3T4UpMVDMIyntEVZ4bduxOX6gm4/qoCK7CWwwMFpKjXfskMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b=zY83OWLq; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b="zY83OWLq"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1270ac5d3efso2935833c88.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 09:02:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772298143; cv=none;
        d=google.com; s=arc-20240605;
        b=STiCOxXDefOC9ZOKBKfAUBFQuSHlcnnqgArI8L8I/bswwC2Ks+Oz+o5sErchrNznyu
         Bb+msLsbTg628KvVm58ClxY/MYb0gE/4QkK64IUZ1TLxCFjfJWjPuc57HvO9btIYtKTv
         3LCwUclWsN42AfcpQA1HSvD/1gG/zlNa02q/pquYezV9qi1UF86vHl6wSgxWs4dOvauN
         0aQ6Kvz+ZKHSisq70PFzQ9Uukgt1OwIQ8PFmUHtbhRUvsTlgtkkNcrIHBv2E75hmWePK
         Wjv1OivPuMT6Ds+xl0QryMW4eS0HA03PJyP9bR3qwUblIrYB6YtSHNJdtj1nvuRgfWQs
         fAOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wkXHGwbRUDxewaayvKe6KdZEsA9VGeh4HuY8C9z0+aM=;
        fh=7osLRyO4uAMAyVDJel8uKJLHzDf7gVyDABv+XKTgatE=;
        b=OgNxQCKFabg2Yff6BIPSnWg8N1nulCkVs2TrYuRfu5/n4Q4b9fLqjQjGBdPWhJ0vt2
         v/EJjomFxWxnnRU6iP3cppqpuiG4ODDbi7KFg/dKsiCosBKPdzVQP2FYOAuGLSCVUuuS
         ujoT0VMXYfrqB0hYs5qTMZzBAQsnv+YaAJqFvHgKNc7MPRhkTb3Vxut2I7Ev2L4TXfM8
         wqkHUAIN0ahBS3yVSPdi0D6ynYrz0xsux1x/GHgC8X7IxC91CKUFtm36BYbA5726CW6K
         v6tBp1tZYdKjOGpuFrOAaz5hFsaZSbuJ3sYUTXwBWFnIrb9VcVzTQ7FaYRviQm6mUkWb
         OACQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree.net; s=google; t=1772298143; x=1772902943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkXHGwbRUDxewaayvKe6KdZEsA9VGeh4HuY8C9z0+aM=;
        b=zY83OWLquTqb0t+yaE6glvLE3I6iy5EAeS2tgticurY/Eg/RKSFI6n4z/Gsh1i8h+Y
         wj5kkwtvyH3p+n2naKn/HLMArBkeiAS7hFH/u9Fgr/8VBRPR6B+ylKtbYBTAaPXWSjI1
         QGw2OC34axFoXwrpVLLbmRT9N8lMaVk5tt64QWgN8DEp7bb3nFBNdvPz5hAezFCHgdwC
         QM8KgHVpbIzx94pAyyDnPT9sr5yO6hy2hsUi6atgQzm229wWOOzsFW4nEld2z0gS2HB4
         w8fyqM2Uo1LU+dpkM0Ok+Da9T+CHr79KHFJz7BPDfS1l9vAtCtHvyzK63ZZb05d/RSdX
         a76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772298143; x=1772902943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wkXHGwbRUDxewaayvKe6KdZEsA9VGeh4HuY8C9z0+aM=;
        b=uHOz1ZS0i/RRETgfEg4WC5oCfNAhkKGUPPRot3yrPfq+92/POu/e03gibIWHijEW1f
         MUmuO0HL7/jpENOBgCzb1bqpwfAleD/c7XBPnNJhXSWGz8yaRr1pHnvkRKAHduh+eCE0
         EUMso4xVQyAJuCop2NNyZ049feoGS+5+3pjQm3wVOeMwCLmnqqCH+/DW0lxUoEUt5cR6
         4DirSuoRckfik0UqBeRGco0RMcygyXzI4KvCh+i+b512QtK0uzvluisQsDNHI85oGkDV
         nSbf2oGH2uGvUGi74wSc6vPlXBKGOO5B6CKVTuwgG6oaf7/5oK8Yx36jwz2EeSCIBs6y
         MF7g==
X-Gm-Message-State: AOJu0YzZ8JLlSZ84M9FemtsYiOQXFpPEb7kqfeuI+6xZ8aX8RyXFqi0k
	yoyveugIAeAXKqp/yKUIU2KgVXgayKe/bm6JyTtlg72dNeQhfVTCcK4CFiORWaWO3L7h42jTaqG
	gvM6+AcBUahuqH07WVbi6tFujLXlqpNBpWbt8RjnB8nbGjO0ptlu+ukbLvWADyuTnEtFCfpbMoO
	Axf8X62CDFNYZ5rHeEp4d5+U4Ch+cjfCFWwu58ze+1FeUL5BvpVnuZsSbB6C/hw3xSyhrjVQGWw
	D7UCKf1K0CySWKN9wvAVLex5nGLEKNq5mL7AkvTg1px1ww2gTom/rDZyzJCwyTeLzugPnTzp1AZ
	EbQJ34nd/kU5tLo=
X-Gm-Gg: ATEYQzygBhkN4j1qSnFoJeuUEebgO3WN0+0S69ZBhr75wHCkLb9vMhNYiIb+sGRsSZ/
	JK9jL/laKyi4uLLWouZXfWVRcKwshVEq3CPrKcI/kNP1mQdbk67Yf76mHtS0L/3mt2QySusgz7g
	DhNChGoCa+V0VMeHND+XsM0KivtLtUh8BZqLXXAl0mQHM6KXxO1M/t5naVxfyfCEOHe7uY83TU7
	Sf3GsDy9TFUNvrMbtB+gd4/18EP6UazFJdlH6xulI53vb+tnnEPAPuen8cIiBrjK/a9DKbCZkXy
	XdSrFYZx+8w1mGzzz+s=
X-Received: by 2002:a05:7022:792:b0:11a:342e:8a98 with SMTP id
 a92af1059eb24-1278fa8a2f9mr3541650c88.0.1772298142928; Sat, 28 Feb 2026
 09:02:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2180.git.git.1769391202338.gitgitgadget@gmail.com>
In-Reply-To: <pull.2180.git.git.1769391202338.gitgitgadget@gmail.com>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Sun, 1 Mar 2026 02:02:11 +0900
X-Gm-Features: AaiRm50cxVkoIPcg-B1XETN0g-jg9oRKpJ7SywUwL1HyxP4TOsqXIXcHQEXlyl8
Message-ID: <CAOTNsDyy2ZQDhkVyML6j5naS_UC=SjE915hjygj+QmKe4bqc=A@mail.gmail.com>
Subject: Re: [PATCH] fsmonitor: fix two bugs in watchman hook retry path
To: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 10:33=E2=80=AFAM Paul Tarjan via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Claude <noreply@anthropic.com>
>
> The is_work_tree_watched() function in fsmonitor-watchman.sample has
> two bugs:
>
> 1. Wrong variable in error check: After calling watchman_clock(), the
>    result is stored in $o, but the code checks $output->{error} instead
>    of $o->{error}. This means errors from the clock command are silently
>    ignored.
>
> 2. Double output violates protocol: When the retry path triggers (the
>    directory wasn't initially watched), output_result() is called with
>    the "/" flag, then launch_watchman() is called recursively which
>    calls output_result() again. This outputs two clock tokens to stdout,
>    but git's fsmonitor v2 protocol expects exactly one response.
>
> Fix #1 by checking $o->{error} after watchman_clock().
>
> Fix #2 by removing the recursive launch_watchman() call. The "/"
> "everything is dirty" flag already tells git to do a full scan, and
> git will call the hook again on the next invocation with a valid clock
> token.
>
> Apply the same fixes to the test helper scripts in t/t7519/.
>
> Signed-off-by: Paul Tarjan <github@paulisageek.com>
> ---
>     fsmonitor-watchman: fix variable reference and remove redundant code
>
>     The is_work_tree_watched() function in fsmonitor-watchman.sample has =
two
>     bugs:
>
>      1. Wrong variable in error check: After calling watchman_clock(), th=
e
>         result is stored in $o, but the code checks $output->{error} inst=
ead
>         of $o->{error}. This means errors from the clock command are
>         silently ignored.
>
>      2. Double output violates protocol: When the retry path triggers (th=
e
>         directory wasn't initially watched), output_result() is called wi=
th
>         the "/" flag, then launch_watchman() is called recursively which
>         calls output_result() again. This outputs two clock tokens to
>         stdout, but git's fsmonitor v2 protocol expects exactly one
>         response.
>
>     Fix #1 by checking $o->{error} after watchman_clock().
>
>     Fix #2 by removing the recursive launch_watchman() call. The "/"
>     "everything is dirty" flag already tells git to do a full scan, and g=
it
>     will call the hook again on the next invocation with a valid clock
>     token.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-218=
0%2Fptarjan%2Fclaude%2Ffix-watchman-query-bug-sfbIw-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2180/p=
tarjan/claude/fix-watchman-query-bug-sfbIw-v1
> Pull-Request: https://github.com/git/git/pull/2180
>
>  t/t7519/fsmonitor-watchman                | 1 -
>  t/t7519/fsmonitor-watchman-v2             | 5 +----
>  templates/hooks/fsmonitor-watchman.sample | 5 +----
>  3 files changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
> index 264b9daf83..907bd1533c 100755
> --- a/t/t7519/fsmonitor-watchman
> +++ b/t/t7519/fsmonitor-watchman
> @@ -109,7 +109,6 @@ sub launch_watchman {
>                 close $fh;
>
>                 print "/\0";
> -               eval { launch_watchman() };
>                 exit 0;
>         }
>
> diff --git a/t/t7519/fsmonitor-watchman-v2 b/t/t7519/fsmonitor-watchman-v=
2
> index 14ed0aa42d..2c59120c3d 100755
> --- a/t/t7519/fsmonitor-watchman-v2
> +++ b/t/t7519/fsmonitor-watchman-v2
> @@ -141,15 +141,12 @@ sub is_work_tree_watched {
>                 # Watchman query just to get it over with now so we won't=
 pay
>                 # the cost in git to look up each individual file.
>                 my $o =3D watchman_clock();
> -               $error =3D $output->{error};
> +               $error =3D $o->{error};
>
>                 die "Watchman: $error.\n" .
>                 "Falling back to scanning...\n" if $error;
>
>                 output_result($o->{clock}, ("/"));
> -               $last_update_token =3D $o->{clock};
> -
> -               eval { launch_watchman() };
>                 return 0;
>         }
>
> diff --git a/templates/hooks/fsmonitor-watchman.sample b/templates/hooks/=
fsmonitor-watchman.sample
> index 23e856f5de..21c81b6804 100755
> --- a/templates/hooks/fsmonitor-watchman.sample
> +++ b/templates/hooks/fsmonitor-watchman.sample
> @@ -142,15 +142,12 @@ sub is_work_tree_watched {
>                 # Watchman query just to get it over with now so we won't=
 pay
>                 # the cost in git to look up each individual file.
>                 my $o =3D watchman_clock();
> -               $error =3D $output->{error};
> +               $error =3D $o->{error};
>
>                 die "Watchman: $error.\n" .
>                 "Falling back to scanning...\n" if $error;
>
>                 output_result($o->{clock}, ("/"));
> -               $last_update_token =3D $o->{clock};
> -
> -               eval { launch_watchman() };
>                 return 0;
>         }
>
>
> base-commit: 68cb7f9e92a5d8e9824f5b52ac3d0a9d8f653dbe
> --
> gitgitgadget
>

Although I don't have much experience with the Watchman backend, the
fixes look correct to me.

One suggestion: it seems we can make the code even cleaner by removing
$retry and its associated logic, as they appear to be no longer
necessary after these changes.

--
Koji Nakamaru
