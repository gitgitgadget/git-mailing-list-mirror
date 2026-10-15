Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EFA2F7ACE
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071676; cv=pass; b=p9aFtwx5n4S1j+7JnyFJNWRYsUucd0/BkVW7MY+6zxiXTeY0GzKfQETuB0Ikws2Me4qPJ7xPD5XfsTl4WbzZIlfeqx8toL24m8Yu74aDqsKf3YIuyD/x1CB8P513sit8etmIaFD8EsSDg/9HwdyHZmLwafpH1SwyxQ7V73Wt868=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071676; c=relaxed/simple;
	bh=vbQuUtmHV2z+wS0ZqF7K6lYrubh9pEBOHNdzrenHmJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xnj6MiLo0iqV9vdZs9aU2PmfmXKHJOIQC9t5L7JXkp9OsX29q1bQyYmwNIGwB7QQxzGjRl3ixQnp6/rAAAzAyqbAloY+dbNWL1XnANbXEprslzzPA+Bhw61hgZJxAvdZYs7mkkjBWAC9cNgseZpX3N23IhrKOhVYaQv+/M6KKzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iM0q873P; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iM0q873P"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-917ad52d7b6so16736876d6.2
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 06:41:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792071674; cv=none;
        d=google.com; s=arc-20260327;
        b=dlqRkJhVzclqI1qTefSySlMfUf+MxAiNct7eZJNdE7IdA60dqZ4SJpObZKCbsy9688
         3LsRRq+ph0zMPW7weHvQXg/g1kYnqZ/ihbZRj1+Qtf3eEJ2D9wxwqMA+y+2T+HKFmYNT
         KL/r/8eLhXgWRQ33fcjm3dLFNJhCo4wsltBus84CEWUGNS9VRwuglVAJ4UcXUgmgSbii
         9+l2aB/UWj6xd8jsFi4/+xcgReycjJ+quCkEPHztcbFiySz5zbSE3YBubTbNtJ125w1C
         N2IJ9D4034yumsW1N/BdB901hxgGmFcMGKLqIMKxCy4GxUKo6z/4g9ljt0BLjtlhUE0I
         il1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YOXYGMC9YDLGufXnpNUT9sIoj2gHUhzL0rqISJtSs/A=;
        fh=eGiqeW1dgT/8qRSthAMHdk7gh8+8tP90n3beR7tXtNI=;
        b=l4S4eV0M6D3T+x61F1lRBwCqtgHoMcFwI2vBpAXZ6J1sKki1nK8ohvUkOViPLQutcl
         mQFhWGYq4bRmOcdIXaKOcb9SS51h5YZ7mHZh2pN1/07u6ozNvzt7alQUJkcZ5HTKu0bj
         HR4skw9gFcF0LweILNpF6T5h6oAmuvY5Bpj/g3GcrDmjk5PwHpG4cZxavZpqX9MCTuMF
         qG5dJU7/S13Duvd+JWnHDhOjyLd8AeuF8r49qz/SckCjXpuKnQ2Dvvr4U5IlZDeRki7e
         n77s0dc1rdSlUJ8rw9L+jOm2gFPK7e26UGSbfQFXQDnywpYBvRLT+ecNEfOsxlIexkuJ
         mAsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792071674; x=1792676474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YOXYGMC9YDLGufXnpNUT9sIoj2gHUhzL0rqISJtSs/A=;
        b=iM0q873PWNclyPpN8u5/eGHkZMHe5nEtfxLKc8zgG3Vw/KuY7tecxueD2598Pm3xDj
         WhkZJiBpTJgUJgosN7MdPb5Vv30UaxrwhngxT5o+YjYw3HeLpRJhAFqWNG8wzyQcBFs7
         7YdOtCpzdn+ht6rDJPC/DEK1pKOP/FyGP8ymfIjXHUbvv60+j9L42nWVUM+4gvs/lAFO
         33k6HdQSzD9nrFy/viN58WKhuxozCkRo6vVd8e07CV/qxzyKl/W4NmuuHOILmeUvhQqQ
         fX8XZjfNUFDThwfHrPL8S7f4+zYgGtaKasoEkG6LPYcToUycKgsEUcovmEGgq2xrNMe+
         p/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792071674; x=1792676474;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YOXYGMC9YDLGufXnpNUT9sIoj2gHUhzL0rqISJtSs/A=;
        b=AOYySk3SWuyKdh4ZTY1uzwCrlTgdKvpTsLKeV0TYQB5c45a/u0wJu6mjTYeXslEkoR
         zSXW8KZsJ6RYFsuv/1z70vtct4Mpj462H1V1wUZrBk5+020oliUhuq7EBzSX/gWKpfWR
         jkl705R1hMDd2hZ8OBFRBk4QMXbCycXGTHA+vsGtn/nYt0iYaLKF1oZpY9X61f3/Wirj
         dxDcUXXxJ3ngb0RYQ9qOOvkhCmSQ7VWKEYG+bHyCO0YW/Hv9Ppz4K7QKULISyEGIZTOo
         205QqJcKEB5XWwi87cVQuUSg0ypwQ8smRZ8CNy5iNoHaSxFk6L4Qx0EYNPTilJyH2Aao
         4gPQ==
