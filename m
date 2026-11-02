Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793648995;
	b=ZOsEyGk1q3NpxGUw7z2ZP0C9p6cw2C+PxUwXVi4XdGmQLfo6wFpyuOSXV8zw//6i9QPy
	 KmP5yOQpf5Ht5vkLCwknsQafE4XqdUB0HWcu31q7HDGbewWg4PY9NyswXNLCE6RJO1PNI
	 BQJUAg3J7dAcHVYRiSDFLl3ma+9xa5dCNLCTZDqSlq51dtiTLlgexXbsSGouT99oZBGWz
	 PVwtU52ssoZYAFPs9ty+3xC3nnX60T8mkPx9JP7GGMedc75ApwxAsp2+d2cRa0mmzbIKO
	 v20poNkvA5hJhx5anV8SQag4y7hM5vHF30xXIX2q/PmRs5Jot3VE542N96S0u7ajj1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=zrDU9igItGMJEylLt45NMbNEDVuRg1eSeECHu4nX3Gs=;
	b=FkC/2ViJCPydO9WcAkhsBGgWD7n5iV1f7x8yY0AkTEKnQTYYXljHJT7ZUVF8+PB/7O/g
	 cDnK7HurdR6F3H5ftTUy5z1OeQATXqdoVZ9tVTRDALFauMxmyGnmgED5NWvy88yYHDFIp
	 t611kzlQ4p0o8wArxcra+AtqfvtB650vYGnDf9HaRbAH/69WroUndTdIHiQliyJ8DvGfO
	 Vu4OWiKZBGBbl+fm6GAgw0XVYwJCT3TZq02eFmSqFOWGWCoGUa1KGJnxFbzMpFPkl28Ta
	 HlNg6mzSdlb2ZKTo7lOrkyF5GBYPihJK3b+jbsjkQA5GmDRS8NMi/sKYlPjISrbcRSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uxr3e9p7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5E8606A326
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 19:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC5E8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uxr3e9p7
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5365d26ccbdso49502471cf.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 11:49:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793648993; cv=none;
        d=google.com; s=arc-20260327;
        b=EqByo9FU9dehCztHi1SLitehLrZGstJe0sX7mG0PBTWNUfMJfi/usz65rcXFLhIXXA
         jsNar5fCO1zZL/OgScaZ92zvFAJRU/08pi8kctQX65FGQF2rVCr3VM6Pn/RznLVgHuma
         iAKeywMv2Lv7lRB+DcjulbCrdaVytUPNe3C9olDo2L0BlDfBY0kOLOATe4x6miaD5LOu
         DryJ2xRNgvRgF+qe/cBD9EOZfMfm2yJjjFdKZ4Hoyewv4m/OFv0Z0Mck7VmsyQQF/luv
         cLl6NKKoQTpWU7Q5XLu5TLXOx17Bhd9PUSfv2OQ+1RoGT08Zhu4jK17fXcQ5mYR3bGcm
         0sMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zrDU9igItGMJEylLt45NMbNEDVuRg1eSeECHu4nX3Gs=;
        fh=Rrt7TCA6D3zJ/yBsa8UXmnBCnNR14SDM49MvGRH1CxY=;
        b=cXOChRkA0XnQknYeo9kms4T0s+2DvNga3l0ekhEBT/LFuFlONweb0p4e6b8Ni5Q3go
         0AjYJSIIZE4V6AY78HQnRklRAqhkH2gJ/XgpzVydbUbwDllIb1A8oX6MSbutwX9LewFB
         qF+FMhxOcHGstRskhITIp1R+ImE7u64W2VdRCojBFPEY4LyFVUHoaZYZjJZ67CDIyuub
         p7ku0gE1q15VT94fLbkzS8pNdsa76kFRYSacJdemxJVma0dAI4PmGagJxLjphOIGAo0r
         EO2cbno5kbz8bxVzdv1dtej51gpLOhT8x+8w4+KfigxIBBl9Vv00aa/ZRTp8Za3NBjnR
         2eQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648993; x=1794253793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zrDU9igItGMJEylLt45NMbNEDVuRg1eSeECHu4nX3Gs=;
        b=uxr3e9p7ysb+fZRVhlDgJuQHm9oJBo3qwS/TnUKeE6j86SqBFiV93RvfPQAy3ivFJf
         QDeXIaB7Sl/K+FkuqYqZOKRoBC6vEb7lQhFNBIwdXxYZHmoY1u19Pdu2zTAwiwCbIhnu
         ir8R6673sajiFBk5mZsDpM/S480Fg0+wAPtpArmXFRe2XWWzshDGTi6rQZXQFGzgf9Vx
         Yu4w1EBrekBfY1lBuKTxVaoSDd7aqz/nO5EV6g9mwdMSuhsDhhwh7fNk2TO0g2U1PQ6H
         99MIfqwMoQ70MxrWMULG2EwtSNYkVDS5E8/yWfHDWyraruo7vWx++g83OXh93yiJxCcr
         XdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648993; x=1794253793;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zrDU9igItGMJEylLt45NMbNEDVuRg1eSeECHu4nX3Gs=;
        b=hhhvZrZsqWfVTEvlbCI0G0zc7WGl+UxsnlOLpPwDPgxmC94Ztatw/NUrbvMXmk/v5f
         WfNqBuHBBiIL5leZUGprE18z4e8lMbkbD+qjtceCz92OjPfpJiHo2y7yvmMDTKoPKWP+
         5kjbxmFXSgpX3gUvH/WiHYVkjGIOb5ZSQoNQCHtoQK+s2gy0rZMaps7s4uRshApFuZ11
         sLZy2O1tB4HwjR0IGftNkydgZS5dI6Yppv0K+KMujagcgD/rGUTHwGHkamprpD3SabuI
         zHi3BMkzsa+DjFuAMUwKWf9ld9x+A2fS5fAasM3Lbwu3LmWgXeKJF4/TXO2uFaypQqhk
         srwA==
