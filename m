Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C173ECBD6
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774950786; cv=pass; b=OqNhNCUGFuQm8AeVjgWK7EBby2VxgMLUglefXgLtl+ftC8LLlhu6WtXwzrHXTJCl0ewTt0OQRMNWlftxILGZHMAXpMoYJcwr4MvlfhZHj+FH7FtJBkVvLZASqfy/g+LIPiMtWMS+36DmOdXgqaoklUphOtCc0J0QK84jadoHnNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774950786; c=relaxed/simple;
	bh=2HUOOFxG6pR9+Q9PO8Vg/b7gZnUxeW35PCQbrTVQrMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvI+Mplur8kIxBQuYHtRv4XPUoo7POnxO6jAo0B+Dwv95tGI7Hi3BX5zFtvQvJpox0idtOpzZyXQtGWw+/+CvM2gVEoPAwZ0IoQ3f7OvDRV9MMsXN5dgUM71NbnITjRE3W3Gt40cl5h3EIcdc0dElT5g7i+vEA40+HO8lH7DOhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gip9pLIC; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gip9pLIC"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56d3fa1ea69so1611670e0c.3
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 02:53:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774950784; cv=none;
        d=google.com; s=arc-20240605;
        b=dZdVt6VPDzKfNABz1um2HBvbiUGKGPrD7fV0KmarSH8/gkO/42HqIp84ZnJduYRDCL
         xt48KvcoA/dkSqH1AtLrOb0CbGEvkBvPzvKJXKANy3LmSeRFhoK8n6qN9cm/hz+WmWPx
         ebBMoHTG0lML0Wubqo9Vo4VDz+GfYcfNN3IfcHGSKq5JRjCkP123IvqQkNJPS9LT61IW
         8NTJCSBNk66gpwwG/JmQrWWNgMD608+LO7tGYv9w9QRUcIQC6sUrmFcdSRXA+6jj82iG
         UzWrtmaS+Rit0dCj21P6BMdKAi2Q4KYs52wm/dwqX33U1VDinys7fMPM4W92vRYAUYDq
         vuOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wY4p1VQEzbGFztCCUtiuelsIDeW5dn8tiOS+0/O8Stw=;
        fh=AoiZ37prslz0Djt4iuvNHjCNCJK99HKH9+MUhgfX0tA=;
        b=O9ieFHmfSlp5MmAAo9K8US2UGoAwK9V/5tfpIV3vBFUM9eWFvlV/BMyU6UZ98CaiSx
         9b7o5XYgR7iou8NRixmnPewbEWZvu1GU3tGT4VU1F9wjgYWWbOk8T8JwN16w/tyTpAj/
         pIjdMbreT8mH+NEWLvgBFpUSuDJ1PQ1O9kNu7xrYutftEhHLj7l6cB2axi9c5hCCHzI4
         lAZRQNJPiz4r3xToabqbqwG83PeVbOSjTm7jdERj8FL+d1JoyYAfxoZztmZMs4EEm8ri
         Y22521lcOtIDUXWPxXoYiszwAI5qf8hKYHi9T6pMijsMumJf4AUHBfYUZMvRJcHy5hQ1
         IxHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774950784; x=1775555584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wY4p1VQEzbGFztCCUtiuelsIDeW5dn8tiOS+0/O8Stw=;
        b=Gip9pLICvMfbHXBTufdBXHb4hqMQddS/lO6jAy6Q9tTJrhBRBGrpMGq7DYZw0Q8/Xj
         lkriUrkC3Lf0soOoEitgU21VLQmcyFGdTar+60YZgsmjWS9Lc26E91FfUdYDwPiim5RZ
         VverKSpqXKt2qh45AY9OXrneRmpaozuIAEbx0dzIjOMLpCSdFAoGPmO12A03o4zMmdoC
         WnryHgos3pvpbUXhh9O/5T2o/b6UyB3Ic5rT5H4230d0jCRdMrZwsQQt3tB7VDipMUNm
         iFiOHzVvbx/IQ3kenqnl3ORU5U3930hQJIJZ7jcuENNG4l8sMO4fgxLy/L3X0dOo3xX4
         +C+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774950784; x=1775555584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wY4p1VQEzbGFztCCUtiuelsIDeW5dn8tiOS+0/O8Stw=;
        b=gtIAnOEdayWayHu6+Hng+o9NjvdPU6qkBGuTXLRlIvgjtUbMfroyphIMqF+k2pm27w
         cBizajhS4aOOTrpC/oIJCLCSQMTJmEdkI33+8in4FImmAyjwf4fycdSYBRBBpE0hKjxP
         rXg2XDWQ9I59layseT+eF2MKrnzHLQngOVvgFWgYY6WIBCyXA1H1ze5+pt5gc/ixrCIu
         r/W8CVkcEWWppTnhEwstrKkaiVGTits2oVGt9wa2gt3eSVrUCweMitBHq7NC3zY9n4NS
         6RJCJT0S2IUeycjM/WghEJqWjKMXlqaO8oYsmZfp+mmsuxMATp8hktd8hsopC77j5CyR
         1B7w==
X-Gm-Message-State: AOJu0YyNBxzRJYX+1bFThm6QcVIQ1/+vUiVGe5bnsLGh7pwnaQAowBGL
	51kuFgvj63SaGH3uCgaEbE70LXELYHUrhNLwbevFuK27GcMajQm5inw3CPvd7CRlZl0qg1vRJZx
	UYKNBczpQwGpB2yBpglTYTghlUXRIosoUqnG3wHA=
