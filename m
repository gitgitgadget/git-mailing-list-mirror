Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3852230BF6D
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781097884; cv=pass; b=SRlki6j4PEaPz6qG72jkz2hT+dm4miVosoUofyNJYPAHH8sVLovKNEbOIrTKBCzDmH6oW5/LsE7pGWzJmSVFIovvRZqlezE56YlHLSHlOJ1VjXKhB4WAqtU7NpFQ4Q56o+jf7JcMszgUPoUKb5DBwap2gRXvFHqFNU5IcvPQeJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781097884; c=relaxed/simple;
	bh=RTb9o45hbheFJACoMAWIoaUJe0TsG0SuyWFjaQl2sEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NcO6ofzu3j9/K3THrlarU37hqXUmdiitW6TU/Njf11tNaSj/1WnufbQLlyG/6fPLwSiolxAg+pARn0VFNi0nx/Lmsm6awpXFYqS21uhS4GsnlAgCBeP2HAd3oFpJM9Hu83+VcgbINCd1mXtRhDKEZJFrwpCcg2Y1eC2ZHZ75zQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnnHs9lC; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnnHs9lC"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6870ad8072eso3055162a12.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 06:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781097881; cv=none;
        d=google.com; s=arc-20240605;
        b=bPE2BdUbmmEhs1gamVxcWw4xmytupCUQZ0b9nK+vQQldPVrRwgiUmrhxWdV6g2HW5d
         Lw+gA86bZEwY2lmzuZR+B6QktZbahkWSPFERmC0LCYHYWzXU0dKApf/1onlNp1c2Dpeo
         Ml/jgbi+zTmhTabnc8RKR55xL7zqVNJZKaSr0BA9fE/NhY1NiBgnSuwSM463eNcTNHeS
         xqocyCza0nsZX/4yVM98Yexprkqk4Rlr0sl6zrp079U3z66XGz2C8dB/XhvGsUuTvyH0
         2PG9zK/knCk3xaWc0KaHlDYLFfzyTTMhfe3Bwk4WDJmyGkotKntn3fT/yeXGgp2BfViq
         mhIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QtFpO5Kr8eOxNIEuYCzynqP+P2Z/OVZFN2wC55VNHjk=;
        fh=mZixHP2Ewss2SFJr0NJjUylVjNy0qV/BrWHw1aJTsFw=;
        b=PDPQF/NLSKizMLPZQvkcHi+Vg+1fPHOYqpPMXHCua8AN8ol07DxwWxh4v5dDHEqksZ
         eyHNFLAnN2t2vP+8LtVrwbohCP8QCEFoESFSWYR+Cspz0ACyTCpm69IeKzmh0QoOXP8q
         k/1lekPCcS+DQRWgUt2ABQCosWXlZh/tUz81Fmx5IU0LajertI79v7eH577c3gB8wivb
         PbfFjY7oMQMUxrKbk1JxrKlpuW4WBrGPl7DWymqIIUyH+Vn7pkaNkn+dCqMFEOaLLiZA
         j7x+aTZ3M8jmUApSmAqciKk5klTfGgOdo5H7zUOME8KExYsI/idtY6DWCP1TJ7dNQSxe
         Zejg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781097881; x=1781702681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtFpO5Kr8eOxNIEuYCzynqP+P2Z/OVZFN2wC55VNHjk=;
        b=NnnHs9lCgsy57Yi+FKOFmVs9dUk201jH7OVHxgYIMtcf7FqTb9bHBQmk1E00RGHMJB
         GAtkKN8WyiMt/IMAt3Yf2LDVsFR56grwrQ3KYw/6pYTYHwAWZPl6DPGxJHuQKapRzZzE
         +zQHiaquZUEJt9Jtu+lA+gSqKUNI9X4zd9Cy7hjq5DQ3dRJEyawXsc40kmrj7Oxw5TZp
         kp40anpA/W5EXG01K/F/om09sKyLikMw97n/IGXPsx8/+gWxmAm6wahd6O/jlPB5fGY/
         aFaRtlTzOgRI+rJTxTn1KIZD9Vb/LBu0qcMms2oFoQPB/r34FsWko2sFt9GXaKUVzL3d
         bCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781097881; x=1781702681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QtFpO5Kr8eOxNIEuYCzynqP+P2Z/OVZFN2wC55VNHjk=;
        b=GjjhnWWP/sASwpijKkAh6OmSCIOffIKTBo0ULi1RpBYPShQxT8stUNcdU24BX7uHVy
         4YDjbnf9DMj2XMYERFbikftFg2wF9TAIgHw9Nn61mI7KmPYEX2wpMx8fPdEJHdRgjsEN
         Hu1yYsO0RGtNxOTv2y4BOQ5lCoaJ4o8EuqmEhIfqEDpNjOsE/6PEkIrW3zLP0UOm3Y83
         oRTBtHuAHlU7+Bmn8BbVPWvI2tWG28lmwSHk6w/XfmdwrNgBMxOLY3RzVXfbTE32ObF7
         sXlbFIrf/02dINzg8zw4yHStDmA7frHamVO6CoIbSumokRCLRUBXkCC1LdQuzXdn2MYb
         OqiA==
