Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CCB35838F
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781856068; cv=pass; b=t/WQHaElDv94ywQV4CEPvd519SUioWhaTaP1p/7/+2pd1GduE8PSvDFlC9uYL+U+dsKAtyio1vYqrn1WW4GdOBebdDAkGHZkpI8OHXTXlal+G5yb6j23SNECajCxXMvkCzw102OVzky2NQjVd/ntzdeWVFGjbxAZ31AFOzeLZrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781856068; c=relaxed/simple;
	bh=8k23IZiEME2rxx/hfNZUSguXF7xE7yEkP4EC8lYPVLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohetXcV1/rE41E0+hwN6K81DqsB53T561vTK2pBV60v+dS8+o3gljahcK7KbfWZfCFHgD4wm/d0B9O3SA/MG0mN82wu3pX5di88Rg6ijyWIovd26Fo2UfHkZjAEpOHHRCO9hXCrIP/NedBhKVnOi/XvjRyJHDlzFjEF7R3foIjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k26dGT7K; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k26dGT7K"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-691c5776f95so3020564a12.3
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 01:01:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781856065; cv=none;
        d=google.com; s=arc-20240605;
        b=HWs9qPkuwmY4YFajm2yGvG6sOotuwcNPR8WfGzVUE/hLns2/EjAEYMvzlYcIrZ7SKy
         CAxDqLKM9YxtoREGciLOyx4Vum8nV6zsmmSe5EUlQJPawuXChiFdyv7RFdD825EUmXA6
         eHH4ZFVOpkQ++sur9NrGGgN5tsy+o+2BDp1F4ScwffpTLKDi9F/WdvWQA0TehlWWRUX1
         kvIEfl7y90lrBbZzoAr6WJEyUwoNlOGNJ0wxIuw45JpwG07B6R8oyki0AZfjbl7Mg1f/
         05UY/F+O6hGAyOw9A/hCp8uNiOs2a/Jrk/eNMRL2o53pElRkX6uRskozFw3GxPLlyuNg
         aJ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bVZvJZ5G+FU/8w3+i2jGzB/gmKhyEcMZCWOg5vaVElQ=;
        fh=4taht92dzazhQDOjq8CsAaKR4Bsqe7vCuOP5jjEO90Y=;
        b=Nw8sdgGPB1WSfSEWF9+SvOZDXNglomD38IfDOnrjfxXLb1xDmFaek5OqygFLpn5Hac
         PwrA4x2Xq0XeaY8c083lFNlxqaUUrY+E0NxnTRBl5+SPHLvBA+/rljAHDc5TGmsYwAt0
         6kkqQL40WSDHqqayRvIe5wax/oUz4wlBpTmbzupqNriLC7TVoL7vYoEvE3qAEpa3ZTiu
         KWvQiOM05axHe5s4rJCvNVhpUOrRIfeRZ0VxGR5928jxQm0PRdgQMG1UU0H9fdixpenK
         zfJ1Dg1VNnAs15LP2fD8m1jQsqToqjWi62g575v4cWoDmB/Rn6DyhM0LfpcenBL7pnww
         Cf5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781856065; x=1782460865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVZvJZ5G+FU/8w3+i2jGzB/gmKhyEcMZCWOg5vaVElQ=;
        b=k26dGT7K0gVsDxCkYgoUDIB6DaD5wMvmMsm1V+NuEir6X4upwRRC7pNxLVMHNVejQo
         jfgk+CsE9dYHA9DY3mKjaxzcBaR/grvNeFiiblkbxUVxKNEmoVcjaXkXp+SrSuyJ7HN3
         fXm8Z0FI7OLhUc5/so354DJpx0AG7saggGu3DjbIiBsu3nGQx3ZW8AEtYT11mMvqnY6S
         fBN/hdB8cj0UBrwCinO0Zx7LGmbnvnUux3yTaTt/X96S0XmdlC5mY59dhU/WibE1XraW
         Ym7mgG/SI+f7p9Sco4aaqPKq5JCVUspQCHDl64vFHLL0yrS+64OyomN3WnJ2rFGDTAXb
         qtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781856065; x=1782460865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bVZvJZ5G+FU/8w3+i2jGzB/gmKhyEcMZCWOg5vaVElQ=;
        b=Q1GIu9HAFB3bGkujA/zphMc5F64ESXTixjCVGI+X09qmsUD/neqrK+yfV6+u9N6jog
         kph87kcseM6SnL0yDfEuXk0xSEfHkXL2SDLjq0qHimxG6p0UUumoZZJbxtNjcVNlyAG0
         xIZ6PeWZtSi/QadfgWd8kpAsleCS3Y3N0TjUcwXEAUc1QZQo2PUuZu1jU/7BIMS0JDIG
         jEAMOf3V9gPyaMcOFOWpXb1gbxPx5OPYX5EmwPSI/vANf4Mi77nLEPH8Fv1xkQFpz9rk
         ydKANm9heFqlTelmuW5PcLcaVsBFHZIKNwO+mGQ0yq0tsVf8X8k2ex2L2YXnI24bti9B
         zG2g==
