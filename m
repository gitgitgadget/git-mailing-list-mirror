Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4111824BD
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763536767; cv=none; b=N0X2Y8JIJlabfqzYNYZ+x7DhYywDeptK/en5cEJ/bbD2gde7dfWGOpDEKbfHLQZYLSjfWBKYIzsomeFGg9NINx4zCYUM49YYcxhZPux4hRHjpaMgt79JLjd42Ls2EM4s41H3zxQ/B/h+KH3nzdHjXUOA9u99WAHfK20laFPrMeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763536767; c=relaxed/simple;
	bh=protRSjHSo1RnQC2cfH+ztCV5BalpWg4NRaz/6fhFn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bv7QNbBNZ3j8XRF/L3Ig3DyAQIJsoN4oGePk6jMvEMl59d3q1KlAH/GE6DPA4ZMaDJjwCMyqChG026NwfG8JPUf9Xl4rycC6ZefUmxJc7Gz7EgtdTZt7gYrPeX4fjlOtbNZ969n0QcTQP6keOpKQ/Yctpldw4FPbr7bMzBXHqMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b1c0dcb3b3so126818685a.2
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 23:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763536764; x=1764141564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=teoL6C1LGesWwaX/CEeQDWHMbiwouu73rWosHBVbYYw=;
        b=qgLcNKfvEMuKE4U6FUME52je8Rqyst3KudOdyek+aMpeAVhlswjVaWt8v9jqS5XWLK
         WACCVqyRTzdw8Zjk/EQn7Qj5/lWIlpSik7b8lZ5J59PYa99W9ymSSV2CBYLILWns6DcT
         3lyPJ+lRjtTSss9G5znT7B28MQxoUUTF56rf2x5cY64Lz2qklZoa9rKkpyd8oUf8DOJh
         GHfhsYLjVRvjrU6kDde5agzZhwGG3eipmQnMesxYlYdeuiTEsm2KNSYJXJm3r1qapmQr
         6M9lW+BiAPHnEkMYPt26Zpu4rUqjjSerZkEWVr4M/16TgQ8C72XgEIo2xW09dPov8t6d
         gnfw==
X-Gm-Message-State: AOJu0YxY5jtKljLzkofbJDm4WYoXbc5fMAPwOs9+QgLBOF9of7KXb2OU
	z5eeTjdxxYmbA1+KXQJ2oWZDWnzgMe/OTeTYBnPunUFVa5F3Pu0q8PphjylAB0djd2n3Db5yjNX
	eA5vtB8SHAIO5dgrKdQNb9IAXqDF6IpY=
X-Gm-Gg: ASbGncsu8OyKkixQ5binv7whxkShmywWB3NskHt4YKgMb3MUu7xC/Ko2weczvXSzAHu
	gZlpNLqTzpFltb8PfPDL6aJgik4OQ/uah3sHpjkk/KA00MJsSKqfy2vauzrLdhZ1Tll53MKYNi2
	ya4gYKI7C6GpmA5S5CBnHtGE7kS0ygQjoD0AEvFZ2vQNINOCp9ssK+1GXeN2kZtFIq/7POAfm79
	OrfnKed73NRN5xviVHjfAMWRv3nbjweEJ4kC637j+TEgyA9osq2K6gPMw/68xtS550DJDMJhyQD
	R/Ga1WAAB/N+MFz5PkIOi2EGzqc=
X-Google-Smtp-Source: AGHT+IGqZtYQl07RbzTeq4k6pvDfsyFOcmZHS0cg5P1xSzlbnAKvApgJtnbWMyfd/7K1nGvfCz4UNAZJdUj80M3Pd64=
X-Received: by 2002:a05:6214:4101:b0:880:8322:8617 with SMTP id
 6a1803df08f44-88453c19c00mr56010746d6.5.1763536764515; Tue, 18 Nov 2025
 23:19:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a203b35538847f3c9358a5ae26fb4ebea5734cfc.1759420102.git.msuchanek@suse.de>
 <0e11e6fb394ffa3a1286deea5a8ede5ba3e4bdf4.1760115862.git.msuchanek@suse.de>
 <CAPig+cSNesf0UwS4=Bxe-Qn+G9y3YYPyOK+7y3q8QJk+o7jaVg@mail.gmail.com>
 <aPtRzTwVgVfqjaZT@kitsune.suse.cz> <CAPig+cQoL_=WdNpcO_9mTLDRRDHCOC1-nYMwUyfaev3BZyzaow@mail.gmail.com>
 <aRxgC7TAopqsrZen@kitsune.suse.cz>
In-Reply-To: <aRxgC7TAopqsrZen@kitsune.suse.cz>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 19 Nov 2025 02:19:13 -0500
X-Gm-Features: AWmQ_bmUWk8NmWoL8bCqpYa9_Gd0H8L_qDPIYQtE_d4RnvmOdCNDsemfa5fsgDE
Message-ID: <CAPig+cTZ4WpO--jCFPZOK6POFzrux8m7Rhw-p1FkJR+NOD3J=A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] doc: git-worktree: Add side by side branch
 checkout example
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <avila.jn@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	Ben Knoble <ben.knoble@gmail.com>, Jason Cho <jason11choca@proton.me>, 
	"Jakub T. Jankiewicz" <jcubic@jcubic.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 7:01=E2=80=AFAM Michal Such=C3=A1nek <msuchanek@sus=
e.de> wrote:
> On Fri, Oct 24, 2025 at 12:57:42PM -0400, Eric Sunshine wrote:
> > Sorry, I mistyped that. What I meant was:
> >
> >     $ git -C myproj.git worktree add ../feature-a
> >
> > which makes the worktrees siblings of the bare repository.
>
> and requires the mental gymnastics of adjusting the paths passed to the
> command based on -C argument. Does not sound like a good example how to
> use the command.

Fair enough. I happen to find the above easy to reason about, but I
get your point, as well.

So the remaining actionable bit from the review[*] regards spelling
out in prose that hanging worktrees off of a bare repository is an
explicitly supported mode of operation.

[*]: https://lore.kernel.org/git/CAPig+cSNesf0UwS4=3DBxe-Qn+G9y3YYPyOK+7y3q=
8QJk+o7jaVg@mail.gmail.com/
