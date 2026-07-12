Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D4FCA6F
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 02:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783824742; cv=pass; b=QPxXt5BVpfpbY5caCy0cUbMaK/vrwHj69heGdpaeMFTBpi98A/mun/YWaFTSyHuY9EpornVXKKnuvyEIIKGx1PIG9GnApeOGL7E31p8ic5c+mvgsq8/SZK9FDLuIPsVETMBxueXfbwKkFjMGtQeDhIXKjS8eI7hqRRbp7JbJJIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783824742; c=relaxed/simple;
	bh=NJGT6B2Lay4y3MZGae0N08Fh75cZicVG0phb//v6LlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgcWjb3+iec2owj0B+nJsZj+B8TjSsXf8dM87uobO2bDUXT88+hVw62iwOxAlXAg2YEgUpTAyaZ/J5y0OHSeynDT9rq6lL3QJEZCPHPbppBW6v6HMppqQcVhGLqz6HskACiQukvUuCziSEcNeHKBtDrXh/H+gvXztz9UT2aCll8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTrMmYD7; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTrMmYD7"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aeae350e0aso2459771e87.1
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 19:52:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783824739; cv=none;
        d=google.com; s=arc-20260327;
        b=P9gOX3XJQ3P54hYuqFJ8fZCOWjUnhxdr0EoZfxj7SbHd5u8XVrcl9SYyvdW+/GJWUj
         vl2qUfGawEXBCv0SP/Ty8EpYWIRJLYF+gHJurOAI8bQVcYaWZ2RqmroAJEM0H3deEwyd
         ZEljQ9Fj/JGVMlAtE/Ci7+wPJgsO85Zg2QIl06RlOJNj6/gQn8bXgPWybw9tvSy/AR+P
         KJ0NLboQwHSBrUE97lTk4Uf2W2F9uyICXnxwwhYbYXSvAlqu3VR8D7hiC982+pQltN4c
         5i/LHlYjisfvpRrDCafuSxQQdP+2WfiLdceP163drZ9OEDZTm8uQqYCI3yycgNu19KaD
         YlNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ty1j6pO6jy6FAcLV07PgiQPvaK60FIcYsTsUyVpIx0E=;
        fh=rfLjIwn2a57wX7vvUPf5sv7xoXYLkb1by0ZOpcDOxJM=;
        b=TcNFfAQrNy4S56cvJlz9bIPD0MGjmIHVR4qQpq8Osm1Prd05ZHx4j+4QAF3r/TioSz
         FOY3IwHNh9eb0vGG29fimfSKuCoIYNvV52Bvtu3ZGKj6mCGpkSeA5b7ATg+ONjJewbBK
         0HpJkzEEys1vYx61+jt4W6Ixf65xIbp/dRabCU7lWSVWNWOg7LZDNVWLCGFolXu5xjIz
         4BOENcBJRkMgvXk7uAejxbsg1SLn49u99HJGdGhrZIpONsALdw58QW+A1FDYKLwcD+gk
         L+sOiqnKVp9A/mpQiQR+RQXh//3BNf4xTIj/hYBx+tX2LOemXxkjZYCoO0kqP9FCPQkp
         UEJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783824739; x=1784429539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ty1j6pO6jy6FAcLV07PgiQPvaK60FIcYsTsUyVpIx0E=;
        b=XTrMmYD7+w78X8wRadu7C9jNAZ6/5rfOcfet50/JmiPz6IAEFoyW0rbqJedrMH7ZRX
         j9HvD0Wu45KEFpU7E4C4ZBd3j7tZmBYzlqqpAZ7TwLI3B9hZ3sdVWDvHgGzMJaGDfQGz
         t1TQwIhLw+wJEXNoSmH/OUSvfW7RD2FWIPL4McZ/Hqju3VZkzBNycwJjIQkSwjnY6LtD
         QBCsuewiRj4L19wuWnuNIzrqa0QZK+qB+HcbTr4E4zsn6Ia4fKd8/fhdc2O2lFIe7ROZ
         h/zj1DGYqDcsIEgMQ7acx5gxZBV6Ut8iPaCVJiDuPOMHdJiUw/B9nQVVGY2sF77uNQHC
         D8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783824739; x=1784429539;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ty1j6pO6jy6FAcLV07PgiQPvaK60FIcYsTsUyVpIx0E=;
        b=Ly/1yCIqso+wmPi+F7bHjxY7RPZpJA+gvPAUph+STsM0oFdZpAvhIGXAWMbNtcAbTY
         +j26c5dDutvkhdME/XozdKLOw3mbAsbxCVFPS3zPR9LMUpx6zO8EoHDuxDyZ2hIGdNlR
         wW0dNNSf36kYdQDOLvTqEWitUcX92sNkPeuFLWizUKn7ZtBNdtbMj2jrJxNU/lEH6FXN
         w7OkyuUEp3PclrwLTNPMcenkGIRhq7pcc3Xh/Z5Z+xPezlzAGrA3HxtCrqxMYX7UM2xu
         I25pJe15sZZ+uLAyzm/qpMyy70+jIk4+NB8Lrn9yntXyv/mHrr2Uam1MHn7P+Xkr2i64
         D0HQ==
