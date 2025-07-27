Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640629463
	for <git@vger.kernel.org>; Sun, 27 Jul 2025 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753647645; cv=none; b=BUHS8YWmlV/AF/jNmtxbB7B3Utt9ux4b1psPXAha0x6bNDJjXjiFJBRONwWDIJ/F09FpLiHdrgUpHG6KHOn1Xufcsk9BeMDxDsa2IdUCMiJdAgIa8OQWRLdSQhS7jbgI6mM4/jMlVrm1JgfW02ZslUHOtrfSjR7fHET4CurZkbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753647645; c=relaxed/simple;
	bh=lSJDWBnUjrupPlj/j+9vvigc8nst0tayBVmIv2IQnic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GziKsg/Wjt6g7Mwp23KWur4kVA9BLo6ZUZAk/xj6EktD66C7gfoRyNcc4Ejk9M5AFEDZNggnrrikIvwRnijTI0wk/Qi0Qw4ymLYQ3Q36FXoPhN5KX2PU/kURT9BAyEL/qS+7AuZFLSHwpMOwst5RU8WrkSfQ2Cx3zUJsnKqsDFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-7073a1933adso1176266d6.0
        for <git@vger.kernel.org>; Sun, 27 Jul 2025 13:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753647642; x=1754252442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWnasflBaPqgJ7GzrocfoVCVDi7kwnkuD3vuappNE7I=;
        b=esAJQf0gKWRweuaaisssq189qqhihRqdscDTNrs6iyjsSxufyoVFMTm50zr1P0tAlC
         nSIC6ibmaZ2ySwnO++4V+usNHZrPqc1rXWdQhdRYUkmQPsnu43tq++zLT8doyaxU/7Ba
         OLMxKvGl9c97iNzcaVLdMlyZoKHGdvh6++LXIog+meupXKZ0FOJeSNtJsWjFrdqY8YY1
         EkTdojPLHTwerE76FoiM1jRcdzUovZ/q587UFl7wA3qrS4lFoXUn1acBfsaIf3A+5QoV
         BUPbPgvt3UXkVfIUG9BdKI7QXaBHWesq2e57WW1YslhA2B7WpbSNhljhPn487z56RjrF
         ovUw==
X-Gm-Message-State: AOJu0YzXwCoerA1S2mBiFfVElEjcOTVTxIleHK5P+1hb6mebonPiqE2W
	5go+MipSMNfvvmJQN71OuocL0GHp35ikXHw08EioRCKSjl0mcYsrs7Rn5Hnu/pVXRsGLLjOoqdp
	0e+5vT6ppe1yryK8Q+w3n8G+kuKz8OPs=
X-Gm-Gg: ASbGncvysz99/3F5F/A/8wFfPme23bDI8lJuaV5ivAgyeeSXs4Do/oHO8q4tmf1Z+KQ
	DcydS0MiSYW9l2robVAnFfELld1OLLtNZsr0uMzZqu6X49+IF7iGXABN0wNqyc9/ZWGZGXuYzHW
	TjPG1H98d/lGtqeqpDO1AJRRd2nfHV0Dk5FiSNdgFaY1hAMRBUzCOh6QxYmRpF8YY5K2BDKNsco
	fmEBJB+cGoHuxYx+QURrTF/ceKpH0+DkyECYN+d
X-Google-Smtp-Source: AGHT+IG6Bi5mxzADqSQqhy+Vz3ZYGS3mjC9+neFaf1X3MXDCjsCXiGvhMu0qYjlN3F53DIs9UtCsG14JssS5mP/vMr4=
X-Received: by 2002:a05:6214:4a51:b0:707:4020:8631 with SMTP id
 6a1803df08f44-7074020c508mr12802766d6.5.1753647642212; Sun, 27 Jul 2025
 13:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250727175110.84770-1-lucasseikioshiro@gmail.com> <20250727175110.84770-2-lucasseikioshiro@gmail.com>
In-Reply-To: <20250727175110.84770-2-lucasseikioshiro@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 27 Jul 2025 16:20:31 -0400
X-Gm-Features: Ac12FXyKr84RqsNm27Re54ON1iE6JHiHoFfSXfVePivlIiz-dqruABt4tjXSgDc
Message-ID: <CAPig+cRwv1xOoiXRBo0tECXPKV=BrHo_aHcD6Wy+mOUv4OvuJA@mail.gmail.com>
Subject: Re: [GSoC PATCH v5 1/5] repo: declare the repo command
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, ps@pks.im, 
	karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com, 
	phillip.wood@dunelm.org.uk, jltobler@gmail.com, jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 1:51=E2=80=AFPM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
> Currently, `git rev-parse` covers a wide range of functionality not
> directly related to parsing revisions, as its name suggests. Over time,
> many features like parsing datestrings, options, paths, and others
> were added to it because there wasn't a more appropriate command
> to place them.
>
> Create a new Git command called `repo`. `git repo` will be the main
> command for obtaining the information about a repository (such as
> metadata and metrics).
>
> Also declare a subcommand for `repo` called `info`. `git repo info`
> will bring the functionality of retrieving repository-related
> information currently returned by `rev-parse`.
>
> Add the required tests, documentation and build changes to enable
> usage of this subcommand.

This talks about adding tests, however...

> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  .gitignore                  |  1 +
>  Documentation/git-repo.adoc | 38 +++++++++++++++++++++++++++++++++++++
>  Documentation/meson.build   |  1 +
>  Makefile                    |  1 +
>  builtin.h                   |  1 +
>  builtin/repo.c              | 26 +++++++++++++++++++++++++
>  command-list.txt            |  1 +
>  git.c                       |  1 +
>  meson.build                 |  1 +
>  9 files changed, 71 insertions(+)

...no tests are added.

> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> @@ -0,0 +1,38 @@
> +DESCRIPTION
> +-----------
> +This command retrieve repository level information.

s/retrieve/retrieves/

I'm a native English speaker, but I wonder if, rather than "repository
level", it would be more friendly to non-native speakers to instead
say:

    Retrieve information about the repository.
