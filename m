Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B8633936B
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701888; cv=pass; b=fPwLY3+MTrHeRz0gPeMGIYKwqFyxwY5hJoufDq1Ormg/P+kbXmmN7pIOuG8SCw1O4mzfbAzETHK3kRaH1c8b/FKzr/p9yqMG+ZORiOaySaCL3qq+taDlJw/i1qfteuWD8sWcOekWiVA52DDD9e4wYNo0dk9FwH441GcKW3nS0IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701888; c=relaxed/simple;
	bh=yoR0zyysiEWcq0C4+XgheIeBE5bSANxP5MPy4Zqsgx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPcYtczbqE0p9BZYFsSmLHchNVIevULaM60Xk8Sxbyu6b5iKw/8NjzvqV2IvP0CdAP6Xk+AjrgGSymu6HA4BFnTeFRx4FqmYvHA0xcuMGReiGm8PNParkCtMQFtHYO5c2Sj1iALwJ8HIvu8K3tjJHm6dapFvOQ54hbEv4x2mtKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZgnJVrE; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZgnJVrE"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-852c481415fso2901165b3a.3
        for <git@vger.kernel.org>; Sun, 06 Sep 2026 06:38:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788701887; cv=none;
        d=google.com; s=arc-20260327;
        b=MrLnIkbzalUBELLsWMrQlYlZFAku7QTHIhv0cp8NG0RqpQOPmfDLkia1nyED9962h2
         2Ow0e+SN66SiDabj0v+nl3FEOxZ7mmbOtDuP4sWtKUSAzk4Zs7QgIBR6L9eg58iBaFRP
         NNoIZSdjDMkvkVtNiBbg4/aCsiF/YOfOYKV7OsfmL3NXwbvKklvlQ931ljYpJbWq0Mqs
         nOY6T/QJUzr9xDj6AIeuJOTALjK3Q1nQG9kpy5sgpbnW0FHQxhgjVkoz9Gj+y9pwQItQ
         nEJHP6oVGoKak4gtu2KeKb+Y+i1niyA5GdXiV0kDpQRtkjJp51EFeqUQCDpegZjWxs8H
         dzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/13ir/n2Tz3nEusbknmj9Ld9Gm8d8xf0ojpYntmVOrw=;
        fh=hqzuVMyjvmd94hheCg9Ge0XnswR74rPMeJmxVj6qo44=;
        b=r1oDockN0s6S41M/PunXG7Jpu9CCHJaxA9/PlHlN6WPQ0qHnOJioiVNa0CQ9Osoej6
         sGlXrDXHqgE3456doaWHddSWsFWLXIMYmqXXk6f7PyHfcIXNn551NkNTdF0vGQyBbg/d
         NYJeHLh7AA8Ch2aBHNMvTD23asBnx1Kjop+nr7tihsRBg0gsaQIQ5m4KeyXXNw9P/cdX
         9dQK3zPfpKykus9MG2gboAcE5yiR9d9KBQMxESvhXr9z4xmRY02U4QA+mRFnE/rTL4pA
         +Cui9Uvi/coVwDpExU6yDG7Wzn4Hg7iWFwaF8mBwbXIeoFF6MChVyELllx+J8TQCvObC
         9pQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788701887; x=1789306687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/13ir/n2Tz3nEusbknmj9Ld9Gm8d8xf0ojpYntmVOrw=;
        b=bZgnJVrEtOmja8BQiIgSw1rf5wwsaKO/XiaOxQJyHZBV5MKs/rUGYRZkJ8r71OoCFF
         2pRO0x5TxSVqpPdnMEJWsvddNkbiutFfuDqNgTx9yhTKxmtihZoQaQ15dbm5NQgjEHOu
         nbOhvJNYKw3mIj6tYyn/XTIdH9eBWeSHraktf/ukNhKsFM9qrPghOlW6lCGwSYhTs/Mp
         eFIES1Co6uJtPyemE4xfxssGwfYsJ6MnqabovhlYIEzhOXElL1L/ui47eZPBTB9LxQqM
         kwrhA9/kcNyzLbUtE6b5G3Hi0IxQ5fE0MzQwGs07OCtzzY4Eui16lepBHgrXTSGTJpo8
         KtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788701887; x=1789306687;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/13ir/n2Tz3nEusbknmj9Ld9Gm8d8xf0ojpYntmVOrw=;
        b=sNhG+qjvguMPpHYKg0DLJ8vp163wZGjvKF+qsbB1VGWw7Jqb0KuNAUJ8aFmVeSkO14
         iHtB+6rXCP7GpBTC/QDKZl76/FQ4uNsjnjS9ozigLLQ8iVCBwfC5ZvzxIvqEHYg4IoLP
         jVL0gMlYjejZIoPa4eUvR0VOR34zzFU3u8QrkWZ0TAy11+s4WlJ6RGCAbDCspaVjLv69
         Lu5ZZ+WdA7HHoe7FEUqfVli9i8ulTYl0NQwn1aI3P30vD52AJkCyG9v/A825ho2tyvW2
         U3znor8NJ8Dx7H1E2cmBBrFPdIua1GgnVJ2Zzg8ggUhoBsq+x06G1nAVWx2OB1zQc+rQ
         hRdw==
