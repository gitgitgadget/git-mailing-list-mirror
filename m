Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E46359A66
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776759506; cv=pass; b=lQOyiehcFtHbkePrMuy3si1hH65QPN35jlUfMxQEZPESh1NE5hakh7jjCMul0W6DSGQI/SnmjzI4KzEsqHud6Opw8IgbvOdpSEdsFGCA2/MhBIuCba56b4hEcw4DghGLJ31D5sLMVqyrt3xBIB14PIBWmWFxp0Y/EprcwAma1Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776759506; c=relaxed/simple;
	bh=ec4fj9V6JpV3LUvsbfmTzr36suRHt72HCqmA5Xb1fEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+eijISJdbWHGPlL7wSw+M4F0rK/L4FOPYSjW5bwtfuuUzGICjOuE23uLCMqTpDLxMuom5l+RElL/3X722ZaF0/HAv6toLsNvPAcafqRQCWSnl6rAygVFr/m74M0+6oAlkeVMRvovCKhDhk7ClWaoPqzrcuv2R8q0QPDEe2wUok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nf7LEZfL; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nf7LEZfL"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c1a170a50so4700426c88.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 01:18:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776759504; cv=none;
        d=google.com; s=arc-20240605;
        b=O0hV1N3Weirar8cjxjg3Pp2cWesBTn5NXqOn7qEJZhybTFmPYkpyXiftQd7txXrhQv
         4IlmanYtExcuZKuiOr2ZS8oesbQaWNzTWwx9gead76Oc/XPm4hbSz4mj/wx87tml3PMy
         ln1o41eqy7lK6ZhN4PCrl6aDviIBfGHXYU8VqhZsO1tGeMWl1HgGejZkXiBXNWR7fyKS
         iKI3SxyNQXnju4/ENWxRUPTlEX17ICYx3hlyA+jKKL76F7QGdMlBXCEliTQnhVA+Ejep
         5zMfKDfCESkwgs3ER5B6WYmMfBdV+GfITW1yn5IffqC35Md+uP1m2oFd5pIBbUsvMhBE
         XDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P/dbFsb0OY4BRCiNAqRnfrrQfez6fdlbHWYVKnQ80W8=;
        fh=fqFFP0GpI26PwP9xR+SsqeqwjlXYODB5uusbAzWKy8k=;
        b=cOuIJE/hxK3JQtpoKVWedjJ8CSv77ZYc0VV/68ojyMlay/07OO5PP3VI8/t/WasOqe
         LXO+GR6CILEbkll/mL/DDawlgCIPrDqW0l/4w8z8FVqMbumQ0oztmgFOUUVVC+nFGNBg
         Z83JkKI0ebIG5J/OnqxQdnRWui/Y+J46HLVkMuAoXZO/7V0Oo2Y2CvkuGJt4gRgReevI
         zHkMSBgPQ6W7V9Ft4jpKcEyWxzdtmiD6V3IXmkZmPrgVtcIHWRwUhZ5GYE1fTia0Q/fE
         WNZyiQW9hlJbckAOEc8zK6zxDjCelwyx3mUDe4VXeSXmk2nKwnYKD3oKLwMzzJXCYiaA
         7e3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776759504; x=1777364304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/dbFsb0OY4BRCiNAqRnfrrQfez6fdlbHWYVKnQ80W8=;
        b=Nf7LEZfLEctN8iTPxD+jxXKvvdVTdRWJ/xjYryloc0S3T60qySTATOjpNoE6cIyWi4
         KGdEMF5qiTDHQHjh+5SjO6EaPetKzDR3gsEK5HCf3Nc85u8WC0mnOjFRTt8KHWgPxZFG
         OSC8jQgwOTECD+/69mTjA7Loqvi+eQ8xR3G698I1RHa70aDe04CpByufKd2Mkh7n8qbu
         Y0OC3lmV2qeFr1cXS2oWjUVDXgM2LQdBy0JrHi2MPcuj/SlocAmOeOEiyMBo2X1Z1uj+
         ue+dK5Ooo3RXrXV/C6pEqoukuTa80KIzOvN95ItDvpl/C3GFkdoyvCTmatQmbBvLfuzJ
         FVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776759504; x=1777364304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P/dbFsb0OY4BRCiNAqRnfrrQfez6fdlbHWYVKnQ80W8=;
        b=esQlbokVVp4/tbgimhIwMd8s6N6SiWJSbd80pq/Td//WFzbUgZ3AKsZkCQ+GMJPXv6
         N9cEXf5ZyDO/Tu5FpBLDM1cZPlChcAEHoyQBohUDxKXssXVw8oCmBkj25OHB0N6SYmOm
         jhPzyz9ucdXmAQcU1q3NzFC6yh246RgfVzgbM/4nZvLYtKjOY6yw/7a+fgckvTPp3xr4
         qAg4b/4pW44CcZMTiCGZU+Vx6PyQn/GqO9Ayl32aaDwNR2ovH/FBpbhZn6C8DlJYoidA
         wCnMyLlVsTCN/FwEsMpDNJRPNOVhwRf8ii4IZG1OJ/GOFY8iSLTgaXF4LgqmpCTIUz3f
         YBhw==
