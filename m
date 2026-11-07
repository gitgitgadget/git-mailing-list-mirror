Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794082834;
	b=d/kwvjJo/af8PjoYYPOpAjS45iMaH8ab/18MUGU6BK/MzBzptDapYrcNqlOb+7A2T1Zl
	 RBbo9vnbjSQaBopptMomOJCMie6+WmmtcO/2quRYBngSLL1ABmKnTIEH6Af65SNgVfoQe
	 z3N4Jm7LupFsi7LtBCptgjIVCQ5qoDcpxcAP/cEmFsiEskUlCaU8iZcccD2T5DL+Qj4ym
	 WP3rzYz7Js+Q1F3s5i/UaqAn/O/zNCKzkNxGsV8EqnDcnUt75qEHK0egTkoRBfCzrbCzA
	 cV7Yi42rQJAPt1mULb80H7QuRCuEitu0YfQ0MY/dZWjQqnBM8G578J1jD+UErRQ/QNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RCC0awMpRYb0kFlrQz9ZJe8yTjaiGC+AG7Y2b1HXock=;
	b=vnNMlZjxS9Ss+AEi1AxsJWJjhEMug0JO1s/jAM7812q9LEMFwbaIh0jYWf4bCePOg7EX
	 JcH38ywCVinZFpLvhgJD9ClCtHOmqzMrOHHv4xAk8TX0E5P155f1Pm0iCyXIHmgdew4SR
	 g0q10RsWxKH9xH1d2x3saQO9ZU0Gi2D7Qr2MMT0ZD3kpYed9reWsZVc1yYiPwmDFQksBO
	 +U9l/5A4rKkMBTKjNGhMC4vm/sF/f/DZF6dYWR1tWxl+mMGAF4Ti5dDDOGesA2lke4/BZ
	 d0w++2aznNSp2a0UafO7itVC7mLO39cd+8Kbd85gTjLF+n7/uOh/T450aws0iqqv1uw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AyoI+iDr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844C5606A33C
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 20:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 844C5606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AyoI+iDr
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b09c07b3d2so5049a91.3
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 12:20:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794082834; cv=none;
        d=google.com; s=arc-20260327;
        b=ON+85hUxh490AA8Yu8MO2VNgt+XJPX23mBEMyQZy5h8AObPeND206xXIJnKuIroUAC
         KyBgVcDkMw9PUkNLhvJt4GmPdXRwm/YeC6lT6LH5S5V+1tE875GQzEMgYKU+U+U3dIZJ
         HgQG+CN9HxqZyBTqNFCC4KlKJR0bBo6K9YIDbvt9QhOB7xZh52nECli8coN8kmr3NMcy
         Yu5hbYWikZiCuvpIw18ANjrvHQIuHaAR8dAkc2t3AhDbECi00bIbzXhXnhSnQMk5Vbkb
         dlbGPivM+124e4WVgOLIjfnBiH4oqluyzikfEc+1SS2spKwrKKuWW6YgpOyN6xt7up9N
         cnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RCC0awMpRYb0kFlrQz9ZJe8yTjaiGC+AG7Y2b1HXock=;
        fh=l8GTMQAxlpjpt5k1jS+SmPQutQlzTJfg0WvsY2hhveQ=;
        b=TOam26MLFVzCX/y6HTzjXdRW69dJpE/dWBYq+o2WhKQQdZWmQr8w6N4Gi7COXqsTGL
         C7/65jrx7B0a9L9EyTG9b1y9vOf9Etm+KvfOzphLZTA+Z9Y7Z3c3UXvGsQenhKGdLbSM
         3hs8mer8wjHNf6lwa5qsUQZQqq4ssd+1RgbjBJTTdjPOx8QGE4urLaHO7NN0MHSJgYWk
         +xLsiuqr0T7XX5itB6nkrItSazr+iWyojb58UOxxf66IDb0jSQKF+z2qqppoka/LMU1N
         2P6E4cn9KXwjJOHy59PetKtPv0csu0wdye7eSqXAhDaLYmn7ZrzsFAhgjdCsGivtF+ff
         XM0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794082834; x=1794687634; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RCC0awMpRYb0kFlrQz9ZJe8yTjaiGC+AG7Y2b1HXock=;
        b=AyoI+iDr5H4TJ7LNHtmIv/3JgxzeDAW0R5+Sqoi5k2KmIROQ+GQUaQNdRg4LzjS0zb
         cmHqrPKIKIP4OLeUQ5FatoBZAPWaMyJwSd/xoH03x8Mc4Xd/KDj1BXk8Y9vjVFh/S4lR
         3HoJyduyd7Gm1PUM7G+ruMYMg/vt+BF+npTemHQcDPvATVIyBYGDPIENE9vaQoE8RUKu
         oWVb3FZIet40LdnXeiuWgftWp4teZMmx4zzAp+pF2ajcqdbD+KGl1AJYuZa3ZWpzteZD
         jGcWM2HaHr64zbcawWmLNJXvAb466XqEhWyM+rRmb7rZslrUC8+6Qhbk9AIG+Wu4NQUK
         9ERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794082834; x=1794687634;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RCC0awMpRYb0kFlrQz9ZJe8yTjaiGC+AG7Y2b1HXock=;
        b=CwrSCqXz50wX40wp06YAmnlrjaqsNwbBlk6bMWLKH4GMxurWTzZLgPwZk5w3kColr6
         w6AdzUQgrRDJlg6CcR77ZIYXipp0C2UXPJWqUgcECuFUD/6tj5Do5QZBtsrGPH/9/0Tl
         bGBlW381ExpCAqjTbXRcruPkSLNDiSLJfc4sccstCy8slf+WOPMDtoVJ6Vms4ax+/i/I
         28Ts8N7JxFhQ0EQYSHGa2PZzIp4F/T1C4sgmwaGsw3AckVz0MggNuPMKLcK6YsPB4HNz
         mkVd4ZY94j/4WlgJuSER/XIDbHLNhjym8i1JI8Vabrv6TtbOh0tn529fxtBp1knJKZjQ
         55ig==
