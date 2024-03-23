Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB33FBF7
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 08:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711183139; cv=none; b=eydgGwl/FuTNmwezV/FnxYUuU0ZPW5NXy2q5tjK0a+16xAe0Xq8cHBPS8xT4b2h2FIzn7NOpY6YZem5Ofk6zTmmZIcZLl+4nzpQWiDckZ6Dze/xVX3z8AW319GZBp3k5eZfRbhFbPb64ntHQP3A2GZSFBagNAAeiXoA4UCO6j2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711183139; c=relaxed/simple;
	bh=HLeRQ//+/AoLePYN4sRhqoSz29k3dRVfhd9HjaG2u8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrZCuSQhJ2QXenyeQAzKOf8rD9JHEpkzN6c84JgOkbB0inlvXzJ5n7jXLuBWyGQXdUfGRT94WAr/sJPnMrsdfsf75rxA8/ipDxIHiQwJglFz8I9nRYJY5nytkfZ1cTS7QcBJFyydSXI0y1eLB1P+9X/hhWHfE0ER2OIapo4/fFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6962950c6bfso26502996d6.2
        for <git@vger.kernel.org>; Sat, 23 Mar 2024 01:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711183136; x=1711787936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quAMJFMukdmXJ1hIZ2ZW9bzwkonTENncQiMupm9GTCw=;
        b=LIcHw62Mv5VCCrKDxqLOIMYnpWHLZ5GsQsMLIPq9F7Dow1RVUr4n5v9BKhXD9QXX6w
         Cm05+S9f8o+hsWw5ljs/Gz2IlHM/WBRDArEw5ecKHyr3XQq/ui2JheR0P22s3riqB2f+
         3aANAjiqTKzG7S7mnBtfnVUTqwU+fbf0mH6T9R9mbUGF7bBL+XvPIRimbEaH3Qm1IsDX
         QuYvdB/ibDs3rPFthdfXSPzzsrfaHN4vO7jC0bvcS6O5kPPQQ1Q1n4xm1cCnV8nPgYVK
         4Eq9D4nYMq0W3galO+Mk3BNLCtX3Lk0CmqNMn92+BVmlzL/+c+FbZr+y3HHja5OEjtkv
         HC0Q==
X-Gm-Message-State: AOJu0YxKsmTPJHCNEWLsGhMSz3ZtbxM3AnnaYJwfTLIOSSKxydNLQg8H
	lTCsOmcD6h9X2k7aERY4ukQQibWA19iOKDIRTxmqliHB+FAE13/NIKQcI60QuMZHVu3zAZDbE2Z
	YrAFHmNW86wzOmQIBRuHwNJHU+QM=
X-Google-Smtp-Source: AGHT+IHVsV1NaarDdSSwMVy4JNXcxmclCbY58oepMf1Z+LD7O22kLR7SVfzBw+7jlHyu293+rtX4HHB2QE7S917l2Ys=
X-Received: by 2002:a05:6214:d6c:b0:696:7be0:de62 with SMTP id
 12-20020a0562140d6c00b006967be0de62mr811046qvs.48.1711183135867; Sat, 23 Mar
 2024 01:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322221327.12204-1-mg@max.gautier.name> <20240322221327.12204-3-mg@max.gautier.name>
In-Reply-To: <20240322221327.12204-3-mg@max.gautier.name>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 23 Mar 2024 04:38:44 -0400
Message-ID: <CAPig+cS1YL1iOZFh5=b1+_P=KBST=DYRqp7TaD7uMVLJQjs1bA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] maintenance: use packaged systemd units
To: Max Gautier <mg@max.gautier.name>
Cc: git@vger.kernel.org, =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>, 
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 4:21=E2=80=AFAM Max Gautier <mg@max.gautier.name> w=
rote:
> [...]
> Package the systemd user units (timer and service) with git in
> $(prefix)/lib/systemd/user (or $XDG_DATA_HOME for $HOME installation),
> and remove code for writing and deleting the units from builtin/gc.c.
> Determine the correct git path at install time by for the service unit.
>
> Detect systemd timers support (at install time) by relying on systemctl
> presence, since we use it as the control interface for the systemd
> scheduler.
>
> Signed-off-by: Max Gautier <mg@max.gautier.name>
> ---
> Notes:
>     I'm not completely sure if it's ok to do install time templating like
>     this, but I couldn't find a similar enough example in the Makefile. A=
ny
>     suggestion for a better way ?
>
> diff --git a/Makefile b/Makefile
> @@ -3469,6 +3469,11 @@ install: all
> +ifdef SYSTEMD_USER_UNIT_DIR
> +       $(INSTALL) -Dm 644 -t '$(DESTDIR_SQ)$(SYSTEMD_USER_UNIT_DIR)' sys=
temd/user/git-maintenance@.timer
> +       sed 's+@BINDIR@+$(bindir_SQ)+' systemd/user/git-maintenance@.serv=
ice.in | \
> +               $(INSTALL) -Dm 644 /dev/stdin '$(DESTDIR_SQ)$(SYSTEMD_USE=
R_UNIT_DIR)/git-maintenance@.service'
> +endif

This is the first use of /dev/stdin in the project and I might worry a
bit about portability. Granted, a system in which systemd is installed
is likely to have /dev/stdin available, but it's often a good idea to
be cautious when introducing something new into the project.

I would think it would be possible to instead generate the
`git-maintenance@.service` file locally from the template
`git-maintenance@.service.in` as part of the normal build process, and
then install the built `git-maintenance@.service` at "install" time.
That seems more in line with how other resources are handled, avoids
the novel use of /dev/stdin, and answers the question you ask above.

> diff --git a/config.mak.uname b/config.mak.uname
> @@ -68,6 +68,16 @@ ifeq ($(uname_S),Linux)
> +       ifeq ($(shell command -v systemctl >/dev/null ?&& echo y),y)

What is "?&&"?

> +               XDG_DATA_HOME ?=3D $(HOME)/.local/share
> +               # systemd user units of programm installed in the home di=
rectory
> +               # (meaning prefix =3D=3D $HOME) shall go in XDG_DATA_HOME
> +               # (from man 5 systemd.unit)

s/programm/program/
