Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8602D1F6B
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758099103; cv=none; b=E3aLsVNvXA9noZakiW3pz5v3Ji5amJ8O4gsYnPL3CUN3u6orjsoJGjgEJck8oivLwziYnxaDNSxe9vUT0+WKDPpGK8D5n8TRMvSuiKFsAb4/hTp0BP1x6h6BkyYxRlC1pf71uszmqO+7giSeqJal+omqNaqPbTflOuYn5C6cYYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758099103; c=relaxed/simple;
	bh=x9K4AR/b8UE+zuoOk+f22fvPIqzc88n+h4uEdzgwgrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngagEg4wlGuU7sBJ/kjmYSEeMB4D8ZaC5ufQRgzm5EeK/8kCw0hGyQ2h+/6KfrTekqFP33mc1SqM+5j8y7CehX6BpwKd8YF4se39kAD0tQhTmxIlGCCmivmx7NeXUkutpZLEO69zXxSeaH3hjQY8APshCqu4bL7aLV6gbz8JKM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b78f4aa547so11637071cf.3
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758099100; x=1758703900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaHHufFDlm0LCThFTU8LLf7magUbENCnILPQnwTMRMM=;
        b=QeoRZQlxasdXs7iYUDxCNHsJEyQmsgVU91WfQl3hSgR4JmeJPW0ru6OtN9GmzEwiPZ
         7uSrlLWh/sL1j2KOji+RD1tR+ObtB9TRrr7uIuj+zj/dTF9jiCtEkSZtRc9O5+T1SuXQ
         m503VEJHzAN2qHYjY55TYVnDMF/R2LdgArpqSUmlZoIZUo9eU/fS/aB+kXULl2XKQok3
         nnd44EYlInB6sImcnOBKIosrWYkN6m4+JoEXHGQnxturdalyixw6PgxJoKli0lOzwzOM
         ZCd/3aCgXN+XohzbXphAdscsRv/2N1AvjK6/mVxGqogEPK2YyYWgmAk63/aavNtY37Jq
         jwCg==
X-Gm-Message-State: AOJu0Yw0MrUFhyGV6uprAym9H1whInhA5CUJwsDnV10zdN1BEh14H3Lt
	AretpWKjsOV54rX0HXz1pePCAkAe6FmTNl+vGLyObD9GT29uJIjVJGmUnNzC8Uuy2j0sFen+5yS
	9GXOEbdkcv8psd8/Z3mwMCnhwWU35zh5FUpYm
X-Gm-Gg: ASbGncvCXJu6f5Lr0zI+gOIHMIPGYoYPaZvCJd7LYLC09zRj0gwGCmoY8PttSr6Eruj
	agb252Rq0RjMfAh8w+5fRHPHEPXuRPWqrX2LsSmeb0cc+4puDJcgjHRkYZc2ckuKo/gfhtxYFQf
	ZjV7rVjYjzMeigOqri8kKzbPztNrfcOjRbP/Pv53F0hTqjPh3LGZw0fhvw5cn9ZdM6DcIuuu/eI
	9X+lzJIpWRInt8z5RVMx5QoHMlbzfhC2Gc2YgCB
X-Google-Smtp-Source: AGHT+IHtqjeiYKIJwkGfPsKDiYl6cmo/tQUbUchXpkoMhuvDeM/W8X7ZBH6m9O3o9fHK0jtVjtCneeGga1ZC6yAHpVQ=
X-Received: by 2002:ac8:5f50:0:b0:4ab:63f8:ef30 with SMTP id
 d75a77b69052e-4ba66d15859mr11701341cf.3.1758099100148; Wed, 17 Sep 2025
 01:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <6a27e07e6310b6cad0e3feae817269b9b8eaed69.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <6a27e07e6310b6cad0e3feae817269b9b8eaed69.1758071798.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 17 Sep 2025 04:51:28 -0400
