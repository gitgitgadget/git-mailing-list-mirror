Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5736336896
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 06:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772864987; cv=pass; b=R4rFh3+eM0SzhrkpdfEN8FUBID63xvKblNe6djW3kVsX2SF8t4fI1F1zgWrtGT7WalOYI9bAwMy2tYz31o4gi3JUO2Q8dXsMY8OXE23tA03dcUXdh7JrU+efHHJ3+RniqUMzEY9+iGOcJIPQWvEmAWvHPFZHDUcMuLmbx6/zf6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772864987; c=relaxed/simple;
	bh=ik+bB3/SV/W8X4UIzXuFxpyQaiWNhjwDlGECwbJe2uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Txc+v4qW56Z1e+ed8hueZRgKFdBSG69YzHCf0nPURjTUoR6+pQsXRuKcwyA6/vi3xfEsX2I2g6AAcvPWo9SF3/VbyW4hXw6lABJlU4EaxP4fM344FE+bb/8dAeXRUXGZIx+pUdJ+DStoqnDRhCkQKS2GFODX/PliUTd1fY2egUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2be0629f76eso287029eec.3
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 22:29:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772864985; cv=none;
        d=google.com; s=arc-20240605;
        b=lZD3m53EviPaq8Q0yYpd5fLoOitH9ibr0Mh1Scq9IKOsnxMLli4zipCnMdwk0pAZnS
         XnV21ywlwyAFURu+MPzINyDrDZvDiU9ff4rYEfhmwmX9oqMb+h+HmWSy/cMC5z/lFFqY
         L+ZbpwLg7dRfSrSy7TXMB+HjJRszZV3z82b6nkhdGi6vVkzLxvKxx569c2zJHDvfemBz
         Jk6wWuIWzfCUIPvg9GWyTp1Dwfc6c/3VbpFn3rQUvEZO+uWFbiB1JY2Wjj4ionuTCIQX
         p4PW59C2RG2/QDzPXgZbXBLV8+/wMm4exFwEOZ+T9g1iYVXOTSAGirHa+fHWUPl1oooN
         xiWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=G+RQ6fxvUfXGcheX+oVH5tvVh0vY1Qzd1IeipouupLU=;
        fh=GDTtk06GWx+BcnnbItsaTxolHfAv1a87i96qChTRwYk=;
        b=N5O+fmPA3afj0aHG/ULuXC6qSI18/Cyli4Ss6C87jQx9Ah7MCDonKAR1wIRB6cJDTC
         CbJXVj42pzVDXboPVi++em3XxM/zyBiajlNzyrFPw8EGmkM3Hqt4IC//s77CT/k+FGyb
         gihzsEcUCrE8V269FNYIRyoiXXgLWTcJ55hDBgtsNl2mpC2uSDmpoXbN48+vDCRW5aTm
         mux5QQUTBBXJlo2haX/Rd4G7yAyeqBMP4k0zjAnoT+RavAKz/60f1DlZhrlXq5CDNvtF
         GjC9k+JWWSjMcVX6BUOhjTTTnSTnFw32XBSb6rwxCVr7zTXFU1+AM1LvEjAZNoodtK3E
         3xGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772864985; x=1773469785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G+RQ6fxvUfXGcheX+oVH5tvVh0vY1Qzd1IeipouupLU=;
        b=r24PSUhrcShthWRszljV2bEOktscQQVJtrHez2S3gskXgEu9UCkOvoFWHi5tO1Wd3T
         /Mbk4AK42UGkM4Zw+WLPuiSOGBQqlBhZuEuev0ZgtijXf5g7DVZyHOyBZV3gGpU1q785
         y1JuFG2KvPOTegf+HJtyU2Xt0WZWTD+qNAqFAgGT0QowKG6xv6ngtjJED+l5Fw2wBSH8
         OXeWFrYQTHV7R5iZfpxySDckVL2P1DFFqJdt3RO149vf1uW4O1tsRmfuyqa7t7X9/Lob
         tR3+PezKyFxbphisQcyPM0eq6q9c0Pp7eOFOh2cS0Br2RVJIHfiiSjN3a+4ItXWTIgGo
         dgAw==
X-Gm-Message-State: AOJu0YweotmhgVLowPXktuzMNpfIgwKmLik6PHRjBdhXcOmx5rFGbvGM
	5mqV6kT7qZqX4/kAKH44WaGkA2vVMOaHYOxqw2LgkigO0nHK/TYXZ9eTI4NqMGxQWKjqdd5IhhR
	NodRQ6Eux7XOWoheE0hQflhKKWjobnkw=
