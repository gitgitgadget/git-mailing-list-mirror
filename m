Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBB744A3F2
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083500; cv=pass; b=go8YxMiCrVoEXWASBLvB3um8/iFYUb9wbljhIZK6j4M9KFaFznhnh6Bcc8lcAvQNIQV5Db3dMtYnA526jgyIDuJI1Oz/Gx7C9x0PjVdKAWjXrQPN0QD5nsIiYqAUage6QINRvxrz1ZY0p4EM4F8Z7RupMmD1EkUSmkBrxO9zRr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083500; c=relaxed/simple;
	bh=Kwq40FXd9U/IT69Mp5aESPYYHpz3uZgCFoqx3bhMJc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkQVCoD/u7BMXRw3UPugXpyMW3Rxr742I6bEbAxTbrRnzKU9h5YhxM7L+yTrTSc9iUMSaJrzhtdAfZh0LJ4CEfd98gi+yDj2fnreBC4Wb+e/hCnl8IsQvZNnvV78bXsk8/RWLivQqS41jyYKoZ1GlhiF1SYXzB0TBj0XPCgekoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rcDqcnEA; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcDqcnEA"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7ec58fa3e01so1606286a34.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 23:18:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786083497; cv=none;
        d=google.com; s=arc-20260327;
        b=ie2Tf9B2N9f/L4CYPbjXH5t7p1z0+hjOMEWwbO4ICzPtVfTV8jGxRMi2ssd3Gu2WRE
         4nU4DSD5f3znlaNOiUCeIjxlxdSYq+xn1FUDklPCecz5H76ydjYYXKRovxooNUROYwob
         HVzSYM+u4v5aQyKiIzm9vvZPHfvHme8ps7KBnQxShtx23/9Ss4gb4brVeh2UKFwfdZ+S
         0Yy++1HV7KAARRM/06WSZO5Lov/MjfFVBSxcVYUmoP6jX9zRLy+5R87sl3O5bUCQKtkm
         +/YczfisBJ68YxI4pJG7JLl6iSppagZ7MO6BwGqGm6MzG3GwPclVGX6DlUDoUQkHRVLs
         5VJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mpKU+h8DQhFZiE3n0uakTrLO3Nyi3RpXdr1xGxJNc/k=;
        fh=K+nwAsTgvJIY4kMWVokCW6lJIm9qzCyizIjWP69oThQ=;
        b=JtNU8ULWJVbAFCfrNNSidvZKe3HqqdLyPKg93C8gSd++xjA1crLAz0ZxOwQaWIIcdy
         fUOR4x5gv/rIPzOZ02Xb6LNwaTfo1964vKSfzfS536F2FoKdx124t/vkgiFQtKpgVcH7
         IgGhYInIpbzjOu/WRH8t0V3P909FafwsduQZ2HRQFW0lcwKKGJHgOapz/w1+Jv2LPET/
         o2aGexvpCjJ0PmZ1SMeR/ZmP8RBKZOA5ymdGciI2ZfaHMOsXzF5Awnh2vnJgxJJpDvl0
         2MOuJeH9I85X3hKujx/rPnPbu39EAKiFXIfvSTFKoxxDkdGVTqJ1iu3IhgT4neVQ5lb6
         EbHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786083497; x=1786688297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mpKU+h8DQhFZiE3n0uakTrLO3Nyi3RpXdr1xGxJNc/k=;
        b=rcDqcnEAY1x/HRtt5fl2NT3dBUaRaDlRzvi1Xs3KMwt8ChMa4hSk/Xp1xY8CQU/7J5
         SmBLNpi2HjGEx5ZeHs7L5IQrrsLvMM5zF/lhsz+7ZjNHBoI+KFPMlzdXzg7+BUB+OuNA
         kIUlVazMshgRelXCe6qqcWP6FdGcPZ3Zq7XMKIA7DMp5CkLSsRDEDGm7WyUKDMwbpZXI
         zzMNmawSvnsRQX+3VNKHG2/XXGrzFXRNG9OCtNd0WMS1eEOf+9JGHqJgzgrnjEM8XGwc
         tNeZVZ+w7HxHnXttpLnYZpqZyDw+8kOalyVGdPhc+Z5MtUHWnU5EajiYkZBropWsqetX
         sfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786083497; x=1786688297;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mpKU+h8DQhFZiE3n0uakTrLO3Nyi3RpXdr1xGxJNc/k=;
        b=LNHn6iEYyWDLtPuyU56xEpKfqfEuMFJaSQXLJ8zUa910pBy1r4MOeuULXQ3WXp1IIU
         ry6gM/K9a0UHhdTmQTdjgQWBpVuQW2qS+xpw+Wtmk/kUyo+UNu6mMa2Lm3eBgCjNipOs
         lhPsmyQlcC37C38we45aT8PBoxbKEK+mSQd+yikMUL+yyBxGOhR7Spy0QyZ5n/f7fMxS
         un/fkgWY1U+nIeXIVNJe95HJ6c3RK+P20TrzvvnZ8MKDQmvFVOwcFBB3K5Uky/evj2xr
         IgK4ryA1zkBHoXTd4jVjSPRXpjhibckdH4uwYPUD6v6Auntf0snu2F22fRixcva77n70
         /ITA==
