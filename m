Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795630407;
	b=nijsVRq0f+p2+czW2A+e4cKEFHITd1ioAnqa12NOG6MhApg3Lp3lZcvyKi3lQZ+XzVQc
	 rNC1C26vkeYdfWqARrR43vkjum09dUbN3g9kpTaOxa9nwy+4/pwmc5vzVpq31T/rMpk1z
	 1C70aH4gWsNcqd8sF6yrpHSUwn5zO5H7MPkHDuWdRClpUueEoTbs+Oz9JgY+o6fHjZlCg
	 xOeMytZxf6i1GvBMue12JnnqGJWfY8e5h0e9ekQuCPf1tnNBOIEgq6DtVXBbs8jsWv7Hp
	 nzUw6Y9USpVvI+D5mTW3SGT4nUh0IFeBzQhNoDHMl52v5s6s9i9X/i134uGVVXglqpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dxTcSuSrCjdvwL/7iEPonQHSAhLbYNvbU0ABS18l6ao=;
	b=MTJXW4c0jbWMPtBfcXIMoVLyxWFp/hcZNxvahR1XRgI2qnZ3yVRFzuUZLufdTuggXJhS
	 VcaMwVgdpNPbDTn+0M5KL6Ln9X1wAY50M0dHXxa/DQ7W0DtMWCsdRVTB2W7D1Jfnf1X3w
	 ZxxG+sYSmtzAms1XfAlGhEEuTtqKhwtECKAdtoiInM0vJpout2Zeaw/COdhXIxoTj+h/3
	 JLfH1QRz0eZr05ADBMf54zAD+wvnK+FjtFYn0lZTL7TRN8RZglYwvBn83Dau1c0+fT6dE
	 yD4RhY9kYPldc+Z8h0MmR9RqWpSGrw50cb0gV1IJhnhGR3OiZ3BmE40IJbTUTYwybzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pq5jDE5m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4248F606A696
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 18:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4248F606A696
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pq5jDE5m
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67dae7d3f7dso7304830d50.2
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 10:13:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795630406; cv=none;
        d=google.com; s=arc-20260327;
        b=JgEpEHiy+ZQImGu6bbtsNr59XBvX6XFWCHDvhfIjjTNeKl5l12e0c/7kP5RKJ3ib0v
         pRVGwI9aRlaT1qGYji2qZiGOFmIMmyTyC4bub8I5ntbXSNS4Jn2B2Cs+pmF0+IxqV+6Y
         HGLpt+QpdJycwY3cDN9EyOvybLNN2Gxu7EV3XZwhGrehdlE0GGRmaWFX+DdEqQJs6sd1
         Lnn3ktuP84qw4NhftFu2zhrorKWMxplnHhFzkqYdv75ImwNuMnry32wjE2ccnrDM1uDb
         qEKmUA4QjUqTpyCB7sNxzWht/WGoHeG5Oj9uoqwpO4bxz2RrGEQSi1vJi/wvbtUiFILm
         cDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dxTcSuSrCjdvwL/7iEPonQHSAhLbYNvbU0ABS18l6ao=;
        fh=KB7XS3PUrwsuadSkaPx6sVcrKkMH9pWiqnReHyvCiU4=;
        b=pUgEjP25dMzMdNXKfAtF11fBeN8t1jr5Py1U7CZ0YnaSX2SDERgaLNzAvXZuX2B5GY
         C76DAJJ3r2uxg7tWOt27J9N1OakJXcZ62/QiuFa4o6EVQKACS/M63b2nTMcht159Woss
         sV291KNGxcoLEK5FHwyGWod2W5UtqOPx0YYwpnp0W2vFPhbXmaTfXYUty5QsO+6kDa9R
         3PSASpjIMjTz/zvPoxUKaARsuWg2aKAOuGY4QwWGo/wlW1wok8lPkh0KH6L3/Dequ9yf
         W7a9o7uBZjeYmBIYPEk8DmjjBk/Q7nVvbwai83Lepstb0hyjUZFDizsjsXvRumN0JtI/
         bUCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795630406; x=1796235206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dxTcSuSrCjdvwL/7iEPonQHSAhLbYNvbU0ABS18l6ao=;
        b=pq5jDE5m+IG1FVLYivIc0T4LLuYARzd6WwfJhen36WvTgdQTc77kBBh5fyUv3rpJ/H
         x2LWOnQOLNbsTUexKRSTdmILyY0XkfUTqzspyV27OfwuWP5PXr7a8+uc1zhq7ygnyYy4
         B1Ycjg86fFvl2aUXB3JzvU+Iv+cYkXJxyNkfndyHi6REg+7+yK5Ck17+yFlJzYuk/U15
         lfkKbc5s9eKiHRx/locz2zwZt5BJf/2Pf32g9H2WzVNk7bcV5N1BP9bn4NMvLD+mhCJa
         HWAFTE1rluTunaSlZ+2HYGjNONkbVtLURgq/TPkmD8dmDjaAxItC55hPM5ttWcAxJ27i
         dqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795630406; x=1796235206;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dxTcSuSrCjdvwL/7iEPonQHSAhLbYNvbU0ABS18l6ao=;
        b=nH+pUf71rjQvwC0isn5bzRiLdk5cvgVAh/xFvXAGZKji3sWjettcD0KZFqg1Wb3HJl
         zUnKwEddZiRJRbHbrZ/2IBlDTZYF5j9HSL5gll6DAdDyDMmxvSrmxJ4/QReppRHEe+7f
         mP9ItZ9om667g0XSa1N+5TDu3UaeFxjlVdjKQKr0SX4EOgVLBXmq5yVj+jUoR1D8/jGb
         +HVeoZEtln43DYmyNMiH4RxwR3fv7znwoNsaptr5Ig3C9y9R28+H2PUDzG3T4Q4KDNo3
         XfYFMhViAV6jsw+P6iWB2fpiH+WLCdALKWuPpNlqlMowtJkBqK5oxvoFHO3AXtou5Fh7
         0oGQ==
