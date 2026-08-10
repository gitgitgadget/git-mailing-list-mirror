Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDC23C1D7C
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367107; cv=pass; b=LoJkT2/g7f4nweEC2P+O6N0a0O8jYfbDqsWt2XKowdg4bfhtxUWstEql3xhOYglJKWM/b4RMJ+fqGM57gTmhf9S0g4mCiAemFO1PEOczUQfcokozbh0rdtvSEucmEnqmDA1cPKzbqPiO9YellgA4Qq2ZxmryP/NL3Ec8YnMU9eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367107; c=relaxed/simple;
	bh=+umQucTXR0B+tMNBZuVrs6c4qiEH7qveEGnvk3EWme0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kI2r2+D1p1M2IQHtrnuGEne/guy5jZdZszJRdTdOzup0zCIL4OgWLUZ6dCvG8tY0HY8TXlQp2ijDvYkCkyF/XTRdPRoY8lwtJFAT3qTFJF4xecmHCYvAZSyBUac6t7OMXOgN7J9KqEnaIH1VqSyAnsDUezTMFnk4RJNQmDsyE7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tG2Swx5k; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tG2Swx5k"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66807ba2f0fso2765659d50.3
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 06:05:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786367102; cv=none;
        d=google.com; s=arc-20260327;
        b=jzehJ+qTMA6bbGfknqrgBoui/Wywg/aLHCFSSuBqQOmKnfD7xWm9cHBrM4JI0m6+Re
         EWMNHlsIGtVVk/2KC78grxr8T8Xt+EIpBGwCZsk/obGuWHwUzK8wlNyRS6MvJW9OKZ61
         6joQfoMw5q+rNjhYJeTnyJWK8nTYQDXgCVJtcN/fGiBYkUomhYyKx2uv7PEmn2XuqkPI
         LfNJIB0iv458/sveAhyyoTMN/qA47uLiaOeqennMIngdmqb43neGw7m5X42LiNIPnuZp
         AUeTdnPTehAhhOtw4GaDJlKby9+u9BsN9ExyYQXYjnlYMshwH4UwbONvyWM7RW3rqPEt
         tWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/905uZzNmpUeruCBubvPoO8SxSEjA9Zivmh5qsMeFXE=;
        fh=VebkeG72JfpKtbHNwMs0LxNQ4+sJM/jslP9O3LDZlrQ=;
        b=Btmc0tHUMVytVzZcn+L5Gs6VAjSKIwM17gvRQOaFFQdBtw0qizXwozVl9wVPayRTy9
         gkFJSbpwGR+U/eQwgFZz2rWK2JsEZfFY5+jmI88yiBYUUrMq4g/rVbx/NLiFm4Jpn8fO
         TfyfYwFTCZXbX3V6eyGcJZYh4f/VlH6mBUx/Owjk3deOs6lxFqmhiqousqpTUYBIlVKj
         +JNSbWmrWm2norSbviqTVgpT+hMmrKCIiDQaWITLYkXAJUNM7c2Kyrk966Mge4YbU0D/
         jAsLSTX0Py5U+zAbKNtbWT47V2QnEKXC3oOp6WBu9FGnoZncODPEMr9qxRVVey0GTfpq
         hDWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786367102; x=1786971902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/905uZzNmpUeruCBubvPoO8SxSEjA9Zivmh5qsMeFXE=;
        b=tG2Swx5kXLZ6mG3+XBHTGa5n0n3xmbtPPweOurf8kdRX7ko7e4Jn7BNNc/JOlOAGC2
         PoRiXovVpb8WWzhG9SyxXkh2Cwu7BRb7hFnThZ5r8GePb92r9W/6hYp/UTiISq5JjwZM
         WzLlRq65yB96cQ4kviPx7C2f3XdrBOpemyxORo5lPoH8cFIyNuOaTwZHCojd9SWwAyQz
         wcZoBbkdDtwkZtE2fL+1n1w5wA9qy+RUBVKM9bwJEUVCRKxVhiCU10yfkM3X9uOoG7Ya
         J56nDN//ZXV3YUMmgvfskVRfABRrc/yTMA2ohKTiPUU0uJ7rFbQ9/CmxQzHUvapEYdtS
         QZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786367102; x=1786971902;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/905uZzNmpUeruCBubvPoO8SxSEjA9Zivmh5qsMeFXE=;
        b=UoxcYNI5eo7SEQ0OVgzL01htjd6e4BY8h7kPa/3H63EZX3FKa8gvDC5DAuDcYwBwV5
         j/7dTtVtnLH7N/UzfxSxasLIdYAkGU7dNtsuUJkF6O4CmHOO100nZVZPP1YLEMsqbNsh
         210KVvQQo+uz0LWzkex4rlmKh4TKXeseYRTst488ldP33h1+laGvZrBGrtG7Z5LREFui
         55cBaW/wBM6OnQSNxlT1UU8fVjtm8fZLQphuKd9TLJ4LbzrT7KZBB3G7YDNLxA5BpZpr
         pMsR3HNh6JR5FCKW5fpIeA5EhZouZObpkv7d343RofvHDul7zOXQbPEvTq6vo2EN+cZ7
         CDNg==