X-Gm-Message-State: APuU4Z+y3bh4Ngb7OhW4pppNii9gbtJXg+tqXjNZcbkfIu0lJ2RrsFR7
	7ogFcBohAV/nh9NqzqLWLsjlx2h2VsaOrocRnCkbnJGhrPbIJQEW9e1Xtv0W6dYCQV3KZB2kbBm
	OLwbm9vOsYgWXDjBcey0YXz8WPe1nVqigMhvBNow=
X-Gm-Gg: AYBFou1J/1cFzWXZaCIOwhJe0hublnGvK/AoCIYO3wgvkaJhp6oU1M2e3iYJ9+8h34h
	41x14vPygcKM7sYVqmV8dYBANYMATeQI2J8JKEXFM7pFn7RRna+PaHzfT33wevLSxtFd4kzT/nX
	f00e9Q2baWO1rtid1qsAaUlm8OevFVbD1kcqHCThsYdfg0H0vrfVde/PfD4S7MfG5/v7AijQjHi
	1c+cZ37ip9zCcHd6UhuwFRigjyZzo4wFR5eyg7hq3buo7pxn7fq27ZMHw0YDW9Zai8+AK+vzi/N
	AP79FfYIKNOWQ0ivpYTE7CRvpzaA5Rg8H+WzSWH8++VakpX9k1O/wIqC2g4esEDcfb7JI4gkL7O
	PPi/CzLRkveDMpcskZm18Ecnp/GOPIFhgc8cQeUv/ZLJvQU90AbNc9D+dUKm5b+54rC9o1jP+U3
	ltIV8jMyxWGCRbI5yXCcIIZp1Paz+RENhtwJiYhdQxMajH4iRuzLR2PTGHsw==
X-Received: by 2002:a05:622a:508:b0:535:cee0:6740 with SMTP id
 d75a77b69052e-542b6d5f357mr178503131cf.36.1793648993441; Mon, 02 Nov 2026
 11:49:53 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
 <pull.2288.v4.git.1793648430.gitgitgadget@gmail.com> <a8c54b929255679ebd02ca06ef1f58de87448064.1793648430.git.gitgitgadget@gmail.com>
In-Reply-To: <a8c54b929255679ebd02ca06ef1f58de87448064.1793648430.git.gitgitgadget@gmail.com>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Tue, 3 Nov 2026 01:19:42 +0530
X-Gm-Features: AclHuK9CMhHfWc4U9u4vNVrWw5zhGuaOTfPt_b8Yr0MEyl8JChgJZaG4PMxObpM
Message-ID: <CABh_KWhHP0bxE0PAGvn-1=DNSoLUCmr_Aq6n-p3wC+VFXkCjZA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] submodule: use the submodule repository to
 abbreviate commits
