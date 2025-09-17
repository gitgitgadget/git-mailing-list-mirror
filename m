Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4673A2F25EA
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 07:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095115; cv=none; b=afnmtenjZELBcnrntaObCepBFLS64Nna7+cN6NsSo/ucsnlkYtk0V93NkQ3QF7rD8k74ZdkUNU7NovrjCHwBJN5CRF86Ylllv/HK23/zEKN677Nu9PaING7vHT+mzE8oazZaaNDmVmXYkV90qSdUbFb/zA/7/2QzzCPH04usx5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095115; c=relaxed/simple;
	bh=hu7IlUbDBwMCJcsZxNprFkfMKF5caGA1WVD9tukfTtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KnjGGhOOx0VHwRTPWlNi0skhg9hIh2pi8gFGtdOddeM/jAH5kEvVhWyMY/lUCmHxWcR+T0uJW/c6E/BKsBaYGL0TGKYwyl+gqAmicLkcqZ7Ci+VV/E46S+JQvy1ti9aN42NaDJV2nSQdO0yjhhksJnIQ80JBWP9hqaxZtzF3x10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b494e774bfso14565781cf.3
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 00:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758095111; x=1758699911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpZAvGwCmyP+i1euHNsk2XGBK5vNHuXLObYQiK4VVh0=;
        b=BLNPO4keNxJHT8xr4R6qadppTEgaHQfnA4Z+NT2zplNgJmimGVD0y4tBSEbuSCAP9P
         mKzIoeaCEx42nUVZ4Ea4Sps//V1lqeO0Y1pEkByDhQzLi8+C0V1q7PB1VffRE+ddxe/E
         1zgdNx42sqlyETEBhSCVUHqxxzhS+hnb7tc0L4u3kaQd6VvUpQSxCSj7RQijv9nPd1Hj
         3tc0VvyEHdM4G1CLKcKgnJriPOYSjYFWtJ+KaV1GX1bztD4OekOWlvkdmlop3GUDlo/3
         VCXy1tgk4XIHgAMtALVeepUPgoLEtIsNBp7U6fsRzHH8DgK7Iaz3ZgqrPNQDS71nUGLA
         LvFA==
X-Gm-Message-State: AOJu0Yw7R944DU0Qw2xQevf0N5Yfp37S4MoO5H4T2Ygs+pe5xov3wgY8
	VjG864Fn+4heW1KW9JxviXlTnXcHuAhMoKmbRZJmMNrkSwO7u8nPYVpreOeWbDhDLHDZKidxL4I
	fNw192CEJOe+asAJT+8SOf8G4TE74CI4=
X-Gm-Gg: ASbGncuuDRv2n8Uk/h9uQU4TJwPYxMxB2lxsJSlpNUQ+AI/NT9qQfB+md4qTSdUtc6V
	tLfFWMn9eH5zXIL+FxvnyFWrCWdwVHIMZ58UHwWMFiB9qebDoPea6aDuRmuzUOdfwHdfewpGxq3
	Ag5/O38/GBaJ6jywC+ItpCHnqSgFvSF4PGqltJA07T4rGMCufip3OgrhBuy1tSHIVnxFsyrQTMx
	f7lG8zDa5YQqLZLSS1icDSdn7rObAOGH89M6GMK
X-Google-Smtp-Source: AGHT+IHlXDMxAQlOGNJt6T8sVXM7cd2MA3m3UIa1sTLI4hu4CBHKk5w/9Blfr5k9vD49yKIdR7wfE/tHMLJCaaDBeso=
X-Received: by 2002:ad4:5e87:0:b0:722:2165:116f with SMTP id
 6a1803df08f44-78ecf8eb86fmr5872236d6.8.1758095110877; Wed, 17 Sep 2025
 00:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <7082e32c5975d2aaa277eddae7497eba0f2131e0.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <7082e32c5975d2aaa277eddae7497eba0f2131e0.1758071798.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 17 Sep 2025 03:44:59 -0400
X-Gm-Features: AS18NWC3m-6XBoH1L5aoYTnXeaja9lNYfalCE5t_9WCA31h-T4qAE67hjN3ZnpI
Message-ID: <CAPig+cRGtMX9bQhb+7g5aXRVjpLKY-qDdQP95f9TmbY8j_BweQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] make: add -fPIE flag
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:17=E2=80=AFPM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> make: add -fPIE flag
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
> diff --git a/Makefile b/Makefile
> @@ -1402,7 +1402,7 @@ endif
>  CC_LD_DYNPATH =3D -Wl,-rpath,
> -BASIC_CFLAGS =3D -I.
> +BASIC_CFLAGS =3D -I. -fPIE
>  BASIC_LDFLAGS =3D

The commit message explains what the patch is doing (which is obvious
from the patch itself) but doesn't explain why this change is needed,
hence it is very difficult for a reviewer to understand why such a
change is necessary.