X-Gm-Message-State: AOJu0YyqZIVZFeMpYefsksxnBeEJL2MikziVscDN6zl1lU00hoFaMqbR
	Sc/mnpGCTkoyTMZjIFKkFvB765g1Y7hzy6uiUpTONWv908EhwicN48EHobN81sza3e2oW4cdn2+
	YcC1lm1xaNw122ebh9HW5hPkBh+18GtU=
X-Gm-Gg: AfdE7cnu5Km6r1RZANdhNgDd9+Ja65Kx/Y7WmcOldvPwSR+/J4smafSpmbndeOjPKnf
	WL2iaALCv5FGUew7pTI87s4xinrGLJlB5ZfGdjynG3NWlPkcbX/tnkyJBfqvlB0U6R3CYZtK0zB
	28QFGKcO6sPzSgkWaz5I/0aA/2aRfpw3PrpsVCHaLurj4fQSJoMpSSbRFt6zNmBWXbs4YNl3u46
	YSK15KUsFKXE9P0mWd/3MhL6fS6EZSTo6ktHOJzBU1mRjEZKUAsqk2avafuR76J1m7Re4ysN3Ic
	PjcUDt3Goyu9QH+grxonU6S7TYyM9RRqBGl/9yuCDdrv42bQ6GZ7krZu+nnf1rpT3sfZEy8Hx8/
	JyE+s5pLw8aOdaW0=
X-Received: by 2002:a05:6512:3a90:b0:5ae:c063:6397 with SMTP id
 2adb3069b0e04-5b023667862mr942979e87.15.1783824738873; Sat, 11 Jul 2026
 19:52:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703164709.22723-1-jayatheerthkulkarni2005@gmail.com> <xmqq7bnbheo1.fsf@gitster.g>
In-Reply-To: <xmqq7bnbheo1.fsf@gitster.g>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Sun, 12 Jul 2026 08:22:07 +0530
X-Gm-Features: AUfX_mw9Lplsru62CmlRHSn47p1eb7MB_2-_qJze9zQI4e_zThMclo-RbKysYwk
Message-ID: <CA+rGoLdYm3aHnfXWiCh4YQyYyz=TDCB-JWZ51v0nwzxzfACcQg@mail.gmail.com>
Subject: Re: [GSoC Patch] repo: support category-based prefix querying for
 info keys
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, lucasseikioshiro@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Junio,

On Sat, Jul 4, 2026 at 4:19=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:

>
> You mean "repo info" takes layout.bare and layout.shallow (right
> now, later we may gain a lot more), so you want to say "everything
> under 'layout' to grab these two values?
>
> Why should we limit ourselves to "prefix match"?  Would a glob like
> "layout.*", or "path.*.absolute", work better?  Especially the
> latter, i.e., "I want the path variables, but am not interested in
> their .relative values, only the .absolute ones."  It is especially
> puzzling as you are going to do a dumb linear search in this mode
> anyway.
>
> Perhaps during each iteration of the loop over argv[], you can first
> look for exact match using the existing bsearch() codepath.  If that
> succeeds, you have a single key to return the value for.  If it does
> not match exactly any key, use the new "prefix" (or "glob" which I
> think would make far more sense) match codepath to find which key(s)
> to return values for, so iterate over them (or say "Hey, that pattern
> does not match any key!" and fail).


Sorry this response took a long time but I have given a good thought about =
this
You are right that adding globs makes much more sense in this case.
I was initially skeptical about globs, but looking at the direction we took
in path.* keys it makes much more sense.

But I think adding a query system is not a good idea anymore.
I have discussed this with my mentors at length.
Since we are building a plumbing command, we couldn't think of a use-case w=
here
people would need globs over hard-coded value in scripts.
Also globing might introduce uncertainties if the script doesn't have
an appropriate fall back.
I am also wondering if there will be any significant performance difference
with --all vs globs.

A query system in itself is meant to simplify commands for user usage,
but I don't think adding it makes sense "yet".

I also wanted your opinion on this

For my GSoC I can pick the histograms patch in the git repo structure
instead of this.

Regards,
- K Jayatheerth
