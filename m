Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B118F179954
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487178; cv=none; b=RZiONAPtGVSMcjG+nLHnE+cDMqEjM8Ww4kKtc1ZkmNaREx4HVLptabgI4vMkZ3icdMPVU/OKZS+F/FLxxCltOOKAh1SE57rsv/TmHp4YyN8J3NjhxOx/bk/Ognh6eodPJBJ4nMLipmmOVufTL6ZPAPOQqQ0CCYZ4IpoFL9vBL30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487178; c=relaxed/simple;
	bh=Q+xTZaiHuXgr0TbJVJxS/9Zk4jElfOPnAVpM+sM3w2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSB/W16DvGpptdri4T5uAKHvttAfqiMEGl/RBxDl5rkosXzGaqn5wZxxG1hm/75nz3qnR4Pedi1jNXaCTbgASpTQs2fZ7HSU1RKlv8WYDw+6F+jsQeSduW6uDnKvRT4wfCaNVJT6Pc5vDhdcWibiSinhMourVjpMATilqjsZ4TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4bn3sLk; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4bn3sLk"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ac9b225a91so4568773a91.2
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 07:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714487176; x=1715091976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gz8Nd0jDELFRFWKvdW/2J2wniuOYFvRqq+ISiaJCw6E=;
        b=g4bn3sLkr5WqGo0/tLFsYM1oeqIm+WlU5f5dmMhcyBLhqx4ZtDOtDR1y7CIyWYpsLt
         zHvwo8QiHgZDUO0VihslkumAM2GjMaNOICDXki4YmmVC1oxwpWEtHwgq6vdmZzKRu/bK
         h+LOwNv/dHK2zl1pe0ciQSC6dOwH4LX+E+84sZo2uRLDq1vyGZV+FK05jb3aMCfMq8st
         C0QHQ6SxTTtHeXv+6nW/BE5+CiR1E7kB2K0O+sO7tGYBatJL03vlPCgwkqaHNv94FBp4
         0OLS6l7Ge0JyI8q+6SqucNeRq19gjcPh2sYkpzfWgjd3TFDBNY6xo4FfRjT+LMwQPpup
         9VnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714487176; x=1715091976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gz8Nd0jDELFRFWKvdW/2J2wniuOYFvRqq+ISiaJCw6E=;
        b=EH5pVjI15+ZDnbJ0fRFPPExSpbD2okYzvyUhb+7IvZCB0+7GiivGVNI9fbozDK1ouV
         ohu87iu4tCFagayYb6OkRDOLZ63CFLlwL8sYbhzzy7IYg5+ADnC46rxltzN9lMlzMOZ+
         +9HktyZoYkPhJyOkyzq8DVuirgBHnzvXNHPBQ1kAcIzRmu2vbwBPJPWP3J1lqg7s/QsM
         6vepejt3CvBy1BhTOXFpmVqDVX4RqxmlF0BQUGsAEdJXkMX51Is3lnn/qsrkGl3NMlp4
         fojYgduYmnV+tD/mvx7K4bmHhC4XCpSpFGf0uXp9DDNIWZzP9bMmeDzPg182ersimnx9
         G2VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgf5MmjoO+QcsHqGJ8i/nJu9vT2rmX99JwbZxb2SHzWNitSXwsaSEk4qqEgSkmiEpSjBHVJLoYOjL50khM0kEC4uVm
X-Gm-Message-State: AOJu0YzbtAUkKebWvwm0YUHuWE0Mu/FaCIpRpnTU8cyNM0JtoO6Jlz0n
	E5/Nppaf1NhKD3/i+HdMYWkCUQMs0secnavYKwe86PSI+DRDFqePqWHAB4lQzhf4w0sCVV4llkq
	Q4e7Dhqmns5g+jPEr67Zh/eYfhzBmGg33NtA=
