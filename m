Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949A33E4C62
	for <git@vger.kernel.org>; Mon, 25 May 2026 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779699640; cv=none; b=IIk5M0nJ7E1XuYZmFWDOaKS1mDuqSZFZ6ZwjreaKemco/1D2Aq7jMw5+vdBjD0PAqHlpa570FjMbUE2Py8xDO06+QCSkLb9/UiC/VxzMFR9ZYbHLzgisqQNtH4UZ0rsdymN7VHlr/Z8UqxSEgopHRcrOpGDfNaSTrdYf4e2tAJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779699640; c=relaxed/simple;
	bh=MFDmHR69RdM1660iGiIiiigiPTie5uHCAUS/60Thekg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOWFQX7Y89QhnCbOhU0QFj4zoMPkxoULuY8RZ5E/94M4vpCv+wqIHLAkvnuLjHDXpblv9Lq/v2d4KmZAZQuuxsTNVQLnnyxGxo6CJcVpaNX/KOddP0fMj6WbNx+d/X1GhHtJRouJ75+57VcqRhp4x3awuKb9Kx5FGrfTeBy6L84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa2c25c632so4009840e87.1
        for <git@vger.kernel.org>; Mon, 25 May 2026 02:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779699637; x=1780304437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kfqp2UxwYUj54jyche6JcggTF+Lrwqf7kr67djDLBrQ=;
        b=Ct5Vbc/aQIxNmOfL+ewBgRIgTHyIxhRzGH6WRjKxAxxhLbmqlKiyA4BFINigJqeL/2
         tqImIE33rCMAIuvrHL0ZKHCO6dgOpmnd9wD9pS7/SGkh1WLs6pQWTi+Jf5lv1jmaOSwt
         VHZY6CJbb8vlZv0Ip+xf44ecJ2M34ysI192q+ftquyn89Pl4rUgyOvKhNt7uv6CoFo5H
         LW9JF99wUict3DuibTxMOz+8EOtEd1cxjchGBDQRK5YxswbMN192CZa1tVuaOnv1vKd4
         aAD8JwJ/gOeYt902wRBH9Tleja3SxTDnWWK3XvbcN7xDKzukeQevxI+jERCqhrj1LDIm
         lEzQ==
X-Forwarded-Encrypted: i=1; AFNElJ+HXMJD2UOmz/ApRHae8xUl0xONnFj5qxb51aX6JC88cHIgcVTGDltGuXC8JgStulDbLrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YztLZqh07fVIggZA/bceNXVFxHeH5lIip4xcAsqXJp3Q4hy7lgg
	JKOVP6/ZVyzyUujz51M1ze7o+VtqKD2dkTlPTtdE/Wo7pFGkCj3YEAmaQAJLPcr6mNU=
X-Gm-Gg: Acq92OEQ7+eCRR+iiYsMr0Hkev+OgJZzkmN7DwXKsJqls54zs2WTtZM9Ib39+WR1n/O
	4zLeFlljA1q6CxcVyKdQGFyQO16zJHLps6WSpdWyIvvi4mDrAqw51V1xqZWDuokDVKKKJIqAQo4
	uTTx4300iPw2hHQ1++6taewLPWKwh306Q3f9GqUom++U5oAUB63WSTzGqPKqIMkSNPsP/+EJv5k
	ENd8Lkw81BmxrdvLBZFUAB/9RcGAc6H9JaHAgWE/n7LF7plDzzETQ+IjMNE2xm8F1Hponu+/AgA
	U8uqWlLSwEzYF4QmNDn3iNDUeVZdQgOcUX6T7xneVSckA+pLGWD1YbveIrb89jciR6DEQ82DjOk
	SEXZWEXKEPIX5BIwLo3p9WCqR4K+zPj/VIZceiQF15e3B2yQE8jOmg5J+gAt0N0vTWH/2RzOmeD
	ii6XXKwWWsXjdOusWaIg3MqaeGIBxNBBdnmXa44y9dwmLLG116TRAEIPG30BsVhEK3QgRSxUgqc
	+DL+BzL43hSfKA=
X-Received: by 2002:ac2:4c50:0:b0:5a8:a754:f9d6 with SMTP id 2adb3069b0e04-5aa3237db6dmr4356479e87.29.1779699635368;
        Mon, 25 May 2026 02:00:35 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32cf4f1csm2500381e87.70.2026.05.25.02.00.35
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 02:00:35 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a8721851e2so10590854e87.0
        for <git@vger.kernel.org>; Mon, 25 May 2026 02:00:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/0uM/QG6oLz8rIXT3ADHjceXUDQPH8kb+AMNjgq9Ms5UB/ouikXqthMQ4cP5Clx4F9yNo=@vger.kernel.org
X-Received: by 2002:a05:6512:77:b0:5aa:10e2:4e1b with SMTP id
 2adb3069b0e04-5aa3231bb6fmr3681459e87.2.1779699635028; Mon, 25 May 2026
 02:00:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525-includeif-worktree-v5-0-1efe525d025a@black-desk.cn> <xmqqjysseyid.fsf@gitster.g>
In-Reply-To: <xmqqjysseyid.fsf@gitster.g>
From: Chen Linxuan <me@black-desk.cn>
Date: Mon, 25 May 2026 17:00:23 +0800
X-Gmail-Original-Message-ID: <CAC1kPDPbyxs-aTrAOi_PNTZF7EApG31iLYwm+Eddpeh2hT8a-w@mail.gmail.com>
X-Gm-Features: AVHnY4IkbLTI4sHK_AsFVgUUODjRFdgBv5yUko2pitok1yxKHmaGj3quwI49Yfk
Message-ID: <CAC1kPDPbyxs-aTrAOi_PNTZF7EApG31iLYwm+Eddpeh2hT8a-w@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] includeIf: add "worktree" condition for matching
 working tree path
To: Junio C Hamano <gitster@pobox.com>
Cc: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Chen Linxuan <me@black-desk.cn>, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 3:31=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
> writes:
>
> > Changes in v5:
> > - Fix Windows CI failure: use `**` glob pattern instead of `/` in the
> >   "worktree without repository" tests, since `/` as a path pattern is
> >   Unix-specific and does not match Windows paths.
>
> Would it have worked if you used something like "[/\\].path",
> instead of "/.path", to cover directory delimiters for both systems?
>
> I am not asking to make further changes.  I am trying to understand
> what the extent of the problem was.

The root cause is that on Windows,
strbuf_realpath() returns paths with a drive letter prefix (e.g.
D:/a/git/...), which does not start with /.

Here is the trace output from the Windows CI [1]:

include_by_path: text=3D'D:/a/git/git/t/trash
directory.t1305-config-include', pattern=3D'/**', prefix=3D0

The pattern worktree:/ becomes /** after add_trailing_starstar_for_dir().
Then wildmatch("/**", "D:/a/git/...", WM_PATHNAME) fails because the text
does not start with /.

[1] https://github.com/black-desk/git/actions/runs/26391768962/job/77683708=
185
