Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694F035AC23
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753830; cv=pass; b=rkkNJ6Ic/Wm5HE7rE4TVW2Arn1sZ/7VsepTAmZPGtgDFS3tlzZ9qS5IVXYKECdoV1gq2JaYmiH5RRus8GU5cC3bDZ46ONCa0eYBKQhH2ZogphPIqvKFJnSwEmdwnbV6cFVoDIbeVJubtrHVOTT6gLBSEWTzsxhOcB3D7J26OcNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753830; c=relaxed/simple;
	bh=5hNxaNgWFp7Zjcf8LNRhgys0oi3gRC1RZmnp8lhXZt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McRFFREvRg9RC0yxqsHvxg8DC72T2bdU6rk/bqhmng2OyWHJbJcmTtzWRXUbULwfu6ESXaGarHnzLE8l++plhr7b2oUVHj7OW3adtD6lltwOSUdmsZO+Fk1Gzz6tgQBh8H96ThsaE0MlOhwY3PFs0t2rk9UY5EOTyhTjP/1fuos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDEAT3OE; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDEAT3OE"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9358dd7f79so377124966b.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 15:37:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772753828; cv=none;
        d=google.com; s=arc-20240605;
        b=jb3Vc9OvXhkgLgb5a5mJSvVo6Bj9a6RbX7Rln01AR4vb7ErJdClZUr7oAnw27iTl6j
         MmBdGW/0AUx0zXHxOh7iViC0VBcJaCVo3KbrUNIICcv+Pljgc+d99T1+kRjrXCxLfYW9
         t2frzYtY9HNVficBARDA5g2+cegP984OS0C/g8+UrrpEYuZFIQE/Jg/6YW9H4nzi8hQh
         byD0OURUEOyTSRJL0ufN88kw/f6T8TCHABFWqt87XCjT8vapi3Vu0P4rSaCEC6OensOl
         v1q4pSnP0CgSkJ9SjInHvfpingTDcVj0j1HG/b8b6e8ZPFzz4NL4dyDWdUsBVu7PQBRL
         dr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8Gzl5hUiOEzhVQTL22xn8EDBavrAIZcg3HL5e8Gc1Wo=;
        fh=VHDmUbx8fjkdN75VWN5CTjkglZBzVlasQgJGlwhruOQ=;
        b=ZaoDbDV0vGFBBMJWtNiz8wyQIolWkDuPjryPywDzt33hfRf9IhCuhenrzLLzM2HmRY
         kMA+0xtiaypUJQ2gL75qy0pLVk+LR2gjf68eYQqIeNtxhTRI9V9bqjkkhn37AXGSk0PK
         17t4meNVlUeblc/yoaG0WVv9nxbdT47W4OybuIa80DB4YntG6qBJ37VkC90mTY+7LNfu
         IxvQIqp1dDkdExjl/8vrLDmqETPSti34EoZE+LOohQl9msVb4Fa65sKlKWoKBjmh4fCd
         3QBm0dH6Aa9k73avLujRZ5xwAm/prNDFtzrVb/aS4+2P8aXBaFk2mhAM35Pa6ukZC8O1
         MceQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772753828; x=1773358628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Gzl5hUiOEzhVQTL22xn8EDBavrAIZcg3HL5e8Gc1Wo=;
        b=TDEAT3OEZJMzQd4HLDdJjdabkgQ+fGFpx92l1CExPeIrzPxydOlt0ULkKwY4mui2RH
         ybv9r/DYnu7mi9pw4VmxJUK4ii1LrI9ZK9Q5+d9mwcZBjosQRnPZY6swBVwU8sxUhElJ
         6eHK9ox7hs3ol5J0atTMiQdfGbuG/SWOoTuwoTFZ/Mn/CmIBC0ztdq2tpA6mJ68NfHIf
         GLinYmKPTBNAy4fB9SHxlXzwjRo6d4OT70rgdPI2O3vuli0i0RrpNnZEk6oh9iuUwjZc
         MFjRICWwuh76DrHclly8PkBI1ASwullcl3GhRAsnCVJtHTq2SpkjTyyEllikFfcmrnY+
         ZGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772753828; x=1773358628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Gzl5hUiOEzhVQTL22xn8EDBavrAIZcg3HL5e8Gc1Wo=;
        b=EGLXCxVT05dwx5SsSdCjE/x6jcRhKyAH9DfiZyXTd8jyiLfZhAVrtobN86jLtomcEJ
         xX3FfFnx1ZAC0l6H4UuU1pPZVkBCtJO8GeJ8704KoAuk7mb1bZ/bUiM/8NymNu+CrVeX
         XD6rUVgsSzC5j/U+RsLmzBwQS95EbQY22dvIFbl8yXG0X+JHnAvcVhIUCiIK2DCEJkjB
         GDk6t1fXhr8KN5hAa2PRR8PVgRLznbvncY7OkNk/0OIJHkWBj2lA9CwKaoA5NvEYrZhP
         pkeGBE9Z3yAzXVLg/zPCoo1vMEn9+Xr+RTBBLse+fUTOTg/J1EGgBs8K0ZuyrifmW0i0
         2aJw==
