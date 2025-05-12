Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CE61E2602
	for <git@vger.kernel.org>; Mon, 12 May 2025 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071412; cv=none; b=XZttlHdW915gzE0XL5jnHHMkCavm+d2tvJjLLqzlIJxWA6cCVDJYThBVmmDdr/KtvqWqf5Sk1XtCivvIxyC9Bxn28aK2XY/KeBOzn33HhOuwueECTSWIvbpL83ApORAwYGI67uN4d3JfajQe1iZs1V5D3rkKlLL+SOJ6zieZ++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071412; c=relaxed/simple;
	bh=mOFOK+LSj6pKtFZGvYo4h+QVmxaBKQnV+UazWqYU214=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/Da3Y5qEODog5QyAOeuOrXuRu+8uFFpl27DGxFyrQhod6Ky7ZeVEuzAW0ZulidoN5X4ykzNnPZ91jRy9GohEhFAuA4riCpzAewM1SVgapum+ekzDC+6c+Xyof6/pLToPsRJkFzVFPHXDOAvjsPYkIGRNM7k8Z9zHM7AbLE9dRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnzEERo0; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnzEERo0"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3da7642b5deso33521415ab.2
        for <git@vger.kernel.org>; Mon, 12 May 2025 10:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747071409; x=1747676209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Sah/zZuyLezLG5mbBHoRNxkNiscIWCCIuoLDlszlxg=;
        b=hnzEERo0DXKPniqH4hXs5pC6wIlkao0RaYjDIKoonVN/D2yKHOuRyi+kw+YsTbHZ38
         PGRvCc6fkz4VTPgLpHC3sYhej92YDD1lRV8SFhKkT6cmDtFNCIDoDkMFyjhBjQ+Dnome
         hFSPLgvdMFpu2nJAIsqJUi4/33DBTGIbJxrdWtzO4An70n2lHAr+Yvb2Ui3IRd7ZEL4M
         igaal6Fxb+XPn5flAFFDtTdhUMMpK+GKiRWwxscO7Kk0FDVaduxisKSV/TsiE0Vj4FlN
         AQjTkgwmcDIM0t1L/WgstXdOCaHaePRkK+Dovd3CUTR641DfKnXPrhTXPKsbpqwYh3TR
         VPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747071409; x=1747676209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Sah/zZuyLezLG5mbBHoRNxkNiscIWCCIuoLDlszlxg=;
        b=PXB5+9CHOF1z5pp+BtCndpYmdFkrNyCaalTstBaN0lxKEa/t3I0T94bXcW4AQOmXeB
         uNejZQmLVKT6h5Frmdb23QTgIuDR9cC2omypqf8u+MXlwPNoAHHUq3ycdcop1U1oT8Cl
         ICZsBcxF43y0jsANSWk9DlC6N9qfNbfh/C9c/w6BI33uTpK680Z6muPx5QWOdHCVrvCo
         W9lo0G+DbY9/Ws3Hia0ZcENsyW5RpEFYGy8nGKYY5Gq7TVNp5Mr3p3vV/8nhluzh55av
         hqAkGtxpQVm+NVf0rW/z+waScfNyGAvbfVct604KR/j7iCidGjWt2Zf02X8n05sRL0cb
         QcrA==
X-Gm-Message-State: AOJu0Yz59NpYd3mNP8+Ri5MZFjhnKsBXwbNo/guMD5+5VCXbA/hTSRAt
	0cdIjqlHn4+dfVeNCdhYw/AsZqEIZ2E2+VjqYY2x9Dwx/w3Bj8Ceg0CnS1+5ruMzTlhsVVo9B9w
	770pd10Fpf7V3P1V7u4ShbJLHOQ9MZFnS
X-Gm-Gg: ASbGncvXIl6DT6gRxcHG/5Fs79j8pJQmAhkaN/296EVy+uTIslSmdbCHmsssfHk3EhG
	XcMyf/8I7Oj/Cx+XpIh08tCeZG05SXDevH/rsUQimPimdwSNvTTHmyxGuLnJ7IeZ3inLM+fJjVF
	ZR0OhbRS+fx+Tk731uydS5xAXJAOuWRvpTiEBrBzfXydxcyxHIojW74pibJ3o122XtwA==
