Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD292ED865
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756474783; cv=none; b=XKffUTjDEgNxtdzuB+Gvic2vzqeHbKlmRQvakdDcJViS7EuWpujGoklIXRsOL3PveFehY700zf9G94wrNTDdIIELIiw47l+Zjm9DCDt2NB6pf0QFEnAPzcImv8o1zl/p5MFrApGIeVX87KhWt7SkU8B3PPiFxnPhS7WYZ8h3fjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756474783; c=relaxed/simple;
	bh=Ey1ikdv8kzmApMjmQrpNUcfhkw/LxxntJMw9HrEsxJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkOeuU2EPoMnfhxxxyXsRbI2IjOFCqJ00qMxVFAAXPQbrxvj9VyN+DbXfIvvSUWwmrugCc4PESAPHUu6hfjTCvYBxsumJIMtOT3D5VKeFFakV0AHmTfqWpJx8fE/Dvt0T08NPO4gaNcADmzgAxkf+wLP7CaeNh5KyTp9MQrQYY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mc8hD9wb; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc8hD9wb"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61ce9bcc624so1980804a12.1
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 06:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756474780; x=1757079580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zg7mVyt2yTG7pSC3i2zbzDlB1MqDgF0gr/7LAjQ6/58=;
        b=Mc8hD9wb4xMgKvIA3g8aqPSeuGQ8ON+VLWTuQ3LBI8e0n+/u1ohkMoLgRugrm77Gcf
         986tYTdFYzMiWC/aEqhEtYzBTEYyT6GSzgea4b3stuj7uV5xeAjRU+a/gN/L/XfUMVpu
         OD8wEjPTV7JhPp6NcdnFFk8NbBzUUrJ66QX5HY5noXeszv1l66yiNQ5WrYroh2DFApQH
         NGDW7Vbw1jH4WEUGdQQq1OnNPubrH5WkcfaW7vxvnFcJwd/vU6Ci1aOia1ni6vExZ01s
         qjH5aOkS1SAJc4DdE+ime3xIvSx+8iRByjOtHGXK1gstI26eIx4hV9sQAvFQJ8H94Wxc
         VYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756474780; x=1757079580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zg7mVyt2yTG7pSC3i2zbzDlB1MqDgF0gr/7LAjQ6/58=;
        b=JW+W+qULNS/r3cw0mwK5fsPUbSt4RfRsQIidkDBopcb1oGHoO6UTq6A+RmQtue+HW6
         JWXrhz1Vgnj9fMBV4Qj77oZDUr2nqz0j4O+yrSduRCzaBXr8LZWC2aS62hfxRD1Tnl0w
         u8fVDMyEBGeq+mfCaK721sFbH7H4G9QI55ZPE2c61xRDCCy4534m8oJuYPTPSbnhACY5
         KjQmXcTpbVNgvUjfHsThsBfYkwryZKSoTT17jqeb4ek2sPN2dr33n4IlYysH4Ev0xIfG
         UZA42iOQoxNmb3+PITcl2CxFzKYX+3jI2e4hz1PxtMiCZFhXi3OcURD1Lcz1cSXcgaYw
         Em6A==
X-Forwarded-Encrypted: i=1; AJvYcCWzTeuFB/le0wqg3Ci3kIPG8GCjVOABM7myx1I4WjTnWmANDkL0dExhX/ufnxiKNnsnqHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBWgk3kDLJf7PhXMbelrcuZYPLzg9sLBwUr25nttC/8xk0JZRc
	Jv+P2TFrxoglpEZ2dkZ464TBuXWyKHRbrwnxAwDx1Wq3WVby38vRp7f/cujJIfKIwMBv1TV1qVX
	H2NS0eBb/uSiuTwvDj2CSta3tP11rOmU=
X-Gm-Gg: ASbGncvz9a8GK0nCvIgsBiovgNUmWYdZG20hOXeE2crteLtZ0vBz/e9dDscQwtyFDhl
	7KVr0vqW3wai1l3SFB2csKHSa2a72bT9UjgAr4OAgk2XCqfWGrpaAOEEIX08vMJcw7G8Cg5Kvne
	xTIqpriGH2kkirbHV0oP0OMwu+bwdXxMNdfTG4xutWdv+ByuGTac/xgW+bgiEG7KBIM8I7ftS/Z
	0yyobI1AkvmRovTUQcyigYNl2ucxu+pfe6mxoBdJeNcgLGetuzB
X-Google-Smtp-Source: AGHT+IE9ruY8zIA7wiowP6b/9+gVnPRVv397uRY8tHxgKPzJFfJY3BHT8MAfj6SQFpZyM69HhtxF5mYK+edJ7DcCJmc=
X-Received: by 2002:a05:6402:1d4b:b0:618:1250:ac5e with SMTP id
 4fb4d7f45d1cf-61c1b6f982amr22804163a12.19.1756474779763; Fri, 29 Aug 2025
 06:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
 <a6125a0128937392af283033e63d2b04776caf2c.1756148933.git.gitgitgadget@gmail.com>
 <CALnO6CCvD-uoan=-VW+OmfCk5cLgNm=zENAejL9vX2czahMGxg@mail.gmail.com>
 <f440d0e4-0754-49a0-9677-980f60a5dbf5@app.fastmail.com> <xmqqa53jqaen.fsf@gitster.g>
In-Reply-To: <xmqqa53jqaen.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 29 Aug 2025 09:39:28 -0400
X-Gm-Features: Ac12FXxwTI68tUK6cqPb2ZvW4UXjyMTEfBj2p-__eyn0NgjW5uRASz0FiqydnDc
Message-ID: <CALnO6CBvsWZe77ireTxBoPBuHem1J3Qrn9H6GZvA-w59ytAqVw@mail.gmail.com>
Subject: Re: [PATCH 1/5] doc: git-checkout: clarify intro
To: Junio C Hamano <gitster@pobox.com>
Cc: Julia Evans <julia@jvns.ca>, Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 7:44=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Julia Evans" <julia@jvns.ca> writes:
>
> >> I think we've dropped the bit about the default interpretation of "git
> >> checkout <something>". Maybe
> >>
> >>     When you run `git checkout <something>`, Git tries to guess whethe=
r
> >>     `<something>` is intended to be a branch, a commit, or a set of fi=
le(s),
> >>     and then switches branches, switches commits, or restores the file=
s.
> >>
> >>     By default, Git interprets `<something>` as a _<tree-ish>_.
> >>     [explain what choosing a tree-ish means for the user?]
> >>
> >>     [Your notes on disambiguation as before]
> >
> > Thanks, will fix. Though I don't think it's accurate that
> > Git will treat <something> as a <tree-ish> in this context, since
> > `git checkout <tree>` is not valid. Will find a different wording.
> > (I get "fatal: Cannot switch branch to a non-commit")

Interesting. A docs bug! :) AFAICT it comes from 19e5656345
(checkout.txt: document a common case that ignores ambiguation rules,
2016-09-07). I was a novice then and don't know the behavior from that
period, nor did I bother to find out whether "tree-ish" matched the
behavior at the time and has changed or was simply wrong from the
start. Good catch.

> True.  "git checkout foo" is disambiguated by seeing if 'foo' can be
> interpreted as a commit-ish, and if not, if there is a path 'foo' in
> the working tree.  Otherwise we'd get an ambiguity error.  A commit-ish
> that is nameed by giving a branch name and other commit-ish then trigger
> a bit different codepaths (the former results in checking out a branch,
> the latter detached HEAD).

Yep, makes sense.

--=20
D. Ben Knoble
