Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E390520C486
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317997; cv=none; b=bwQgq+brVczC42gR1nheCHNCEC0mqfItRAqi3cMNa3uTW0xhGH3GDicP01oHqi8VfhOiYkBcLK2aA+GOsk76hXnkv2Kx+TlgmQdprPRmMui63RnQ1VwVqsv2j5jAprz64e+pHLIML35YNXVIiz6uYZ/XPp8lLJOEjRvIcuup6mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317997; c=relaxed/simple;
	bh=K/OFcn98L2zTc1cb+dBbMImrnO4pcuyg6tqKVjTrDzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPzDH836U8Wfcjp8/P3lmafVA0PzPODKWxm5az58OAe3puPgaBcGqkAsCXIDV0BRZ7eOGA0KWy8E4r8MqDi6m+k7xO6Qu8eqw+TmoGOCpPa49d4xs++ulj2xG2xh82pJOYKNASW2M2+NrC5ItZ17fktoC5CmGjAwX43pNV8pNKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMYQxZeE; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMYQxZeE"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d5704f0721so16690525ab.0
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 10:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742317995; x=1742922795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UR1VFPolnfRK3ZlVDa1xtNlYBwS3EyszHQnZVAy3xhU=;
        b=MMYQxZeEMFLh/8NPnJgUYPumS7vlwOS88EdGsw9sbKK0gRza1xMeFgVhN3bZebmm6b
         rmrQcuk6ECxq7lWsixq9/DVcWqFs2YyLdMGEjEGVZRLT5nW7A7NVnfrmhaDCKkCOWmlR
         u7dc4CJ2jUEkHNCjLB9Nc2dgPlpTHZNsr9+iV0ZueRu+rik+jRGBR0c2YkwAtvjLlgQu
         s26ncYM2vSB3tyJrskE5DYEChVIpQqF+XrWZFrfOsIEN+WGSkJD9N9+nD1a3OkKuYpec
         Wwl4VaXZvkCPoVp9bT/RUU3sJjG54s8LVOtNP93iBZUMutx2IuJ3ADMCPXA1mbk6AbBJ
         LdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742317995; x=1742922795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UR1VFPolnfRK3ZlVDa1xtNlYBwS3EyszHQnZVAy3xhU=;
        b=mThvuZDgh3oY/Wq1YcpOqktLSMW7gKSOnJDqj+6qlzVOr0FJmRGlg5zcGlMFgiCtbD
         qNUzhaBz4qDLZoyeVcssAFEAp+ai9EuF73+dUUeKm/6kWTk/8TAli7M6CcHHpJ6rGbi9
         TShBHieZGr8fmvFeMENuOOKWORYv5EJvfxZh+BwDsHR1mlwJATjshEco7Ko349GJ3vW6
         MqZgJbfspsk8rTFGlXoDc44at1qxqwxvrSIhzONVPebhbS6NhIkYOIky/2oEES0Nar0B
         Zeh8RD9p7mY7zPJgCikA5GiWvCywhAqlczlE8Tky1ypJQ74YR8EZDzVfjhS7AgDsUiiM
         ZZIA==
X-Gm-Message-State: AOJu0YwZgNMJKP6kczKKNFLt8d4cSZgibY0O0SpA0wCsmEKA2EsOV+bU
	MfnMiywL8MPYP7i1dN8Csamu+Q16jgnW8UFC/zjvHUzi3/fjqDg+oI+UbFQwqnXjdRu7a/ubmFV
	w+r+ABY8uCKb3tfjnU7GgGONyKj8=
X-Gm-Gg: ASbGncvJ/tI/iv9OtUaSiLVnWgp7NqEegD1y2kNEj6XLH6Rbil49ege2G04nNRAI0KH
	XjccmYBiwQs4vER2YHvW4HaQdl7wa8N9cOT0eVKq3poL6RTkrkPuxJFKlIjFqZUABkOuwPfB/Ml
	QPhKIi1rXs3H/W/WbD/mm4gGGmhbXO3Z4T9M4kZbcgBKffhL1T0wPoso76
X-Google-Smtp-Source: AGHT+IHanGY1Lve+b+XJ3bAtYpZyri+tiAPediiPIRoySll1fktGdxTzj9r6Iu7d4CXyBPmjbK2ad8f7pgUKcRARIMw=
X-Received: by 2002:a92:c263:0:b0:3d3:d28e:eae9 with SMTP id
 e9e14a558f8ab-3d483a09d10mr193474445ab.7.1742317994802; Tue, 18 Mar 2025
 10:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723755667.git.me@ttaylorr.com> <cover.1741983492.git.me@ttaylorr.com>
 <d0d564685bc66df71b4c3ed1093452e58e0f54fd.1741983492.git.me@ttaylorr.com>
In-Reply-To: <d0d564685bc66df71b4c3ed1093452e58e0f54fd.1741983492.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 18 Mar 2025 10:13:03 -0700
X-Gm-Features: AQ5f1JpzcsRAArIekVUdmpPR3jUt8BEwpy1MYg2Eip1ybbauZU1jhx9ALQ8ah9Q
Message-ID: <CABPp-BF4msjkhV=aQYt8GrK8ptKaciE28OqQx0y64xrjWKrPMA@mail.gmail.com>
Subject: Re: [PATCH v4 13/13] midx: implement writing incremental MIDX bitmaps
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 1:19=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:

[...]
> diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
> index e92341b8fa..056c410efb 100644
> --- a/ewah/ewah_bitmap.c
> +++ b/ewah/ewah_bitmap.c
> @@ -399,7 +399,7 @@ int ewah_or_iterator_next(eword_t *next, struct ewah_=
or_iterator *it)
>         return ret;
>  }
>
> -void ewah_or_iterator_free(struct ewah_or_iterator *it)
> +void ewah_or_iterator_release(struct ewah_or_iterator *it)
>  {
>         free(it->its);
>  }
> diff --git a/ewah/ewok.h b/ewah/ewok.h
> index 4b70641045..c29d354236 100644
> --- a/ewah/ewok.h
> +++ b/ewah/ewok.h
> @@ -158,7 +158,7 @@ void ewah_or_iterator_init(struct ewah_or_iterator *i=
t,
>
>  int ewah_or_iterator_next(eword_t *next, struct ewah_or_iterator *it);
>
> -void ewah_or_iterator_free(struct ewah_or_iterator *it);
> +void ewah_or_iterator_release(struct ewah_or_iterator *it);

Was the rename from these last two hunks squashed into the wrong
patch?  Since you're not changing its definition, I'm assuming the
updated name should have been applied to when it was introduced.