X-Gm-Message-State: AOJu0YwbdERNKlLam+OBrGL9O2m0RLWusxpkWJ/IzbEJf3LD8eGH1lee
	lAPEJNJzMRlBhuzs+ONfU9aCnzY0L+9bsmkzGTB2O8+FgX30DUCjqltrT5dI7wwjfa4lr0NqjmN
	FH4V0l1EZ7HkoER9cIy2ql3iQumJqHs1xVhbF
X-Gm-Gg: AeBDievpAax/XXW+pYtAOtIWmvs72lswQUwxI1mM/dDisehkgpqAwmf9NYMClwcJL6L
	00QzmxizgQeOZqEpa1ZEphNOVgmJfmSHpZigRwxdv2KdvnshN16jx1S3sHCuxSg1dKdzeLABdmd
	lYU2wtzXDgS3kfsOE4mCg7p4KADXWI9od0S3W23Cuv3kUAinWzJULDdAAIwzOqxDVoJ72oYFbX+
	/5HixE8wdBeNZzVs3ZED/U+voctLm46uLOhKVvz2yahU5tupg6na/QtrucL0SYuNRAfbcLmU3gg
	e/1UWRz5A/FYylgPCkC/3/pEyNH+/HTqiKoyd5ZRhGkaWbIyR1bdztfU3/qYCSnjWUyS8E8Q9EP
	i1FQ=
X-Received: by 2002:a05:7022:3d87:b0:12a:85ef:1e50 with SMTP id
 a92af1059eb24-12c73f6c614mr9125382c88.12.1776759504188; Tue, 21 Apr 2026
 01:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420-refs-fsck-skip-lock-files-v1-1-c2595e206a76@gmail.com>
In-Reply-To: <20260420-refs-fsck-skip-lock-files-v1-1-c2595e206a76@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 21 Apr 2026 10:18:12 +0200
X-Gm-Features: AQROBzD1LECzp8Y8cQ5sBj7xPRsFXfgELKVRsJhj6noFvVnFzSTIt5T0JZ8nzaE
Message-ID: <CAP8UFD2vO415UfEUw34_Whh3bTG0ECV99APH=uaDyiGLiNq1yw@mail.gmail.com>
Subject: Re: [PATCH] refs/files: skip lock files during consistency checks
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 5:21=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:

> @@ -3962,6 +3953,15 @@ static int files_fsck_refs_dir(struct ref_store *r=
ef_store,
>                         strbuf_addf(&refname, "worktrees/%s/", wt->id);
>                 strbuf_addf(&refname, "refs/%s", iter->relative_path);
>
> +               filename =3D basename((char *) iter->path.buf);
> +
> +               /*
> +                * Ignore the files ending with ".lock" as they may be lo=
ck files
> +                * However, do not allow bare ".lock" files.
> +                */
> +               if (filename[0] !=3D '.' && ends_with(filename, ".lock"))
> +                       continue;
> +
>                 if (files_fsck_ref(ref_store, o, refname.buf,
>                                    iter->path.buf, iter->st.st_mode) < 0)
>                         ret =3D -1;

This just moves code and associated comments, so the following are
probably pre-existing issues, but still it seems to me that:

- "do not allow" is not quite what is actually done. There is no ret =3D
-1 set for example, so if files_fsck_ref() succeeds with the ".lock"
file it could be allowed, or I am missing something?

- a filename like ".stuff.lock" would be treated in the same way as
".lock". I wonder if it's what we want.

Maybe ".lock" or ".stuff.lock" would fail a check_refname_format()
somewhere, if they are not ignored, but it's still a bit confusing.

It seems to me that either:

1) we want to ignore all files that end with ".lock" as they might be
used by some tool as lockfiles, and then:

               if (ends_with(iter->path.buf, ".lock"))
                       continue;

is enough, or

2) we want to check that all files matching "XXXX.lock" correspond to
a valid XXXX ref, and then we should not completely ignore them, just
ignore their content but check the XXXX part.

For a bug fix, I think implementing 1) is enough. We could implement
2) if we think it's worth it in a separate improvement (with perhaps
a new "staleLockFile" fsck message).

Thanks.
