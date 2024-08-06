Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE2B29422
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967516; cv=none; b=hHrXtm5dfHYA+lK4VowpHCMK8FkiMY/qcXA2lI6yNi1hk972w33f86ixBCjQxADFsxwfnGIRq+lDIpIHHxJkuwXSdtordt2KlpIzaAxKhFa0/+QQ8X5dE30ArOyVnn1KKoZI+/AOUZZSD6RKjv5hNNR7hTTzIBOhKRvyLO3aYZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967516; c=relaxed/simple;
	bh=PMJfYMuiD5isIYQ2sz6sYeKodeZtTg/LcJkJTb7/xkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6BGl5XsPN3mC7mk1sIiWjjHwm92kRgKXmMgjT5gTOkpVSGDbtvGVaxZ5O8Bhb7U4uW0jgxxilzIcJ9qEjvY7OeJxkYdfIm0WmcEMmvSTQNmTog3i/PBf7XwptUGRh0zwwZqYsnWWQLTSPKquFzOVK4Sva6hsntXxR5u4xOg2mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b79c27dd01so5030926d6.3
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 11:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722967513; x=1723572313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPbj//Ob+XG8w+ROh06zqH4qpbWgKDYrYFzi6EF3Qo8=;
        b=HgDvFn2h/zGW2DLBiNcSxSBDIirX8aTJmGN8cPOm0oE678aGY57PgqQ5n/NT+QtSNq
         B6gO0knXVGZ2+8Q5KarLChl8nh1zzhrhDOwReGYVnwVdN5bt/shjPKmlZmOlK3bel7Zi
         pwLqFhJ2uz99ejysmCW9u7efOCQw08ehnI7MY9mpKuOViV30vfpXz53YSUXNh4I7+0am
         61J4Yr1Ubrnj735Z1EGChJoac0nXd0hQ2bTrBy6SzBfPw9txK2CL0XC03QGDNytx1YDS
         z3z/91b57XnHXRZYfz4c9zmu6V6vL1FpXoLYB0TDcpY6E80CKy4eDf7nC0t9oErKFrSA
         jlaQ==
X-Gm-Message-State: AOJu0YzppbLe7KBh3C0+WeXhiRKa/bARdn9lG9pv6Sx+b0AxWYhNczES
	RJFBe5tQybogIAk6V2Bbhj/6/AfP2NNjRxhAgcDN+0uKs+L1uEWePhFY0wbpVGL9tJWyaJVcQJs
	WpF6xJtEqO70UNk5+WP0gpsEaZ3c=
X-Google-Smtp-Source: AGHT+IH88U+Gf7MjmiD4d4BnqeAxMArIwy06e5R95k+BGjJhll/aPgTcamhtjONEQY4GkUiHAHUpnwqNLdImImvmPt8=
X-Received: by 2002:a0c:f409:0:b0:6bb:b9c0:6480 with SMTP id
 6a1803df08f44-6bbb9c0649cmr5541276d6.4.1722967513290; Tue, 06 Aug 2024
 11:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805235917.190699-1-abdobngad@gmail.com> <20240805235917.190699-3-abdobngad@gmail.com>
 <CAPig+cS6-gqZbJSz3wBcummyycJVudKybVZW=D33WHk-Fa9ytQ@mail.gmail.com> <3cba795c-631b-4e86-a1f2-ddefe76ef0f4@gmail.com>
In-Reply-To: <3cba795c-631b-4e86-a1f2-ddefe76ef0f4@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 6 Aug 2024 14:05:01 -0400
Message-ID: <CAPig+cRQSVZrOrHUaQCG91PbWpgUEbpFVAM5sriRgTSrkCnMvg@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] [Newcomer] t7004: Do not lose exit status to pipe
To: AbdAlRahman Gad <abdobngad@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 4:38=E2=80=AFAM AbdAlRahman Gad <abdobngad@gmail.com=
> wrote:
> On 8/6/24 06:13, Eric Sunshine wrote:
> > On Mon, Aug 5, 2024 at 8:00=E2=80=AFPM AbdAlRahman Gad <abdobngad@gmail=
.com> wrote:
> >> -       test-tool ref-store main for-each-reflog-ent refs/tags/tag_wit=
h_reflog1 | sed -e "s/^.* //" >actual &&
> >> +       test-tool ref-store main for-each-reflog-ent refs/tags/tag_wit=
h_reflog1 >actual.body &&
> >> +       sed -e "s/^.*   //" actual.body >actual &&
> >
> > It's not just `test_tool` we care about; we also (importantly) don't
> > want to see `git` itself upstream of a pipe, and there are many such
> > instances remaining in this script. Here are some common examples:
> >
> >      test $(git tag -l | wc -l) -eq 0 &&
> >      git cat-file tag "$1" | sed -e "/BEGIN PGP/q"
> >      git tag -l | grep "^tag-one-line" >actual &&
> >      forged=3D$(git cat-file tag ... | sed -e ... | git mktag) &&
> >      git tag -l --no-sort "foo*" | sort >actual &&
>
> Thanks for the review. Could this be done in a separate patch series? As
> modifying a patch in the beginning of a patch series requires lots of
> time to adapt the rest of the series to the change.

As the person doing the work and submitting the patches, you choose
how much effort to put in. If you feel that fixing all the "`git`
upstream of a pipe" problems is better left for a future
"modernization" series, then that's almost certainly fine. Since
reviewers are trying to help you polish your patches, they usually
prefer to review shorter series than longer ones anyhow. If you decide
not to make these changes, though, be sure to explain your decision in
the cover letter so that reviewers understand why such a cleanup is
missing from the current series.

Having said that, if you're not going to fix all the "`git` upstream
of a pipe" cases, then you might consider dropping this patch from the
current series since it is merely touching the "tip of the iceberg" by
fixing only these two minor cases while leaving all the more
significant cases unfixed. But other reviewers may feel differently.

If you're worried about the ripple effect of making significant
changes to this patch which sits near the beginning of the series,
then one way to sidestep the issue is to relocate this patch to the
end of the series. This is possible because, unlike many other patch
series in which there is inherent order in the patches where each
change must follow the preceding change, that is not the case with
this patch series. The specific order of patches in this series is
pretty much immaterial. So, moving this patch to the end of the series
would cause only a tiny ripple since it touches only two small chunks
of code, and once the patch is last in the series, then it becomes
easy to apply all the other "`git` upstream of a pipe" fixes.

But it's up to you if you want to do that extra work. As noted above,
reviewers usually prefer a shorter simpler series over a longer more
complex one, so relegating such fixes to a followup series is almost
certainly acceptable. (But be sure to explain your decision in the
cover letter.)