X-Gm-Gg: ATEYQzzh3hmaRovVLtC3d/La+32rIwuISJTW4QZsUcnLObMJwjThtMDx/btvSv2StQV
	62qAHHenqFUEFifbZoz6HsCTf9WpFSZEWs06+KlIAhAxoLV92hDyoX1U6isvcFRpglZpJg6LoVC
	2MWjeuHM1WMJYa8zAYT9UkWt63oZu0ARsit/x6pnjXGo086Kf0riI9HM0o1iQcMFtxy6tt8fQBF
	NtV7KuXjMLVLiuZTnXXzcuQ59VxaMKXCmQa2OnjXw4ZNFsW4g937LlpmP8UWRJnwRlaLB/j9vzp
	tPV1F2QK
X-Received: by 2002:a05:6122:1d03:b0:56a:9841:efd4 with SMTP id
 71dfb90a1353d-56d4a4cabbfmr5639718e0c.1.1774950783964; Tue, 31 Mar 2026
 02:53:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <acasFS_UXC8NybtE@Adekunles-MacBook-Air.local> <actjaxIkDEXHJbyi@pks.im>
In-Reply-To: <actjaxIkDEXHJbyi@pks.im>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Tue, 31 Mar 2026 10:53:04 +0100
X-Gm-Features: AQROBzDk_Ks1X8c0PdCdPj_EgkSB-JLIA_Gs1ZxVb7nRTuM0F-wEew2iromwCcU
Message-ID: <CADYq+fbLFH-gc9=N9H63N74wr2CEZDxwRAxdvc1Jq6R0dCsOeQ@mail.gmail.com>
Subject: Re: [PATCH] repack-promisor: add fake paths to oids when repacking
 promisor objects
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 7:02=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, Mar 27, 2026 at 05:12:43PM +0100, Abraham Samuel Adekunle wrote:
> > This change addresses the NEEDSWORK comment added by commit
> > 5d19e81 (repack: repack promisor objects if -a or -A is set).
> >
> > When 'git-repack' repacks promisor objects, only the raw oids
> > are sent to 'git-pack-objects'.
> > This gives 'git-pack-objects' no information about the original
> > pack order of those objects in the packfile so it must
> > rely on its default strategy of sorting the objects by type and
> > then by size over again. This can produce suboptimal packfiles
> > because the objects that were previously stored in the same
> > packfile can become separated.
> >
> > Provide a hint to 'git-pack-objects' when sorting, by using the
> > packfile basename, and the offset of the object in the existing
> > packfile as fake paths when writing the oids to 'git-pack-objects'.
> >
> > This will ensure they can be grouped by the type and existing pack
> > order which will make them end up close together in the sort, improving
> > delta compression.
>
> I think the general idea may be sound, but ideally we would have some
> benchmarks that demonstrate it actually is. Like, can you come up with
> scenarios where it will indeed improve the packfile size and show the
> advantage of this change? Are there scenarios that are likely to have a
> disadvantage because of this new ordering? Which of these scenarios do
> we expect to be more likely?

Thank you Patrick for the review.
Okay I will look into this

>
> Before answering these questions we basically just claim it's going to
> be an improvement without actually verifying.

Yes I agree

>
> > diff --git a/repack-promisor.c b/repack-promisor.c
> > index 90318ce150..3f3034fb79 100644
> > --- a/repack-promisor.c
> > +++ b/repack-promisor.c
> > @@ -12,25 +12,51 @@ struct write_oid_context {
> >       const struct git_hash_algo *algop;
> >  };
> >
> > +/**
> > + * Build fake path for the objects to give pack-objects
> > + * an ordering hint.
> > + * For the packed objects: pack-basename/offset-padded
> > + */
> > +
>
> Nit: this empty line can be removed.

Okay

>
> > +static void build_ordering_hint(struct object_info *oi, struct strbuf =
*hint)
> > +{
> > +     struct packed_git *pack;
> > +     unsigned long offset;
> > +
> > +     if (oi->whence =3D=3D OI_PACKED) {
> > +             pack =3D oi->u.packed.pack;
> > +             offset =3D oi->u.packed.offset;
> > +             strbuf_addf(hint, "%s/%05lu", pack_basename(pack), (unsig=
ned long)offset);
> > +     } else
> > +             strbuf_addstr(hint, "loose");
>
> Nit: our coding guidelines say that once an if statement requires curly
> braces in one branch, all branches should have them.

Okay thank you

>
> I also have to wonder whether it's going to be a benefit to also specify
> a hint for loose objects, or whether we should rather not write any hint
> at all for them.

Okay, I think not writing any hints makes sense.
Thanks

>
> > +}
> > +
> >  /*
> >   * Write oid to the given struct child_process's stdin, starting it fi=
rst if
> >   * necessary.
> >   */
> >  static int write_oid(const struct object_id *oid,
> > -                  struct object_info *oi UNUSED,
> > +                  struct object_info *oi,
> >                    void *data)
> >  {
> >       struct write_oid_context *ctx =3D data;
> >       struct child_process *cmd =3D ctx->cmd;
> > +     struct strbuf hint =3D STRBUF_INIT;
> >
> >       if (cmd->in =3D=3D -1) {
> >               if (start_command(cmd))
> >                       die(_("could not start pack-objects to repack pro=
misor objects"));
> >       }
> >
> > +     build_ordering_hint(oi, &hint);
> > +
> >       if (write_in_full(cmd->in, oid_to_hex(oid), ctx->algop->hexsz) < =
0 ||
> > +         write_in_full(cmd->in, " ", 1) < 0 ||
> > +         write_in_full(cmd->in, hint.buf, hint.len) < 0 ||
> >           write_in_full(cmd->in, "\n", 1) < 0)
> >               die(_("failed to feed promisor objects to pack-objects"))=
;
>
> This now translate into at least four write(3p) syscalls per object. Can
> we maybe reuse a buffer so that we can reduce the number of syscalls?

Okay noted
Thanks

Abraham
