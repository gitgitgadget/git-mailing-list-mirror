Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792969899;
	b=FauK6FKSNPPfMJoVvyaVwWtvbQOgQ4tnZpSDFB1UTZBeXXuCMkPtNkOddwEO25oV4e4H
	 3j5mf5oAW0Ya+Sa0s7YHDaDJf0+KJLX4TBRBFAI8O/UyGS2W4bCjouI0R42g96625NZBr
	 2WwxNQEJLnYv78hHcyUqzpnNhGQrVTyXC2fJPmjV9eZZlgD8b/R8WCNJwhz/6+cL0k3Aw
	 ucgrBbdQievZnJxtBXHSWv6ALEIhKBuUoXXIeDIVe7y7xZIxFVUilh2EGF3uh+s4uK/Il
	 7+XxraNg2T7dY4kExyOWFQjTQKWjlGcvroEcXpaWFSVkqzeiDgk4EBDzEaBltvjt9iA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792969899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=FCQAyBktI1Alwypgsy4sSAkMAGTqpvdFfa5XVoVHT4M=;
	b=Xzae87YJRC9Xq3P+hX/ml/LtyzUE8/B7HUCWy/K3QcRYVYsOcA0NyDGrepxRMNN88DbB
	 ga2zip2Le2EuMdCjaIigxQriuW1yjZVji448idFMDsfw9ezVXuyXeSZPmFzdpfj+4IW83
	 IrzF+0Fjh8F7uFx38IF/eIVtea+IKkSilzxWzRVcrf+QDSoN919MLrUaoi+gZ0nt/9iG1
	 Sq5gJLr+5qTYFAn1Mm+DSZC1RuUSEKZrtJNL0y0vj/KCZy98XqM8Og509sP0GpHoOR2gO
	 w4CqOL1Z7L5UvHqFRuhRFLu7whi5SBpRAXfJitjZskt+eetpV4Dhi+yfuq1Rwo1jdNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OQdMcBIZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA06606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 23:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AA06606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OQdMcBIZ
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-702dedeb70dso1475896eaf.1
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 16:11:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792969898; cv=none;
        d=google.com; s=arc-20260327;
        b=oaD7QS4EtK6irBysOz0TWELzLUdiJTfnJj0QLC8splXCy8EV9D0TCv9U6y5D6KhZ7p
         t2fj9YBPhYrgKFxDz0+btQ5BLmIEyNbHURPuY9NxAxzzOEQH7cUQNBA9chVsofMPy9lw
         7TSVLZ7+LpXcSQwsdo7nVq390d5yRDPmzxIoFsZ1uTKkfPo1PGJ+W3DKWuSLZHhCg9J6
         pJmarL0UMWa9OjgH38H/XhvrRjd6MBsDpmmu+n3xc7eCy0JYEo5tHWESXHFgUBWAKahG
         QPGwlXSxr8ADnEj6q9xhIOOxRlyJ8CdjdjLmFUcW9dkNSG5Plx8thTfYxoj81PS5oJCl
         jXBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FCQAyBktI1Alwypgsy4sSAkMAGTqpvdFfa5XVoVHT4M=;
        fh=UfphQm4Hqdo6WH1l0G4BQQ7LZkyG8GWumJTbiG6/V2Y=;
        b=lFdHVBM3DmbAj7aJ58Zyyv8GqKW/KG/tQ5U0UywBt+BJ+K6flWJUTiPf0ahJl8vkgL
         e7Wb9ggVKUqTfkltiZtKRvpyV/JwtVWlLK33RubosmLGv7QjJVz0ZsbXIZbswA3yeKDF
         yyMKJqsCaWcDW+pWJCo6inCO1X4jF91NpiXLbaUutQ7WgZMztF3WxvhBMB8dYGJ7VNU1
         guagQ/sMJqEeeFjBKqHikM+P+POexdrF7JC6w7RmOfLVyD8KnmcqFUvkF9LvMyyEs/nH
         +DsFO6uqbVspZMeUs/F0NW0rkT/OpLB6vWZ29CTlvqAYuekNRwTtbq0bSvpZRoUVFvvj
         vHyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792969898; x=1793574698; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FCQAyBktI1Alwypgsy4sSAkMAGTqpvdFfa5XVoVHT4M=;
        b=OQdMcBIZZDon6PpKq8fn315nBqyCQyuKVtDoUty4ZNxkOiDrkVGzgqnrdbKOUe/Yel
         V63g+dx7dT68Jjq/Jgb/CSYZR7S79X1Se7fO70gottc/gEySlI8cL2SVi4FUXC/YxZfh
         ZKINLIHkjBvcTA62ut/2gM+65hSy2fmMfrMpw3cMNwkILrhuwAkyXmcNTxsPTPXM6nAi
         x4MIutVYLSThZ+20uSkhsYDcQjz9G6FK+xi71eLAe/QTAvBujgmNgdGMqoffbHmZ68DO
         347cA5qwNUy+ZCMdpSm+bacBMW/WfZrC1TWR71RY2kxEyszjNSkszyE9qOVKJl2HiGiv
         68Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792969898; x=1793574698;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FCQAyBktI1Alwypgsy4sSAkMAGTqpvdFfa5XVoVHT4M=;
        b=tzjc6Vi2dPiIObpSsJImcUYy2VhteyBD34Y0OT1q3aAJFPl+D5YIlkq8cEphc4bc57
         rN/QmsMu3A+OUeF95q8+56me2PNbbvNf15hKna2E37p9yqmnXh+q3tMZzjkSb2IXliYR
         DqpCpniThgx5bSdM86bZfl24iSuCC79KGcRonLPmwWIXo6vGLynJpn4/RBri/V57e5mc
         wfSTDB5QT1Dl20jD6r15hpGu1W98pxZcDArhYo39dWbI4MuyWunOz0hsedmflcHijMT7
         WLO4+1KbTYpGqNpsc8FBv2ezdpdYMgLzSNfWyjn63imwuEYuVev2TQNNhjAJGXfZ99L/
         n55g==