X-Google-Smtp-Source: AGHT+IFp1cSaKrVsiE7vEWsSVITqBBH6BQ2uujuiTbvYX/Sqi1bxTb5TyegqDZE2lJ4Jihlmjy5d3S0UkdCdrtdCL7A=
X-Received: by 2002:a17:90b:46d7:b0:2b2:a6ba:818 with SMTP id
 jx23-20020a17090b46d700b002b2a6ba0818mr1456367pjb.31.1714487175763; Tue, 30
 Apr 2024 07:26:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANHPH1-6mbWdt_FLsrDEB_XVb4r3yTYMLLPUyDrL6tmS7jZgqQ@mail.gmail.com>
 <CAPig+cQ39Z+WjThqkxCKgOUfkZyB6PG-6RhHBYhinp-ZY4dxKA@mail.gmail.com> <xmqqedap2ijk.fsf_-_@gitster.g>
In-Reply-To: <xmqqedap2ijk.fsf_-_@gitster.g>
From: Toru Okugawa <castor.4bit@gmail.com>
Date: Tue, 30 Apr 2024 23:26:04 +0900
Message-ID: <CANHPH19FCWUAMZLFZEY+_+zv0KUkuVGNQS26WmEPjnPtjrK8KQ@mail.gmail.com>
Subject: Re: Re* Unexpected behavior with the rev-parse operation
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 8:07=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> > On Mon, Apr 15, 2024 at 9:58=E2=80=AFAM Toru Okugawa <castor.4bit@gmail=
.com> wrote:
> >> I have encountered some unexpected behavior with the rev-parse operati=
on.
> >> ---
> >> $ ls -a
> >> .  ..
> >> $ git rev-parse --is-inside-work-tree
> >> fatal: not a git repository (or any of the parent directories): .git
> >> ...
> > ... This
> > means it is your responsibility, as a script writer, to suppress or
> > capture the error message (whichever is appropriate for your case).
> > For instance:
> >
> >     if test git rev-parse >/dev/null 2>&1
> >     then
> >         echo "in a Git directory or repository"
> >     else
> >         echo "not in a Git directory or repository"
> >     fi
>
> All true.  It may however need some documentation updates, though,
> something along this line, perhaps?
>
>  Documentation/git-rev-parse.txt | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git c/Documentation/git-rev-parse.txt w/Documentation/git-rev-pars=
e.txt
> index f9d5a35fa0..a62d798744 100644
> --- c/Documentation/git-rev-parse.txt
> +++ w/Documentation/git-rev-parse.txt
> @@ -18,8 +18,16 @@ Many Git porcelainish commands take a mixture of flags
>  (i.e. parameters that begin with a dash '-') and parameters
>  meant for the underlying 'git rev-list' command they use internally
>  and flags and parameters for the other commands they use
> -downstream of 'git rev-list'.  This command is used to
> -distinguish between them.
> +downstream of 'git rev-list'.  One purpose of this command is to
> +allow calling programs to distinguish between them.
> +
> +There are a few other operation modes that have noting to do with
> +the above "help parse command line options" added to the command.
> +
> +Unless otherwise specified, most of the options and operation modes
> +require you to run this command inside a git repository or a working
> +tree that is under control of a git repository, and will give you a
> +fatal error otherwise.
>
>
>  OPTIONS
> @@ -32,11 +40,15 @@ Each of these options must appear first on the comman=
d line.
>
>  --parseopt::
>         Use 'git rev-parse' in option parsing mode (see PARSEOPT section =
below).
> +       The command in this mode can be used outside a repository or
> +       a working tree controlled by a repository.
>
>  --sq-quote::
>         Use 'git rev-parse' in shell quoting mode (see SQ-QUOTE
>         section below). In contrast to the `--sq` option below, this
>         mode only does quoting. Nothing else is done to command input.
> +       The command in this mode can be used outside a repository or
> +       a working tree controlled by a repository.
>
>  Options for --parseopt
>  ~~~~~~~~~~~~~~~~~~~~~~

Thank you for your responses.

I'm aware that `--is-inside-work-tree` is an option for `git
rev-parse`, and I understand that it is normal for the command to
generate an error when executed outside a Git repository. Indeed, I
have previously used the result of `git rev-parse >/dev/null 2>&1` to
determine whether the directory is inside a Git repository or not.

However, if determining the presence of a Git repository by checking
for errors is the appropriate approach, I'm interested in
understanding the intended use of the `--is-inside-work-tree` option.
I had thought it was meant to suppress errors in exceptional cases.
