Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012C44B04B2
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083367; cv=pass; b=egbco71cC35YkkIPHLAvvrAdWbGwP6kfRa14QU+OEPCsJ8tTBv8gX/pR2wKAbkZYtE/GcB0kMINzFUk7Ijt3fXxQupU5vnz2f5dxXFniJUcP7NM4G5FiF2IfAITsX3wuPB9HQWhfecZSuObc9pboWQu4Jf17CtbI8nZAsfzQOEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083367; c=relaxed/simple;
	bh=MCNRrn1TaM4VZa599TRRzfBnFs+YJNMyCE3Wk2eJgUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Snm4Jy2xPHZJfwKVRkL2KaVnhsAhrGrQMbaUHlMatCsPBHeITpDwFKw43LeY3hZLk04c2NeoybGjSy8zaWzzvq3XeBCjIVtKSadgugARUf9DPtlxPf57p9LUCv/m+jhG7v+RfyNAS08TnpRCgqDVNUyBz7BqPsDIs3+XgurUQCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hd/o7kxp; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hd/o7kxp"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6ae88f4e4f4so1339230eaf.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 23:16:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786083365; cv=none;
        d=google.com; s=arc-20260327;
        b=htbVcYWHCkL8/Ir7nIRjeafjQicn7NTAbYHf74quhuRIrQ6FWd0nqqQ/IIWeY0yFgb
         WoRikR6jA97fRd3skynFbcviJUI2aHpQuolrxs06k3f2nRpuC6ZtF5lChhBkgaZzIsOi
         3onSDOBK0MkObMBNm5zcCUPXPS53YLGGI/x6Flt9WwtEDlzY29k1ZIuE3wZuudcTSwDm
         25jgdKmV9HDWuoZv7vfkdDX61ds0/TS1mC7iQFhoPRsTdVHhe7afiLKzaTRR9xjS5q/N
         ipUzt1L0IQbAjCwoBOIrTovXtgExj490DAfC3Je7bZyEy9RInMTbj5gKkPEQw77V8iDE
         guFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nIH83vewMIIWFnBwoj5nXvBFB0m4coug3CbHSJzuRY8=;
        fh=K+nwAsTgvJIY4kMWVokCW6lJIm9qzCyizIjWP69oThQ=;
        b=ZZcBfNh2UeUKHkiRGwh0Md/NmasDxze1uc1rdYbUsMsJ74Y/DlejJCI2TWHsp280OR
         LnZ2VCDjOeZxEEIRyeIZCvqtKqhuMb80TNtVEDoFnaeFHnWagwGA+LKDgb6WjWcr/CKL
         32aWTMjwiA6dbYJQvvVuhBxmKCLJflzL9bZC6Bx8CyD9Aof0VvORLaeU6Ml5uVYYodZz
         JRUzd4mDg6dW4G0G9NhMoxE7hMCoSG3SOdHRyj2yGCeFidhKw0nlvzyOsagWjf36suZE
         aMw5Fe1dGlHQdFrNayTbrVv/ULcbBAlCuBvqFfJJGYBefo79npr9xRP44FT+Zsd/IcY7
         6RxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786083365; x=1786688165; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nIH83vewMIIWFnBwoj5nXvBFB0m4coug3CbHSJzuRY8=;
        b=Hd/o7kxp2/xdFQX6yJENsSZYO40V7uTvfhEluuTSDCMDXTCjpc8xK64Ztir+RPKXXL
         I47tmWoxg8Fc+Pdvu5dBNklNKBioMWQ4ZJIMgUMCVKyQIvBEgVOpSxGM8+EpaXmjW0Vl
         2JQ7P7uNdRI43B/O+RZRKhPajTCGCyBI3YEp6Aj4lK9mrAhMkzPHdF/094TxiGAreJeG
         Vr+5nhtG3dn52ufZp5O3udsr19WC++sUBg06oO90kQhkhxGs7zItphiglz8mpWMjdAM+
         ZIEuSXDr6J4y3rg8hmwrnviuZWmL61eQUojDqXQJ4y+WQt6VsNMrT7gg1+6+nzs9786r
         F08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786083365; x=1786688165;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nIH83vewMIIWFnBwoj5nXvBFB0m4coug3CbHSJzuRY8=;
        b=OWBFF0BUClgRIgcMMYOOrPdDz8bSft+eVJo1Ll1ZqCil3wjpLKl6C5I6neSw/sVOAB
         7AwWT7Y0f5ulfSLrgVX8opiRdQS3vJhn/Qjhqa93+WJj7pOhewmTe6/dtKYr+UzB31Tw
         +LZGc8fEtZbNTgd4zAxU1kULKFDr3rXGxyTe+mIkbiWsFtnvS9lR7HZ6B2qnwjD/xOqF
         B4ivdx11/y21MyUfXuZFYmOCzC9mMcJG6KCA2xdq7uBAQrI5CrBjxWMdjP1e1HAHD5HY
         QOvioGGOA6bd9+C9jtsWffHwefiEerSWGxEHCAvGKC7oA9C913jzFJUOG5vuO50RHQ7h
         ahpA==