X-Forwarded-Encrypted: i=1; AL+hErH5fyeysjT15VP8NH8rcl7+v7erMTX87h+D/EyCFIZWxUCXgjdTlknrZavQDBMIXO/BJeQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nwuZybsfQdiALQKg8xeg+xf7AyGi2LG3vB9/dx10MxJasb4Es
	fIAC5yocBRXvc/iTiPuQZzxd5K+5jIkBYFhkiGGg26DdlYomF3uhVJkAxcMAoL0eJMi2sxDFice
	qzEhoqulmXuotI1RWkEV/nJtqx31sSVHRwyJGepA=
X-Gm-Gg: AZFdTZcR//2kU+Bw+AO3DGIntkVTmthc2/gA9iSrMk3YHSmICq3+gInjA3qUOhnGXCu
	Or295V7IModYoI0HpLdC5V3BsqCSDP7kFC97qqhX9gT7XPDXRJhJ96mj7ZZLKXtKj8EBK93BQ6S
	XVNRvKJ7S7H5+daKV8gBDSDg+yZOnQ3F7vYcuR45piXgGTmxQWQCiFrDmTF6NkZFw/WWZyYju1D
	vXW7md2m7FnjEshCK/tuLhvKzI3tlwBk/BjdD/keE0eI9DEcySnlQtja1+WrBqj7bjngK1IMhP+
	D4CFwZvPN2KAWrWF9a+VN3rOX+Yukq+hqO7vWL5FY8lpzwqV10HLl7WcEcugzXdWxes4vF6MewI
	e2DYGYY3AyHWH/8EfEtj/mfY4eVPj0/YOjXTzVBlLLwUnBtvh+P9v7IjqdWHkEmqM+DqImNySfh
	XqkUjzORbOLG8rLd/1ObvaeoJYqeq8kmil0z7UlzCz0J/94hEGMNxYQrp2u9WlIQbtqDDTDjSCb
	TxFwtAof24ifQg5xGOrIj93lYRzh2m+QMZwWA==
