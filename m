Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE8C1F427B
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535300; cv=none; b=VRnfNPF4HEfHzKjRu8DvhjwphZaPM6Km5/V8k9anO1KvU89FKLsT8vVYE//LG0lZDb0Nt0JXRvQm6oGZS+nBQRbfXsNUffioANmwCVOkxpGx5ww3CGuLqZYmcvtFrGErU7ifSBi7rv59QmEA0Bu4RXk2wOj4+loC8IqP+qQTvaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535300; c=relaxed/simple;
	bh=lO8tNV1PgdAbkHXO04XVLC6gKrdTTeFF0KSbO3bt/ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sspda8ZDtlNtwNH12brxPVg434/UUckrpGyAttnv+Rk9biH6/+YZxIQmw98wzD51Lb+Hcf4Bux2EBEYrLTvNgerw+P81eiy6ORUmQUAaSbQ3pCos0VC49tvROiPZDdu2MXT1iTPJnh7MYr5MJ914iD4IDIE46yFO656RH8XSBGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cc04754326so2850166d6.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 11:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729535296; x=1730140096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eActermqH5YCkKMjaIkEYYMWs4IPZTKeWTH7+9K7WWo=;
        b=PgpK7lvoZA+4bdd/RaDDw4lGc/ARa2kWgN/bjZkByUQ9HjCgXvqfYpcjtL8+BPrfjn
         0dWk+TjDgZbLCBEFp3qJzsbCzT+wDuHe2IhbsyHNZm3xBO+sSW2sNZHXT16oCVvC9MIc
         Kc763UXQihFYPwuS63SrJzK+xVJv63Fd1Kx9w+ZHFCR97FPGt4xuO77NlD6dnT0VvHt7
         kV5LUh5STZ9Ndh5oOzaSM7XERtw0yB+yNOI8psUNTWWx7adki3vd7q2LO0eSdjzRXj1k
         E6yx18PtZR5Bg61ZUngC4X7zAYbIwKdqkgLainsAFpxcUi2xDsQ75baPWKjvTpOis+Em
         LsjA==
X-Forwarded-Encrypted: i=1; AJvYcCUvwUs483fn280n4ZBxsfERTfN+Gt/Yk7e0FsRCdQtSPODzYy/U59mQ1aHwo/7KTu2/Mlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfEmBqDJt5FsSkJsZG2g6QcgUgrewiRUb3FkotUZGczkKzVVL0
	DUTmOrsHeox2ShSuotC1DYy+7aSnjYBlHtnhtwtQcZf3VqgYVaK/GPc5ZsrGwjiHs/brKG9p+gS
	iSjh9P5x4UMHQ32MS42WvCKZ+rA7kTmOL
X-Google-Smtp-Source: AGHT+IH1L+NP03HNXL44Ti5Wd4evEqG1sVYgWdP9qDUbpiv75WNm4H24nUiHda6O0h3sgWmR1Iy+nQy8aofAaJW8Bkg=
X-Received: by 2002:a05:6214:2aab:b0:6cb:1fad:82b2 with SMTP id
 6a1803df08f44-6cde14fa109mr81359346d6.3.1729535296636; Mon, 21 Oct 2024
 11:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1817.v2.git.1729382580491.gitgitgadget@gmail.com>
 <pull.1817.v3.git.1729521495497.gitgitgadget@gmail.com> <ZxaG67wuvjOXc5kr@nand.local>
In-Reply-To: <ZxaG67wuvjOXc5kr@nand.local>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 21 Oct 2024 14:28:05 -0400
Message-ID: <CAPig+cSw_F97nBzO3Z7t2Zrv5TZwGnYiQLhpq2iKgLfxhhxvfQ@mail.gmail.com>
Subject: Re: [PATCH v3] notes: teach the -e option to edit messages in editor
To: Taylor Blau <me@ttaylorr.com>
Cc: Samuel Adekunle Abraham via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Junio C Hamano <gitster@pobox.com>, 
	Samuel Adekunle Abraham <abrahamadekunle50@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 12:53=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrot=
e:
> On Mon, Oct 21, 2024 at 02:38:15PM +0000, Samuel Adekunle Abraham via Git=
GitGadget wrote:
> > +     MSG=3D"Edited notes message" git notes add -m "Initial notes mess=
age" -e &&
> > +     echo "Edited notes message" >expect &&
>
> Very nice use of the fake_editor script here.
>
> It is a little cumbersome to repeat the same message in MSG=3D and when
> populating the 'expect' file. Perhaps instead this could be written as:
>
>     echo "edited notes message" >expect &&
>     MSG=3D"$(cat expect)" git notes -add -m "initial" -e

This suggested rewrite feels unusually roundabout and increases
cognitive load for readers who now have to trace the message flow from
script to file and back into script, and to consider how the loss of
trailing newline caused by use of $(...) impacts the behavior. It also
wastes a subprocess (which can be expensive on some platforms, such as
Windows). If we're really concerned about this minor duplication of
the message, we can instead do this:

    msg=3D"edited notes message" &&
    echo "$msg" >expect &&
    MSG=3D"$msg" git notes -add -m "initial" -e
