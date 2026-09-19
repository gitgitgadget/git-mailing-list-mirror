Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378103655C7
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789832595; cv=pass; b=pdFlAO/u6Vh2dS+7Hkmc5LXH8q5zcGkKGBws6YWCW/Vi+uhV9x7mxl1y4rMDS0Wj6t6GAWs4W53h7Tq8BF5iQOwjZofYRrvoc84oY2DagAcHcFnONX/b6RWerUJ87n0u93a32S0dwogS1oB7Xh1hnYSlLO3Z2qYzDB1/VVLwiBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789832595; c=relaxed/simple;
	bh=jaSrcdf1i1zsiVourTSG/t+GLwu0O9P5iNmL4aiQmWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ln9JaGNJiYv56Lc3tO2p9zZh2gDV/JJEm4ei3Q2PLSedvTvgB1T3PNLWwOsw5uUQymgYx4LdWooYBrtN3Hur0yqmd1I8rvMvOk+SPbHbVwVJ473iWWFEpZwMd2OLuvYVBr9PJ9H+3SqbiokSliCaLuoi7XO7pFiGDxt0yxQQ/GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVvcqzSE; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVvcqzSE"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff00b8d8so14274511fa.1
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 08:43:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789832591; cv=none;
        d=google.com; s=arc-20260327;
        b=AAd2OrezNBsyUw6qVxtWl0G7mboFlQyI4360MbdPj43dvvKFHo08NfP7wMa9zeTSQj
         1KWvvp+Mj/BGr7usmHVaiP0KuFF8gJbW8yu4hZC7tOSU4EzMZjrONu8VzASItHXBvnaT
         sTML94Ongy0OTs2ESyYKE99TWAJs7N9IB7uZkylJI5e0Bismszhr74fkgSLNKe4Cnmnh
         8S8AHyk8ZB6VRGMRBsA2k2Jd1P2lXWbt0fxdnzYk37MvFP+9RmZBqcXRGWrWkyRLOyQ2
         ZdzQhm2TUDblqwaCm75t5houraxsJishl4EMAvt4Ktrgw/5RrGz0JPcuHo2iKxkTsaMV
         Y8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jaSrcdf1i1zsiVourTSG/t+GLwu0O9P5iNmL4aiQmWo=;
        fh=o5l0Eu0aYVhYLNaknXG9Bd9QW+Oip/V1pdMxWtUugbA=;
        b=KjsIGeL53mBdVAriHllCCEK9snKTmvnQsZ0OYsVO27ITc7L+/sAKFcIkq6f2sRvSzp
         3woNa374mYpFAyR49UUZzc8q+OW1OagmefTDqKi/hfcdxuv/++JTP3+wg+9AihgKuz+R
         aNFq1xu0gjetQRBtKL2Jxko76kmxvh/V2AmKj1S1hgUcVp/+gefO4NOrq9BMvW/s1QAn
         Mxn5PN1H9OqaeDoB1mcq/j420y7JzOdvu/3X6/GlbhQ9br/ciQ+EoQiz8nCYuiQuyPYf
         w14GDSO9z3fHApbNbsEnxWwWbks6vJ/XpI9e+jAXumxEXmm0Jld+9xx1oV/3WdMWfXSc
         5Vzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789832591; x=1790437391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jaSrcdf1i1zsiVourTSG/t+GLwu0O9P5iNmL4aiQmWo=;
        b=DVvcqzSEbAzRyL+qPofDc9YEH8t3Ddqz6jHqXGvXoI96Y2NiBrseYAcBUU1yvwg+SJ
         0jquQmOuUeHmO8uywJqT/lDdSTYX3/OM8lltgGo8ekLQxE5uFAcpknboSUEea+EUymmF
         sCoy3roxO1o/45GX04yBrOpQbQrIgPWDI255KRcPg3oY/wdyAwNZX+GcmUQ34hCUuUXv
         7V7EXY8gLgmqf3CLZ4GG3Zf9NYoQqSzOWor9Y0RdtkTD3WYY0GHtxSu245o+XZjFmzQO
         tFBSnxnxk423+Uh4GbOCkuyv5yEih8wjjT2dy6dyQw83fL3coWDC/GRxXesNSik09Ht8
         rmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789832591; x=1790437391;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jaSrcdf1i1zsiVourTSG/t+GLwu0O9P5iNmL4aiQmWo=;
        b=bKd7mnhAXzJhwaOt6nbx509uYmqHb6bsG/Bwt6MVkxokoMbzH/05XKfjznaj5Dp7aT
         Xn8xv1yA4abWKPDuYKH2PArAlAic9RXPeVtBOJ5f8uroRndHFYJFlq4LKbIqLyWZ9u4k
         vi0VbqkLQeJBkWDXW3t6bBSugALUva7i+GfnxMa+2rlwOjVphSLbthfKk86slWn6dYMc
         0Ohz7XetEMQbvlJ99RMMDn7vfTGkFbHFdILvL/vH/cPN8Y9ZSiT2KPKkqa1cGQpU6NPl
         3v0JyhhomSj1kyjO171CZ89EJLxDj05TqzJrTVQQznwoWHK7yLy1URoQ4F+u7ByrYQr4
         fDIA==
