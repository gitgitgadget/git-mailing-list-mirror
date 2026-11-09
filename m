Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794210217;
	b=ulYq7iQyeiE9EU8/Pmao4b1S1P3GHzsrb6A3S2iHYgjV89xSAh0gPnEJMZkWoEyyYqko
	 sGUuwCF6sd2YPwOwDMjrvKyXCyhRGHVEFIqC9Ov4c8ykvD5/b6u3gMa3LSArdAg8LettY
	 LV7rGSSNjXdxzsfDnA4aus57dy5ju03bXcV/3sN0RQ8r9V7itjfAJ/vaXCf+O2c/7U5Hq
	 jX/m+xCFHZeKh7C4m8HNjkfx6vVSX5DqTdpgBwixVqQIm6TAWS4RgY+UmFoCc/bhryU39
	 CWXrceIkwJempLBgP5M5Eeb5zlaTclvvi7v3jQbknFveVuyXTe04bylIJY9SQTm+O3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210217;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=nd78pemVoYAxjiWCuE0PYD0OeN0TzUPSQpUM7Bm9e3A=;
	b=Y7d/bosr5IEzKCU6sKoOEOzqb0XYjo/zsFLeolPGRSP237YXkFfJSOUfZskTwI6FZ9bw
	 Op8Cb9FIk1hDBV3ZPTqnhNrciI0598aICcRGDXfyb6RafuY28YuETrt+dzg5hq5Gn0Ebu
	 trUiGknLT9/7xzpyTtoycZMnHNX4tHRbqt/pnFeKpElVsEsP62bAUfT1AtURwsBwCffKp
	 /aMZ8nsMroJpQFxTfm1uLwzKb8c0kaZtCXUZklIrTelAQWLSFbVEoPM84ZbijuvUBBWhj
	 Hp4Wm0vihXQVSDEv5ObXPiLw302l0HNRqOlwUw3as+AezPdcU7XpfV6TBrYQFPsggXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=d57zHX5A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AED606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 07:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4AED606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=d57zHX5A
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b7245ab5e2so845691a12.1
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 23:43:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794210215; cv=none;
        d=google.com; s=arc-20260327;
        b=FHY2G3jAONhtaEZvb/g0xUpE8bfWqkkwWpYDjy+EGrx24pnRvH3fCG4m0F3pWPKA8k
         QRIYtzKgOXO9ZaqElpPs+AheLftmSI05FWdekyr5wU7yqzcyc8L4k47YZsWD+gDxJyRr
         4AQmIweWOo+fL4S/sCmXHxrK8w9bNeqNyMyzfm8/B/0lRadUu3X8E2fNUxRq0/gXJrhY
         PQ8UYEl1aYEoGh/Yy9OZToCn1gPL2PCEUJtpupQ9Kf2mhBV5m72FX9CylVED+usOoA0E
         tMgqX2gHR3jRfOOjwOGtQZjlAKYB6WnNAgZrOPm+fXjukzuAV4Aze+dAgCC26pjLZeyV
         wH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nd78pemVoYAxjiWCuE0PYD0OeN0TzUPSQpUM7Bm9e3A=;
        fh=StUjxtPbUuH5JuA7/EGRz/sLkBdJYKXwbPhYJp1al90=;
        b=TBNlmvF1HbuqghYtd8ZBp0Jk9tMhFWX5/yR3WxSfwrFWY1nKLwL+OSCmE0cTzuBb+t
         Mvqrlb8NsqqtDVvfNy50JmMwktGM1fjBA3EhhkeMo6gxVcMm8a0YveKco+/tgenf2Tqp
         Dp3Q4uTdBj5rvxNLjLTIGrisHr5JSk942WHChnaGro292sG0aZud2309pO4XcjkUrPvm
         ncxhFYjkwPBz0tuBqnQBFWfgA4vxFrGU5LdYbLxSnfjfkrtJ4vPJV3ffqAPzTHARH6PK
         DKRS6fHGvJu/+192gncJQWIqtHIqcDPtEMjOov2qRtWcC+p/X+J7B/qTha/twWWm2OmD
         wdFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1794210215; x=1794815015; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nd78pemVoYAxjiWCuE0PYD0OeN0TzUPSQpUM7Bm9e3A=;
        b=d57zHX5Ak3Hsxt+y5Wismin9hN6sMQjomb9bNhQcnRFFur04yLSDY8fh7xpXsJIlbY
         H9vASUWdzrnmGD0KxY4CECrppMba5ERsdGoIUBJTGR5Kny4nLp7WEqP6iXdmfj5JNHuu
         LlQEiZTLjtLNJHN78vi7S9AC4qDoKlXYcp5mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794210215; x=1794815015;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nd78pemVoYAxjiWCuE0PYD0OeN0TzUPSQpUM7Bm9e3A=;
        b=AE1XCAjjpwOXV6khcaIDCCQv4lNsfi0aIFiN0G+uodYmPmseyHNDdKEvaIgi9fTZUh
         xLO+v9NmdaNeA4AYtOKLwfsjQTP2pf6p0rx6rnxtLXT0SWWQnL8vNkjXV3QFiUjv6d5q
         PxhVtjun/X1K9dExaVgPyTl3usckFYP8mkzswSp3d7Tcb+CuXCEgxx/kFTC1YQHBQCRH
         8VgVpVY/cDK5lgIxjdBMjJTcqFf3+2Q0TTYGQxnFQVbhCzz4NsU0GNv9UuKN8iXaW8/5
         +vemhOWz5oUeEEN3Obq2zD/h3QAqPWJgAJeTP8I1xPXh/dB7dtGWGkrkRltOZS43PHEe
         M+DQ==