X-Gm-Message-State: AOJu0YwLXWCdxe7XDdugvbz3iR2S9zyeD49z+zArDoHPQvIE/E0MjwBg
	C4Oo3ORFiYlMQqccNEFBTdCgHJjVuzPyapqub7+pRIQykJcTe3c9TOtWkMe1x7ndGZd5mJcl3dO
	5EN0t65GmguYYyzk8R1n/90vSEbVXunQ=
X-Gm-Gg: AfdE7cknGR0A0uxIdkd/BKAdIso9uki+2UUJI8hna/bVxFMiwytkHE7Q2EE2QbjWcsW
	GFLkHPCRkcp5FlWVuUaSXJyZzwXRIIchkJgMn7b+2AMFkvz/C8WwZJzF36LTd0bB1j8jXvIb2qE
	y4+4IsVCgLkWxz34E5i6zVdaLibx86oGtPBhwP5n7Q7qMHJWMouBoVxVd395UjinwwDxcl+w/gK
	5yRqESYf842NR3br44ep0VqS+s48vgJVynfJhAc3Z8cDcwRzYpo5y2WNsTo9sLzaBOJsZgI
X-Received: by 2002:a05:6402:3507:b0:68f:cca5:51e8 with SMTP id
 4fb4d7f45d1cf-6975679d941mr521455a12.27.1781856064439; Fri, 19 Jun 2026
 01:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2314.git.git.1780269406949.gitgitgadget@gmail.com> <pull.2314.v2.git.git.1780610623006.gitgitgadget@gmail.com>
In-Reply-To: <pull.2314.v2.git.git.1780610623006.gitgitgadget@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 19 Jun 2026 10:00:28 +0200
X-Gm-Features: AVVi8CcHe2TlwTFf3n0ybx2JIsSYzDxqybh0MUoCoiwE9fCV09XQiahI1Npilus
Message-ID: <CAHwyqnWBb65dC+qSYTw9SKdufjibUmTm065feM5D9906H5SQ4w@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: dedup archives in $(LIBS) so link recipes
 don't repeat them
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

I think this would be quite nice to fix for all the macOS developers
(I don't know how many we have who are active on this list), but when
running repeated tests it does take up some space on the terminal:

````
=E2=9D=AF git rebase --keep-base -x 'make -s && cd t && prove -j8
t345?-history*.sh && echo'

Executing: make -s && cd t && prove -j8 t345?-history*.sh && echo
GIT_VERSION=3D2.55.0.rc1.20.g1e31474ef6
ld: warning: ignoring duplicate libraries: 'libgit.a',
'target/release/libgitcore.a'
ld: warning: ignoring duplicate libraries: 'libgit.a',
'target/release/libgitcore.a'
t3450-history.sh ......... ok
t3453-history-fixup.sh ... ok
t3451-history-reword.sh .. ok
t3452-history-split.sh ... ok
All tests successful.
Files=3D4, Tests=3D69,  7 wallclock secs ( 0.02 usr  0.01 sys +  4.14 cusr
 5.39 csys =3D  9.56 CPU)
Result: PASS

Executing: make -s && cd t && prove -j8 t345?-history*.sh && echo
GIT_VERSION=3D2.55.0.rc1.21.g498da64046
ld: warning: ignoring duplicate libraries: 'libgit.a',
'target/release/libgitcore.a'
ld: warning: ignoring duplicate libraries: 'libgit.a',
'target/release/libgitcore.a'
t3450-history.sh ......... ok
t3453-history-fixup.sh ... ok
t3451-history-reword.sh .. ok
t3452-history-split.sh ... ok
All tests successful.
Files=3D4, Tests=3D69,  7 wallclock secs ( 0.02 usr  0.01 sys +  4.16 cusr
 5.41 csys =3D  9.60 CPU)
Result: PASS

Executing: make -s && cd t && prove -j8 t345?-history*.sh && echo
GIT_VERSION=3D2.55.0.rc1.22.g0050368e96
ld: warning: ignoring duplicate libraries: 'libgit.a',
'target/release/libgitcore.a'
ld: warning: ignoring duplicate libraries: 'libgit.a',
'target/release/libgitcore.a'
t3450-history.sh ......... ok
t3455-history-squash.sh .. ok
t3453-history-fixup.sh ... ok
t3451-history-reword.sh .. ok
t3452-history-split.sh ... ok
All tests successful.
Files=3D5, Tests=3D86,  7 wallclock secs ( 0.03 usr  0.01 sys +  4.89 cusr
 6.36 csys =3D 11.29 CPU)
Result: PASS

Executing: make -s && cd t && prove -j8 t345?-history*.sh && echo
GIT_VERSION=3D2.55.0.rc1.23.gb86b93bda1
ld: warning: ignoring duplicate libraries: 'libgit.a',
'target/release/libgitcore.a'
ld: warning: ignoring duplicate libraries: 'libgit.a',
'target/release/libgitcore.a'
t3450-history.sh ......... ok
t3455-history-squash.sh .. ok
t3453-history-fixup.sh ... ok
t3451-history-reword.sh .. ok
t3452-history-split.sh ... ok
All tests successful.
Files=3D5, Tests=3D88,  7 wallclock secs ( 0.03 usr  0.01 sys +  5.01 cusr
 6.54 csys =3D 11.59 CPU)
Result: PASS

Successfully rebased and updated refs/heads/rebase-fixup-fold.
```


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