X-Forwarded-Encrypted: i=1; AL+hErFlATNMgHib6P0Lc/UfhFcQCYBTfcaQ1sowzlLl8v3YRi8FDafvccH36hRdUVh4NXw9iM8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LVObLd3wLq+4hCcBvsK/d7QaBWYC+nIfq5sNmojf0wQ6tBsfJ
	mHvKmOXQxsbPVPIx3y+6BMXbW/61Tm1f441qIzKo0qtkDFYFX3otCvK1ZAAiLz4Osh+mgK2X+up
	k8IF+nQqD/UCK2DioXqJsx612I6/h0Y0=
X-Gm-Gg: AYBFou2jmopyPjRWAqv/IikwK81V4abJvOwSXzN9uE/bC9UvbwZK4K9fvfFc2CWkx0Z
	b3O5e4k60KesnbsI7laIAutPYhev4PLz1J1qC4FUTWf/v94KgTRsJDliThnAWTkMT3Tc9APNCR+
	Tow2DRT4wHtQSG5SPP6oRyFQbfGliVzdl1sZ6SUOEEUT+NSE3YBPhbE5gqL8UIO6M3lGCW3vSLi
	Vhj2Fb+FNmac1B5P7OGkJmORWvc7aLIAQrnpJgGP0CvK8Q5pHS0UVDUQckvgSR7Wsc2Lh8N/t9O
	e89/W7lwJ4Ef3GoZUiwg/Tb51+Z3123AC/+FLjIFvAnfg4Efl9ru/+vknDPkZh99XxfCau601X1
	srS3TRzPeipiIgbS4Zel5QmVbd1YktnHpSkyOwIb/lcNUbvwMqxp/VnGI6ln+eIgOifZgv6cEX9
	wPlk9vggPH0Vj35BvCweWHMr0+Bmb92BZ1FFjOU3s4rbQJx783V5C6uQTYbDdqJiZf16DT50DUu
	XxBnKTsb/pWM4A=