X-Gm-Message-State: AFq9FYJ3EcvyYVsLqvEPDFrV/XOsrUVyIXxHM5SOxNqoFR/+YUj5weiV
	kVRyXOMp6xAmNCFnVqZVaBl9d8HLrllUuo4h57gLu53igUXFqf3MLiOiMRoMOdCnofTmDmLnNkn
	ilwcK78FPdEoUCHEOlnJw28Ujc8SrrPU=
X-Gm-Gg: AYBFou0v/o68xq0f2CDe3kC+BKAKCZmSRMOUe24wMbhWgMKfWXBBAUPvLOmiGFjuDk9
	SLlpIOdSKn9b3VqyYo6Wa3119KT24LFjucOSzMV9JAy81evb1ByuNwixbraMjcwkp6JMnbyzC00
	QKMnsdybZwf3VDlWhkQqo0EzwLyi8qRJoggSAL2LPNBSG2TcI2AD0RTcopStOWToQ+PU9ng2u44
	p/ptwcghcYU3rXf4OI4YmkdJl5Sdw60FqhvQbvuyuDfu9KQKJgcBB5aFKCqgpe/PxWWyZCPa3dl
	gYJ3HnuudQ17ItFDTxVRy/UZ4MajwyNU0bvl/pt4hZVExC8Y323Wd6iaEet1cydtf9QHi9SS17U
	B0GRFN7xy8ZXb5f2o8vQCuFewifIPGes58w==
X-Received: by 2002:a05:6820:a659:20b0:70a:4973:e475 with SMTP id
 006d021491bc7-70ba0baff47mr1940049eaf.9.1792969898369; Sun, 25 Oct 2026
 16:11:38 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260929185122.3127574-1-lightofmysoul@gmail.com>
 <CA+P7+xoSd2rsHpw+n5vCrcqXRibG6zH+SKCsVXA0OW-VZN_+=g@mail.gmail.com> <20261025212517.479922-1-lightofmysoul@gmail.com>
In-Reply-To: <20261025212517.479922-1-lightofmysoul@gmail.com>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Sun, 25 Oct 2026 16:11:28 -0700
X-Gm-Features: AclHuK9siqCez9V9dJUIdYDoEAL3R-t0busaC73xYRpjtibTIyJcN0LuyLaXjUw
Message-ID: <CA+P7+xo8J_+3QECoGHnN1AxXPpjaKaHp3VoN9EEcyhZ+Q1fzew@mail.gmail.com>
Subject: Re: [RFC PATCH] submodule: make '^/' work like '../' but with an
 absolute path
