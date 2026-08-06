Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5234218E02A
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015870; cv=pass; b=Y6kJWRq01o/dj0GeGNyZ2K32xGerYnIJPiX22qUKMXZlkax32i3dl2MLbuGsvXRS7UL6qMXMKGroBt3Jk+EIGEJK19540kpt+Vsx3hOMY9vkQ0NRAxbmfN5uz35BN5tm4ixXk8RITpVbflIvqoR63jyAnPFpyYEKSrOwQphOMOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015870; c=relaxed/simple;
	bh=gzAvBZmBUp0h6aNyKGay1G8mE1R6FN/PsFOnInuMraA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7TKG03xksAPCmiglny6SwqVL2fm7uwUNHbtIORsPB3DD5iEo4qhjLnzWWFyoH4018YNaz+YNTcNU0WYQc8kQoW/gpbT+VChOkh7rw5quXIHxJh5WxDxIfEg/adFkhWGmchZcYVoQ/wYLFYjb+oe++CvHoie1Uw0/AKusDIehIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYCOALWs; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYCOALWs"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbe827e3cb4so385330a12.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 04:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786015868; cv=none;
        d=google.com; s=arc-20260327;
        b=nwwuFwn9xJiWASVG3qfbVD1D8VAr4r7dV1Nvcl8cRZmwJCbyYmFoJnXNyMH5MNEaP2
         BUXx4aVZmWzhG12OhFQLzqbH87vccI0c+oIwkbQi+XSpszIHQvwXGEsmak70j0vUmyGQ
         MEgbrUtpjdEoS3ctpvKUTZkRdeoA8XGHijlVnUZk75Dq9OsxBs+X/MFx76ksbdd5Qv3h
         z9HU9ytyUhRAs7JPNwPvYSBkSHpvWmGWwJ10btMiUNaYNGTNjqOAQCYxK/TA/4jjyok3
         Q/eYY5ui6gpOtmnm5VsGqYSC4Ae70+ed+tNn9MIYRj7onbQ5xzJMVA9qH00pK6MFPKt3
         pWgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g5gF0vKAGsK1iwyu1hjqgFt5Am4As+ZjjEheetVneaI=;
        fh=Gl1yUhNnY/d0FwAIaGoMwb0WkywJIt0FuZR+TDAfljI=;
        b=M1GNv6U64O9g8FSwBipWNsUwiA2pexTkGLrw80u1tUnOHviNnMIuSry75+oBoo24Sr
         EqcFawttUgqXs+IUvsPOdNJfNE9Bc3eptUAngCjH+35DYiVpZ9HUyy84eUOtnoRElcYE
         jQP8kcgsm79uRP5p8jBN01C55MPXbHebxh7cPy829mYrSdQxISGxvZ8GQfAmAtoy6o6y
         Zi/a/NWZSF5kQutMMFcsLtgryOjP15XAqVKHmctNeOyowKAWIDmK2z+CGZkYGNGJea/u
         Rm/jXUsi7pYQDv6N4tc6W3YtrCSslHqifD2yP78MGOw7Up/aTKHyg81XCKtKulyyLAjc
         3y2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786015868; x=1786620668; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g5gF0vKAGsK1iwyu1hjqgFt5Am4As+ZjjEheetVneaI=;
        b=YYCOALWsnq1FQt2WwH3CUdKQ0CMOH/OSd0CDooEMdRIq4b3YwBX9hQeQRYToq6IltT
         Y7dcyUsANnWxqDbOQday3Sh9SMrer1rZXhJ1pwjU43VbW5fwM75n21mSTIsWrzkOqodD
         sg0Vso4VuaKAoOwX426irMrkURnhucMA6+H8emDjIaOZyAfb6qMqlLfRlyXpWhtMqrCI
         w8t+ePFPjPBXkmlZgD56BdMA74jASaaceee72p+DaVplDnBETTrMGW5W/NJ2jU6jogPO
         3gQiZ3Vc2ANCkUrhHoYLCyxkjD49RFyFnxi16wMrLAWgWZ60EuQ2CW3CnDTfoHCyJ7pP
         T2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786015868; x=1786620668;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g5gF0vKAGsK1iwyu1hjqgFt5Am4As+ZjjEheetVneaI=;
        b=g6erWid6m4OIzTLH3yH2rlFOEjQZEZSDnOoGLGWkD86tjujUmvVZlmv+XwOL7QU9ws
         cXK9oRWnzLPCB/THCU28PUJ/kMzhsX6KToVre2HD0nWF4usj9rtoBH2RDl8m/Wfhu9ri
         ayes/fe9H4sJYUCa0RsS7ZaHszWQtvqCUdMxiq295YB1RjkTTFoZx3jyPbfoOQX7xBMQ
         qgEhqUNcD3zF6TIBFqR0q/u6pdHjeS4N+49NDcxmmPXdZPZpmBZ50+Y98oddE3jGQqu8
         0bZAYpZzdJMOtMhePWncL0F5dH6Dnp2DwsO5VnMGjdYUm3NwBvgHX1i7nIbUAdzFi0G5
         JHYQ==
