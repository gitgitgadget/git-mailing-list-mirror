Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF27C18E1E
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467007; cv=none; b=Kqw2A6K6TKAQrlAwu0PrC4fjDepA4ABsFBxiKABUIsdPEy9nlE27bApXT2C0xEtS0pDqH8RSQH6JGBlVegJWl2VL/e1C4aMP3WfvUOWCPfpQtsQpzcVazGERwiyIPOA7NfBRD7SpSqxFJ7BVPe/gwO7TBruHvHf6WDF2rFAgHEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467007; c=relaxed/simple;
	bh=LOEcCf2RZZyLJhSsGePNYzmh0/wDdgZqzaakQWd9BOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksUJSbi/isLqpZXXrQ1OxTjaryVZcvN5t0usm2OXmdV4fm65MxgphZtcYi9EYbO88sckkZuMgiDOElRh3BdWlpKPSaR+bUKQS5qTMiDFbSzW713cQzW+7yBdv/BHLf4t5LHX6qFZwab+pzwkM47i6L6nCpm48GjLt9lePRhHfHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCPLrp1y; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCPLrp1y"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-367a081d1cdso2484082f8f.1
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 12:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720467004; x=1721071804; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OjyeCLxeuiZz+Z8RwWfrm3srvFkur7ur6OqjnjrA+oI=;
        b=YCPLrp1ywZ2lFY117KJPb7yz+Ya+hC9h3MLGYjoJyZKqZooAP3kzSjRxUfpEWMWsSf
         S5eJKST9PbCex+nVPYpNCP1ifSv2prhj2UuXdJnSH68W3t0Kr96Tv9BePf8r2jmgUqL9
         55Qva6zA/ey84rx8uFqQ2U6e6PhVEhlgYdIB88jYH4I/vcNdto1kDhWhn6Nf0jCDIG3p
         7n5W/X5eB3iu3w5oPgTp7xF4TkQdurvh/z7fMqMy4WnIBfWZP6fmxRAYHnEzHKaX3zdu
         qIFPo84Eh3S8TLcuL7o0izb5ITjOJA/2QdRMmWdh7ZqAOV9DaQXtS5B7XcfN1bAi820O
         mDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720467004; x=1721071804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OjyeCLxeuiZz+Z8RwWfrm3srvFkur7ur6OqjnjrA+oI=;
        b=YrwTqmRkGld1pAs+qCXxyUWK4t3VDu9IWZcW9nqIPWi3Vu8S7HpwwahySOLvnurel/
         cOXwwcPX0HafWSz3+JHKcArdwSvxAfvSDZoKQ+SkVTbkkArdfkWKsQTSAVRM/lXTNtnr
         C/MP9YmDy6GE+9Bffx3+U01zcbdhkzlbp6R6fCdGG8rxRgmots++U0rdxx5eEAkhoUxQ
         gyd9o1dB44NJ3pBZSejMvl8whxPd4k2nRlrZ4OTY5ZxnUW9UlnEQVTV8iX38rbJOTZvd
         SQbR2BsbqoxaxVCQpaAyf07ORsh5HdNEhHpXkyyCq+1Za/Ec6Mj4Yp7cid7Ec9RtoMaD
         +eqw==
X-Forwarded-Encrypted: i=1; AJvYcCXIPm9qcqCzIRuE3zGlBGs1UFOTp3YQY7YqUwXlYUKVYvRdNkhYAr9vabt2AxIB0D5Q4zisJILMzLS506bozqe4vmiU
X-Gm-Message-State: AOJu0YyMcz/vwxHpxKGyI5zOsJY+C3IL5OUid5+utAdIU9pWG/3fVkM+
	Ah+sShsnvWFwOfug5PS2e7p5unUL3zQWIgNJSdlsxQY6wW0Lt79tHYAxIHubxoSN2bqLX0Ylpp8
	UeK8WqfgmOxBzmj19qEmA0+kZNvY=