X-Gm-Message-State: AOJu0YzZTiONxkrt7T3iwHwRgcLSjhAsAgA8NDpdBp+LwJJM2rlm7lCx
	NuOrB4Um8rl39HFswCEbch2Q2BbDsZpZxnWG/wkT0oQuMAXXgFXhkWQJVZBWHyWo9V5QZy//syz
	yV1tvKIuRpZlohdnT8QBFnxx2/kY7U7g=
X-Gm-Gg: Acq92OEw5oqE5PV3jjIg5icpRF4ZwdFVU5iYK0j1AoCxAIGRCn2DSLt54UXnkyYyrX4
	TvhFmPKk+UogOXBgmbeGcZifzM6v79Dizii3KatiRITHkCJAlBJcnxyZO+/kMOdvJAjaYQTS+rQ
	YLbcNzS7ol25JFYljMqj7lMTZgDcCx9pasIWkZfSKOSFCivnH5menx38NI6lrttnCqmN414436r
	rFQo3M2ZBFR7IKUAfb6JhYm1CoGcGipjCEOH3DQWyNzwKi9zPVxIi3M79qTMznTerOpMH5DvWeH
	OLVz19/w49rO6EQSlw==
X-Received: by 2002:aa7:cfc1:0:b0:691:5077:9887 with SMTP id
 4fb4d7f45d1cf-69150779bb1mr5886602a12.2.1781097881239; Wed, 10 Jun 2026
 06:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2314.git.git.1780269406949.gitgitgadget@gmail.com> <pull.2314.v2.git.git.1780610623006.gitgitgadget@gmail.com>
In-Reply-To: <pull.2314.v2.git.git.1780610623006.gitgitgadget@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 10 Jun 2026 15:24:04 +0200
X-Gm-Features: AVVi8CdB7xIsigjGLqZhp27010-m3RWurtS6TNsTavIomx2G3RdAoCimUOqHxto
Message-ID: <CAHwyqnWSLymeW-yQcjP-5shHGqYg+vu3rN-uwX21dY-dTR2CnQ@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: dedup archives in $(LIBS) so link recipes
 don't repeat them
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes!

Maybe this could be interesting for you to look at too.



Harald

