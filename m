Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32AA55C324
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791927616; cv=pass; b=OXS5XfYGMnXLl3xPgJ2/KxZ59Au8RWOAwl7rdbRCPi5Bnl06YZAbIJeqkHpQ/DPfargimWlC/YVODiulvUphMNjO3MV4LqPlirUBSxv7QNc3ozSnJ60T3+GNPaVXLQD17+/UJgNC+fKeEh//1p0KMCnCY/+pK0IkWDsgXE+LPyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791927616; c=relaxed/simple;
	bh=3NH3XMopuBA+xp/LHmg9p6jOB9R5iegO+LNBs6my18g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SY02D/FAI0Vm4zRKFzpkdwgdVYzanCGJ4ZQwLjzn2tJaZPRauak/AE7bvS19M9bCh9MX9ooqKEWVRllqsTTpoFF25SkXMvSMtUMdupjZcPKkUFRDwkJK8+QDvfTgqGJmEvfOn7kFIQEmXy7V5V3+aPdxZzScyCTeWqshT3rmk5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noM+Hn+U; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noM+Hn+U"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e831e86ebfso1900835ad.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 14:40:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791927614; cv=none;
        d=google.com; s=arc-20260327;
        b=RCTHhlI5CDVYtnkqBJe530PlVO7ct4aOTNSlPNIlSoxG0jADPoCCO/vy+tH32CcdX/
         /4R3qd5SJ5bQfUEZN+Sd+pQNnYbfEMY2KAf+NU3AzEdL8ZL42aChHZq21PoNcAakKsVM
         +Dzy11viCOm7IsoYWj/WK7vB8RnevVBpbuk0pCj3dpeTnH6ehuslIsWAcS4522iGdDVg
         yBSZ6SmXk4gaMRo9JessA80DzuoHOvz1r+C5rLd/Brly9SX6yMlv3XUNtEeo5zJFN2Cx
         aPWAtTFVTkOGHssOKQMndlnnnfskn7IEcdhzuwuVxY62gXSkiXRgz24oXKDNr2MS5m5e
         VALQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3NH3XMopuBA+xp/LHmg9p6jOB9R5iegO+LNBs6my18g=;
        fh=jggxNzvs03UpP22LdvmhORJIS2ZFiA0ctW4Y7zdeQiM=;
        b=nQeXDJ3UeqXdW1hJnV5mHl+McvZiE7Tbnp/0+CDYYxSaE8xm2HCitFurVWcS/4K7T/
         s1p2py7gUt7ZLHdJ8rkVTYsjeMQEkIytle1wCr4uIKeCS/DJb8PHTagFmHgY2ekwKYcj
         bwgTodOseJZjhpFqtLfSazXtD+wONTYcJ3nsYfry9fGs33riEzu15ENle/fvwrF+yQLj
         4aVo5lHO+k7fxO5UIsAWX9Ff5ColtWygOWT5SVBiyQT9aMwrNUyrEIrdxrtFkGBSgul8
         mUHaiTieCWqJzqQXU1KVtaFR2U0f2wHyMawCOEyeJDJpz3XPNTxhAiPGxwpJ/M5obS4l
         t4gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791927614; x=1792532414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3NH3XMopuBA+xp/LHmg9p6jOB9R5iegO+LNBs6my18g=;
        b=noM+Hn+UkTYoQKVJaEExJsjRsx3hOivUS0nmVBKuv7sGcv4V50lxnuJxZDt5JCyEsM
         19p025WEsXc4WlJOibvCxWeOv5ugdYVDt29zwWiETBjfiy75r7KZSCgxUQEvwyqAAZqA
         cN9ywAjWwnxFHT40o9EhfoRMwUM4m52r+te1gmAOck+G22+x9xbfs8mgURDLtHnEIB6r
         wDoha3BR0OTCxgo21pCIgpJyWkv+pDfH+JtH3Daf8/QizuDokFCG2uynNSnV1imZto4R
         zTT0FGTz/U7vREDf/dTF4SfjGLN3ONemzFBsE67Agpg3y+MQvisjZZDHV/GWRUxucMAG
         a3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791927614; x=1792532414;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3NH3XMopuBA+xp/LHmg9p6jOB9R5iegO+LNBs6my18g=;
        b=VCBfftddRwuM/PfKh4Qg6U4G2n9sruQmf4e6kVUpdlOkGuRmGrF/W/LAEK3TwRcqk1
         jrHukz24zSh38Tmw3jc/Dt+goigVS+iJZ9ZXq1fum7eUnPRt/EF99cN9zUzQ1ZuPvcGj
         9bZFbPwRxC6FHHKLwj9r0SM99+Jvh9moCWshlZnpFmrHEd/6i4u4XGEphaEZpD+Uk3cQ
         Ve1Wo8GrAMsPR1lsfas3CzQ4ZASsUhDHKjg+ks30gJHj7/gscvf0h1TxgBxYA37FmvWd
         xapoj1+O4Nu+Kn9lYsgirLCqKvO/8nXQVSH5f/EO0Pq0MhHmYyZlLNaUyKUohh3ytZvS
         +2uw==