X-Gm-Message-State: AFuF++nE4nBSnluTOisMPJ5btd4er9d34bAuAlntCrjDFvwz38/cg5KU
	w1KNZsIRTTziTpXpyGyQ9ZthmLZy9jroTKJrqSr7AaolNXj0mTKnUP2BLcW337NlJz5REiIau/p
	JHVzcjLiunJKousmuPtVDGD85/hjMRRxQQoL1
X-Gm-Gg: AYBFou0QVxw+4JB3TFWMSuTbCOII4uGDiknBpoNuGLlw3daHrnkNTonVOQ5HcBYpKCQ
	d+E77SdxCbVSiRHZZKHxbg+HCwFm9GbVQS3UOZcgxkubJyRlOKr8pi6GEbawDtBVQkXCUG1t5Xl
	s12PeMZjDZnQm+JhnVdMa2xQemSqc21Bc7rpM9UIM2ex+aPIKFMxz+6scrbNAa69jgYYTLb3VoW
	zUh0AQ75RYXbCTJL/d7MFi3QvQa2cbyvh+t+Z89zILGNb3ApHS354Te7PQ9acb0ROxf5PhQ/xvs
	0BmwO+X1Ar+VDUzA+toiO5azXStdD27yStp46wTgbfZR0XO8mQQ9k8NfXLmZfWHsfzHj4nAmjYI
	5h+wuq1Q9UQJMPDOv1qXL+bDA8h6g42H7aZYUnm8TmBdHg9Oyvt5zTUpkLVf1+G3jqr19JzIKqd
	A=
X-Received: by 2002:a05:651c:2213:b0:3a5:d070:9fef with SMTP id
 38308e7fff4ca-3a5fbf544fdmr10629191fa.10.1789832590770; Sat, 19 Sep 2026
 08:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACQ=SRGTTdQ+dHXhN6F52dBv5KxZBRfk_Em2fvmEmGJDoB6oTg@mail.gmail.com>
 <CALnO6CBUr3=Cj57ikytiPxU-1hZkYu1Z3fRPydhFLqJHprbDew@mail.gmail.com>
In-Reply-To: <CALnO6CBUr3=Cj57ikytiPxU-1hZkYu1Z3fRPydhFLqJHprbDew@mail.gmail.com>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Sat, 19 Sep 2026 17:42:59 +0200
X-Gm-Features: AcwNN1VzlCkFfVMf_n32C-AfKbyu_kgLY1KojrHNWNSDass9LTmHrMgGqQu53Jw
Message-ID: <CACQ=SRHthWOLVXmY6wgknOPgpQ+oB1vV-Q0AL=mK9mXb2Xy9Nw@mail.gmail.com>
Subject: Re: [BUG] reference-transaction reports zero OIDs for branch and tag deletion
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Commit `6754159767` introduced `reference-transaction` in Git 2.28. In
Git 2.28-2.30, `git branch -D` and `git tag -d` used `delete_ref()`
with the known old OID. Commit `8198907795`, before Git 2.31, replaced
single-ref deletion with `delete_refs()`. The new function preserved
only the ref names and called:

```c
ref_transaction_delete(transaction, refname, NULL, NULL, ...)
```

Without the old OID, the `REF_HAVE_OLD` flag is not set, so the hook receiv=
es:

```text
000000... 000000... refs/heads/topic
```

The change was intended to speed up deletion of 24,000 tags from
roughly 30 minutes to 5 seconds. The loss of information exposed to
the hook appears to have been a side effect. So I assume this is a bug
introduced by that optimization, and it should be fixed in a way that
preserves the performance improvement. That seems feasible.

Cheers,
Maciej Ciemborowicz


On Sat, Sep 19, 2026 at 4:59=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> On Sat, Sep 19, 2026 at 9:34=E2=80=AFAM Maciej Ciemborowicz
> <maciej.ciemborowicz@gmail.com> wrote:
> >
> > Since Git 2.31, the reference-transaction hook receives all-zero old an=
d
> > new object IDs when a branch or tag is deleted with a high-level comman=
d.
>
> [snip]
>
> > Was this loss of information intentional? If not, could the previous
> > object ID be restored for these deletion paths? If it is intentional,
> > the documentation may need to clarify that high-level deletion commands
> > can provide a zero-to-zero record.
>
> Since you seem to have identified a "good" and "bad" version with a
> reproduction script, I suspect "git bisect" is a good way to answer
> your questions about intent.
>
> --
> D. Ben Knoble