On Fri, Jun 5, 2026 at 12:03=E2=80=AFAM Harald Nordgren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> A handful of link recipes listed archive files twice: once explicitly
> via $(filter %.a,$^) and again implicitly through $(LIBS), which
> expanded to $(filter-out %.o,$(GITLIBS)) $(EXTLIBS). On macOS the
> linker warned about the duplicates:
>
>   ld: warning: ignoring duplicate libraries: 'libgit.a', 'target/release/=
libgitcore.a'
>
> Redefine $(LIBS) to list archive prerequisites from $^ first, then
> the rest of the library list with those archives filtered out so each
> appears only once.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>     Makefile: drop duplicate %.a from test-helper link rule
>
>     Redefine $(LIBS) to list archive prerequisites from $^ first, then th=
e
>     rest of the library list to avoid brittleness in the future.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-231=
4%2FHaraldNordgren%2Fmakefile-test-helper-dedup-libs-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2314/H=
araldNordgren/makefile-test-helper-dedup-libs-v2
> Pull-Request: https://github.com/git/git/pull/2314
>
> Range-diff vs v1:
>
>  1:  f6166450b0 ! 1:  0ef442ea05 Makefile: drop duplicate %.a from link r=
ecipes
>      @@ Metadata
>       Author: Harald Nordgren <haraldnordgren@gmail.com>
>
>        ## Commit message ##
>      -    Makefile: drop duplicate %.a from link recipes
>      +    Makefile: dedup archives in $(LIBS) so link recipes don't repea=
t them
>
>      -    Three link recipes list archive files twice on the link line: o=
nce
>      -    via $(filter %.a,$^) and again through $(LIBS), which expands t=
o
>      -    $(filter-out %.o,$(GITLIBS)) $(EXTLIBS). On macOS the linker wa=
rns
>      -    about the duplicates:
>      +    A handful of link recipes listed archive files twice: once expl=
icitly
>      +    via $(filter %.a,$^) and again implicitly through $(LIBS), whic=
h
>      +    expanded to $(filter-out %.o,$(GITLIBS)) $(EXTLIBS). On macOS t=
he
>      +    linker warned about the duplicates:
>
>             ld: warning: ignoring duplicate libraries: 'libgit.a', 'targe=
t/release/libgitcore.a'
>
>      -    Drop the redundant filter from the test-helper, fuzz-program, a=
nd
>      -    unit-test recipes so they match the pattern used by other link
>      -    recipes in the file.
>      +    Redefine $(LIBS) to list archive prerequisites from $^ first, t=
hen
>      +    the rest of the library list with those archives filtered out s=
o each
>      +    appears only once.
>
>           Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>
>        ## Makefile ##
>      +@@ Makefile: endif
>      + #
>      + # where we use it as a dependency. Since we also pull object files
>      + # from the dependency list, that would make each entry appear twic=
e.
>      +-LIBS =3D $(filter-out %.o, $(GITLIBS)) $(EXTLIBS)
>      ++# Archives from $^ come first, then the rest with those archives
>      ++# filtered out so each appears only once.
>      ++LIBS =3D $(filter %.a,$^) $(filter-out $(filter %.a,$^),$(filter-o=
ut %.o,$(GITLIBS)) $(EXTLIBS))
>      +
>      + BASIC_CFLAGS +=3D $(COMPAT_CFLAGS)
>      + LIB_OBJS +=3D $(COMPAT_OBJS)
>       @@ Makefile: perf: all
>        t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS=
)) $(UNIT_TEST_DIR)/test-lib.o
>
>
>
>  Makefile | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index b31ecb0756..a828a66f28 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2503,7 +2503,9 @@ endif
>  #
>  # where we use it as a dependency. Since we also pull object files
>  # from the dependency list, that would make each entry appear twice.
> -LIBS =3D $(filter-out %.o, $(GITLIBS)) $(EXTLIBS)
> +# Archives from $^ come first, then the rest with those archives
> +# filtered out so each appears only once.
> +LIBS =3D $(filter %.a,$^) $(filter-out $(filter %.a,$^),$(filter-out %.o=
,$(GITLIBS)) $(EXTLIBS))
>
>  BASIC_CFLAGS +=3D $(COMPAT_CFLAGS)
>  LIB_OBJS +=3D $(COMPAT_OBJS)
> @@ -3392,7 +3394,7 @@ perf: all
>  t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS)) $(U=
NIT_TEST_DIR)/test-lib.o
>
>  t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
> -       $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.=
o,$^) $(filter %.a,$^) $(LIBS)
> +       $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.=
o,$^) $(LIBS)
>
>  check-sha1:: t/helper/test-tool$X
>         t/helper/test-sha1.sh
> @@ -4015,13 +4017,13 @@ fuzz-all: $(FUZZ_PROGRAMS)
>  $(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS) GIT-LDFLAG=
S
>         $(QUIET_LINK)$(FUZZ_CXX) $(FUZZ_CXXFLAGS) -o $@ $(ALL_LDFLAGS) \
>                 -Wl,--allow-multiple-definition \
> -               $(filter %.o,$^) $(filter %.a,$^) $(LIBS) $(LIB_FUZZING_E=
NGINE)
> +               $(filter %.o,$^) $(LIBS) $(LIB_FUZZING_ENGINE)
>
>  $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TE=
ST_OBJS) \
>         $(GITLIBS) GIT-LDFLAGS
>         $(call mkdir_p_parent_template)
>         $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
> -               $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
> +               $(filter %.o,$^) $(LIBS)
>
>  GIT-TEST-SUITES: FORCE
>         @FLAGS=3D'$(CLAR_TEST_SUITES)'; \
>
> base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
> --
> gitgitgadget