X-Gm-Message-State: AOJu0YwOZa0D4/ofq2fK6kAVtRWwtcPQPi42dYmo2D6lJkeau6sPO0ey
	GitNAqt/v49d9DkkVCi7r05DhbsvP/qsmUvVs5kOn5ONXCHeapBUOMytyoESs4X5pjXh2Egr9BY
	g9jOI4PTXQPGrSXonoXfLmBWsFvDCzXA=
X-Gm-Gg: AR+sD11/IxLIiDLPBbHmAa4nnOZgEs0ZPRPpxDuiksOC0UQtvzAJyKBvni1N0JmvM9O
	RoVtv/xjf1VeuI3jX1eEgMHv90Y0cwbGG51SdTxd3GI94ovY1eFgfot5gNvdUhbxB4kw1v3meQW
	PRvsFnvMg9rB1TsQyuaL0JRJBpsk0EnbcoTIxq3cUTbA4dKBFBtw9DkqB+SaBsMZH41o0NnVG9G
	cWob/bJQHtvxd4JZ2BtHAhcZiXhxykuQOEkkFtYkAJDOs5BwuzKhaAhcql1sYX7FFUFNxAGzWV1
	V1+plBrIQ5dl0Huz4TcED4J3N+4V1ujZWullaGDQoPF2ThaRO8h6WSl/8/1g+Wd63K4USSkjo63
	wRGF+r8i4iBeXquvA3GLuf92WmCqS59JBjwVaoSCxqrb+2etH/ZRNmCe1xE/OjYo=
X-Received: by 2002:a4a:ee0a:0:b0:6ae:6f38:dac with SMTP id
 006d021491bc7-6ae96c8490emr10890908eaf.10.1786083364794; Thu, 06 Aug 2026
 23:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcxw010me.fsf@gitster.g> <20260807013830.698340-1-gitster@pobox.com>
 <20260807013830.698340-2-gitster@pobox.com>
In-Reply-To: <20260807013830.698340-2-gitster@pobox.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 6 Aug 2026 23:15:52 -0700
X-Gm-Features: AUfX_mzd6G3zrJPxr_XOkdmAx062RwjBnxlghxfqnm32kIfZaZvX-LDvrQnbutU
Message-ID: <CABPp-BHhNHBN0Mt0LVjGEcNL_y7mad7rS6NRX6p14ELrRD-+bg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] completion: no-op refactoring of diff completion
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>, 
	Britton Leo Kerin <britton.kerin@gmail.com>, =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, "D. Ben Knoble" <ben.knoble@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 6:38=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> The "git diff" completion function punts very early when it sees
> "--" on the command line, since it is a sign that options or
> revisions can appear and the current completion does not need to do
> anything "git diff" specific. By returning, it lets Bash default
> action that completes the names of the files in $PWD to kick in.
>
> In preparation for the next step to change what happens when we
> "punt", arrange the code flow to avoid this early return.  The
> behaviour at this step is unchanged, but the control flow just
> falls straight to the end.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  contrib/completion/git-completion.bash | 61 ++++++++++++++------------
>  1 file changed, 33 insertions(+), 28 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index e875787710..ccd3b2a372 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1947,35 +1947,40 @@ __git_diff_difftool_options=3D"--cached --staged
>
>  _git_diff ()
>  {
[...]
> +       if ! __git_has_doubledash; then
> +               case "$cur" in
> +               --diff-algorithm=3D*)
> +                       __gitcomp "$__git_diff_algorithms" \
> +                               "" "${cur##--diff-algorithm=3D}"
> +                       return
>                 ;;

The refactor in this commit is a faithful no-op -- every arm got
re-indented by one tab as expected.  One tiny slip, though: this first
case's ";;" didn't get the extra tab that every other arm received.
