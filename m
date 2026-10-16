Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0B83C3438
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140663; cv=pass; b=TrABGE0S0gGVTOVZDNrDnTRWyWCo3xYIKektkNt09a9tRRjx+73FeC6I7++UZwVJhnTUA2glElr+vfmMDSxUp+PI4ot/obLPV2JCJ5bFnzCL5lPPWsAyjpKIs4/9Q6so8Go0naMWLrIe8deg4vcZm6Yf1BL4HeHHY7I91trenwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140663; c=relaxed/simple;
	bh=7Xh2kZt56BH8o6iGjFq2TDXZ4/udyKwVEghnmmBBsXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q82hFZRQUTmCAndRmXl3b+G0Hx/UZX7QkycyNqhfH1gOgG+UUAPHPHq1vFn1DX9Igg4MGduCU1iSD5DefUm+rkHXmW1Wr4BvQ7VJhFOLimCZE1NKyB3uyqSq3ALgaNdRJb5iAgWBzFAP6sohcOn8rZpQGmHJ+z9eHvJe9sWZcDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBzQBNja; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBzQBNja"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93e63ee7b4cso522506385a.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 01:51:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792140661; cv=none;
        d=google.com; s=arc-20260327;
        b=KcJY/GVgHVfi+VamzHyW/+fFmuIu8l+Dj9VLf42ZS/KSTUXZ/Eqr/LUqOo4vOEr4h/
         b8k0c6RU9w8y7MaPGO1/xLzmgO/Fn3F0uG/uiTKrEuW+kKTbHE5SHwxGiujy4s60wL3l
         My+hJQmRR+8H1r8qmZPYUxO8cbIbK+597Tstl6ne8CrWhXL0L98wJKtuz+Mv9OHXE6JS
         XYtZYKv2Tv00I/1VljvifX5khOZP2JfMEeYmFdRletlOv1KM/lfdRdDakZsHVF9bxGTW
         cBXovuJqiGrpqUCkdVxxVAtD9WwpbMvGTXDYUhV/tw5X585S3rsDLywNyVY9ezFzZ54G
         /fwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d/kcNsKxgloKdIeo1DXIkuP34RrZRF+PqEugjijGQOY=;
        fh=fZdpMwq7QSqNmyrwcYJX6WE4wwRdMQC5fu2wqJFeYFM=;
        b=r4/Ob+OHPd3/rYdUhXNkLxXtOzjW2syqC/478K2QcQLDoLIoEVnHfeKGhv630L6t5R
         tmrHBcVBGUc3NpWKYu6ODH63RQESzBpUPPtsgNHSDy2xlpII10uxNwgutbuyQlTLvvFi
         180adFmoP7p9kkgQXeukJzkON2/2sAxSqTvjSZ2z/9DV40htHHWVJPDg6VZeuP5jbSOu
         8v6CpxoZn8ZZc+2m6zeeUaqidCoPyiETQlRYajNmuhvFTuT2iMVTqkiznrHm4b7Ahkel
         6Mo3qzhcky1GUtfyABMSErm4XCfue2ldMHZOSKvj4ibbFXnOURfR42txAElGvs3XjoY0
         I2Pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792140661; x=1792745461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d/kcNsKxgloKdIeo1DXIkuP34RrZRF+PqEugjijGQOY=;
        b=fBzQBNjaUBSB+iePfZQXbeCFcxstyai51h5DZ8XzmdXXUZA/4pvlBc4T31LCXd6dmg
         mYwE+5bncx7KYv298cvLHniPwJSlXYhxlpYrW8IImkCI+kBGlgLYLVb1ZYHQ1dLLv8GB
         yCylrGZU+KW8FiPwzUjSDvM1ivC8aNnOMCBZPlca3J2UQxdqtttd0DU7MNsE1guFynXR
         hzvVOLUnd6ZAw7lBSo37A1lgdOiYPrZzoG4IeSb39aje/cvwad6Eun6ePnWfGxMWaKd/
         frhmc9uU0fsE6QYZIUEO6uLRR+7nQFBOiuiNuzREMOL20a+i275hTYDUSYm3v1shdrdJ
         rPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792140661; x=1792745461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d/kcNsKxgloKdIeo1DXIkuP34RrZRF+PqEugjijGQOY=;
        b=rQDys1iR42IzruL7WgVjZN4wi/iyaiW7RmgtunLyb9UeY8mRs3azb48UbaWQGSY5DH
         Ods50W6bvdaGGnZ2uTojpr10/4EwBFdTYssvNJ3sMsjINWsiudy5NpxhlstRRRa4hOBO
         H+Wt28N/Y8aJsZ0ivwE6M4QF0VO4uZzXZD1MrOqP8Jq4hLXE+Db6iBKxKvORd3UYx5xu
         6YGmZhDFZjzhVAldN9O12OdwsTqlluhzndfJHgehBCttiA+djSNZjNhhvtGl5aZLJg2d
         fORF8JxKfPAb6yl3wNOC97SFPIP5znCviOtTJAobSdX52SNmO2QRVZgblzqQ1LK/XgiD
         3BFg==
