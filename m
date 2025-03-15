Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0478363D
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 23:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742082703; cv=none; b=SA6NEkwcq6rmCcAqSRGQfzpv/n7KDlBjtk3b1PRwQCl9RuHGCfJFm9E7p0QIzfLCnCAJkX7+y1nHF03WJBKbIPB63xKrzpJkAdFAPMh6faL481d7b+k5bhLcbUR7RcTyxHPBPLuBZwZttMM54xHmzy9oSyLkOQCasU53mZZozCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742082703; c=relaxed/simple;
	bh=KGbw/6u11d4ynHUJLFOVQIWuRlaEjgT4vfVUt8aHSaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrPQnMUvqnyPd/M5BUK4F2lojFrr1t0TJa7eAsYWQtiHoQGb6C/7Fnv6zO3QiinjUyIANrcmEa36RqAeYox412VJJqVP0bMI89ZGe9Z7a5vp9LTHs6NJYK90lPuU1529tZTPsbYHVgi7+COH6ANnPDV/N/tq1eFaFrDb4pBCEiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AL+335nE; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AL+335nE"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ff4faf858cso10449047b3.2
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 16:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742082701; x=1742687501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGbw/6u11d4ynHUJLFOVQIWuRlaEjgT4vfVUt8aHSaU=;
        b=AL+335nEVJz8b9SYO+RQtWuFvbZyJZkduTXG871ELodqSi+Ce/veEL7Qdg6QkUA2Va
         LstobYZ40BaRux2Qe0pg6vVkIvil7yewrF1Rh6iNVoLE+hYIiUgp+MARsHMYZi/DKbKe
         isXZAXMJ+VPDRiaEBA+6kdK2y/s08raJ2u4Ne9dPR7n1TmxUq256mnuADF8qbCN9kLUI
         vnpMI8dMki/s9CjGFy0ZvKpR3ot7HwYwALJYqnhG0IGgFilJCgBdVUi3EXXXYA/CVx19
         Y4nqFdUr5qv0xDtdMnGFVyA0oJGjkXtgfI0ez9KRJoSt4oDyoUd/TLLLSozJeWdty/5v
         dZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742082701; x=1742687501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGbw/6u11d4ynHUJLFOVQIWuRlaEjgT4vfVUt8aHSaU=;
        b=hiZvyTHQM8JpK79E/V8jwRR+tUCmsuKDqZ+MCMPJEb3bGaShHHeUZctFukF9X5a3Wb
         6o8RxiizpCs4IBEtIQmNAr2qbCK4FbFc3rYwLEUqhhDgwcT/IsDO80/ys1pBrE2j0lYR
         4WZLRCljdUBepXPgLFY9VOtT4kIlTZG9S3rWF7XG4LDFs1LQWOutnnI42v8DvT28IumM
         44bi+lvMi3JwIhlXcAHvI0/Q56CKl+Vc+c0M7crf+7WeNBvyVPXkwSfF07jWjvfKjp0W
         QXWrUGDD1TvlTqBXIz+Do2dxmUWAH+bMJ/x0NwHlBXBNaEenploRkXeNkWOCCVjLVO+I
         66zg==
X-Gm-Message-State: AOJu0Yz1egXEqtugsyPzZLURT4AlJI8CRGi2mZQZntXXJq5dFdjRykSo
	I+glwxQih2++vIVUHhufBN0Vop69OLuk0v1zItU20m5mbW5guFi4DlGEobMMr5UQDOqB8ZdtOlR
	1W7gBARffQaWSoCEeLu8ATRri/PE=
X-Gm-Gg: ASbGncuZDm3ldeXhT1PXGPU7mdtN7Yk8vVPfYKO56H3pRnTLCyB7FjMbQwsCvae0U1H
	KbyccYftfgDU0WfGViNI0YWydhOpUpwd/SmNJ7KSrgWsLhhSGvsLV+5XcIpmjksYdeNlKjSvyh5
	kRHSKdwxo52Xyfh7ruItcDnVx7HqcZfIIy9HK7CV8Ck+ZBCChedKdDV5gZFhpK
X-Google-Smtp-Source: AGHT+IGjfOTFSB+jw4pOSMVAogWTsTB8XTbwUitjGDZmM0hAXh4YRm+BCe0WtondhlXIsDyybBSDbZnkTrfSXBTMji4=
X-Received: by 2002:a05:690c:380e:b0:6fd:4670:80e0 with SMTP id
 00721157ae682-6ff46025b58mr102055607b3.36.1742082700953; Sat, 15 Mar 2025
 16:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANrWfmRq=7Q=vCPgmcLcek=fRsw83BPqTX7gTpcLb=JpQpYZEw@mail.gmail.com>
 <CABPp-BHPAEcJibTaiMVE1K7AvYE+TYmOt7=6XUtcZbm7wsWhDQ@mail.gmail.com>
 <CANrWfmRpDFuqv+fkCf_p_ggHTrRjD3Vgviqrai_rA7Lu-YFEMA@mail.gmail.com> <CALnO6CCppGXFHoL1jSkUWQUh41=RHb346hW6Qr9hFJpTawEW=Q@mail.gmail.com>
In-Reply-To: <CALnO6CCppGXFHoL1jSkUWQUh41=RHb346hW6Qr9hFJpTawEW=Q@mail.gmail.com>
From: Han Jiang <jhcarl0814@gmail.com>
Date: Sun, 16 Mar 2025 12:51:30 +1300
X-Gm-Features: AQ5f1JqgfnsaB0lIBzW9EfW5eYBLWmlvZkSXf5uB3EQ0nGjy72mRMVjBNw_kRz4
Message-ID: <CANrWfmQdnrGmGW3ot9e0DU0vEbstrOsqzh9Puv9dy0Zsr7zQcQ@mail.gmail.com>
Subject: Re: `--ancestry-path` documentation has wrong graph
To: Elijah Newren <newren@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the help!
The pull request has been created:
https://github.com/gitgitgadget/git/pull/1883 . I'll `/submit` when
someone `/allow`s me. (I'll also `/submit` before I'm `/allow`ed to
see what the bot would say.)
According to https://datatracker.ietf.org/doc/html/rfc4021 and
https://datatracker.ietf.org/doc/html/rfc5322 mails can use `:`
instead of `:<at least one whitespace>` to separate mail header and
address list, use `,` instead of `,<at least one whitespace>` to
separate multiple `address`es. According to
https://datatracker.ietf.org/doc/html/rfc5322 and
https://datatracker.ietf.org/doc/html/rfc5234, strings such as "Cc:"
are case-insensitive. I'm just testing these in the `Cc` field.

On Sun, Mar 16, 2025 at 10:50=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.co=
m> wrote:
>
> On Sat, Mar 15, 2025 at 4:21=E2=80=AFAM Han Jiang <jhcarl0814@gmail.com> =
wrote:
> >
> >
> > 7. How to make Gmail web client default to bottom-posting?
>
> AFAIK, you cannot :/
>
>
> --
> D. Ben Knoble