X-Forwarded-Encrypted: i=1; AL+hErGqz4Vl3NO+/LBk/oynFju/CqV/6wf7Z0sHz4ELHx8GmveRiJVp53zuPb0NIT/MkPxP31k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8zoHx3N9+eQhKMRlcpx0sP+UwcKWkgj2ZDO2Qu8nQMyLHEwg+
	5z72CNQ1be7LvoIc2FBCFGtsVgCSMBMcrJecJlI8XiAY0SVDz6H2kyEORlbNC2QCIiIYBNaroaL
	p5dklNl/jZh9DVwnaoCvxP768UoYJg64m6KahJxIckA==
X-Gm-Gg: AYBFou3hZbpaqrlHoQxi1WSNTykzdziSXYSzlAYaOxczcWYMHj8ZZL2koXuGQbXsaWk
	ET0wi3dnVmSdK9L1QgGjI6glGXXEQ4ChjM4q6ylHdOXdQ/JWIKv8pmbzcEkUt9ZdyjwGoAMmeZp
	nrEQENmeXwz2bSqGZ5XAnIG4Jf9opqxORdFQjcKrOn/xrt/pbK6Hnhx+MkOc3Xs/UI1STSj/jVR
	ZCyoVaC4VTkC/kt6DjKV0dHvfm1VNdH3L9xcsHpjOUi9PR7H4x4tNGnwrRBTBIYfXiCPE8dg1ce
	qQy0h3n67PwYmmRN0t8ngPdspA2HalqSnVyQoNKJqyzDQo2q0zIaYWLNnDYy/2IpB4W+IbS7oUB
	P1PnEYBqisB1AcZE1AP3y1lfUytoBztKdLacNzQ==
X-Received: by 2002:a17:907:968d:b0:c49:9247:9688 with SMTP id
 a640c23a62f3a-c4d52577c14mr355692066b.7.1794210214987; Sun, 08 Nov 2026
 23:43:34 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
 <pull.2301.v2.git.1794165304.gitgitgadget@gmail.com> <54139a3a97127732e11fc5abbc9a3687542669f6.1794165304.git.gitgitgadget@gmail.com>
 <avFvYD5K4SKlveiI@pks.im>
In-Reply-To: <avFvYD5K4SKlveiI@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 9 Nov 2026 08:43:22 +0100
X-Gm-Features: AclHuK9PPMPVw-XTIat4ljiqPtW7nikKuWKoJgQPL79-cjQph4xhZ4z2T1-HpTw
Message-ID: <CAL71e4Mrw2h-D+yKLVE30q-7dnkT31CVsyVmktmS9Wx6Xu6ocQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t: add "test-tool genbytes" to avoid slow tr(1) on macOS
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 07:59, Patrick Steinhardt <ps@pks.im> wrote:
>
> Okay. The diff is unfortunately quite useless as we do the file rename
> plus all the changes in a single step. It might've been helpful to split
> this up into:
>
>   1. A rename of the file.
>
>   2. A refactoring of `cmd_genzeros()` to use the write buffer.
>
>   3. A change to introduce `cmd_genbytes()`.
>
> But maybe I'm also overdoing this.

v1 had the rename as a separate commit, and Junio preferred to have
it squashed into the change.  I do not have a strong opinion either
way, so I will wait for a consensus before sending v3.

>
> > +     return 0;
> > +}
> > +
> > +static intmax_t parse_count(int argc, const char **argv, int pos)
> > +{
> > +     return pos < argc ? strtoimax(argv[pos], NULL, 0) : -1;
> > +}
>
> We can use `git_parse_signed()` instead.

Good idea.  It would also reject invalid counts, which are currently
silently treated as 0.

> I wonder about the regression in readability though. Maybe that's just
> me, but I don't happen to know all ASCII values by heart, so if I were
> to read this I would now wonder what's so special about 61. And the next
> thing to wonder about is whether this is supposed to encode "=" (decimal
> 61) or "a" (hexadecimal 61), and without reading the code of genbytes I
> would not be able to tell.
>
> So can we maybe make the underpinning logic a bit more intelligent, e.g.
> by accepting "\NNN" or "\xNN" syntax instead of two hex characters? That
> might also make it more extensible going forward if the next developer
> wants to make genbytes take and repeat strings of arbitrary length
> as-is.

That made me look at what the callers actually need:

  callers                     need
  t1007 (4x), t5318           NUL bytes
  t1051 (2x), t1450 (2x),     any byte, only the size matters
    t4141
  t0613, t4205, t7006, t9850  any byte except NUL and newline
  t5300                       three different non-NUL bytes

So none of them needs a particular byte value, and the only special
case is NUL, which "genzeros" already covers.  For everything else, a
plain character is the most readable:

Given that, I am now leaning towards keeping "genzeros" as it is and
adding "genbytes <char> [<count>]" for the other callers, i.e. going
back to v1 without its last patch (and without a separate rename
patch).  That avoids inventing a syntax for NUL, keeps the call
sites readable, and also leaves the existing "genzeros" callers
alone, which addresses Johannes' concern about the churn.

Junio, would that be acceptable, given your suggestion to use hex
digits so that NUL does not need special treatment?

The rename is perhaps less important to do if genzeros is kept
(though it also gains the genbytes function).

Thanks,
Kristofer