X-Google-Smtp-Source: AGHT+IHlCx/Mw+yBwyDqDc4ike8AxAL+HvyynWlE6O6CcEiNCXBhfwN/K8a6JGFKlibXdR8Vie7dxhVcSKutNP4tgYo=
X-Received: by 2002:a05:6000:2c5:b0:367:96b5:784e with SMTP id
 ffacd0b85a97d-367ceac4900mr450545f8f.50.1720467003941; Mon, 08 Jul 2024
 12:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <17df67804ef7a3c8.df629cdadcf4ea15.524a056283063601@EPIC94403>
 <CAPig+cRQPrtGBTxM49nUeHvsVr0qEOnKZ5W_4by=A9mXEsR3DA@mail.gmail.com>
 <m034onpng4.fsf@epic96565.epic.com> <CAPig+cS2r-b22ikZZ6QHpzfneQ07n6s=E40Sb+QYmCnezVFAww@mail.gmail.com>
 <752d41f9-6ce3-4c31-a0a2-4960c7dc1b2b@kdbg.org> <xmqqtth2petz.fsf@gitster.g> <028ae5d6-b587-4ffe-b837-38f2c13992ae@kdbg.org>
In-Reply-To: <028ae5d6-b587-4ffe-b837-38f2c13992ae@kdbg.org>
From: Brian Lyles <brianmlyles@gmail.com>
Date: Mon, 8 Jul 2024 14:29:26 -0500
Message-ID: <CAHPHrSfVLLn_djR1eo06fr5OPaz2RAChv8dBJ8eJKB6b6snWnA@mail.gmail.com>
Subject: Re: [BUG REPORT] git-gui invokes prepare-commit-msg hook incorrectly
To: Johannes Sixt <j6t@kdbg.org>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org, 
	Sean Allred <allred.sean@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Johannes,

Johannes Sixt <j6t@kdbg.org> wrote:
> My take-away is:
>
> - The commit message that is entered in the edit box must appear in the
>   commit unmodified. There is no such concept as "comment lines" in git
>   gui's commit message edit box. The commit-msg hook can overrule
>   nevertheless as a means to enforce message hygiene, but otherwise the
>   user must have full authority.

Could you elaborate on why git-gui's commit message edit box should
behave differently than any other commit message editor? Why is there no
concept as "comment lines" in git-gui?

Johannes Sixt <j6t@kdbg.org> wrote:
> - A commit message template and the MERGE_MSG file are populated in a
> manner that is suitable for `git commit`, i.e. can (and do) contain
> comment lines. It is, therefore, necessary to remove them when their
> text is used to populate git gui's edit box.

> I suggest that removing comment lines ("message-washing") should not
> happen as a post-processing step, but as a preprocessing step when text
> is gathered from particular sources that are known to contain
> inessential cruft.

While I agree in theory that it would be ideal for git-gui to wash only
content from sources that are known to contain content meant to be
washed, but I don't think that's possible since git-gui can't possibly
know *why* a given line appears in the message, in particular when
running the prepare-commit-msg hook.

I think that whatever path forward is taken, it needs to be predictable
and consistent with normal `git commit` behaviors. I think that's the
root problem here in my mind: From the perspective of the
prepare-commit-msg hook, it's impossible to do the right thing because
git-gui is invoking the hook consistent with normal `git commit`
behaviors, but then creating the commit with `git commit -F` behaviors.
This is an inconsistency with git-gui specifically.

So it still seems like we have two real options:

- Start washing the message, allowing the prepare-commit-msg hook to
  provide template-like guidance to the user regardless of if they are
  using git-gui or some other editor, or
- Pass the "message" argument along to the prepare-commit-msg hook so
  that it can at least avoid adding template-like content (but of course
  then lose the value added by that template).

The former seems most intuitive to me, though I have admittedly little
context for git-gui. Hopefully the elaboration I requested further up in
this message will shed some light things if you still disagree with
washing the message.

I'm certainly open to other ideas as well so long as they allow the hook
author the ability to add comments when the message will be washed and
not add comments when it won't be washed, regardless of whether git-gui
is in use.

-- 
Thank you,
Brian Lyles
