Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793129661;
	b=39vqxjuv+/MpkhISGpWbnY1QzpFbsik0/xMSxQ0ZMLDiF3IsWGEEqxrD7BxwnSXsfGQ6
	 0W8GTtNlXDfogs2Tt/hRmsU3VHbcmzFp4HWDNPcQubWGjUW8yd9XnGjvsGo5Vpcy+I9WD
	 0aLLxFj9pHgMt++PhPlGGu67oK6DUYWxtp18kV+gILt3S0Wohq07MVvyzHJ0eRe9L5gf3
	 9r6hn+hCfsRj98rVwaExIHyzcCTsjVH/JinW9bJiPxfJjq5og/bBuJupFrWZkGNo8NMKC
	 S3NL3CI4C61qU/M8Yogy9hyvC0LIrC2L6W96YaHK8FMqLM2wdZ0C0MJrNtRYaXzJ4gw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793129661;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gLPdh8XnrxjUoc6dyWpLturaIjjqUNMvrEGC2JyX22w=;
	b=1UYv6plGYpW1js3JpKxu+Rlr/xRBuVvi+c5hwpoXOiHpcqSgW+Xc+6tguuFj3yoGUVf2
	 iUypiLP+tgmSOzr0gkSz9p0gjrnZJw5basKQcU3SaFPff0xj+gOa/JJE9BT3DJZqTwANr
	 1RiI/ElpbcefCjvqqEGpHNOsfEsiTpj9gmV9Oc90NVB4QYj03pfyUf+50RRwm2rGodCg3
	 VUqQSqgumQuvG8kxy2vb5/sExiogNZGgrvK93uUT61PYaKmARuXeRiSjUAub0dP33gQYy
	 bNxzwApMT0b/eJK/zsDxW/ynNm0dVM7+I3HfCxx2FJG1zZYJX86+qQc38W35XZLg1cA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jtzCCKT9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D4A606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 19:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12D4A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jtzCCKT9
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e9995ce866so1583095ad.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 12:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793129660; cv=none;
        d=google.com; s=arc-20260327;
        b=ltFAd29mQSNxLmEQC70rcxAat9JBQzoblHSVCfcJgVHO0zJj0yJIEI01t6HLQPgo9d
         iHqtvihZCA5lbi6ZhGCCr/KAX6EOI1jGtXKdkz2UO+GECcV2aQaeOe3/21z0aJ8LDvwe
         s8QO8nlT+volJGgip5tE5r9Wq/r7hu4SUd1QOuF609El0zpOg0W8m/uF7n9cCiPeHG3Z
         2wZHhieGDGezgcapB7ODF8BxTyKcWjWGuPWxoCYT5/muVVcHi6/Tss0vo+xy4qPNcAD7
         uJBzWJn1+2wlxQ9SICpH1MH/JA0H/taOnpZN95MdiBVy/YCgrqP06DHNuck+ERXPlHuC
         GEbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gLPdh8XnrxjUoc6dyWpLturaIjjqUNMvrEGC2JyX22w=;
        fh=ELfGIRzjCZy6aZKp/m6bLF6KVA5qa10Mr84cOxGd6J8=;
        b=M/LTsUybXi2339l7ZEABNY8d8uJsYcFZV3/eksCVdEoYiW9QVSB8OCfw0J6oXo8AXh
         TCNKfMFASUxIVhWAwYTq5l3QAFh442xh2rqclxMu00BrfPkHWcP4G3YbpQ1VX7gP6UrN
         ziwBNrYxVT8IdSifOnmCmsxrixFeoWZEn9aYs087cWTPSzshcq1hSy1aWOwzIb2FUXFQ
         r96O8Sx87bSJ3ypZvY2aHvCgwSMYfvCdm4KATFQp1sRXd4iPvX7P8zPsmw10SEIM68Z9
         9zsnTm9WdZtAvX0Zy4LugEIj8u+WU38M+i8vkIczF5S9j2bo07NaTzf/ru2us6qpPYO7
         tS3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793129660; x=1793734460; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gLPdh8XnrxjUoc6dyWpLturaIjjqUNMvrEGC2JyX22w=;
        b=jtzCCKT9mj7dgcJQLJ9bIdvac6d+ZJArnI6BvnsXdKsgpfXU9qXWSBHAOTjl/F3yB7
         zHMa8lFyDBUp/iL61ydNF+dR6mgnUGwz/FQnM5rvCmmLGcetlHwLdYj09IxE4XPfv50B
         uisZ63aUiIXnkx4A8oxLDBvVc/+0SYJyiQcCcsaLekTfwEt70BweU9BN8cyCn16JBKBY
         UZGJiLoi9rU0wmLWXl6VygT2hLk5GXHDR0R3viuyKuhnQcqsejgi+uJJwBqGsRH03b4V
         LEwgF2CLD3nMyH1d907h9FTOsX7GQ/9oY3RYGv9n38JwLFT1/QW1JkJqhpvBSs4MgsoI
         1/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793129660; x=1793734460;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gLPdh8XnrxjUoc6dyWpLturaIjjqUNMvrEGC2JyX22w=;
        b=P4c9d7VhcA7+M1wvuARW1DFFPpBZFPErWXsjqU9zKTXItvgI4bEK6V4djBZ0kyPuNy
         A+pBCbue0Kvcda0JAmwI7+r8fUjO0Igt8etKLBAuxAfg8tw0C/NBgIUWZ+Rl+18fIWMM
         7FzjYhhXGwCTcUdbghlDZzEmrwfRLZw8Wb8PbfZ2UIdMOZ/5pOJTUqjC5XTit2bAgbc1
         d52Y+DhMXfnJun8SZasrru5Po8ZSBT1tTpaWqIPpMDl7G4zvQiEsZ+jD8xZ1N8OO+K6q
         jtSr630QOi82HOByFXRkjVRGLItStCIwJraaN+CNd/zV0/8/W9AQdDPQq3Hpylc9IOVq
         /W9Q==