X-Forwarded-Encrypted: i=1; AKwUvBx9imm7ykD40v6T0wRgrbZh8ew5r53qt4UNcleAvRowNZd2OSI3jOOrQfouCjv2TGG61bc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGNpUdQKsgiL7K84G15Dbdq3uMR/ptquapH/49oh6bOEyekhM8
	7/SAczRvOJMRwaBPaO98ou72F77IVceZkcJGksYHKTpPyUVkA8EGQdcsi+50LKDE4NUewnTATqu
	CVkN9mcnddG6Q9v9GjomHOcMzJ+xRCmnbp6NDmCo=
X-Gm-Gg: AYBFou1LJ19U9V5OicuDIRosrKr1ACblFyAUGxGnuc9kM5xKQa2lMf/EndfOQbtywxT
	fi6Cv06EItol2IrpHCwrFqs9Wr+oncljpL+/cHPRlYr3N2ioih3cmaDbWljEAgiAWK9h2R843KS
	5MDAlJ7O+LAM7bOQc8b7Q5TzvCuhX0z/uxvJk9bgRUkO86xu4R3jiWevQkEwRvXvHB+A8S4HUjr
	JkWXZfp2iE9sTMpLLXMOO4VNGzYk0kQoZCWKTltEXTVtqmv7WXBJyH6cvygrFi9f3lTPHkHHQGi
	FTDR+QmT+f44R1Abvcml6AfQdcwa9989rgBl3mjeMwy35c6F1pOhvhJw4YBP49syS+DO0oy/8CI
	Wsfzvz6wo5trOQB91VLzSaexL
X-Received: by 2002:a05:620a:2802:b0:93e:5861:34df with SMTP id
 af79cd13be357-93ebd22d87emr3380881385a.47.1792140661379; Fri, 16 Oct 2026
 01:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2256.git.1791978767497.gitgitgadget@gmail.com>
 <pull.2256.v2.git.1792135548923.gitgitgadget@gmail.com> <CAHwyqnWT9f0FvthhsPcRb+c7j7xb1LBxGxxBheb_ddfcUqij+A@mail.gmail.com>
In-Reply-To: <CAHwyqnWT9f0FvthhsPcRb+c7j7xb1LBxGxxBheb_ddfcUqij+A@mail.gmail.com>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Fri, 16 Oct 2026 14:20:52 +0530
X-Gm-Features: AclHuK-I8hWHS5hw_TKGr-c7pjmnv_-MZZFS8DTs5s0nA5Z3YyVJ7CYoPjIDO3A
Message-ID: <CABh_KWi-MkiTY56LOLdaZu1dxxYjkSNX3jjO8+9_+mp3-FaNkg@mail.gmail.com>
Subject: Re: [PATCH v2] [Outreachy PATCH] t2030: modernize test path checks
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Harald,

Thanks for taking a look at my patch!
Since this is for an Outreachy microproject, I kept the scope small to
follow the guidelines. But I completely understand=E2=80=94if it helps, I c=
an
take a look at modernizing some of the other ones too in a separate
patch.

Thanks,
Srujith A Poojary

On Fri, Oct 16, 2026 at 2:06=E2=80=AFPM Harald Nordgren
<haraldnordgren@gmail.com> wrote:
>
> > +       test_path_is_file .git/rr-cache/$rerere_id/postimage &&
> >         git checkout -m fi/le &&
> >         echo resurrect the conflict &&
> >         test_grep "^=3D=3D=3D=3D=3D=3D=3D" fi/le &&
> > @@ -182,7 +182,7 @@ test_expect_success 'rerere and rerere forget' '
> >         check_resolve_undo kept fi/le initial:fi/le second:fi/le third:=
fi/le &&
> >         test -z "$(git ls-files -u)" &&
> >         git rerere forget fi/le &&
> > -       ! test -f .git/rr-cache/$rerere_id/postimage &&
> > +       test_path_is_missing .git/rr-cache/$rerere_id/postimage &&
>
> Seems like a good change, but there are lots of these calls in the
> codebase. Maybe change the others ones too, while you're at it?
>
>
> Harald