X-Gm-Message-State: AOJu0YzT4xtOjHWU7O5QfF/fwiO8UAlKoenRfUXqawELwozdddfHRaJB
	GEAD/BIWziDo/f3dzZPOVV21nxOEUnEuY3K6MM6aKPHqzTvfCYKOOwM7+24AEdSibTjYZMGsGM+
	KnQ0JIbnxLDk4gS2senWSkqalW40jJOUOvs92
X-Gm-Gg: ATEYQzxpf7YISiecfSHMEwMQ6R3iprybOYXaQt6x+LSpiQ+Drdq55HqPT/QXlOT2W9b
	AIc33nLAoJzCWgbbsLK5fCdSBZGkWKG9IUjGdjX8Voqn5//0akx8E6oMa14M+sq/bbUsXv9aTsV
	j+kerbu75Y2MP+fAND2HI4uzDiryRyFogDD9s/hBnOKBj2lv9xA8WfUQrMHcvV2MkUojvSuKznl
	Yfqe0ItknHVSKZJQiNR69oTQOFgzO/vksTK1XuzHTp5iVAQpg6zCfnyyKGf7v9Abzp6q4Xz9IrV
	MczPiYN6
X-Received: by 2002:a17:906:6a06:b0:b87:117f:b6f9 with SMTP id
 a640c23a62f3a-b942da4b05emr3317666b.8.1772753827463; Thu, 05 Mar 2026
 15:37:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM+g_Nt8vZX4NxPvddJxNvSRgdMWQaLg2O9xzAU1pTHa=Et-gw@mail.gmail.com>
 <xmqqqzpy46n5.fsf@gitster.g>
In-Reply-To: <xmqqqzpy46n5.fsf@gitster.g>
From: Norbert Kiesel <nkiesel@gmail.com>
Date: Thu, 5 Mar 2026 15:36:55 -0800
X-Gm-Features: AaiRm524m5gKnrsvqsy5ljUFayVEUwHBwBYAMUdGMVYEDTR-Ou9ydlOOhNedOAU
Message-ID: <CAM+g_NsX5jdjbhtLznxJ=ZRtJ4ShEAzTHzkjgnidyDr-a2r=kw@mail.gmail.com>
Subject: Re: Feature request: support listing worktrees sorted by creation time
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Wrote a Zsh script that uses the "directory create time" but when a
worktree is moved then that will be updated. So would still like to
have `git worktree add` store the current timestamp somewhere.

```zsh
#!/bin/zsh
# List git worktrees with creation timestamps, sorted oldest to newest

wt_path=3D"" branch=3D""
typeset -a ts_arr wt_arr br_arr

flush() {
    [[ -z $wt_path ]] && return
    local epoch=3D$(stat -f '%B' "$wt_path" 2>/dev/null)
    ts_arr+=3D("${epoch:-0}")
    wt_arr+=3D("$wt_path")
    br_arr+=3D("${branch:-(detached)}")
    wt_path=3D"" branch=3D""
}

while IFS=3D read -r line; do
    case $line in
        worktree\ *)  flush; wt_path=3D${line#worktree } ;;
        branch\ *)    branch=3D${line#branch refs/heads/} ;;
        detached)     branch=3D"(detached)" ;;
        "")           flush ;;
    esac
done < <(git worktree list --porcelain)
flush

# Find max branch width for column alignment
integer max_br=3D0
for br in "${br_arr[@]}"; do
    (( ${#br} > max_br )) && max_br=3D${#br}
done

# Print first entry (main worktree) always first
printf "%s  %-${max_br}s  %s\n" "$(date -r "${ts_arr[1]}"
+"%Y-%m-%d")" "${br_arr[1]}" "${wt_arr[1]}"

# Collect remaining entries prefixed with epoch for numeric sort
typeset -a rest_lines
for (( i=3D2; i<=3D${#ts_arr}; i++ )); do
    rest_lines+=3D("${ts_arr[$i]}  $(printf "%-${max_br}s  %s"
"${br_arr[$i]}" "${wt_arr[$i]}")")
done

# Sort numerically by epoch, then replace epoch with formatted date
(( ${#rest_lines} > 0 )) && print -l "${(on)rest_lines[@]}" | while
IFS=3D read -r line; do
    epoch=3D${line%% *}
    printf "%s  %s\n" "$(date -r "$epoch" +"%Y-%m-%d")" "${line#*  }"
done
```

On Thu, Mar 5, 2026 at 7:50=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Norbert Kiesel <nkiesel@gmail.com> writes:
>
> > I have multiple repos with more than 20 worktrees, and sometimes
> > forget the name of a recently added worktree. Therefore it would
> > really be nice if I could use something like =E2=80=98git worktree list
> > =E2=80=94created=E2=80=99 to list them by their creation timestamp. Is =
that something
> > that makes sense to you as well? I could also create a pull request
> > for this if you would like it.
>
> I do not think we have any _record_ of when each of these worktrees
> was created, so this is not a realistic request.
>
> The output from "git worktree list" may be more than 20 lines, but
> isn't your terminal taller than 20 lines ;-)?
>
> Since very early days of Git, we have created .git/description file
> that is not used very much (I think it is shown in gitweb).  Perhaps
> worktree should have an equivalent in per-worktree part of their
> .git/ directory and "git worktree list --verbose" can use its
> contents in addition to the additional pieces information it already
> shows, or something like that, perhaps?
