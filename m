Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA412942B
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVPWlP1L"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55783b7b47aso2414313a12.0
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 01:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704792738; x=1705397538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGTs/f2iD2nIHlAyEpm12RgrJZ9bAD9eBm1TZj++ykM=;
        b=eVPWlP1LNG1oxqwZtIBlEOcU5PruXBRi4Y8v/CQ8TOv3QDpZVIggj6CIj67JXbkaUm
         uoKSs66Xdc+ngxe+IrKMHJKUf8cYLrDYlSc8iVDvgVcnf46SYkVUJDqWn2O1BNR/WAhx
         87iaSp/HsLdl8Oo6G3r3Ka2adgi/IAJuDRXgGS45mlVZJv2OGVG6PFOc+XRbV6r7kaXW
         t129NPxWteRmeK3FTKlPFnkaG1xaR9e+ZgyeGElEsoOqr2HfkQtyi9zt6zMn9Z7KrJRg
         IdKTqohcBARrWzLjWhY8/pIW8kRNyE08vNB/QPSodmrP9rowXx51dnvVf54dZcVJ9owR
         CQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704792738; x=1705397538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGTs/f2iD2nIHlAyEpm12RgrJZ9bAD9eBm1TZj++ykM=;
        b=ZxlulTno9ycDqqe9RSrsNIwJBR/+wamrXouGoZI8acTnByUYGbAP9JKd2CMCMzHxZv
         pcI9Yewwv4OgsiXScpg0vpU332uY132ez7tqmzBfPuX5eWrw459HujS+B7R6hNCXjzX7
         BsXGDBwF/4i0K+oizXA6WpCjnIPSOdrXK/PSHKX/aI7gBSDgyPg+p7YddX9sQweI1qnT
         ERFIi9uZMcVkHTZeyHKVH7GybQfQbav9WWmFLWio+c4sD+R2Q+43h1tRFOnqjPbpxtY7
         uh9gl9ZWzdoVyFHbZjihX20mYc2oFO6fcQ04t1BzL+xAU7/AU9+00rSXlkvQ1g1SO34W
         WdZA==
X-Gm-Message-State: AOJu0Yxb1gVKh7QWM/Al7xFcoZ9IHEQsAqP9H4HnAVoL2yltXTKA0Qwy
	Z7j/a94EffbDIRh3lvHCaz9P+chyX0zQKjD5hAWgA0V0awM=
X-Google-Smtp-Source: AGHT+IGLVjJwDzaG84vv40nKikxGSPObvO0FcRhUxK0IKzRmeh1VOSBvPVytY9rjBUn1LwH6P1cXUazADlnGfeDRC6Q=
X-Received: by 2002:a17:906:3f8b:b0:a2b:1e5a:f367 with SMTP id
 b11-20020a1709063f8b00b00a2b1e5af367mr276161ejj.79.1704792738555; Tue, 09 Jan
 2024 01:32:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109060417.1144647-2-shyamthakkar001@gmail.com>
In-Reply-To: <20240109060417.1144647-2-shyamthakkar001@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 9 Jan 2024 10:32:06 +0100
Message-ID: <CAP8UFD2W3JCXQCRV9ekzMbcPHW+LmWBxm_WOKkEZDD=Tnjj_mg@mail.gmail.com>
Subject: Re: [PATCH 0/2][GSOC] t7501: Add tests for various index usages, -i
 and -o, of commit command and amending commit to add signoff.
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 7:10=E2=80=AFAM Ghanshyam Thakkar
<shyamthakkar001@gmail.com> wrote:
>
> This patch series adds tests for various index usages, -i and -o, of comm=
it
> command and amending commit to add Signed-of-by trailer. This is in
> reference to the comment added in commit 12ace0b2 which reads:
>
>   # FIXME: Test the various index usages, -i and -o, test reflog,
>   # signoff, hooks

It seems to me that the patch series should remove or change that
FIXME if it resolves it, or some parts of it.

For example I would expect the patch that adds -i and -o related tests
to remove at least "-i and -o, " from that FIXME comment.

> Ghanshyam Thakkar (2):
>   t7501: Add tests for various index usages, -i and -o, of commit
>     command.
>   t7501: Add test for amending commit to add signoff.

I commented on the first patch, and I took a look at the second one.
It seems to me that a number of comments I made on the first one are
valid for the second one as well. For a micro-project I would suggest
focussing on only one patch though. As we say in
https://git.github.io/General-Microproject-Information/, we want
quality, not quantity! You can always work on other possible bigger
things after your micro-project is merged.

Thanks!