X-Gm-Message-State: AFq9FYKXczJp/eiAIlG2RS85APqrvXj5duUSvdIpRKjYS8fIKokDcefe
	17i7nxSYkJiLCDbQRKeaSObZd6PLYYP5lFEjiIzxiisgs67umecuqZKOZL6y8HOOF7wTrdGz0Ny
	FdVxvjJumWBe4wOr8v9GL1K8mOvN8ob4nBg==
X-Gm-Gg: AYBFou1GPY420tyU45QzgjVF4Ii2aSfb04LW+b1XheyDPwQSZtXnerfQuBR5bwFakB2
	J8aO6i3olI0AX2qtwJKv43QKW6W2njCDawrZw3r/FgSS14Wx6CgYaVD/U7iYh455DEq7Y1OVeCv
	utL6s4GsNEMr0ZlZQTbmK0kSTmM91FHsYHDZFgUV81iEpKGBvM81IpXK6w/lL4tMdLBFHFAzMF6
	J+hzWpuC2KgY1PrJ+49mWMz5lVHnjfPaf/eJomaWqUm4optNfKIuH55RtEB8Q3feSixwWSemw+Q
	TrGMQe+6WjYhpNiSYrKYUOhpqyx+lntl+4ajpFz+2b3CH9MJIlhylDqMa2hJmHVpjko0zjhz/d/
	8GqZ9HxmmixuJnuq2KRrFEYwYrl8uFwp1fwuA3AF6fdkRk0GkajRAN0pzIKyL3aWmi/n3q4l0M7
	Rb1mfitXY=
X-Received: by 2002:a17:902:d541:b0:2df:8f19:5db8 with SMTP id
 d9443c01a7336-2e842f136acmr119006705ad.59.1791927613825; Tue, 13 Oct 2026
 14:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013172315.2997446-1-quark.zju@gmail.com> <20261013172315.2997446-2-quark.zju@gmail.com>
In-Reply-To: <20261013172315.2997446-2-quark.zju@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 13 Oct 2026 17:40:01 -0400
X-Gm-Features: AclHuK8Xz29CZNnp-7it8CmcV_TiUlJFvh9fXwfjtDJU-ixReSOW1xVQj3IzaH0
Message-ID: <CALnO6CD8c+nZktineZjo6PkZbXXEQfKto-cvJvLW=_xjTPVCRA@mail.gmail.com>
Subject: Re: [PATCH 1/2] repository: add core.indexLockTimeout
To: Jun Wu <quark.zju@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net, ps@pks.im, 
	Jun Wu <quark@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jun,

On Tue, Oct 13, 2026 at 5:07=E2=80=AFPM Jun Wu <quark.zju@gmail.com> wrote:
>
> From: Jun Wu <quark@meta.com>
>
> When an IDE runs `git status` periodically in the background, `status`
> can take the index lock, and this prevents other commands like `add`,
> `commit` from running.
>
> Commit 27344d6a6c (git: add --no-optional-locks option, 2017-09-27)
> avoids the conflict by letting background `git --no-optional-locks status=
`
> skip the index lock, at the cost of losing refreshed stat info, so
> the next `status` has to re-hash files.

Interesting. That must be the slow down you mentioned in your cover
letter? I'm trying to make sense of this. I think you're saying that
not having the index lock means status would "lose" refreshed info:
we're not throwing away the *existing* stat info, just the ones we
recomputed for this "git --no-optional-locks status" invocation,
right?

I suppose I don't see how that causes things to slow down continually,
but I bet I'm missing something :)

> Approach the conflict from the other side: let non-status commands wait
> for the index lock. Mercurial and Sapling have a similar "waiting for wlo=
ck"
> behavior, and Git already has `core.{config,filesRef}LockTimeout`.
>
> Ideally all non-status commands can wait for the index lock. However,
> some code paths (e.g. `commit`) load the index without locking, then lock=
 and
> write changes. It is already racy and the wait behavior would make it muc=
h
> worse. As a defense, waiting is disabled if index was already read.
>
> Default timeout is 1s, effective but not too long to avoid breaking poten=
tial
> user expectation (e.g. "an index.lock error means I should check whether =
a
> commit message editor is open somewhere"). Tests that are slowed down by =
the
> default timeout now set the timeout to 0.

It feels weird to me to fix mostly-invisible behavior from external
tools with a config option, though. I think of config *mostly* as
user-facing (whether that user is a client of the Git CLI or
configuring a server repo), and I don't see how we could teach users
to look for this or know what a reasonable setting should be for
themselves :/ Further, we already have a lot of config options! (I'm
guilty of adding one recently, heh.) It can definitely be overwhelming
for users to think about all the options, and I suspect many just
don't as a result.

I applaud the effort for sensible defaults here, which I think will help.

Anyway, maybe it's just me: if others are happy with this approach,
great. I think I would prefer to see us try to address the underlying
performance problems, though, if we can. (Maybe we can have some way
for git-status to not throw away all its work, or some other good way
to communicate to IDEs that want to poll?)