X-Forwarded-Encrypted: i=1; AKwUvBxWhphC2Lj9OcxvPPe20r2HhCLQ8ypj4pZCzv7HhTX7cDYullqcyjm8D4tdGY3w4lA4Sto=@vger.kernel.org
X-Gm-Message-State: AFuF++l2qHMt+l/B3bdAhzDzyOJEgpkC2nMGA5RuoCSVIBGP02Gg6UG7
	ZQEyVtMwRdgUldBqV9LRW0EVYvFXK4wgljtAtSSVtv8HRmAV9Pjd842Ij6Tc+rUZLZjPFdoCybX
	/8Y9dH8MIi7eD5ru9r3KGuP09vJnPR0rf+w==
X-Gm-Gg: AYBFou2AKD6F5UO7g6PAM58ch7tuvwj3rQI/DZ/BGPkble7utJbhdI3KF0SACb2Ksd5
	T5r8WDGZ9XR7vyDG9rhirzMwSnfOzf1U0OyRlvHG2mTpRi6UaTnR1XGn/ZwF0mM3ct+N7i6dEJ7
	tU0LREEYfvA84Jx56pcdMmfovXwMabivTsSJa9Z/GmFkBy20xhik7bkYwpVvawrxo0iLmLQDBBT
	X7foQmUn7aqwcwSa/xYk6yNbEmkTopoP0Z44UjOVLlYY9bSTHcsV4xBq/kNxqGuiJqfnSqKrR6Q
	FEyYCqZ0hrgi3m7TcTB7c1JqJv6naLv7PgbswbzM7pmHQd2x0URwIrkDq/bOL4Vdx0FFvvkRGY7
	xQ6ZaefE16vRC8GZmfOorU6L3EA5SRIQh7R034RQb/TFuKlArieX3vXksDWe3tAbU7nkDi8V52Q
	==
X-Received: by 2002:a05:6a21:d84:b0:3d2:2011:d184 with SMTP id
 adf61e73a8af0-3da3a096045mr29031580637.14.1788701886738; Sun, 06 Sep 2026
 06:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
 <format-patch_learn_--range-diff-notes.c5a@msgid.xyz> <xmqqjypfp2vl.fsf@gitster.g>
 <16315616-097a-4fe2-8665-010e424afd8b@app.fastmail.com> <xmqqbjan6q7l.fsf@gitster.g>
 <9335a35f-e9c0-4e62-812c-e5855c201003@app.fastmail.com> <xmqqpkz24193.fsf@gitster.g>
 <b3c66de3-0ced-446f-9bd6-73412a8c92b5@app.fastmail.com> <e3b7ef75-08e6-4529-ac75-56f800d2f4a4@app.fastmail.com>
In-Reply-To: <e3b7ef75-08e6-4529-ac75-56f800d2f4a4@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sun, 6 Sep 2026 09:37:55 -0400
X-Gm-Features: AcwNN1UBWGAz7IO4sMhju7BPcN8k0yVD3A4r3egK5N7A9JExcDs5bnJO5FVQ7bY
Message-ID: <CALnO6CA-6m58sJCf=5_GwK3GE8=EfhzgsheWBqMQjc0r+N7+Xg@mail.gmail.com>
Subject: Re: [PATCH 3/3] format-patch: learn --[no-]range-diff-notes
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 3:23=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Wed, Sep 2, 2026, at 15:19, Kristoffer Haugsbakk wrote:
> > On Fri, Aug 28, 2026, at 19:13, Junio C Hamano wrote:
[snip]
> >> That is fine by me.  I was hoping that you'd come up with a way to
> >> add this new option with simpler-to-explain interactions.  E.g.,
> >> when only --notes exists on the command line, it is used as the
> >> material compared by the range-diff and as the material inserted
> >> into the final output, but when both options exist, they work
> >> independently, i.e., --notes gets used only as the final output,
> >> while --range-diff-notes gets used only for comparison material,
> >> or something like that.
> >
> > This is how it works. The `--range-diff-notes` behavior that the doc
> > discusses is just the special case when the list of notes for the range
> > diff is empty.
> >
> > That this wasn=E2=80=99t clear is the fault of the doc here.
>
> Seeing as how the doc was unclear and did not spell out how you can
> build two separate list of notes, here=E2=80=99s a draft of a rewrite:
>
>     `--range-diff-notes[=3D<ref>]`::
>     `--no-range-diff-notes`::
>             Used with `--range-diff`, tweak what notes to display in the
>             range diff.
>     +
>     The default behavior is to display the same notes in the range diff a=
s
>     on the patches; see `--notes`. But you can use these options to use a
>     different list of notes. For example, say you have given three notes
>     refs to `--notes`. At this point those same three notes will be
>     displayed in the range diff. But then you pass
>     `--range-diff-notes=3D<ref>`. Now the range diff will only display
>     _<ref>_. You can of course pass more refs to this option, just like
>     `--notes`. And you can also turn off all notes with
>     `--no-range-diff-notes`.
>     +
>     You may want to turn off this notes override behavior after it has be=
en

[nit: should we call this "no notes" override behavior? Otherwise I
think we are referring to --range-diff-notes=3D<ref> overriding
--notes=3D=E2=80=A6]

>     activated. Use this sequence to do that:
>     +
>     ----
>     --no-range-diff-notes --range-diff-notes
>     ----
>     +
>     Now the range diff is back to displaying the same notes as the
>     patches. Going back to the three `--notes` example: now the range dif=
f
>     will show all three notes again.

A bit long, but easy to follow and understand the interactions, I
think. The examples are helpful.

--=20
D. Ben Knoble
