Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D0D3064A5
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932044; cv=none; b=ifOkvD58qRQXEplzVtzI368NN/cq40f9xRRWFkMFQigblIDG9s7+3yfe6xgwDht1ZT/GZWtHk5rWZgjXVHlvXGC8GKGRCefGzGnS3SvzKhWJQr1ONwMSP3iiwp09zDbo9fyzzOxZrbUqjKVpdn0odUK5ORQAAiWSJFj3IkEE8y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932044; c=relaxed/simple;
	bh=P0rLgTfo5Cue6E7z5LWhDYPJhqDezeCq6ZbgwkwpCD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esktQXsuwhhs2j/2gNud5x8QYdD+nkz8HWF0QfBDGDsVNGJUe3/QOHH3xhj2+HQ1qL3bvlM1/4DFkYJBjMig6McJwAJJ57KuMzH4GYnRGtb6AjHsbe8Izz4nC63ATKNwoxNgasPsYvNg63px+/7NX7tJfmhQJxCynCDNgg6LbV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-880284cce17so2277536d6.2
        for <git@vger.kernel.org>; Fri, 31 Oct 2025 10:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761932041; x=1762536841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUeyVRlOi1ThC25tJiBP8fsV/+bTDbA4crDC3KehGmE=;
        b=s6MlJ6vXX3p0lTYZ/UscdQ6BrcBnyy0pC1KXrG3MRfs31SN04RNAIL7Jmhs2fmBEUk
         yWK049gd7d+jMLWr7AJ4MTIN12xA1mNjL+MUaP1VCQvsj0qAFC0vH+b/Mm62fJI5DmdY
         mElYoIdc5poeXUVa6iAIflIvZzEM/wvboGm/PMvF0vcB1iEqxgbv+Ki5rkKynFZnq8Aj
         3rtaocxLuPzR8j3cPvUMue+KbHqqBX4vR/dgSgQUQTpwoYXC3DFSfyt/5C8d/6LFshpX
         T9RuqWe37Ay5mGvIMmNTZLJtMTD+LOTkg+4fZB4TjaMYPVtdjL9WK8jFrJ4HpXSzMtEZ
         KC1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXqSvBWU+aiAQSfwcUYcMUrXqZTv3Qz/2O8Iri7RT/ynfK+r7QyvMbekXDE7y+wHoIuL5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjkO6o1HMLUrdV+btRQ1O3CNPjahER2Rc3/nxQ/uiPII0JfxX+
	lFk9pcBNvWSBIERFBgVXis6cqDWEqH4Qfnp+QoFJT2Xa2uvtSUapwh9+8VGyx2mdlk5cZnNXKet
	ttA9vSFrlYiDJ2fCu5l+H705UNz/iX7cNgTqV6GU=
X-Gm-Gg: ASbGncus4GxsoZTA5ZSQEd0Rw1bYltRlt2LUVYwPJETyQTuS36c/jPDYdS8bu+rlC1U
	kzo4gpOMqovc+NqFC0vRn4198TSev/NqwQ0W31RukLRbPkaO74D1nXwT7vnaIFNVaRvt/yaacQg
	QrjU5jg6Z32EXNq8PYp5jwUVN3Ad8YTaA6R7Kt8zltuRGHZKAOy7TtwltSyx799Ko2icGncKsnK
	FvccQCqL3gTPFC/EjSRxOEASXcqTmjYaqxJ9JIn8IJT2TVFTIaWvDI/QDgPM//JyoQl06U=
X-Google-Smtp-Source: AGHT+IGHgQQoK2B8oKHSwad7RNGHO8mawcKk6q+NotU6A4hyklNNL+ExWk7KXfrfxWWXXw9lpkfi28FNoj9hvN+f7g8=
X-Received: by 2002:a05:6214:2b08:b0:87d:c7db:7897 with SMTP id
 6a1803df08f44-8802f26f50fmr40636736d6.2.1761932041351; Fri, 31 Oct 2025
 10:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqpla43wcp.fsf@gitster.g> <aQRaRuBtt_r7SamL@pks.im>
In-Reply-To: <aQRaRuBtt_r7SamL@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 31 Oct 2025 13:33:44 -0400
X-Gm-Features: AWmQ_bmMe0uHQxFCzeIBn3wV7UYcf2gFZ2nS90-D6yRXIPCwEcFCzPVWecxmB5g
Message-ID: <CAPig+cQm7xY4ihQk=pA_4kVGnrvx3tt+CnsFxOhx7=6TB9z3Hw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2025, #12; Thu, 30)
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 2:43=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> On Thu, Oct 30, 2025 at 02:36:54PM -0700, Junio C Hamano wrote:
> > * lo/repo-info-all (2025-10-26) 2 commits
> >  - repo: add --all to git-repo-info
> >  - repo: factor out field printing to dedicated function
> >
> >  "git repo info" learned "--all" option.
> >
> >  Will merge to 'next'?
> >  source: <20251026225409.46647-1-lucasseikioshiro@gmail.com>
>
> I think there's still a couple of comments from Eric on v3 of this
> series that probably need addressing?

Agreed, a re-roll is likely warranted for this series, not only to
address the comments I posted, but also to adopt a very sensible
suggestion[*] from Junio.

[*]: https://lore.kernel.org/git/xmqqwm4gl7fg.fsf@gitster.g/
