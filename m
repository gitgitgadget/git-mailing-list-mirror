Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEC32D77E5
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700259; cv=pass; b=NxYpisEZzeWwsvfMO+ue0KVYA50kOsk2ZrnFiniIymmazUtgECl8vi6UZZQGBeGx9ludAVMG1w8jWlEJqc7wTEyFvVGQp58Cu8hRNeCxsIrPBKrYc7ay4+PBqk/RQgxCcYF3bCQApqZtoOm+yJu+e3OGtjYc0SG9PCTcpx1JzM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700259; c=relaxed/simple;
	bh=36ZzNnRzlyqXVoMW+Ng9neLCW6SGXj1Yx1NkNXhouvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oT4994QovZNZYsZ9Bt0yET5siywkOldtm99/4PYnJSkH6F+0N8IATxxajPgSDYgcIPUqI0SeBy/Mmcx9I6/UYjWyXb873SY5U2UMe8xz6T8Bl3J55aaiqBWoxVPDF2jJMVjjRZoXxUaBswpkJ5oiZGhSWj6YyMNs6RHTLXXct/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYrwoHAm; arc=pass smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYrwoHAm"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-691de293326so1792764eaf.3
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:50:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776700257; cv=none;
        d=google.com; s=arc-20240605;
        b=KCGsKcDLHmWzw7LkEfWsXewSRMYiLHJRsqyp09wc9pU7H0bPz0pwdOWe1zykkL9zUg
         KjMgT0Ua33H7jta7lYhFDjCWa4AId25cOHyP++LTRtUF5JWmZQGBQUQJt7KNjDNE65rl
         gAk9PrCZ1N9HRO4VEJWUzcN8LVNeaUuLYX6G5+h2gdoROqGNcQsWtXOGBJYlO5MOMFSD
         Ue2YpkVNolW8tD9UioCSDx4YVgYi9/MTlE5QbuPaFQyowE7VoNQy2fK2VDXPeMfWcygP
         OSZUB7ULPMR4ILNV8gRJ1X+xPGcqEZ593k/uFGynPuSH4Hscuwjm80Z3vzNrIv5Kc1tp
         Jq6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ixa5Ci/dot0vu4hsPSxixqDhNJ0ZJsZuM7bZRuni1p0=;
        fh=JpWi2PftPy4ej/G4OTmmjCzWBQj5wEUX06rwGiSxReg=;
        b=TICsuAZ2Gs07lTn5akPFRaregTiZkD/hs8+80z1BH83im59ja4W0Cs2dYDOY1aWqDV
         lK8qSJzNQ58JcFRqRxQOTYwwVcoc8htBxldZE/n/BwL6UBZAiDDpJ4KCNCu5XAMvCrU8
         nSFtNs17KjmhJtsRmYGKxVnz2XBBZrSZHDjnvN7dDBp3h/5bgr4Wr2+DxNH+GkMll8HD
         f0ORnQQHQ9tQ82Wq3unasdjUUUbUyDIy71fn+Tf3OPjx03qt9DyKqFsWzT+xRfMtoAze
         Y9u1DFKaPF5h4ovtx6L4xyGIU0hpj33epmjlEO7snshvoeQhzDs88S9a9UiJKLCqrBqO
         UbMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776700257; x=1777305057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixa5Ci/dot0vu4hsPSxixqDhNJ0ZJsZuM7bZRuni1p0=;
        b=HYrwoHAmAGL25Ktvs/1jQ2z8MRmbUYkH5vK9KZSK4alYPmsFhZq+cAho7vDhodNC0Z
         iWN/RcDyr6FtxO1sqkpS2plTvtzDiypAJRBCVWsFE070X6sQDAq7v75rjcIyRrKygWTa
         YVNbzepLIrP3F6NBGFpUlwwVuU/ACRGfMj1Sh2Ic3HSE2pxvqIMRh+4+hLsVUswaHI+e
         3IvG5MtErHL8dFjJQuyyVxt0RstIiokbOt+5XK2Tohap6X35uuKcKJ4Xuhqsd1i3Z5oa
         gbdhsQT7tgwKlghKMf7myT7mSl3isN6gJNohNq/dVCugnQY6vhljUXjeHMWcXrlrSj8E
         P8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776700257; x=1777305057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ixa5Ci/dot0vu4hsPSxixqDhNJ0ZJsZuM7bZRuni1p0=;
        b=njIsi15ahT869cMYPl/k0cilB+Qr5POowvKmea9dM3VLUUrDWX9OSqdBlPdkihL9Bx
         YUIj4DgpB4Bb5+cJKLZYAvWXW50Fu55BSh0dquqebZzcmLNVokypJ4RhHqHUZxEFJhP5
         0h6eVmdit9lwPQ9AFYfpWSIfhZhZMklCUZ4NRlzGQgyoyEuH9wXHxTMO8FeEu+PvhyyC
         TvrN7uGiewt0wnKaFxBljZWKofuL5skZcgZQuGOGuHejv3TPcBSwHiudkoXHjL/CRwFA
         18bYXqyv7vIhyLQFfn3XHfFnpPeqZqBcP0e9eCcCCp2Pftn2tZJyNv6F7ZvXCnj9ZH1h
         y+NQ==
