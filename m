Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFD7EC5
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 05:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728191696; cv=none; b=L8V5kZ5A9PPfO37SQrBVm01C9KTHozc5wYZtTnsV+Ml7+Acl2MtwWw1U6bnBoW8AXj2BK4avnxxxZYBjt9lYfVX+7Kj1MRwN9/1Fytws4W4F6WkDvV8NqgLncK/fXTcjyBjeIKs3KSoMXXmJs1cFOm4zHQYZozy0VjeSiOR1x4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728191696; c=relaxed/simple;
	bh=EjPAVLLmWWJJ3lqueh3+Aj91C8WwPFwxxNm48JJtBIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4rg2JhUsBb4A6jdqh1XLQz9DXPaFKI7td6E0XMH6GHQdLrLet3GB5rz3SMcAvo1kWgOW6rZA+FvoixwbkmCfleF8Bgw9Wm8sjiOC6dbvLei6w//UCtSSDp5XQoQUY65buEYPo8pWgf5oP/uk5DFCWIGzFb9XcAjTvm26k20Teg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cb3eb30527so5107286d6.0
        for <git@vger.kernel.org>; Sat, 05 Oct 2024 22:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728191694; x=1728796494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qREqdp1wOfRmoZ4uL3jrvBKtxg/TAVOk03HZ1yjOjMU=;
        b=Or3M4U7uqU8emR6yi99pUjjmageIas87T510tpPR5inPsyg2fJCDkX3D5qfaIU2ru9
         Jibu93wIw2wE/EOl/C5Ao4xU69VgaCodqnnSTxXQuyoYTOvRs3eLyAhZcjSnS7fonElz
         PEh+3G2e388663iUN3o98jGWqqjBEBSKxOjvXB789ApNbdgY9DyrfHgafDgEZt9sBbYn
         KpoKdqQotizKP88+O/b6LMmxqjObwKU27ann2kql8ePdKNI1KcTTt0fviT+JRVRR7OVb
         IKKQ8Xvd3SN0zIZpkj+Mh1FrEYcWYYrxGFXuDRTGoritWWEoI0S+yz8AKCww4pE9cp9/
         6Omg==
X-Gm-Message-State: AOJu0YxnUOW0iyEm4dgf4XV7znZMCGBIKDzMpEdET79/bKDqRUwgJdFY
	kvTQIeEqHhhVZW8glLsuovItS1la65zXl2hcNuf+X1EwNZnEPtp+ECpUkSBx5owiTA8im8yB0bw
	kp1YoC/mbeXMUZaWEJ/B5R/+AMaE=
X-Google-Smtp-Source: AGHT+IFhjcLuZZ60I2n7eN6B7AqWOCzuLLl6coj/idf9/OiPtuFtv5UbN1RhzJSu8vpfI8ECl0sbuC9sF3XF2T4QkoQ=
X-Received: by 2002:a05:6214:501e:b0:6c5:1022:6a86 with SMTP id
 6a1803df08f44-6cb9a4661e5mr58035746d6.8.1728191694016; Sat, 05 Oct 2024
 22:14:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006045847.159937-1-cdwhite3@pm.me> <CAPig+cTB-sA-g4cdhfEjWwY1mnbWJ41e=bOCNwp=Y8JKvpmpRg@mail.gmail.com>
 <zKUnWY8u1SJNeS4oLK85znjacgYJJeN8HefenwaJ9B9Q1YrQAumpAxWos4svaawkTfQZ_HaS3yp6WrOQQI7yt3ZO0UMCfkM0lJDDnMD-Lno=@pm.me>
In-Reply-To: <zKUnWY8u1SJNeS4oLK85znjacgYJJeN8HefenwaJ9B9Q1YrQAumpAxWos4svaawkTfQZ_HaS3yp6WrOQQI7yt3ZO0UMCfkM0lJDDnMD-Lno=@pm.me>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 01:14:43 -0400
Message-ID: <CAPig+cT6LALKjEappB7QkB7oc88NyMcr40T_qJGL2mPA77K7XQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Link worktrees with relative paths
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 1:11=E2=80=AFAM Caleb White <cdwhite3@pm.me> wrote:
> On Sunday, October 6th, 2024 at 00:04, Eric Sunshine <sunshine@sunshineco=
.com> wrote:
> > Unfortunately, these patches are whitespace-damaged. Can you please
> > resubmit using either `git send-email` or GitGitGadget[1]?
>
> I sent them with `git send-email`, let me try again and then if that
> doesn't work then I'll try GitGitGadget. Just out of curiosity, how
> could you tell that they are whitespaced-damaged (so I know what to
> look for)?

Hmm, that's very strange; git-send-email shouldn't be damaging them like th=
at.

I noticed the whitespace-damage just by visual inspection as I quickly
scanned my eyes over the patches. For instance, in patch [1/4], I see:

    + struct strbuf backlink =3D STRBUF_INIT;
       struct strbuf gitd
    ir =3D STRBUF_INIT;

The "gitdir" variable got split.
