Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20672261B98
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 02:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773282861; cv=pass; b=TyqRVC8jqt0jsP+qkjJXmMfqis4U62bVe4ldTBodado7Zsp8t5l3eh/lDbh3r1m64k2EXWqAJYofd7h2C9L3QO1eCQJqXLVr3eoAPcq8hBmtF3bGfLQBUAWGgH9uj+DLeiU2250v75sSPCpvW/GrYVFHJ7w2Tvn6zecX0P5LSsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773282861; c=relaxed/simple;
	bh=87WwduBVhbYlBbAHzh6Tn6PXGX7PXC4vGk64btQa/ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nF5ca7s+N0hrv96dyuHc3+gC6CBQlPmm6z1t4M6TBGdrHd5Vr/TDZm7SBTAoVcwPS3QvF+4jV7z3OBxcUPRg41bi4yh+J5NjIpRGm5TTOFRbwq1mQaJdXLMR+jYt1OdIQRsz11pfI0Gt0eaalUzM4QoPzl3Q+WseL/NxBpOP/Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mrt6AyEO; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mrt6AyEO"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1271195d2a7so1490460c88.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 19:34:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773282859; cv=none;
        d=google.com; s=arc-20240605;
        b=NuTPaWScWSuYjzxGkl6PsWz4Ze2VtpNM6liIupkC6KN+rhmfWnsqtkkc8YXMQa/kx1
         otKju2VUbBeQko9I4RZU35Dd0uGW5+P5wkkDyrZ9x2QKH1pyz+2F6bVvSW2gG7ph+B8w
         aZpnd1bgxGWiVsIQzwBQ2RlRf29vdBrr09EkzDzhLdT163OZMGcc2A/NiTRIH/JmtvLB
         dcD/O/yKJBeyBecK6V0gRQC39Y0bg0iDZk7YHsTB6A/Pu16ZgFz+YLRISIG7SPHKtXj9
         sgANkrv8XuwBMbn0nvvQEJeDMgyq2emugT+MRyX9Pzyi0vkQtpZUJPY4aGlI30rok3lP
         3EPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UosJiM/JGWXhk8SRJTyrd8DHaz/OQpWJLau3IlpplRg=;
        fh=/L38zx4ueNQW7CP5o5w5vtEy3koW1t9MYfQNDdn+cFE=;
        b=QbCJfq4cAcVAhjXlpJ4K4cPAUUHOoOxwGUqhbt4hsrgXo9y3O8ftDkd8+KBW/oTEJ8
         YHh4jaO81OeNPx7JqU4FjLJlwLA+8UgvCigRwkaFO70yYyeMbn4YkdenxGlhiVV74ZDS
         WptVgg/JigRKCm9uCx1Se8INhtfpy/YM0dWD9lC1Dd39aFsl8SrARXZVHmTmJGwMrBnm
         djTUAInPl5Gp5KSc5yDambVUdAug5ZLcMPLPB7PhEvd5HMOi/yrEcc3GDPwpRziWI1as
         GSaxyFmoVwq2NF9wXutrswGhaVRWuJgQBlUO3YjvYxmXVgWoSYTNi/lc5kIs07wRmwD8
         jBRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773282859; x=1773887659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UosJiM/JGWXhk8SRJTyrd8DHaz/OQpWJLau3IlpplRg=;
        b=Mrt6AyEO2Jfii0Ds04u5jma5I3n0Ug+kVCoUy9bZNnD77gtCR5yOoly8KpH4XvJBwz
         q4K5pL7Wdy6lVJKBfUonneOtUre7EUWWgC0W5pauMFl5i6jGi7j/u0X1uo6vOKHC4W+0
         OnCRJRRCGC7W3jU1K5F0INiB8epvWPtaExuTIcp7m32rnwzcWb7APUVjJWQfxCHWgCR/
         ePyV6Sj8inEYpytfHp+VjndwGLBjPjJWkhWwFg02KMxJvrfV0MeaP/JA5+pnloCDOLRk
         cH4CEzxujlOI6QR2ktJS5j9oNe8+52CBnwTHBqqdaDDWNiSmdwNGU4mpBvtN41wW3Ce3
         3ySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773282859; x=1773887659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UosJiM/JGWXhk8SRJTyrd8DHaz/OQpWJLau3IlpplRg=;
        b=cCbnPAoiSq99CvvvpLB0y5kNDHA/yx56bs5BDQpX6/lFT2Z9/uK9In4Z60W8AFEs9m
         Gp7SnarWCg1zJpOfwM4Lbk+0WqO/R/30Ci5WuBf+CdD0B7bQBE5YUln05R6gy/Dg78cL
         xwF9c87qjtagb9MoRBeE4P4oBk3ZaC8TpQcjMxH9tgeKEYuj/hkFZx5WNVwnTjO9plat
         z16k9RcVKU2JEe64hWrN0+a7NRrZ1t5B6qlBBPuyFbThNQrYWcqmho9sPB6+HSxH//Nk
         TPBbvudqseBhgKlMTYhMKfBoad4crGceES9oyYZ+5110+B0BVA6AaCgX78uzoNOI0szu
         5yJw==