X-Forwarded-Encrypted: i=1; AHgh+RqfQ5iEeBKyJ/rkAxH+sxCqkZkSx6L1+tnwvnlGNK6BlH8NXy4q6YjmnRmaZaUcuLPpRhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YytM+ihJBDl6oJ/6MtJeV3g5cd5ceJP/2zZ8pEkYgXAppPa+KWo
	kBDBmcvBMGEnDNgQB7d8I6oY06hfL0m7VHbVLCFIyuxlhwNKy68yqRI6hWbmunh/TKO/BAcpmvy
	oBXk7J2JGncKIMgOS6lCJHTuH1QYz7fI=
X-Gm-Gg: AR+sD13OovCwm2TqCwtzpCKXUl5btmnFHLnCC+OHJeeGgfXMOHK7+V0njEL+s68c1ye
	/tmEVR0XClxl2I7y5JvhtswdE2WACbIQgGxX7z8fsjMxvbR5zX4Z9gbqdOdZ9RvYIoHpUPOQZEr
	PbGB2in3adEKVMuECtC9NN/8Rbrm15FFGr7QA74S3UCBu4Y00KABtrvOd58H/TN+BaMDuABoYBr
	Aq61WkECmc5iUiioFRIaBMLQ75qakIMoQluqD0XtVtFxW7eNmsSBUWByr6O6EnfQCRBSiuRETOq
	FZSkwBzZ3CN7ZWKw1pJ/Rv58wgaD4tY0Fyq6bSYRzvQilvC+YxuGTXLfI/Vsp9ieV2VBJjNQY2k
	rq/3N5HAHsp5lkmOpfW5+6zeKEw1Z/idRXQ==
X-Received: by 2002:a05:690e:4842:b0:664:c535:ee36 with SMTP id
 956f58d0204a3-66ad73550cemr8275102d50.41.1786367102230; Mon, 10 Aug 2026
 06:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
 <xmqqzeywa6ol.fsf@gitster.g> <xmqqo6fc9swz.fsf@gitster.g>
In-Reply-To: <xmqqo6fc9swz.fsf@gitster.g>
From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date: Mon, 10 Aug 2026 22:04:50 +0900
X-Gm-Features: AUfX_mz3y88beeqMZcoHPb2BkbPdYVAp5SoQ23Lfh_1Dm7hZJCu2g7ep3H88DGY
Message-ID: <CAF5D8-vEwG=3rr99F4TW2WMJksts5BOZ+hoN0=kNkT6dUwqr1w@mail.gmail.com>
Subject: Re: [PATCH] worktree add: improve message for ambiguous remote branch name
To: Junio C Hamano <gitster@pobox.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 6:57=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> >> +static const char message_advice_ambiguous_remote_tracking_branch[] =
=3D
> >> +    N_("If you meant to create a worktree from a remote tracking bran=
ch on,\n"
> >> +       "e.g. 'origin', you can do so by fully qualifying the name:\n"
> >> +       "\n"
> >> +       "    git worktree add <path> origin/<name>\n"
> >> +       "\n"
> >> ...
> >> +            char *remote =3D unique_tracking_name(*new_branch, &oid, =
&num_matches);
> >> +            if (!opts->quiet && !remote && num_matches > 1) {
> >> +                    if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMO=
TE_BRANCH_NAME))
> >> +                            advise(_(message_advice_ambiguous_remote_=
tracking_branch));
> >> +                    warning(_("'%s' matched multiple (%d) remote trac=
king branches\n"), branchname, num_matches);
> >> +            }
> >>              return remote;
> >>      }
> >
> > The worktree.guessremote configuration is set.  dwim_branch() is
> > called when "git worktree add A/B/X" is run with a single argument
> > "A/B/X", which comes here as "path", and that is munged into the
> > branchname "X".
> >
> > We used to pass NULL as the second parameter to unique_tracking_name(),
> > so we were only interested in the case where we have exactly one
> > matching remote, and if there is 0 or multiple remotes with the
> > named branch, we returned NULL from here.
> >
> > The patch does not change that, but using the branch name, we try to
> > see if there are multiple matches, in that case, we give the advice
> > message to say "hey, don't be so lazy, as X appears in more than one
> > remote, so tell me which one you mean".
>
> Stepping back a bit, I think what I find lacking in the proposed
> warning message is not that we lose what the user gave us, such as
> '-b <branch>' or '-t'.  While this loss makes it impossible to
> simply copy and paste to reproduce what the user may have intended,
> it is not the end of the world.
>
> What disturbs me more is that the code holds back information only
> it possesses, which would immediately help the user if we shared it.
>
> The reason we got this error may not be that the user did not know
> exactly how to spell out the necessary information (such as which
> branch to use from which remote) on the command line.  It may be
> that the user did not remember some of the necessary details (such
> as which remotes have the branch they have in mind).  Displaying
> the command line and advising them to use the fully qualified name
> might not be the best approach in that case.  Telling them that
> they may have meant 'origin', 'upstream', or 'home' (all of which
> are remotes with the named branch, though we could not guess which
> one of the three to choose) may be much more helpful.

I realized that instead of placing a burden on the user, we should
present a solution.

When a multiple match occurs, the only decision the user needs to make
is which remote to select.
For everything else, the hint should give a specific command with
arguments that achieve the same
behavior as when exactly one remote matches.

Rather than presenting a list of candidates, I think it is preferable
to explain how to generate that list.
This allows users to process the list e.g. by piping it into a command.

I'll submit an updated patch.

Thanks,
--=20
Yoichi NAKAYAMA