To: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 1:10=E2=80=AFAM Srujith A Poojary via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Srujith A Poojary <poojarysrujith@gmail.com>
>
> The commit IDs shown in a submodule diff header belong to the
> submodule's object database. However, strbuf_add_unique_abbrev()
> uses the_repository, so it checks the superproject's object
> database when abbreviating those IDs.
>
> Use the submodule repository when it is available, and fall back
> to the repository from the diff options when it is not.
>
> Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
> ---
>  submodule.c                      |  5 +++--
>  t/t4041-diff-submodule-option.sh | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 6fcb606f7e..1302c11ddf 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -543,6 +543,7 @@ static void show_submodule_header(struct diff_options=
 *o,
>                 struct commit **left, struct commit **right,
>                 struct commit_list **merge_bases)
>  {
> +       struct repository *repo =3D sub ? sub : o->repo;
>         const char *message =3D NULL;
>         struct strbuf sb =3D STRBUF_INIT;
>         int fast_forward =3D 0, fast_backward =3D 0;
> @@ -599,9 +600,9 @@ static void show_submodule_header(struct diff_options=
 *o,
>
>  output_header:
>         strbuf_addf(&sb, "Submodule %s ", path);
> -       strbuf_add_unique_abbrev(&sb, one, DEFAULT_ABBREV);
> +       strbuf_repo_add_unique_abbrev(&sb, repo, one, DEFAULT_ABBREV);
>         strbuf_addstr(&sb, (fast_backward || fast_forward) ? ".." : "..."=
);
> -       strbuf_add_unique_abbrev(&sb, two, DEFAULT_ABBREV);
> +       strbuf_repo_add_unique_abbrev(&sb, repo, two, DEFAULT_ABBREV);
>         if (message)
>                 strbuf_addf(&sb, " %s\n", message);
>         else
> diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-op=
tion.sh
> index 4dd4954260..e80472af32 100755
> --- a/t/t4041-diff-submodule-option.sh
> +++ b/t/t4041-diff-submodule-option.sh
> @@ -14,6 +14,24 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
>  . ./test-lib.sh
>
> +test_expect_success SHA1 'submodule commit abbreviation uses submodule o=
bject database' '
> +       test_when_finished "rm -rf collision-super" &&
> +       git init -q collision-super &&
> +       git init -q collision-super/sm1 &&
> +       printf "0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n\nb1rwzyc3\n" >collision-su=
per/sm1/a0blgqsjc &&
> +       git -C collision-super/sm1 add a0blgqsjc &&
> +       tree=3D$(git -C collision-super/sm1 write-tree) &&
> +       commit1=3D$(GIT_AUTHOR_DATE=3D"1112911993 -0700" GIT_COMMITTER_DA=
TE=3D"1112911993 -0700" git -C collision-super/sm1 commit-tree "$tree" -m a=
2onsxbvj) &&
> +       commit2=3D$(printf "child\n" | GIT_AUTHOR_DATE=3D"1112912053 -070=
0" GIT_COMMITTER_DATE=3D"1112912053 -0700" git -C collision-super/sm1 commi=
t-tree "$tree" -p "$commit1") &&
> +       git -C collision-super/sm1 checkout -q "$commit2" &&
> +       git -C collision-super update-index --add --cacheinfo 160000,"$co=
mmit1",sm1 &&
> +       git -C collision-super commit -q -m "Add submodule" &&
> +       git -C collision-super diff --submodule=3Dlog >actual &&
> +       printf "Submodule sm1 0000000000e..%s:\n  > child\n" \
> +               "$(git -C collision-super/sm1 rev-parse --short "$commit2=
")" >expected &&
> +       test_cmp expected actual
> +'
> +
>  # Test non-UTF-8 encoding in case iconv is available.
>  if test_have_prereq ICONV
>  then
> --
> gitgitgadget
>
Hi Junio,

Thanks for the suggestion.

I've updated the t4041 test to use `test_oid_cache` with separate
expected abbreviations for SHA-1 and SHA-256. I've also removed the
SHA1-only prerequisite so that the test runs with both hash
algorithms.

I tested the updated test script using both configurations:

- SHA-1: all 48 tests passed.
- SHA-256: all 48 tests passed.

I've updated the commit message, added the Signed-off-by trailer, and
submitted the revised v4 patch series.

The updated patch series is available here:
https://lore.kernel.org/git/pull.2288.v4.git.1793648490.gitgitgadget@gmail.=
com/

Thanks for the suggestion and review.

Regards,
Srujith