X-Received: by 2002:a05:690e:484a:b0:67d:b3b0:e03f with SMTP id
 956f58d0204a3-67df43f3e19mr4117921d50.48.1795630406118; Wed, 25 Nov 2026
 10:13:26 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
 <20261124172146.18330-1-okhuomonajayi54@gmail.com> <20261124172146.18330-3-okhuomonajayi54@gmail.com>
 <xmqqtsl5g28h.fsf@gitster.g> <CAFpMFfDnfJRt1HGx60esEeC-spfBbr4KKzp9ocLFceAMESx1yg@mail.gmail.com>
 <CAP8UFD3Pf-0T13OAPO312tm6DdYdmF_-NR6zRyk9-T1h9Qoi=Q@mail.gmail.com>
In-Reply-To: <CAP8UFD3Pf-0T13OAPO312tm6DdYdmF_-NR6zRyk9-T1h9Qoi=Q@mail.gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Wed, 25 Nov 2026 19:13:14 +0100
X-Gm-Features: Aa3M54rdQ300diQ645b3SY-6X47dhH5daNPxe_z_aiEzXDKK6OXNxZ751Ne9Ijs
Message-ID: <CAFpMFfAGzqWS-N4YBtCy6ar2aJm0TzyQtZEvVUozuC8qghBQSA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] notes: use the tree's repository when reading notes
To: Christian Couder <christian.couder@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, ps@pks.im, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 8:25 AM Christian Couder
<christian.couder@gmail.com> wrote:
> It looks like load_subtree() can be reached in other ways, as subtrees
> are unpacked on demand, like for example:
> get_note() -> note_tree_find() -> note_tree_search() -> load_subtree()

Ah, right. I was only looking at the init path and missed that
note_tree_search() unpacks subtrees lazily, so load_subtree() (and
add_non_note() under it) gets reached during ordinary lookups too, not
just from init_notes().

So the cleaner way to put it is yours, the safety comes from the entry
points, not the individual helpers. The public ones (add_note(),
remove_note(), get_note()) swap a NULL 't' for &default_notes_tree and
assert t->initialized before anything downstream runs, and the internal
format_note() does the same NULL swap and initializes the tree if it
isn't already. Either way 't' is valid by the time we reach
note_tree_find()/load_subtree(). copy_note() is the only one that reads
t->repo without that guard, which is what 3/5 fixes. I'll fold that into
the 2/5 commit message.

Okhuomon

On Wed, Nov 25, 2026 at 9:25=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Nov 25, 2026 at 7:45=E2=80=AFAM Okhuomon Ajayi
> <okhuomonajayi54@gmail.com> wrote:
> >
> > On Mon, Nov 24, 2026 at 1:34 AM Junio C Hamano <gitster@pobox.com> wrot=
e:
> > > But others? note_tree_find() calls note_tree_search() which by itself
> > > does not touch 't' at all [...] The conversion in this step would cau=
se
> > > them to dereference t->repo without checking if t is not NULL or
> > > t->initialized [...]
> >
> > note_tree_find() has a single caller, get_note(). It replaces a NULL 't=
'
> > with &default_notes_tree and asserts t->initialized before passing
> > t->root down, so 't' is already non-NULL and initialized by the time we
> > read t->repo. note_tree_search() not touching 't' doesn't matter here,
> > since get_note() has already dereferenced it.
> >
> > The other functions this patch converts are safe too, for slightly
> > different reasons: remove_note() and format_note() guard a NULL 't'
> > themselves, and add_non_note() and load_subtree() are only reached from
> > init_notes() (and load_subtree()'s own recursion), where 't' is the tre=
e
> > being initialized and so is never NULL. So I believe this step is safe
> > as it stands.
>
> It looks like load_subtree() can be reached in other ways, as subtrees
> are unpacked on demand, like for example:
>
> get_note() -> note_tree_find() -> note_tree_search() -> load_subtree()
>
> So I think that the real argument why the other functions are safe is
> that all the public entry points (add_note(), remove_note(),
> get_note(), etc., and the internal format_note()) are safe as they
> replace a NULL `t` with `&default_notes_tree` and assert
> `t->initialized`.
>
> copy_note() seems to be the only public function that doesn't do that,
> which is what Junio found in 3/5.
>
> It would be nice if the commit message of 2/5 in v5 briefly explained thi=
s.
>
> Thanks.