X-Gm-Message-State: AOJu0YxnMxB/Aqrqs3Ofn9rW8wxePULDEszcGYY4nGdUBAeVFYXzR3FN
	GWHz4cj+dBnhkSiCEljzA75onq/54g6mU/8IR4h+Seb6jJJjWOZx5QoXA9y8ke/ZwVTzsdXkynO
	zpI1vc3i1Sow91S9jXcy0dDFDV4gx7XyoCvpsVME=
X-Gm-Gg: AR+sD133795yZhagqruTAGNQzV/qoTszlnekGthMO81Gs4GqDEWKkD2sclGBTmdTHO1
	Xe0QKT4ZYGymXMwS/gwCiPLUa6ZFqbOMZcKSmUM2wu2pe2ns4EoFa0PfNMjf9OZPtK7KzRzxuIb
	fxFIz63Ppp1Yc47UNfXneggp3wE9JMDLINZ6z0m982+gEreJItMEC9KXA/86ffNGKyOOj3LcYEK
	MUpX0fQkuhy6B36G0tdcXbKTut9+PzHp6csco6+6BlXwIvtwlM78NTGQE9gRZsWpDTubeYGR7Qe
	Y2qQQfuSG+fNUTBIubccb7nvDG43tXOvKoFnM97rMtKifwsn2ulmnC/HzfjNAq3r9RNhA+NiA2i
	5x6bCLiIyF9dFMxG6k+K3m7Jgq+UNqrLs9jb6GZwLKRdJTDku14fGyC65Kl/84aulZ8JM/WSt1g
	DkdGtQbGLHsQN5J1Otk1NRL65JvHTksA==
X-Received: by 2002:a05:6a20:cc0e:b0:3bf:ba48:ca88 with SMTP id
 adf61e73a8af0-3cb85e6b038mr17939375637.15.1786015868564; Thu, 06 Aug 2026
 04:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcxw010me.fsf@gitster.g> <20260805194250.3316220-1-gitster@pobox.com>
In-Reply-To: <20260805194250.3316220-1-gitster@pobox.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 6 Aug 2026 07:30:57 -0400
X-Gm-Features: AUfX_mxeU96jG7cWidoiO4nrWYkApIqA_qEVIezDSrk3kpsTAPQhFPPQevoLI2A
Message-ID: <CALnO6CAFYZb+x0W8sxLe8cicCuvhCZFrxiEJSRQs-aMF=cd14A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] completion of 'git [-C <dir>] diff'
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>, 
	Britton Leo Kerin <britton.kerin@gmail.com>, Elijah Newren <newren@gmail.com>, 
	=?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, Aug 5, 2026 at 3:44=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Here is another reroll.
>
> The primary motivation for this topic is that the command-line
> completion of 'git diff' does not handle paths (unlike 'git status'
> and 'git add') and instead relies on the default behavior of Bash
> command-line completion, which completes files in $PWD; this does
> not work at all with the '-C <directory>' option.
>
> Previous iterations of the patch taught the completion script to
> offer tracked paths that match the prefix before <TAB> to improve
> the situation.
>
> This time, we also complete untracked paths ourselves, so that even
> the following commands, which compare files like 'file[12]' that are
> not under the control of Git in a different directory, are
> completed:
>
>         $ git -C not-a-git-dir diff fil<TAB>
>         $ git -C not-a-git-dir diff --no-index fil<TAB>
>
>  1/3: completion: no-op refactoring of diff completion
>  2/3: completion: complete tracked paths for 'git diff'
>  3/3: completion: 'git diff' completes untracked paths as a last resort
>
>  contrib/completion/git-completion.bash | 69 +++++++++++++++-----------
>  t/t9902-completion.sh                  | 59 ++++++++++++++++++++++
>  2 files changed, 100 insertions(+), 28 deletions(-)
>

Left one comment on 3/3, but the rest looks good!

--=20
D. Ben Knoble