X-Forwarded-Encrypted: i=1; AKwUvBydjvqtPIKfKMktuXym8owYTZidE6CP0RSlHBMv2mTSHxfHIaqkbtHZqywAxELbwmJy8is=@vger.kernel.org
X-Gm-Message-State: AFq9FYITmlVlOu6RE+4AsIpYkcOBNachxzx8W/n9vIOly06Wb2lmPKrn
	SgDO3CEUZ3dc4khxHDjV80lRPPIYclAUgVfzC5qNXnTh9T57tD6GeVro4qfu1eVmA+VHcKpxgvp
	r5eOVrG2oFqiMez2z7ng5nSpTBbL79gcYAA==
X-Gm-Gg: AYBFou3uK4zjRviV0M6YbTASDokTEboVOKhucZrwV5RqOyVeo5ti1gdphgXcwmBhgwv
	ya41LGE2nH0MVFTEMfRH+4HzfhOUgQbKpDSctsaWk3VqbNYZeEIS4CMCkclWeRCmwPdn7jU6JVN
	QkmCXbQb7odd8LGQPNWruTa4H4M2yMHrD3e2r+jr0Hd6DruRX7xT8DGcU5L4BTe4fzi/S1DwkE5
	TBixMNtVFq8Chn1alqpL/4QP38D0S1XSyItStM0HZog45PQ8l0bjj+DvPGeloDZN5HggGrQ5pym
	dRDtyh+EduLN7ao5vp2AQ5B+3uJa8XDYhWc6pp8+Ylb22C587WfxiXXMeS5ujMFAcC6A3LeAp9l
	nC27zg6RudAMHjaqO8T9CsEwb+fj5eqik1JDOIK2N9SBcRTpqf++jFKQ7yUkbTRNQCeerHyIfpC
	j6hsP50/4cHy/6ai+nt1uFJumt//Ove4fG2631Z1qb0UYEN9F5DgunqcAKSsd8vTAna4BFy2+eF
	le2WMwHrqGYen4=
X-Received: by 2002:a17:903:2c0f:b0:2df:991b:4368 with SMTP id
 d9443c01a7336-2eb004eec42mr3346205ad.53.1793129660355; Tue, 27 Oct 2026
 12:34:20 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAHwyqnU-BEtOPdVbBXtuEYtFYuL3MqC9nUQeP_Puvq5bsoWEAQ@mail.gmail.com>
 <3EF4DA22-6739-46FA-8028-74EED08BB931@gmail.com> <CAHwyqnWJOk9FCGkPi8yWOFq5vr-CMWNhn=wBAifx9Gfn+1bMzA@mail.gmail.com>
 <CAHwyqnWi6E=idoP2+1FdeEE4-o3D20xJfsc4Dutt6R30c===xQ@mail.gmail.com>
 <CALnO6CAAoMLZP4MBzgBa96RYMMReyxKXObb2JELqkBe=LBUVLg@mail.gmail.com> <ba149000e13634ffcc5dc51e4d584a56@donquinleone.com>
