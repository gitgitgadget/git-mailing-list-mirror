Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888412595
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 08:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiWjN9wC"
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E30EA
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 00:16:53 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507975d34e8so7729511e87.1
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 00:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699345011; x=1699949811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57IYdOC4+kVmSzmltpKQspU5GUqytDQX6yIspgtwr6E=;
        b=TiWjN9wCBgfy5qDHmRd6Qmnxll+2+TMWXT48nS4XQVUNtNKJQJmeVWW1iMGedKHy6A
         jvytOUZoZkDorzLMkJEpMO1srTLZNDQKjo5QOrXBsO8KkAPXp7c96zaUlAjUNOSnzwLT
         bbmT83TXabG2NzMtZgrJJ1cMm4r9bZM6I/IorSEDCkueiM2OSycLDqML1LPOaOFl0pJZ
         nrxJoKSGAealncDcOJNYzazkqrMCxJGjbKIpEmkbpoh+fXDOWRM+rIcavRvOI4PV21YX
         ZwXVtpogwhvddCY5IvMzAE5T7mszNw/vyYBrN31ZON+oTr022UNYGtT523h8kexDUyz2
         /13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699345011; x=1699949811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57IYdOC4+kVmSzmltpKQspU5GUqytDQX6yIspgtwr6E=;
        b=rKLHUUR8VW5SAnYl41eTmf5niuLQJLeNFDj3sYieC6goaLUmYKl/luZEfRH7ZvCj1D
         KcVHtIxFV8NB3cwhVONhPmOEb2mbBAf9By4id33eAMLDVXk6bkdf3JsXh0nCp+2hF1xq
         SqORZjlei/SiLf9HQXl3gO4/2jYggcDR1agkIOlE0k+2bPFf0MNp1X+DdakAjWJVolNG
         PuwaJ60cb0OwnDniOCQlBWesOmAJshbQ/Adi5FDhXY/06b+OKpELT/6leMY8L97upaof
         8ID8f9AHJWA8aiqo05LIWHEQjw1mrFev/1+bsBEZ8SX4NkqMUIWLrX7ym+7vHZFnvu5/
         Cs2Q==
X-Gm-Message-State: AOJu0YzMhz5j+wcYU//FywBTQ/JRQ+gNleH6cTetU50WuKOX3jwlVESZ
	CNUW34y4gOVoODEB4WXEKS4rBgMLvnRQcezBe5OhwZ+B++Q=
X-Google-Smtp-Source: AGHT+IFuVL0CF/C7YX3W2xdx9M8t8hrc6NQdy7jdUwQpqLKirwPfhn29HVF9inkBtuY2u80gX2rpNiJP855y54U45q0=
X-Received: by 2002:a05:6512:3195:b0:508:269d:1342 with SMTP id
 i21-20020a056512319500b00508269d1342mr29425468lfe.35.1699345011314; Tue, 07
 Nov 2023 00:16:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87cywmintp.fsf@ellen.idiomdrottning.org>
In-Reply-To: <87cywmintp.fsf@ellen.idiomdrottning.org>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 7 Nov 2023 00:16:39 -0800
Message-ID: <CABPp-BH7WBm1j-Ue9oZFjoy6sTcw5B0hz_ndDEtJqvpZF4YF=w@mail.gmail.com>
Subject: Re: first-class conflicts?
To: Sandra Snan <sandra.snan@idiomdrottning.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 1:26=E2=80=AFPM Sandra Snan
<sandra.snan@idiomdrottning.org> wrote:
>
> Is this feature from jj also a good idea for git?
> https://martinvonz.github.io/jj/v0.11.0/conflicts/

Martin talked about this and other features at Git Merge 2022, a
little over a year ago.  I talked to him in more depth about these
while there.  I personally think he has some really interesting
features here, though at the time, I thought that the additional
object type might be too much to ask for in a Git change, and it was
an intrinsic part of the implementation back then.

Martin also gave us an update at the 2023 Git Contributors summit, and
in particular noted a significant implementation change to not have
per-file storage of conflicts, but rather storing at the commit level
the multiple conflicting trees involved.  That model might be
something we could implement in Git.  And if we did, it'd solve
various issues such as people wanting to be able to stash conflicts,
or wanting to be able to partially resolve conflicts and fix it up
later, or be able to collaboratively resolve conflicts without having
everyone have access to the same checkout.

But we'd also have to be careful and think through usecases, including
in the surrounding community.  People would probably want to ensure
that e.g. "Protected" or "Integration" branches don't get accept
fetches or pushes of conflicted commits, git status would probably
need some special warnings or notices, git checkout would probably
benefit from additional warnings/notices checks for those cases, git
log should probably display conflicted commits differently, we'd need
to add special handling for higher order conflicts (e.g. a merge with
conflicts is itself involved in a merge) probably similar to what jj
has done, and audit a lot of other code paths to see what would be
needed.

I think it'd be really interesting to at least investigate, but it'd
also be a lot of work, and I already have several other things I've
been wanting to get back to for over a year and haven't succeeded in
generating more time for Git.

Anyway, just my $0.02.
Elijah