X-Gm-Message-State: AOJu0YyGiTssrT60VR9w4sKGFkb1DnIMiXU54tMKH7YYMPMrWTQBEh3o
	bPslrbcmCyN+eIeMID15V4ZbxIlOK4QL8UCN+7Vfg5AQXfcHD0K5s0PqugbL7OM/EBy7PKLzyWt
	d0w2g5+oAHgpCgrwmbKDegpXjRsKlk31UGVhz
X-Gm-Gg: AeBDiev4q0DNIBwVXkY6WJbCJ6XptPgR/+liQ7BlzGFhsTnodvWrGlMTV9E6ODqcgmJ
	1JoWRM58Buh4aXx+SbW1Uf+t+8W8lFDPzu8YedfY11kFi9Aw2LKPtkDPcAhr9hU/dQBEtlSHUNC
	zmhbbjxKl6dVme2TS7jbldBpyiU/qLpKiQfHDYnA2IKP36LqjvZ0cPdq/HKmBxLtfIJggHhy4eb
	Dtx++K6bYU6cTbSlVzsr0U6Zd1TigreVLu2odh0VSOuqOlQqbJ7l5N8X6TFi8Od0ivI/JkUe749
	nBbDaSVXbf0U1izNkE27B1YM8w3hT9jZWlhswUsM9Ye9CkiZ69nS9zDikPoFx1TWZw1xXRSRrhE
	VtmsL0iKFXGKK+xLXk1b+j6sWRx/UnHxC3kpR
X-Received: by 2002:a05:6820:2089:b0:67e:3ae6:9031 with SMTP id
 006d021491bc7-69462f45720mr8072552eaf.59.1776700256920; Mon, 20 Apr 2026
 08:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
In-Reply-To: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 20 Apr 2026 08:50:45 -0700
X-Gm-Features: AQROBzDgK1W2-8OzXxRXSmD961LcGFbiZpwdqxbzdq-up_dHfXeeP7HK20mZ8v4
Message-ID: <CABPp-BHOVhQPL4ScA+sJCvE2OYXjLJSyDim5AocbcqoxzObGxQ@mail.gmail.com>
Subject: Re: [PATCH 00/18] setup: drop uses of `the_repository`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 1:22=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Hi,
>
> I've had enough of "setup.c" and its complexities, so I finally decided
> to take the bullet and start refactoring this subsystem. This here is
> the first out of the following three steps:
>
>   1. Drop all uses of `the_repository`. This doesn't yet allow us to get
>      rid of `USE_THE_REPOSITORY_VARIABLE`.
>
>   2. Convert a couple of global variables and drop
>      `is_bare_repository_cfg`, which then allows us to drop
>      `USE_THE_REPOSITORY_VARIABLE`.
>
>   3. Refactor the subsystem a bit so that we stop intermixing repository
>      discovery and repository initialization. This is my original
>      motivation as I want to get rid of `odb_prepare_alternates()`, but
>      due to the way we initialize the repository it has proven to be
>      extremely tedious.
>
> Most of the patches in this series here are rather mechanical. There's
> only a handful of patches that warrant more attention:
>
>   -  2/18: setup: stop using `the_repository` in `is_inside_worktree()`
>   -  3/18: setup: stop using `the_repository` in `is_inside_git_dir()`
>   -  9/18: setup: stop using `the_repository` in `setup_work_tree()`
>   - 10/18: setup: stop using `the_repository` in `set_git_work_tree()`
>
> Those patches don't only mechanical move stuff around, but also change
> some logic to make it work.
>
> The series is based on 5361983c07 (The 22nd batch, 2026-03-27). There is
> a single merge commit with "seen", but it's trivial to resolve.
>
> Changes in v2:
>   - Remove static `initialized` variable in `setup_work_tree()`.
>   - Use enum values to initialize fields.
>   - Fix up a comment.
>   - Link to v1: https://lore.kernel.org/all/20260330-pks-setup-wo-the-rep=
ository-v1-0-0d2e822837aa@pks.im/

Thanks, I would have preferred this series to have used the "PATCH v2"
prefix and for its cover letter to be sent in-response-to the cover
letter of v1, but those are nitpicks that don't affect the overall
series.

I thought to check one additional thing I didn't check when reviewing
v1.  I looked for all cases where this series added "the_repository"
to some function between the beginning and end of the series, and for
which the function where the code was found already had a
repo/repository parameter.  There were several of these in builtins,
but those are already littered with cases where cmd_foo() has a
repository parameter declared UNUSED and where we use the_repository
anyway.  Those should be cleaned up, but that's outside the scope of
this series.  However, I did spot one non-builtin case: in patch 16,
repo_migrate_ref_storage_format() already has a repo parameter, so
your call to initialize_repository_version() can use it instead of
the_repository.

Other than that small issue, I think this series is ready.
