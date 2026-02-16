Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17B464
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 23:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771285541; cv=pass; b=aDW+hHVqCTNsPedGEfRI7pDCiy7I9ZzMvabKusEuL5iyN76K2M4V+BLYFgdMNznI7FQUeZwVi+8Ye7WvQ6/jIgKoRsXoC0KFXzIF2UUETg9ezZH+UKnJKuS28WrK/IzmgOs2WWywbxPyuA7u8ONRfA7OKW+y4Nj5m8JpDXs7dlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771285541; c=relaxed/simple;
	bh=Gnwk9jwBJDeV+/OMgqroLF5JQ514SG60GjolgUal4hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPhD9zxbugWw0PjixkvtNOv/SzQFTweGCT1AvfXLnrYdV+gUMIbHH/c69pz8Et1cut7RzJSueDZx8GdRILkEQyhv8Rzo918MVYQOpewlL+n60otN1QTi8QB+JO3xh1gR5mVNJSqvx1dmixJ5emUmt7eSshB1YO5t2xmK6/ah3L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGASkrrj; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGASkrrj"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-352ccc61658so1523020a91.0
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 15:45:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771285540; cv=none;
        d=google.com; s=arc-20240605;
        b=dTsT7SgVvyud8jmw/V/T9/5lY8jCu9w0U4L0SDhxjAoI/sB4tRbVsJCYZhrKCdk6l+
         Ali67C5svCri1Fn+QjdZUtueNyr4ycAwWHkYo+vJAvfUs1yxDw8AQ5SrDvfIOMoxWryJ
         NTBISMuR/LgXRXLmSW1+FlSPAgWj9T14joK1KtBbOz5ohzPG7miQEo/JePuLhHjj0okQ
         nDSIvGya3ZjXHolkzSZPikrG/eW7NmbhM82OZ0LGgbnQvs+rgomZ6xU3g8TIdGUlZYAi
         JpFq7EE6hn3ujiNNoJr8+GLvSgNuYSpvfR56PRCb4VZlswSRfz3HVHzXvvutSA2XSw69
         Eorg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=94NUQiOvX0bBX+UMmoTnXjAf7mRRMWfHBYRNMOfVBsI=;
        fh=SgACNcb8W7mWyQIloKL41NkSItAGD276VhIgKKbSzB0=;
        b=iAsCtIdKKOU/5cgR1IKTiPtYYHGrXdLF28n43cC0lv3VSDQASt3nGitPTJf/yIZNJx
         aG8nnaBOres615cnAvQj1Vkh91nUtfe/z35Kw+OTd0p5bmWCFQmolpCWMuI/1OoI+sec
         qAxLLUutEjeGtIjuhF1NhbLL1llMQ8YO1ki//3C6ZT+SoFDLXPOth4Cus1yMlaA29Xz5
         PcfgHu5HTqKgty0J2+SlUQnTSifhDAW3y0DrRBpguxrrA+v+cMuTq9QAF0DQM7cNOmjz
         V8ZrB4+k1Fqal+4yY1NN/CV8dwCwwNOrhTX9DANG2mhb3xTNAqT4fhXlJ/kJyZ+V5inp
         B4rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771285540; x=1771890340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94NUQiOvX0bBX+UMmoTnXjAf7mRRMWfHBYRNMOfVBsI=;
        b=IGASkrrjDR6rFb+mA+TIN9eQwxo26wKy1DxLayK7uJunLQE7XI8T4qgSIJga81kOg9
         eGI2LM4QxOxGTtK0zz8GRItGgKb6iyS9oSqdkPfWQ3kEFF7oQxHBrNiz/txm/Yt7jpmV
         XIaNB4izYbY7n8bSLvk7jaKETFhK0WQMyIbIBk6FilijQec1VGadE4EHF0k7GxxLXboO
         CYBYxdQFXhgURhsa4bhxmXGxCGgmCaP8azDoDst/IJ4gyH3krNBJP31xkZUd2kNdNQOX
         ZbJnD1E+12mEkwk71mnsDyYsQQL1ib6RBN2YUGjC7xweEQt0PDEAjYi+Sb1SS5Nu6dZL
         yR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771285540; x=1771890340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=94NUQiOvX0bBX+UMmoTnXjAf7mRRMWfHBYRNMOfVBsI=;
        b=ZcMLCsb2MOB3uGk7Nf1Uxpj3gbZ17qc7IvZrO4tSgdDYi0EXX7AU18c5b5TqChOOF5
         cz5IcvZIgbY/BfWgjGCKgqmb/hF7L17lGHC94b2maQ8RLmE1979U8zayBQjNMqZ5mq+G
         ZYCd29L0YRnGta+kQqbnLy53VXBovh9xssrBGcXMOAG8XChajh+li8WFEUexrfwugqaB
         IxpipZWf/7qxxlZeIrkk9gMlHoWpzmbn6d8i74D5WOdaoANDZkS17dIa83CHiQfkxkyP
         6OxcTKTZfjPKzfKe3J74modz/nYttEPae3G+RR2YIcqVs9SgrGhLWAgniyn7PAlo3Q7s
         EQoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0oeFszfamP0tR36SD7biJ5godIDkESJ70i7QrCsJwGaUOrN3jSxQ0F260yxOJXs5Olas=@vger.kernel.org