X-Received: by 2002:a17:90b:56c5:b0:3b0:c11a:9026 with SMTP id
 98e67ed59e1d1-3b0db717589mr7228281a91.55.1794082833712; Sat, 07 Nov 2026
 12:20:33 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <e6af5d1e-4ca1-48a5-8a84-5e0cefbdbc2b@gmail.com>
 <E50044F1-41F6-4FD8-9A22-A43FF36932F2@gmail.com> <xmqqmrrwywq8.fsf@gitster.g>
In-Reply-To: <xmqqmrrwywq8.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 7 Nov 2026 15:20:22 -0500
X-Gm-Features: AclHuK_rYkToQT14jaAnH_miR7HG3Jcn6EuN5ecE_dbd56_kGvDK1BN6fyKdaCs
Message-ID: <CALnO6CB5uqHpeJm9QUC-J7n=RBVB+0pXRuMfaSQZt7mHoZbasg@mail.gmail.com>
Subject: Notes, refs, etc. (was: Re: [PATCH v10 1/5] fetch: add remote.<name>.refmap)
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, Git <git@vger.kernel.org>, 
	Harald Nordgren <haraldnordgren@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Cc Kristoffer Haugsbakk as a fellow notes user ;)

On Thu, Oct 29, 2026 at 6:21=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Ben Knoble <ben.knoble@gmail.com> writes:
>
> > Yes, I would love to add pushRefmap atop later! It would
> > ease my working with notes, I think.
>
> > Yes, I would love to add pushRefmap atop later! It would
> > ease my working with notes, I think.
>
> Tell us more when you are off mobile ;-).
>
> I do not think I planned to add '--refmap' support on the push side,
> even from the command line, but I can imagine there would be
> reasonable workflows that benefit from having one.

In my local copy of git.git, I want to have both Junio's amlog for
spelunking and my own notes for patches. I only want to push out my
notes + topics to my remote, though (I work on Git from different
machines and it's nice to have the notes sync'd on both). Here's the
hack I ended up with, and it has some downsides.

In particular, "git push" in this configuration does too much, so I
usually have to think about whether that's ok. A pushRefmap would let
me separate what to push by default (push.default!) from how to map
pushing when I want to push, say, notes or other things. I have to be
especially careful with a "git pf" (push, force-with-lease,
force-if-includes), since I usually do *not* want to forcibly
overwrite the remote notes---instead I should pull those down and
merge them=E2=80=A0.

So, here's the relevant config (I have a remote "benknoble" and a
remote "origin", among others):

[core]
        notesRef =3D refs/notes/benknoble/commits
[notes]
        rewriteRef =3D refs/notes/benknoble/commits
        displayRef =3D refs/notes/origin/amlog
[remote "origin"]
        fetch =3D +refs/notes/amlog:refs/notes/origin/amlog

The "usual" stuff to make my notes important, but still show amlog
notes when browsing history. (The origin remote section is in addition
to the normal remote section with it's url and heads->origin/
mapping.)

[remote]
        pushDefault =3D benknoble

Push to my remote.

[remote "benknoble"]
        fetch =3D refs/notes/*:refs/notes/benknoble/*
        push =3D refs/heads/*:refs/heads/*
        push =3D refs/notes/benknoble/*:refs/notes/*
        push =3D ^refs/notes/origin/amlog

In addition to the usual config added by "git remote add", fetch
remote notes into a local hierarchy, and push them out, but ignore
amlog, and don't forget to also be able to push heads. Without the
heads map, "git push" will not push branches!

Now, maybe I'm holding something in a way it wasn't intended and
that's made my life harder, I dunno.

=E2=80=A0: There isn't a great story for that, either :/ When "git fetch"
fails to fetch notes because of divergence with local, I end up saying

    git fetch benknoble refs/notes/commits
    git range-diff refs/notes/benknoble/commits...FETCH_HEAD
    git notes merge FETCH_HEAD

or something.

It's *almost* like we need remote-tracking branches for notes, ahaha=E2=80=
=A6
at that point, Scott's git-meta work becomes possibly more appealing
to me, even if a part of me wants to "fix" notes so everyone can use
them easily.

--=20
D. Ben Knoble