X-Gm-Message-State: AOJu0YxKhlRcC4RSHiMYrgo9q5U9xTMSjKdzVuUPrApUzpbiZFdGCdVM
	e+f608zcvV4Jhvlua1Q/MWbmm32lkQK00qY/n5oJUZ7qEZMGsnCAA9qkwb3qGV6Lx1IAewqJgpo
	oXNKNRAx/O7XvXdAgHQMOV6NAY0si+P0=
X-Gm-Gg: AR+sD13EShLbEXQ75IgOeiXMQxxbsDuyIa+5dfc+ItsVbxwy3hwMTHSsiykMD4lSeP/
	xgbl9XB3nRLxjPnMML9Cu0FoSmKFNRMAm8/8zhnCG7kN4CMFRRzmhA3GtayHL+zTpNbnI6cCtdh
	jZBJd8LY8qFHRj7BRaXpvpFzavwp2ZqprO1Kmqm4K4h6UDd/WNNi6BDPWwXhIj9ZrIGGpDZf5yt
	r9aZ5aBcpDFrsyCFPfo0Lov1a+F81ktaMhFC/Zo/6wOcRpKIilJ9VmuJIPAzGqNkzQr/ezmt+Tg
	a66u6byNGao7Q8V5NFJGtxrcigiJ1OyG/sWPlvDyPwOqD6gDoyD6SQW7y4Ozs2mabOlBRuOktWz
	40qXFZm+5ZG7fyfD7eNHo3G7ukGYlFlt3XZbkiaQ94Wrh/4ZdcYssVIkvukjwDms=
X-Received: by 2002:a05:6808:1443:b0:4a4:12c4:9c16 with SMTP id
 5614622812f47-4b1a0e40450mr719590b6e.7.1786083497364; Thu, 06 Aug 2026
 23:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcxw010me.fsf@gitster.g> <20260807013830.698340-1-gitster@pobox.com>
 <20260807013830.698340-3-gitster@pobox.com>
In-Reply-To: <20260807013830.698340-3-gitster@pobox.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 6 Aug 2026 23:18:05 -0700
X-Gm-Features: AUfX_mzpzh7-TiIoOT8KOaJgROR2tjdiG-4xs30s2guQrb63ckzT_cR5Cbn1920
Message-ID: <CABPp-BEAtpT208afwSNoBbR-Nowss8OsLsL8ynETuBfN_xvWag@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] completion: complete tracked paths for 'git diff'
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>, 
	Britton Leo Kerin <britton.kerin@gmail.com>, =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, "D. Ben Knoble" <ben.knoble@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 6:38=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> When completing arguments for 'git diff', _git_diff() delegates to
> __git_complete_revlist_file(), which only completes revision
> references.  This is good [*], as mixing both revisions and paths in a
> single list for the user to pick from is simply too confusing.
>
> If no reference matches, or if '--' is given, however, _git_diff()
> leaves COMPREPLY empty.  Bash then falls back to default filename
> completion in $PWD.  This fails when 'git -C <path>' is used because
> $PWD is not the target repository.
>
> Update _git_diff() to use __git_complete_index_file() when '--' is
> present, or when revision reference completion yields no matching
> candidates, so that tracked paths are offered as candidates.
>
> This changes behavior even in the case where '-C <there>' is not
> used.  The new behavior omits untracked paths from suggestions when
> no revs match the prefix but matching tracked paths exist, which is
> more useful in the context of 'git diff'.

I'm looking forward to using this.  :-)

[...]
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index ccd3b2a372..845fd19f70 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1981,6 +1981,10 @@ _git_diff ()
>                 esac
>                 __git_complete_revlist_file
>         fi
> +
> +       if [ ${#COMPREPLY[@]} -eq 0 ]; then
> +               __git_complete_index_file
> +       fi
>  }

Curious; __git_complete_index_file() is documented as "requires 1
argument", but you pass none here.  As far as I can tell, it works
anyway, but feels like an accident:

1.   __git_complete_index_file CALLS
      __git_index_files "$1" ...
      (Here, "$1" =3D=3D "")
2.   __git_index_files "$1" ... CALLS
      __git_ls_files_helper "$root" "$1" ...
      (Here, "$1" =3D=3D "", again)
3.   __git_ls_files_helper "$root" "$1" CALLS
      __git -C "$1" -c core.quotePath=3Dfalse ls-files
--exclude-standard $2 -- ...
      (Note that $2 is unquoted, and since it's empty, it disappears)

It seems like it'd be better to pass an explicit "" to
__git_complete_index_file than to implicitly get it.

[...]
The rest looks good.