X-Gm-Message-State: AOJu0YzboQB+/4QuEuE75Qp2Skwve+hZSrnbc8mSFpo5RLyyQjhf6y8E
	v/stZ/9k24IWto5+RU0X2wigTaNeejLiOj0/if2fQRv4ve6/qM03/gleX2JOWkg0YjbIH48SijM
	/wOjxojyC1p9uAoCEWI4HkN8gGf/7BUE=
X-Gm-Gg: AZuq6aIi8Hxf7exIAo6wfJkrPNsKE085+NmZ5GGMMzpjQNieXnLDlIJERRfe+uFWt1o
	FuXC5fWA49GBhYdyvqebKkelf57k0aTPfqhxDEsM0dPg3vL7/UOti57L6kIicQebYah2k69U1SR
	0Iud6NrOplVyMnQS85GIEiEu9inbI3bExXJ/UGmeV3ck/oEm+/0Qa0sPgZkmR2X0VGPpov/1coP
	jeuHKMY/PV+FMLZvGylETsY4BtnwexlBDbmdUYZtKrYIcuwPVNJVp36/WxdyHjm4sRqlRz/vEyk
	3ueSW8mZpx0p3LmbGqfnL+PWxDByFRtTiltrRZlY7VBHxdRGpV2h9au23uwYtoF3Mp8hFzgb5se
	0k3bg029wDOz712KZdRwmUZ8dnQ==
X-Received: by 2002:a17:90b:5603:b0:356:2c88:1e7a with SMTP id
 98e67ed59e1d1-356aad6415bmr10598879a91.29.1771285540229; Mon, 16 Feb 2026
 15:45:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2046.git.1770746461307.gitgitgadget@gmail.com>
 <pull.2046.v2.git.1770775169908.gitgitgadget@gmail.com> <xmqqms1fwasx.fsf@gitster.g>
 <CAOTNsDz0ZtdsM8Z2NW0WBMGs8xyWz5ROS6pf8DKQAx26LU4xRA@mail.gmail.com>
In-Reply-To: <CAOTNsDz0ZtdsM8Z2NW0WBMGs8xyWz5ROS6pf8DKQAx26LU4xRA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 16 Feb 2026 18:45:28 -0500
X-Gm-Features: AaiRm5113giA9I-SjrcfRDNko4TUIvB8Gxl-8CbBa92Eovhu6z_A4z38pCzk-ps
Message-ID: <CALnO6CARu8HSYh9=z6FAF=84q1qA4Oan7_DLMbcK+1rth8B7cA@mail.gmail.com>
Subject: Re: [PATCH v2] osxkeychain: define build targets in the top-level Makefile.
To: Koji Nakamaru <koji.nakamaru@gree.net>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 6:06=E2=80=AFPM Koji Nakamaru <koji.nakamaru@gree.n=
et> wrote:
>
> On Thu, Feb 12, 2026 at 12:37=E2=80=AFAM Junio C Hamano <gitster@pobox.co=
m> wrote:
> >
> > "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > >      -+       cd ../../..; make install-git-credential-osxkeychain
> > >      ++       $(MAKE) -C  ../../.. install-git-credential-osxkeychain
> >
> > Will replace and mark for 'next'.  Will squash the double spaces
> > after "-C" into one while doing so.
>
> Thank you again for the squash and for marking it for 'next'.
>
> --
> Koji Nakamaru
>

Homebrew picked this patch on top of 2.53.0, and on a recent build on
older macOS I needed to

    mkdir contrib/credential/osxkeychain/.depend

in order to make their build work, since otherwise:

    error: error opening
'contrib/credential/osxkeychain/.depend/git-credential-osxkeychain.o.d':
No such file or directory
    1 error generated.
    make[1]: ***
[contrib/credential/osxkeychain/git-credential-osxkeychain.o] Error 1


--=20
D. Ben Knoble