X-Forwarded-Encrypted: i=1; AKwUvBxpscmdad/CVl2EoCKqtUwpZZHuDLIOe6oM6y2T7n+uHdN+5fwBuCmibe1fWHBLofp74m0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiZLLmnWZA/eOvm9kEiv/vrDEScU4mIhV94Mbqx9svxD9fai1/
	E3Gwii/wC05PUwaWZ8gpd11Tr5IpPS2lcSlcISNe1uuB8bAdlGhdz4PYuC8jnO6si7v4Dpasm4D
	mFclLtkrLlVK/cTvs+Ar0mgxS5dsGi1M=
X-Gm-Gg: AYBFou1hV6KX/YCAPmPGU0yZf5FkJO24+Zba7DsgyW5iyToSo06FwnnHOrOKzHg9bL+
	/nAD81HF9CaqJHayN2yo9MktNfMeD8lgQHPnX/i8wvgLECBB77YDIRN42MSt2Z/dOXmqGEaWRRR
	Vtp2hTn3XdCtN9KEaF0JX3jXa59WyvNQjTclQOwpT7iFvuRlakY8TC/ICu2n1yjGFUyiFYQNwLa
	xFG/3V+5k9wAmPhWJDOOJqi146Vzr654yOUNCu2OZ4Zfd4+/rA/Spm2mm7KK2AeRNDS0ej0BQLx
	ENJSlWDKhme+wRa+5A5YgzZWz+WHfrwpD4jP0v9AOZBWiWzSBHz+guE7+hc6n4MmTHOKzmvbkmb
	+6rH/+xe3UH9WmM3lMQDtSUQisChmpAsMjSxEL6xg7V/P
X-Received: by 2002:a05:6214:ca6:b0:914:2c9d:b376 with SMTP id
 6a1803df08f44-91b55806013mr339986206d6.46.1792071673800; Thu, 15 Oct 2026
 06:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
 <pull.2225.v2.git.1792012836.gitgitgadget@gmail.com> <xmqqmrsfq4rm.fsf@gitster.g>
In-Reply-To: <xmqqmrsfq4rm.fsf@gitster.g>
From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Date: Thu, 15 Oct 2026 22:41:02 +0900
X-Gm-Features: AclHuK_UwFQ6FdRNk__W_IHkCBGok_COoCK-XILkHvBCTcqSAMD3U5YgpgpF-Cw
Message-ID: <CAF5D8-uzTe2qm8MdoADkSunrKhc_qSLzjBG9CGR5tDAS32Xh5A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] worktree repair: avoid breaking unrelated .git
 file and gitdir
To: Junio C Hamano <gitster@pobox.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I sent the previous email in HTML. I'm resending it as plain text.

On Thu, Oct 15, 2026 at 7:46=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > 'git worktree repair' does not sufficiently validate the cross-referenc=
es
> > between a linked working tree and its administrative data before repair=
ing
> > them. This can cause the repair to modify the wrong .git file or gitdir=
 in
> > certain situations.
> >
> >
> > v2 (0156021)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Split the first commit of v1 to make the changes easier to understand. =
Fold
> > long lines.
> >
> >  * [1/5] align .git file handling with repair_gitfile()
> >  * [2/5] centralize inferred backlink selection
> >  * [3/5] use read_gitfile_raw() in infer_backlink()
> >  * [4/5] reduce .git file reads
> >  * [5/5] avoid breaking unrelated .git file and gitdir
>
> Makes more sense to have this series as a logical progression of
> smaller pieces compared to v1.
>
> What is "0156021" by the way?

It is the first 7 characters of the commit hash
in https://github.com/gitgitgadget/git/
(Creating a commit from an email changes the
commit hash, so the identifier was meaningless.)

Thanks,
--
Yoichi NAKAYAMA
