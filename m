Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB65338DC67
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564650; cv=pass; b=qrfByiC/T2d8xr6HoC5qqEdKZdanEgUf8/H31swTrVZmi7sNUaclBY7ZODntY3gjryICrmnNyUxmxKGaF95E0v3XgFRoKrQOjKRGnBXJVRVqVvC/GBu1oSigEQC+vOy97ewZq5YUbl1+V9X18DYi7XKYRcuI/gA0QC+nr3MNYK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564650; c=relaxed/simple;
	bh=Gnx9iDH5s7alpx/BCcLg7QX+0qJRXyLnhJQX1zlv3z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/S5IxAfvUSy8N2MrNXyEvYA9Hcjp69sGeoihG1xABV0n7tsOjKKZF7zCbLU9TKjjU3zXehPdpvvKuFNsgulceOOXrb4APLiefTwbPVoHFA2MDQ097TvgpU6K86zGDO8etOGa0hSBYgemoFsK3FVxqCYI4qR52v9wzZcrWtb4aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWP3jslh; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWP3jslh"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-49ff971e903so187023b6e.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 12:57:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786564646; cv=none;
        d=google.com; s=arc-20260327;
        b=bW3mW2ZXpV7Ub+ZoXR6KhVdTUt97sQbBdN5HK0g1upHzmL7oTvcUL2J+cV5kSQGs8h
         /r5+mNxa2doTLajCUBcM7FjoRBU+3G3uY+eK9O+swwEyrFhCZqskaF2qyNZy8QHWZYsc
         CV8qzSzzcHfkvCWZSkBbyK+aPC6ERwJTTWbEkJlEn0CiPTbyEDnKcQsDjqt6V022uiyE
         Rv47jhi9m9LJSaBMSSuF7AQMK9XdxA7IdxHsu4TU6XTPNt5UdtC34l9AnBDftdM08tbG
         eu0IqVE5aKpzf9Iialhbvs8e017XKlPEX2zYfoT8xm2kIe4foVLueUF/hN5xJRr5+giM
         O56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HiZZoZcmxMbPsHi05Yxk3SMlmj1Brps/8iB5/2odSw4=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=CKJ7MTCiBfnKNGreAv8/JOP5kSrzaabw7/XB/rTJTwj37mK2wOeiFXYxurWWJ0dl5O
         aXmCnWXgUDoU6vXGipooj2fGgrGdcZX2Pw5hoJXrFCIWenBhS47IDSQSz/CAKzOn8lPb
         C1zidTOd6W1tlXSHUOCVtgVtxNegEHl3LCdsY1cA3gHc/alpC3Uq/DAo/p2w3dcPAaKk
         86CIzOgC3cqWb8H7oLqx4QjRfZGqxHta0U5LdEHFpjJQkAkoYlQPV15K/qV4GroL3ZFP
         y8jKEyH1NkPmR1lGMNI6SVJTA5UwDSYnB1v/zwaNlXof9U3X8BUf4iiebTChEh4uUH4i
         L/aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786564646; x=1787169446; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HiZZoZcmxMbPsHi05Yxk3SMlmj1Brps/8iB5/2odSw4=;
        b=kWP3jslhgcexJsfMvYAcCd9wjh7YbLg/8OZdWL5P4aRuSrNki+kLFd8PQZRWi2rbNo
         dvgczyLm5Kqdq6kefHElbWWq6l29Dd11+OJRtpo0BzLvBWp+Bkl2XHFTtFxVaHu4DYW3
         fszvBhfa+NOk6Vb/kfcfprL+X2CL/zMPP+jfToFg3GpPKfs3p4NBghtcgxKrjafibaHn
         KxNyTOK2fTXQwEJp/G8tRhwiu11g36iO+eX8PM4CEW9VdGAo/QfXVfiQt1Xlk4SD1agG
         fEUz+NO4NjDu2b0qM+/SeCmWqq67cQJUN1tI3ChoUzlrPJgkafs8nBcXnQVf7EQ9mQJb
         dKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786564646; x=1787169446;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HiZZoZcmxMbPsHi05Yxk3SMlmj1Brps/8iB5/2odSw4=;
        b=LzyP5flx0X7roQTcogzhHWdqyy+sKxqxeOQT6toGBLy+XdxfQJ1fyKyhMhH2cqAUoJ
         I/Dem6DpSoDhQrmvQ/rXsH4XqanzaYLFdv0lv8VfTbH94J7J6X5zYN3VztuQVmw50pNt
         j3YRWh+iSdbOo0kSWWFTEr64IzhXmAk+1QIS7uahVzFhIzCsvTDfje6+C3QP4EgnTKnG
         59xKgfentO1ohmK8uRGqNdNxrt4dxJYl/NQro8asiJvKzCsmfpFGMVd/67yZ+JDXbzHY
         XQlUPHR28iJYyBHSH3W9SRM59JlLJenozGxEuKfLaCmOkbiYnIx20bly+BUOiRruvv17
         oT2A==
X-Gm-Message-State: AOJu0YxVJ3ZDO2/+CMq1d/VmrhptJ3uZE6SehN/KNt7ZdgfgBluBb5fk
	uIsYfC7BPAJIVTx12DLGGLTxGAJB1wMKv3QOuxr6r4clVI+3PJVzoC/wFfvBoDCO41HkUZkHLwI
	hzdYjSFpJdGzAZqEsq9YoUhXRUgeb0J8=
