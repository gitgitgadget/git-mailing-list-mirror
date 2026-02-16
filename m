Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0B61EEA31
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 01:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771203950; cv=pass; b=a7qg6OGHSDf7w5KP9SOzuazwWvdjvtlALeJ7J9co0N//LE4qMxsQQno2b27kVcliPRyY0b2W/3z1IwfdTQhH24DZYlbwYW5dfXlSaUpahf/Pa5nnIbiAnbMORdiU9HWIAlft9OFo1LeZ+bwEQoQFFSeTIGUA0Zib2fKX15aQQCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771203950; c=relaxed/simple;
	bh=1gtKXVqBTmWfPhI+zw6XOmBxzSk1eH7QoC+Ad+oSsUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZVbkKOr+SQ9TUSJmEMDEbCU3TpryDYjR9ERPXihYiHMXHVZCaNVgwQRNXwwEVGaPSPVJniQvxGTt2tI3OuJIPNJZC24Jq/1Nvz4MEgZKVq7uJaS2PWolspXKd+v4nfXhTy1jAnX0oDeXvn1eLCrAHvHc+kBfPcrpKfxXgvdokw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2bab709f867so130887eec.1
        for <git@vger.kernel.org>; Sun, 15 Feb 2026 17:05:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771203948; cv=none;
        d=google.com; s=arc-20240605;
        b=M26ovP1xmP9FEIcfG+j3LA84J8wsMB5ZSGUm79peWCbz3uROibcsR0sjLCotObVG4L
         cPZVBB3+yyFlGvY91VJTdlQpB5c77PCQroz2NQVcyYhIaNFMKs3nvflyUaN4HsT/AR/m
         obSSGZmc52EZLOuB73/qyM/90i9MnFpX2PVjAp0tkKCVIczMIIpwvYyjvbbWN2qZB3WF
         hJopccLwH3bAfi+iEl0IjPrkkQaMpmNqGLXJ31rhniPscChqhr5eO9HdyYL+JouRml8/
         BdZSIY80/vd0sPXzqfrS3m2u4QAdvq7Aht3EKVosC61b46nTZYfL/lIgqVV/OxwFQ4pd
         G9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=1gtKXVqBTmWfPhI+zw6XOmBxzSk1eH7QoC+Ad+oSsUM=;
        fh=v47hjdPmCTLWpvgW3NTMaXdowhR6qrHotpo4pQstG2M=;
        b=BDwZL2gjNdvmfKWvI1s0sylF+B9jePV0H2aPu8ShhX2A4yr70nI96hvB5HXF6bhGas
         wrap6g/H73mSQqk5aXH27Pk5fPVWOfD5CtUc6TgutEj5CeY3yJ+ViYMqm2vKNP6iDCXZ
         fRsKrFdSflhCYB8LVVCtPqNn75GLDok4Sc4Bz1kwDYAy5P1i3akPO8cwibb5fyVhIT9e
         98zpHRlnxFQiOVjXrLof3ixqQ+FbMuxHAzVEOCGp4zBm/FrbK4nXaAApT/eg32/0s+au
         PD4NOmHMepG8f2HUQpRi5oJj/Mlog0vCp36FHLwp83vT4wm9sS9gmWeauEMeOKIn3xvf
         qe6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771203948; x=1771808748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1gtKXVqBTmWfPhI+zw6XOmBxzSk1eH7QoC+Ad+oSsUM=;
        b=AOew04q5c7+Dg87OeeBW9RrzCIAtz7TfUD5Td87vREBI8WabrQ0icOSXOeBPlzoqkW
         jXChr49KjLbXzBLVxRvz4W0DYUi+4hUunpVUJWuisWQmWaGP+yiH3W+iTZuX9wf4ha5U
         XBhVGbGgZqXaH84JjE6Msq3zBmBxIIGO6xOsqIbMzsfOXx0kYkFhIkAeLcu6LX78YaNx
         SIcBVRQ2qKuAwwROwC6/j3JQ0OdnfrJzccJof27Pe7RNbM8J9FaH/Fo6P4HMjfw7/rVC
         u/NFc8DjPUO5s61+kwjstT4Z3dNMAPOF2YNh2wYsw27fybPlwZFqtvuLtBpts6lQjyoV
         WVRg==
X-Gm-Message-State: AOJu0YziaM9KjxSGPeu5heR7xRbVklC8ww75weFjN7w5fDgQdj8YjD7R
	t9JgI2QoStA+mCqC4LxLeY9bnaxRYanwBoGteLxJg28vR0HsC7EEBTN5Nv0GcEtm/kSi0dOxT8f
	id1FEs9EAndUK1GsV5mvKcVmfczYwQmE=
X-Gm-Gg: AZuq6aJro3HoBpNOejX7WdQqaervARmRL5azE3bXb6Je+p8FR++CDPk3v+AcfmjP57q
	I6Pz38xwkv6h2hc3vfeCqxYBtWhe2QONF5s8W//Rry0RYExrl8mdCWbBSxhGn/6qkxtVmLXfS06
	Ee78E9DRqPXcKT2s2cgxx4iV+B4E6jVH/XZfll3g6LhzHKj1FNZu8hxCPVqBZ9CpHcC0o/CV8kX
	m0NyyHhyM1XqUh6xM65Nfo7xeyjj/rbGfcTwJHpCqy/mkXUm0Sq8g21Y6rl9Lr+25yyAiNp7Krt
	C/VvOGKyfQ==
X-Received: by 2002:a05:7300:e60c:b0:2ba:8204:3f81 with SMTP id
 5a478bee46e88-2baba0f8623mr2223545eec.9.1771203948368; Sun, 15 Feb 2026
 17:05:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMh=C_0ravwVS6UsKKux8PTewd7Z=db4bgvisMXnPwKU-Kyytg@mail.gmail.com>
In-Reply-To: <CAMh=C_0ravwVS6UsKKux8PTewd7Z=db4bgvisMXnPwKU-Kyytg@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 15 Feb 2026 20:05:36 -0500
X-Gm-Features: AaiRm51F7teoBFX7WY1UYdhNjI2AwxSROiFr9uaajZiY41rLpcxreWDlSfoIha4
Message-ID: <CAPig+cRpiOqDGouEQG2MUnYXNSMLKGcqBTBWgqQKYxL7fdN7QA@mail.gmail.com>
Subject: Re: [feature request] stash diff usability
To: Pierre Houston <jpmhouston@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 15, 2026 at 7:57=E2=80=AFPM Pierre Houston <jpmhouston@gmail.co=
m> wrote:
> I can't recall wanting to get, from the command line, the contents of
> a stash as a diff in the past. I thought there was maybe an option to
> `git stash show` , boy was I wrong: `git diff 'stash@{0}^'
> 'stash@{0}'`. This seems rather user hostile.

What you probably want is `git stash show -p`, which is documented
indirectly as "<diff-option>" in the git-stash man page for the "show"
subcommand.
