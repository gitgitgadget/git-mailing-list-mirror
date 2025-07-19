Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E92823DE
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 00:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752885134; cv=none; b=UM63P8ps8QBbcZ+HauBQxEfR2L7ywL/Q4Oq8iYpuKBjxVydE4iRIWZnbx1LntH5RfZhKIxXTT6yI2/RDpexia8ukkTjfmUd0K9PKk+/+ll/akWhD2EPdBgwpRK0wL2OYL3hzS8QiXWE+LAO/Pi91C8/rAbUXL+oBX2mkc5RMcV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752885134; c=relaxed/simple;
	bh=lEtVkDEhFw4J+BQeCqhmtjvsm4Noo9ndh5tpcoYL96Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhtLQtBa54JCwf5BSykXvHgWWgcdhTkvv8tyM1/tzehyiRxkM5uxk8gDmrhnD0sqXonv8eW1rimaYMIAwKdYjbTE1eNExDlRLCRP7nyftGvDSORhlyPIPmY2VUuLWYUYiN45NPHz5Aoq9neky8VmtnW9js/8C2YVW95M6//VsEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1Q+3yU8; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1Q+3yU8"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e293a3b426so14236005ab.1
        for <git@vger.kernel.org>; Fri, 18 Jul 2025 17:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752885132; x=1753489932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyrqjjuNGkHbuhEr2i9cvq1aUgcX5tufdd7EvXPEPQ4=;
        b=g1Q+3yU8bMXIFHu8dA8O41Ohkqd9A4tt8H1SomIDweQ8zKEFRHkrbdu8SyFiL478hd
         Ovqa2FUTQNIqzeIbCEyFBTWIzwa2lqfLeYisdI521pVupKN2s7I4xSKO+0RkGDHpM7F5
         o2OnIyJ16b0yqO2gGBg8wt58Xo4Vv+uBzxeYDxP4qd2++21DfVq4mDPdm+47DMqzyE2R
         mhYoODH/HVEFlJvz6Txn4l/vnLiTtijGdRw8HFxf3xrMMO23apoyxiNGlFx2rL9gcwAb
         8RbFHXi8TuBCigDJJ31veUFygy4+pBpRTdFr2FqoLwYJe06cMDoIPrLVYU69cLy6a8lM
         zt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752885132; x=1753489932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyrqjjuNGkHbuhEr2i9cvq1aUgcX5tufdd7EvXPEPQ4=;
        b=ijLoTTmu3LO4uMz8G4m+QuhCP/+QfUf/Zw2zXdb/0qHY+TtDHFLWnckncqR8cCrcp9
         1sQOiVJU9T7+AiW0fbaAV+HYu9qxp7okDZT32E4qOuXLh9NsgTRRzEYKRMDGDZ25NUbx
         XkhRwWZrNGSZ+I2renZMaX6eLw9q6AAs174tbGHjicEJrBpU4dEWG2sQpAUlJdJ0U9/Y
         xd1maPN6CJa6oeDY5eCXUtNQek5TWUAgSciOZbBzQ8gZ+hkEEn9tU3Qx2rl0iL+b2rnX
         Wf/HmSlzty2E6HzCgwn2O9DDgE2p50LqMrZeWThIatudkSgO/vSJOl3XQMjN14+7ZjNU
         7KZw==
X-Forwarded-Encrypted: i=1; AJvYcCUfIlxTu6DdL/XwF0Oc+foL2Pay4idRJoZqqsRsC2nGC8Kxu9GNdwO0fjODWVl4BEJlc5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5BHmB/2whXTIFjt85QiITRBe59eWVgkc9Nl1NmAG1oST4YR4B
	ulcLerm8iWLTWHDzy3GobP6fyQ9LVBCAxDaHe1WVwXNq4w8xexNAn7Rw9PkOqet1a9KSXgsaQRw
	dCGw730vfr8yMPPqNhHxaYStFshHGyO2Tbw==
X-Gm-Gg: ASbGncsRRSixDwr1GxQIGyRB1zkhu2RgKR8WBluLZCD5B9HnzH+BPqtdfonal9Ykuk4
	AtXvhezJwxruT0qKhEM/H1K12UYChfO9nqxA2x/4WWCHuMRT9mkwmJhvQAxS8kLO5XjUdfGYNNR
	CGWcjPw3zIsESbRSdTQAJU46RoJzsjphXVEAKSC8i4PL3uZpboJ0YV3JvGh8plKimwMvkTiVxkQ
	ZnnAM/WU8HUKpG3RNxo/JB71yudeiS+m0PmE821
X-Google-Smtp-Source: AGHT+IFNAX6I5nEDIxCFG+Q9fQGC6MSDIy7fesW45na+xybh0T8EEQhFQB7yl0HXoEl27qsHKt4VEfAiPHhwvVlRoIE=
X-Received: by 2002:a92:c24e:0:b0:3e2:a2c2:3fc8 with SMTP id
 e9e14a558f8ab-3e2a2c242camr981945ab.12.1752885131920; Fri, 18 Jul 2025
 17:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <aHoSjbV2nMZkBn5l@256bit.org> <xmqqcy9x4g8n.fsf@gitster.g>
In-Reply-To: <xmqqcy9x4g8n.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 18 Jul 2025 17:32:00 -0700
X-Gm-Features: Ac12FXzYuIYspfQR0k_xahLYsrikpRAGouQPA0GKpxbWzFBFIM_EwFRdQe9XOHk
Message-ID: <CABPp-BHH1gYrv66k1dmeE7+W2jPfcOCxEH4orKOFpze-kBcEQA@mail.gmail.com>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Brabandt <cb@256bit.org>, Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 9:26=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Brabandt <cb@256bit.org> writes:
>
[...]
> > Just a quick heads-up: We (as in Vim/Neovim) have been using gits xdiff
> > library for use in Vim and Neovim.
> >
> > Is the plan to get rid of xdiffs C source completely and replace it by =
a
> > Rust implementation?
>
> As far as I know, there is no such plan that is widely agreed upon
> (yet).

Yeah, Ezekiel just barely notified the community of his efforts
yesterday with this patch series.  :-)

> The discussion starter thread you are looking at only introduces a
> new code path that uses a different line hash function written in
> Rust when whitespace munging search is not enabled, and everything
> else still is written in C, but since it is just a discussion
> starter so far.
>
> I would personally have liked the effort to start with xmerge code,
> not xdiff machinery, for various reasons, but that may be just me
> ;-)

We have both xdiff/xmerge.[ch] and xdiff/{xdiff.h,xdiffi.[ch]}.  When
you say "xdiff", I suspect that you're referring to the files within
the directory rather than to the whole directory, yes?

I actually pointed Ezekiel at xhistogram to start (and thought he
might only do that file), then he backed up to xprepare, and then he
continued from there on to other bits of xdiff/, including xmerge.
Different parts are at different stages of conversion and testing.
He's not just transliterating but also trying to both clean up the
code and look for performance improvements (and it's sometimes hard to
do both; he's hit a few maintainability vs. performance tradeoffs and
those will likely result in some questions on the list at some point).
It's been a long slog, especially given how arcane xdiff sometimes
feels.  Anyway, along the way, he recognized the DJB2a hash --
something I certainly wouldn't have recognized or even thought to
investigate.  It led him to this optimization, which I thought was a
really good find, and it seemed like it'd make for a good initial
series to send to the list to get a feel for what people thought about
possibly Rustifying xdiff/.