X-Gm-Features: AS18NWD4qK-fZrJ5P6IAr1YwbpoVkm_NtdSZ-o9ofHDRLS7DP2US5FQ4MPAFeTk
Message-ID: <CAPig+cTZch_pvfurtjBTNphMeRQL6jSBSjNY-4mffjoXZ4eqcw@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] build-helper: link against libgit.a and any
 other required C libraries
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:18=E2=80=AFPM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> build-helper: link against libgit.a and any other required C libraries
>
> Don't link against the C libraries when building with Make or Meson.
> Run cargo tests like this:
> cd rust && cargo clean && USE_LINKING=3Dtrue cargo test
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---

Perhaps it's because I haven't been following the discussion closely
enough, but the above commit message leaves me entirely in the dark.
After reading and rereading it several times, I suppose it is trying
to address some difference between building with `cargo` vs. building
with Make or Meson, but it gives no explanation of what the
differences are or what problem it is trying to solve. So, please
enhance the commit message to begin with the "why" and then proceed to
the "what" or "how".

> diff --git a/rust/build-helper/Cargo.toml b/rust/build-helper/Cargo.toml
> @@ -4,4 +4,3 @@ version =3D "0.1.0"
>  edition =3D "2021"
>
>  [dependencies]
> -

This seems merely to be deleting a blank line which probably shouldn't
have been present in the first place. Rather than fixing the "problem"
here, it would make more sense to eliminate the blank line in the
patch which introduced it in the first place.

> diff --git a/rust/build-helper/src/lib.rs b/rust/build-helper/src/lib.rs
> @@ -0,0 +1,84 @@
> +use std::collections::HashMap;
> +use std::path::PathBuf;
> +
> +

If I'm not mistaken, it is uncommon to have two blank lines like this
in Rust code.

> +fn parse_bool_from_str(value: &str) -> bool {
> +    match value {
> +        "1" | "true"  | "yes" | "on"  =3D> true,
> +        "0" | "false" | "no"  | "off" =3D> false,
> +        _ =3D> false
> +    }
> +}

Or, more simply:

    fn parse_bool_from_str(value: &str) -> bool {
        match value {
            "1" | "true"  | "yes" | "on"  =3D> true,
            _ =3D> false
        }
    }

(Though, admittedly, I'd probably lean toward writing the function the
same way you did.)

> +/// To build without linking against C libraries run `USE_LINKING=3Dfals=
e cargo build`
> +/// To run tests set GIT_BUILD_DIR and run `USE_LINKING=3Dtrue cargo tes=
t`
> +pub struct BuildHelper {
> +    crate_env: HashMap<String, String>,
> +}
> +
> +

Nit: unnecessary extra blank line

> +impl BuildHelper {
> +    pub fn build(self) {
> +        let use_linking =3D parse_bool_from_option(self.crate_env.get("U=
SE_LINKING"), self.crate_env.get("CARGO_TARGET_DIR").is_none());
> +        ...
> +            println!("cargo:warning=3D{} is not linking against C object=
s, `USE_LINKING=3Dtrue cargo test`", self.crate_env["CARGO_PKG_NAME"]);

There are more than a few developers on this project (including
myself) who still use 80-column editors and terminals. As a general
style guideline, this project does recommend wrapping code to fit
within 80 columns (except in cases when doing so would severely hurt
readability). I imagine that the same sort of guideline would be
appreciated in Rust code, as well, by those who still stick with 80
columns.

I bring this up because, although it hasn't been such a big deal with
the existing C code, assuming that developers run `rustfmt` on the
code before sending a patch series, then this may become an issue if
different developers have `rustfmt` configured to enforce different
maximum column width, especially since `rustfmt` is likely to reformat
the entire file rather than just the region that has just been edited.
So, if this code gets checked in as-is with these very wide lines, and
then someone else, who has `rustfmt` configured for 80-columns edits
the file, then it becomes a problem.

As such, can we also add a project-wide `rustfmt.toml` which, at
minimum, sets the maximum line width to 80? For instance:

    max_width =3D 80