In-Reply-To: <ba149000e13634ffcc5dc51e4d584a56@donquinleone.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 27 Oct 2026 15:34:04 -0400
X-Gm-Features: AclHuK-pwXgoPkbR8cLM2bltQI0zB6YDIZfPM1ZAFxILx1wTT7BTJDGrLgxd97c
Message-ID: <CALnO6CC+3shDYzX3ks0wk4YuxbsdCCTbKdgHO3fEwHEkN0yx7w@mail.gmail.com>
Subject: Re: [RFC] branch: delete gone-upstream branches only when proven
 merged into a named ref
To: DonQuinleone <don@donquinleone.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Liberally trimming some LLM-ish prose?]

On Sat, Oct 24, 2026 at 12:01=E2=80=AFPM DonQuinleone <don@donquinleone.com=
> wrote:
>
> Hi Ben, Harald,
>
> Thanks both, this has been really helpful. I've tried each suggestion
> against the reproduction script with Git 2.56.0, and here's where I've
> got to.
>
> D. Ben Knoble wrote:
> > In this case, if "topic@{upstream}" was "origin/master", though,
> > "--delete-merged=3Dorigin/*" would work, no?
>
> Yes. With push.default=3Dcurrent, "git switch -c topic origin/master"
> and "git push origin topic", the dry run offers to delete topic
> once the pull request is merged. So the gap
> is only for people who follow the hosting services' advice and run
> "git push -u". That's the setup I'd hoped to help, and I suspect it's a c=
ommon
> one, but I agree the better long-term fix there is teaching the
> triangular setup. A document like the one you mentioned would be very
> welcome.

Yeah=E2=80=A6 I'm not too sure about the "push -u" setup, which only really
works when you push to/pull from the same place. I personally want to
spend my effort weaning folks off that model for triangular workflows
;)

> D. Ben Knoble wrote:
> > Rereading our docs for git-branch(1), I think what this RFC is
> > looking for is
> >
> >     git branch --list --merged=3Dorigin/main | xargs git branch -d
>
> That was my hope too, but it doesn't quite get there in the
> reproduction:
>
>    $ git branch --list --merged=3Dorigin/master | xargs git branch -d
>    error: branch '*' not found
>    error: cannot delete branch 'master' used by worktree at '...'
>    error: the branch 'topic' is not fully merged

Yeah, I missed that the default output format "git branch --list"
doesn't course-correct for being machine readable. But!

We can do

    git branch --list --format=3D'%(refname:lstrip=3D2)' [filters] | xargs =
=E2=80=A6

pretty easily!

> "git branch -d" checks topic
> against its upstream, which is gone, so it falls back to HEAD, and
> master is behind origin/master. Only
> -D [works], and that drops the check altogether.

Oh, that's interesting, I didn't know that about the deletion checks.
Still, one can easily dry-run (no xargs) and then -D if needed, I
suppose?

Not the best overall experience, but fairly composable, and something
that could be built in to Git over time perhaps? idk.

> (The listing also
> picks up master itself, and would pick up any branch that has been
> created but not yet committed to.)

Ah, yeah. That's a bummer, and the only things I can think of are to
explicitly omit it:

    | grep -v "^$(git branch --show-current)\$" | xargs =E2=80=A6

or to simply "let it go" (even with -D Git refuses to delete the
currently checked out branch). But that's a bit noisy.

> To me that points to the shape you sketched for (B), with one change:
> when -d is given list filters, the --merged commit is the proof as well
> as a filter.

At that point, I would lean towards teaching "-d" the same filters as
the rest of "git branch --list" (and possibly additional ones, like
--upstream-gone, if needed). That might involve some patches to make
the filtering logic shareable between the 2, teaching "-d" about them,
and then extending the set of filters?

Just a thought.

--=20
D. Ben Knoble