To: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Adrian Ratiu <adrian.ratiu@collabora.com>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 2:25=E2=80=AFPM Stanislav Aleksandrov
<lightofmysoul@gmail.com> wrote:
>
> On Sun, Oct 25, 2026 at 12:42 PM Jacob Keller
> <jacob.keller@gmail.com> wrote:
> > On Tue, Sep 29, 2026 at 11:51 AM Stanislav Aleksandrov
> > <lightofmysoul@gmail.com> wrote:
> >> - Why not url.<base>.insteadOf? It has to be set up on every clone;
> >>   .gitmodules cannot carry it.
> >
> > Could .gitmodules be extended to carry this information?
>
> Not as a rewrite rule. A rule maps one fixed prefix to another, and
> .gitmodules is the same for everyone, so it can't send one person over
> https and another over ssh with their own host alias. What differs per
> clone is the superproject's remote URL, and that's what "../" and "^/"
> resolve against.
>
> We could add a separate "same server as the superproject" key next to
> an absolute URL and then Git would ignore the host written in that
> URL, but that would be really confusing.
>
> >> - Compatibility: a local "^/..." path needs a "^" directory in the
> >>   superproject and protocol.file.allow=3Dalways, and "git submodule
> >>   add" refuses it.
> >
> > What do you mean here by "refuses it" Is this character already
> > refused? I.e. "^" isn't considered a valid directory, which is why its
> > suitable for converting to a special meaning?
>
> No, "^" is a valid directory name, and today "^/org/lib.git" means a
> repository in a "^" directory of the superproject. By "refuses" I
> meant that "git submodule add" rejects it, as it does "foo/lib.git":
>
>   fatal: repo URL: '^/org/lib.git' must be absolute or begin with ./|../
>
> So such a URL has to be written into .gitmodules by hand or with "git
> submodule set-url", and since 2.38.1 it can't be cloned without
> protocol.file.allow=3Dalways. It is possible, just very unlikely.
>

I see. Because protocol.file.allow is set to "user" by default,
submodules can't use file-based URLs that get interpreted as local
paths so only very weird setups could be using "^" in their current
configuration. Makes sense. The likelihood of breaking someone would
be very low then.

> > The ultimate goal would be to allow users to specify what protocol
> > they want to operate on.
>
> Relative URLs already do that: a superproject cloned over ssh gets its
> "../" submodules over ssh too. The problem is that they also follow
> where the superproject lives.
>

Right. I guess it is more that using relative URLs breaks forks but
using absolute paths forces protocol on everyone so it is not a great
fallback.

> > I guess "insteadOf" even in the .gitmodules wouldn't work because you
> > wouldn't want to apply that to everyone. The issue seems to be caused
> > because of the URLs on Gitlab changing such that relative paths don't
> > work anymore?
>
> The URLs don't change. Forks are the problem. A fork lives in another
> namespace, and on GitLab often at a different depth, because groups
> can be nested.
>

Right.  The "relative" URL of the fork just doesn't work unless the
subproject itself is forked.

> > Does doing something like "../../" work to allow the subproject to
> > find the root from a relative path? Or does the current logic not
> > support multiple ".."?
>
> Multiple ".." work, but the count has to match how deep the
> superproject is. Let's say the upstream is https://gitlab.com/org/super.g=
it
> and lib is https://gitlab.com/org/lib.git:
>
>   - "../lib.git" gives me/lib.git for a fork at me/super.git, which
>     only exists if lib was forked too.
>   - "../../org/lib.git" works for me/super.git, but gives
>     group/org/lib.git for a fork at group/team/super.git.
>   - "../../../org/lib.git" works for group/team/super.git, but for
>     me/super.git it climbs past the root and eats the host:
>     https://org/lib.git.
>
> "^/org/lib.git" gives https://gitlab.com/org/lib.git for all of them,
> or git@gitlab.com:org/lib.git if the superproject was cloned over ssh.
>
> On GitHub every repository is two levels deep, so "../../org/lib.git"
> works for everyone. GitLab and plain SSH servers have no fixed
> depth.

Yep, that lays out the full reasoning for why you'd want this. Forking
the main repository could end up with broken submodule URLs unless you
*also* fork the submodules. Depending on your project you may (or may
not) want to do that, so having the option to use ^/ is good. Of
course using "^/" would mean that forking both super and subproject
would potentially break, until/unless you update your fork to point to
the new fork URL. I guess that is more semantically correct, your fork
of a super project woudl only change once you officially tell it to
move to the appropriate fork.

I think the concept does make sense, if being driven somewhat by a
specific forge decision. Of course this could be useful on other
forges in the future.