X-Forwarded-Encrypted: i=1; AJvYcCWPQphELTDlEZ2VobJi9CiMxbBPNSsLJlabVxVz20jtEc3cdCvtWeQvOr159H9/tkpKgD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+n2eBPqNT/sXdV55SX+nLn/BQWC4wqj2QqLAjXRG9W9VaOMtf
	+bU8534338eEz5mE9ovUkuqGzPfXIy/Ze6e2PKUjOPssAa29l20AmKbZfioermFoqkuRUCELySO
	sFWTZ73cCzkk2jCs8QnkzFwEYiyOa2Bo=
X-Gm-Gg: ATEYQzwQA/K4sszeJ9cP3xd+Ym59EIH4pf6wVYNDHAk0c8tyubKbaQ4xY3N052aCyOW
	aS8pH4NX1EYEm3cCA8crvubNewUJJ9kKp+9xmFBXyKtdT8zfY05gmeDfqrhG90SqAvFl05ahGOb
	xTKSxh1XU4Azxp+W2oJc3lF2U702CJGzTZ1vSNJrwDhYW38W4pV44JM1Y1gQv1qvbIuWCgfhG/N
	ZzARCBz1t56ysAKy6nC+4MPCFnleZzELHyr+G2TKS7fpbP2/lSye1tiPCFis3cA3LueHB+DHlDP
	VsQqFTxc6AcLKtdsmoqHUqyhmOWL7vJDB6+8S1+zoONCJ0RdlyI7nwH1398aq0hwxVag/EH7474
	tXXgGnqo=
X-Received: by 2002:a05:7022:fa3:b0:119:e569:f268 with SMTP id
 a92af1059eb24-128e77af815mr2181624c88.17.1773282859113; Wed, 11 Mar 2026
 19:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com>
 <cover.1772551123.git.worldhello.net@gmail.com> <d7a7a07acdcf15520019fc58be5e6a1a1e24791a.1772551123.git.worldhello.net@gmail.com>
In-Reply-To: <d7a7a07acdcf15520019fc58be5e6a1a1e24791a.1772551123.git.worldhello.net@gmail.com>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Thu, 12 Mar 2026 10:34:07 +0800
X-Gm-Features: AaiRm505hZx2R767EG4_UNF0MdN0Dy8p3wPNdm57-wzcRwqGDiqRfB16o3yFWGw
Message-ID: <CANYiYbG3CtSnis4NfhsH3SLyTPEurW2acqtj3snt4FO-2X809A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] docs(l10n): add AI agent instructions to review translations
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc: Alexander Shopov <ash@kambanaria.org>, Mikel Forcada <mikel.forcada@gmail.com>, 
	Ralf Thielow <ralf.thielow@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Dimitriy Ryazantcev <DJm00n@mail.ru>, 
	Peter Krefting <peter@softwolves.pp.se>, Emir SARI <bitigchi@me.com>, Arkadii Yakovets <ark@cho.red>, 
	=?UTF-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>, 
	Teng Long <dyroneteng@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 11:34=E2=80=AFPM Jiang Xin <worldhello.net@gmail.com=
> wrote:

> +### Task 4: Review translation quality
> +
> +Review may target the full `po/XX.po`, a specific commit, or changes sin=
ce a
> +commit. When asked to review, follow the steps below. **Note**: This tas=
k uses
> +`git-po-helper compare`; if `git-po-helper` is not available, the task
> +cannot be performed.
> +
> +1. **Check for existing review**: Evaluate the following in order:
> +
> +   - If `po/review-input.po` does **not** exist, proceed to step 2 regar=
dless
> +     of any other files (e.g., batch or JSON files).
> +   - If both `po/review-input.po` and `po/review-result.json` exist, go
> +     directly to step 5 (Merge and summary) and display the report.
> +     Do **not** check for batch or other temporary files; no further rev=
iew
> +     steps are needed.
> +   - If `po/review-input.po` exists but `po/review-result.json` does not=
,
> +     go to step 4 (Process one batch) to continue the previous review.
> +
> +2. **Extract entries**: Run `git-po-helper compare` with the desired ran=
ge and
> +   redirect the output to `po/review-input.po`. Do not use `git show` or
> +   `git diff`=E2=80=94they can fragment or lose PO context (see "Compari=
ng PO files
> +   for translation and review" under git-po-helper).
> +
> +3. **Prepare review batches**: Run the script below to clean up any left=
over
> +   files from previous reviews and split `po/review-input.po` into one o=
r
> +   more `po/review-input-<N>.json` files (dynamic batch sizing). Run as =
a
> +   single script (define the function, then call it):

In the v3 reroll, we will adopt a solution that is easier for the
model to understand: using a single pending file to record data
awaiting review, rather than splitting review tasks across multiple
files and requiring the model to select among them.

> +                   git-po-helper msg-select --json --range "-$NUM" \
> +                       -o "po/review-input-$i.json" po/review-input.po

There are trailing spaces in this file that are breaking CI. This will
be fixed in the v3 reroll.