X-Gm-Gg: ATEYQzyp7OLD2bMaCCsO85lzn+/ONvdpUggp8cqib20GGu+uQ0CR/s9A6E4594ngOHI
	PpWYj+QuvA2ziF+AJqZUOz/BdockFbAsycNctHQmcAZvkH+d2C6C6RcaWnM26IElUVF5Wjp/Ysd
	CM1P5dnYbM3CkuasmZuL2aPVOCsqx0hJtQUIn4VPZsdKJj9cl59KQ5Zlr9ymWkYF4X9Tmf/o7rp
	a067tYMK7Hyb0NYzqCc/ohWH4stbd42k+xliR0mXNsmxtzarS7nAbnDCym64lHdt2fzbpfE6GxS
	mi4sBEPIVvuOJlSElxJAUBJQMwx5Damgb8R5x2xO
X-Received: by 2002:a05:7300:cd90:b0:2be:1f56:ed0d with SMTP id
 5a478bee46e88-2be4e09d96dmr870113eec.6.1772864984742; Fri, 06 Mar 2026
 22:29:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEaT9_-h2MEshMHoyoW9kWQgt_EfQJXcxWSn+cXTSL4mKME=5w@mail.gmail.com>
 <20260305225128.54283-1-francescopaparatto@gmail.com>
In-Reply-To: <20260305225128.54283-1-francescopaparatto@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 7 Mar 2026 01:29:29 -0500
X-Gm-Features: AaiRm51p65MHW0HyGUmE9zNxQI0BqI_JBGfEa3I_K4Yr7dMnazXr28xmxp6chVQ
Message-ID: <CAPig+cQWCK48GJEnGX7bP6exu847WR8HU3Y8sna525w6NEhmmw@mail.gmail.com>
Subject: Re: [PATCH v3] t3310: avoid hiding failures from rev-parse in command substitutions
To: Francesco Paparatto <francescopaparatto@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 5:51=E2=80=AFPM Francesco Paparatto
<francescopaparatto@gmail.com> wrote:
> Running `git` commands inside command substitutions like
>
>     test "$(git rev-parse A)" =3D "$(git rev-parse B)"
>
> can hide failures from the `git` invocations and provide little
> diagnostic information when `test` fails.
>
> Use `test_cmp` when comparing against a stored expected value so
> mismatches show both expected and actual output. Use `test_cmp_rev`
> when comparing two revisions. These helpers produce clearer failure
> output, making it easier to understand what went wrong.
>
> Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Francesco Paparatto <francescopaparatto@gmail.com>
> ---

Thank you. This version looks much better and addresses my review
comments on the previous round. I do have one actionable
recommendation and one subjective comment, though...

> diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-=
manual-resolve.sh
> @@ -569,13 +578,15 @@ EOF
>         test_grep -q "refs/notes/m" output &&
> -       test_grep -q "$(git rev-parse refs/notes/m)" output &&
> -       test_grep -q "$(git rev-parse NOTES_MERGE_PARTIAL^1)" output &&
> +       git rev-parse refs/notes/m >actual &&
> +       test_grep -q "$(cat actual)" output &&
> +       git rev-parse NOTES_MERGE_PARTIAL^1 >actual &&
> +       test_grep -q "$(cat actual)" output &&

Storing the output of git-rev-parse in a file only to read it back out
of that file a moment later is unnecessarily roundabout. It would
instead be cleaner to do it this way:

    oid=3D$(git rev-parse refs/notes/m) &&
    test_grep -q "$oid" output &&
    oid=3D$(git rev-parse NOTES_MERGE_PARTIAL^1) &&
    test_grep -q "$oid" output &&

Unlike this original in which git-rev-parse's exit code was lost due
to being embedded in the test_grep invocation, this rewrite is safe
because the exit code of git-rev-parse becomes the exit code of the
variable assignment, thus correctly aborts the test (due to the
&&-chain) if git-rev-parse fails.

> @@ -606,8 +617,9 @@ test_expect_success 'switch cwd before committing not=
es merge' '
>         test_must_fail git notes merge refs/notes/other &&
>         (
>                 cd .git/NOTES_MERGE_WORKTREE &&
> -               echo "foo" > $(git rev-parse HEAD) &&
> -               echo "bar" >> $(git rev-parse HEAD) &&
> +               oid=3D$(git rev-parse HEAD) &&
> +               echo "foo" >"$oid" &&
> +               echo "bar" >>"$oid" &&

This is purely subjective and you don't have to take the suggestion,
but although yours is a faithful rewrite (which is good), I probably
would have simplified this to:

    oid=3D$(git rev-parse HEAD) &&
    test_write_lines foo bar >"$oid" &&