X-Google-Smtp-Source: AGHT+IFSsa3m6c3NTPI+PozgEfHY+zoUdZB8g2/EmaTg0Pberx/wpoP0UzLVVeriPesaD/0JRyu6iZwwsM0yTGfPz4s=
X-Received: by 2002:a92:cdad:0:b0:3da:71c7:5c7f with SMTP id
 e9e14a558f8ab-3da7e203e03mr163523045ab.15.1747071409515; Mon, 12 May 2025
 10:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501225958.2947677-1-gitster@pobox.com> <20250503005814.3030099-1-gitster@pobox.com>
 <20250503005814.3030099-4-gitster@pobox.com>
In-Reply-To: <20250503005814.3030099-4-gitster@pobox.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 12 May 2025 10:36:38 -0700
X-Gm-Features: AX0GCFvwAslTD7_AH36yUUq4WK7ul2EgCI8gntz-2iF0A6rTgn19sYnw4j-0Ffg
Message-ID: <CABPp-BHWjspvWWXpv9ZYmbNzWBHe+w8nxDrpT-nebpZBYT_wSA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] tests: prepare for a world without whatchanged
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 5:58=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Some tests on fast-import run "git whatchanged" without even
> checking the output from the command.  It is tempting to remove the
> calls altogether since they are not doing anything useful, but they
> presumably were placed while the tests were developped to manually

Perhaps use "invoked" (or "used" or "employed") rather than "placed"?
"placed" feels a bit awkward here.

(and there's the developped typo that Patrick already pointed out.)

> sanity check which paths were touched.
>
> Replace these calls with "git log --raw", which is a rough
> equivalent in the more modern Git.
>
> This does not remove "git whatchanged", but we no longer have to
> worry about adjusting these places when we eventually do.

Seems like a definite positive change.

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t9300-fast-import.sh       | 12 ++++++------
>  t/t9301-fast-import-notes.sh |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index b258dbf1df..4dc3d645bf 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -120,7 +120,7 @@ test_expect_success 'A: create pack from stdin' '
>
>         INPUT_END
>         git fast-import --export-marks=3Dmarks.out <input &&
> -       git whatchanged main
> +       git log --raw main
>  '
>
>  test_expect_success 'A: verify pack' '
> @@ -279,7 +279,7 @@ test_expect_success 'A: verify marks import does not =
crash' '
>         INPUT_END
>
>         git fast-import --import-marks=3Dmarks.out <input &&
> -       git whatchanged verify--import-marks
> +       git log --raw verify--import-marks
>  '
>
>  test_expect_success 'A: verify pack' '
> @@ -652,7 +652,7 @@ test_expect_success 'C: incremental import create pac=
k from stdin' '
>         INPUT_END
>
>         git fast-import <input &&
> -       git whatchanged branch
> +       git log --raw branch
>  '
>
>  test_expect_success 'C: verify pack' '
> @@ -715,7 +715,7 @@ test_expect_success 'D: inline data in commit' '
>         INPUT_END
>
>         git fast-import <input &&
> -       git whatchanged branch
> +       git log --raw branch
>  '
>
>  test_expect_success 'D: verify pack' '
> @@ -882,7 +882,7 @@ test_expect_success 'H: deletall, add 1' '
>
>         INPUT_END
>         git fast-import <input &&
> -       git whatchanged H
> +       git log --raw H
>  '
>
>  test_expect_success 'H: verify pack' '
> @@ -2066,7 +2066,7 @@ test_expect_success 'Q: commit notes' '
>         INPUT_END
>
>         git fast-import <input &&
> -       git whatchanged notes-test
> +       git log --raw notes-test
>  '
>
>  test_expect_success 'Q: verify pack' '
> diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
> index 1ae4d7c0d3..e62173cf1f 100755
> --- a/t/t9301-fast-import-notes.sh
> +++ b/t/t9301-fast-import-notes.sh
> @@ -76,7 +76,7 @@ INPUT_END
>  test_expect_success 'set up main branch' '
>
>         git fast-import <input &&
> -       git whatchanged main
> +       git log --raw main
>  '
>
>  commit4=3D$(git rev-parse refs/heads/main)
> --
> 2.49.0-601-ga5925c3955

Looks good.