X-Gm-Gg: AR+sD12iSUCm/X29dy0D9H628BDC6SOzNParY+TuTD+gNOy92IzTte2l/Gjz3nCqycH
	RA6PzogKB8g+xR80x2jnAfN29FlqR9v4sqbGipyB0WuA0LKwdmgiwZM1bPFsfilm8RbkJ3z6fuF
	ZdKb84e4SNIpFE4fYnGRfYifgZMrwL4OXlZzeDbMgpGbSzfH4wIZ/GwEGZMPe7N0c5y/4uocYg/
	om9Tvl4kGeuTdII4LPZmmuZOZL7Y19u6P5EWcKrxmJoD7zgy7VIORe4RrI5CYuBOo9mcs3tJDqz
	6NWe0pLiTe6OjZHM+RDp8hUwSkRAHU0SIHgwLgrDPXAq34wViYub3OX1u0hfKMWnddq0Ly6xS30
	yWINZzRksfux1dOUwIODd3nfJ93UFdz8p2keCHb+6u9Qq/+8Eh7lNXU5yzNznbnI=
X-Received: by 2002:a05:6808:c187:b0:4ab:224d:6dd6 with SMTP id
 5614622812f47-4b22833d38bmr125198b6e.15.1786564641237; Wed, 12 Aug 2026
 12:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq7blx5oor.fsf@gitster.g> <20260812164846.2236221-1-gitster@pobox.com>
 <20260812164846.2236221-4-gitster@pobox.com>
In-Reply-To: <20260812164846.2236221-4-gitster@pobox.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 12 Aug 2026 12:57:10 -0700
X-Gm-Features: AUfX_mxTIC9lhnF_XUiNuk9Nc3hg4oSK-RSDVJpnK3Y-zFtKA2RJ55Mc9vktpSY
Message-ID: <CABPp-BFv4uf0F1PxVYRuQDbJQWw-YFDNbr1QRUVZxadsexbu5A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] completion: 'git checkout' completes untracked
 paths as a last resort
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 9:49=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> We taught 'git checkout' to first try to complete revisions (unless
> '--' is present on the command line) and, failing that, to complete
> tracked paths.  If this yields nothing, it lets the Bash default,
> which offers paths in $PWD, kick in.
>
> Teach it to complete untracked paths before giving up and letting
> the Bash default kick in.  With this change,
>
>     $ git -C another-directory checkout un<TAB>
>
> finds the 'untracked' file in another-directory and offers it as a
> completion candidate.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  contrib/completion/git-completion.bash |  4 ++++
>  t/t9902-completion.sh                  | 21 +++++++++++++++++++--
>  2 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 0eecfcbf8b..22c53697ab 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1784,6 +1784,10 @@ _git_checkout ()
>         if [ ${#COMPREPLY[@]} -eq 0 ]; then
>                 __git_complete_index_file ""
>         fi
> +
> +       if [ ${#COMPREPLY[@]} -eq 0 ]; then
> +               __git_complete_index_file "--others"
> +       fi

In your completion series for `git diff`, you passed "--others
--directory", but you omit --directory here.

I think playing around with it for a while that it works either way,
because without --directory __git_index_files splits on "/" and only
keeps the leading component, but not passing --directory means it'll
just have to parse through and then compress more options.

It's probably not a big deal either way, but might be nice to include
"--directory" here for consistency with your diff series, and because
it'll be a bit more performant.

>  }
>
>  __git_sequencer_inprogress_options=3D"--continue --quit --abort --skip"
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 13fa5c65c3..e8418f069b 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2727,9 +2727,19 @@ test_expect_success 'git checkout completes tracke=
d paths when no refs match' '
>         EOF
>  '
>
> +test_expect_success 'git checkout completes untracked paths, too' '
> +       # ufile is not tracked and there is no ref that begins with u
> +       test_completion "git checkout u" <<-\EOF &&
> +       ufile
> +       EOF
> +       test_completion "git checkout -- u" <<-\EOF
> +       ufile
> +       EOF
> +'
> +
>  test_expect_success 'git -C <path> checkout completes paths in specified=
 repo' '
>         # otherfile is tracked, oops is not
> -       # lostfile is tracked but lost
> +       # lostfile is tracked but lost, ufile is untracked.
>         test_when_finished "rm -rf repo-for-checkout" &&
>         git init repo-for-checkout &&
>         echo content >repo-for-checkout/otherfile &&
> @@ -2738,6 +2748,7 @@ test_expect_success 'git -C <path> checkout complet=
es paths in specified repo' '
>         git -C repo-for-checkout add lostfile &&
>         git -C repo-for-checkout commit -m otherfile &&
>         echo untracked >repo-for-checkout/oops &&
> +       echo untracked >repo-for-checkout/ufile &&
>         rm -f repo-for-checkout/lostfile &&
>         test_completion "git -C repo-for-checkout checkout o" <<-\EOF &&
>         otherfile
> @@ -2748,9 +2759,15 @@ test_expect_success 'git -C <path> checkout comple=
tes paths in specified repo' '
>         test_completion "git -C repo-for-checkout checkout l" <<-\EOF &&
>         lostfile
>         EOF
> -       test_completion "git -C repo-for-checkout checkout -- l" <<-\EOF
> +       test_completion "git -C repo-for-checkout checkout -- l" <<-\EOF =
&&
>         lostfile
>         EOF
> +       test_completion "git -C repo-for-checkout checkout u" <<-\EOF &&
> +       ufile
> +       EOF
> +       test_completion "git -C repo-for-checkout checkout -- u" <<-\EOF
> +       ufile
> +       EOF
>  '
>
>  test_expect_success 'git diff completes tracked paths when no refs match=
' '
> --

Looks fine otherwise (as do the first two patches).
