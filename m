Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA61524A2
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708079946; cv=none; b=OdnXEof7f2m1RvS00rQP804TA1sJE/FnNA1M6OnZLgbreXBJdyBJkaBtPFqBA2lFCcU6V1J4zgJKS3cIken8XUGStOtSQ/ZvT3VyPYpEFenQTSEPTW4XXpgtHQ2ucN9zsAbV+J+Dq2v2iITU4sUWd1fKDa5i0nxDO4RFn7sTudI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708079946; c=relaxed/simple;
	bh=El8zq0wJbQ/X+K8nlSYTYBZ0g9OpnZlLhfm2EzLxMA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHW0FIxCJ1GCI7yzDWUALUyn0aBwf9wciJWHs9LpUt/GWF+yN8bcI6rRGF0VCIV59Y4GJXXCio0jUFvuNAA8UkDTDp2fPB6xiTC6FdOkGQT7t3CjkHt+4oZi5aL6mHPyuAfXll4QR/EocZFDTiJuX5O+6TUmajCyykCvup+Z2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbPyswBI; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbPyswBI"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3db14a0a31so162057066b.2
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 02:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708079943; x=1708684743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlyUg5Cv7xTTJySuKewtuisorgjJzpxZQBY3L5nxHxA=;
        b=nbPyswBIMKxTGXa7BM12NqmxgPXptmfAuaiKuPM1/ButnUCsCYs6IPK85J6hOc8z0C
         lUW7dA6z3AwCMgRYeM0S00UprWym/l/CCu0YIh0BRSjf3I7sT/4L9OCpwyiuClqkm2eh
         QadvrgjplAADM4UPakvtXoVOfi9+QHTcEAY+OzVxGYAnrTBob7B6MsR6rBzJYn0m+cr5
         V6+D7YCriXT4t0MjAHuSsaThDmv0QLlcvR1BmOZPfiLssUptVKPP0sQ7WOKw4/idaxnb
         XeBDkZyLzuM9Ma48j+2cQo0LbXIy3RPhGCPg8OSDEQiC+tnCfhvoBxfCnAWKGICwU2oq
         7aLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708079943; x=1708684743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlyUg5Cv7xTTJySuKewtuisorgjJzpxZQBY3L5nxHxA=;
        b=Bcl3bl5xFtwUgP0retokPK06F9GfhU1mSVaiIQDyfSDD3WYAiRPEsw0CqTrSC3esCj
         lAtW6+iA/96D6x1y+gyC+Jnb/I7UQSSXnVKlNkef73wjXgLbYaWryYU+WxJnHUITXaZu
         FAFt53MKfQW4ffUUyB5VkM+hsy9i65rujuJIxbZe8VN2Gyr5qGc9dy7SOzlAbhoKs4vJ
         XaTxEVRrmpoTXZ1theUFDPQhH4hADiMgis7YNJDniGFTj2q5KLkln5HoqCNZCJGQThwF
         kThVBK3ooWgJ/yPtlNgvnfSej5TuLfJKbcR6dge1JYqrhowgFWofWvy54PoLl3z93XVd
         IEjQ==
X-Gm-Message-State: AOJu0Yx7ywlUuLSduYD0MVcS4xL3qMvz8r+PScNphb+QZn8LflIqTyGO
	oqu8NH+IxtZPxBaYozazZUWV1lWMIrlpqUxDslpCMfQayp/vthC6Kw6Yax7tXbDpa/FFByWwidl
	USlhFp5fwCC1UJpLsLoCJJNd2UYo=
X-Google-Smtp-Source: AGHT+IF08UW4aanOFVeK77fytr02+g5Y48jEVoQ4dvqXI0QnhwmizOmO2Ym4rjRDgJ04K1X0LQ6egmP0DOHVPfVWKKg=
X-Received: by 2002:a17:906:af09:b0:a3d:3aef:2311 with SMTP id
 lx9-20020a170906af0900b00a3d3aef2311mr3670493ejb.35.1708079942545; Fri, 16
 Feb 2024 02:39:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208135055.2705260-1-christian.couder@gmail.com>
 <20240208135055.2705260-3-christian.couder@gmail.com> <owlyle7o9iyf.fsf@fine.c.googlers.com>
 <CAP8UFD1aJD5i68ekHuq0UG14X19y=Eo6qKPianF8MKNf6iZ_WQ@mail.gmail.com> <owlyy1bl8b8u.fsf@fine.c.googlers.com>
In-Reply-To: <owlyy1bl8b8u.fsf@fine.c.googlers.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 16 Feb 2024 11:38:50 +0100
Message-ID: <CAP8UFD0BfdVQ6p8SH6RVRYF4=+-V4PAtKg9LdUEeL_GnSqozzg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] oidset: refactor oidset_insert_from_set()
To: Linus Arver <linusa@google.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	John Cai <johncai86@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 2:10=E2=80=AFAM Linus Arver <linusa@google.com> wro=
te:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > On Tue, Feb 13, 2024 at 10:02=E2=80=AFPM Linus Arver <linusa@google.com=
> wrote:

> >> Are the extra parentheses necessary?
> >
> > Yes. Without them gcc errors out with:
> >
> > oidset.c: In function =E2=80=98oidset_insert_from_set=E2=80=99:
> > oidset.c:32:16: error: suggest parentheses around assignment used as
> > truth value [-Werror=3Dparentheses]
> >   32 |         while (src_oid =3D oidset_iter_next(&iter))
> >      |                ^~~~~~~
> >
> > Having extra parentheses is a way to tell the compiler that we do want
> > to use '=3D' and not '=3D=3D'. This helps avoid the very common mistake=
 of
> > using '=3D' where '=3D=3D' was intended.
>
> Ah, so it is a "please trust me gcc, I know what I am doing" thing and
> not a "this is required in C" thing. Makes sense, thanks for clarifying.
>
> Sorry for the noise.

No worries. It's better to ask in case of doubt.

> >> so perhaps the following wording is simpler?
> >>
> >>     Like oid_insert(), but insert all oids found in 'src'. Calls
> >>     oid_insert() internally.
> >
> > (What you suggest would need s/oid_insert/oidset_insert/)
> >
> > Yeah, it's a bit simpler and shorter, but on the other hand a reader
> > might have to read both this and the oidset_insert() doc, so in the
> > end I am not sure it's a big win for readability. And if they don't
> > read the oidset_insert() doc, they might miss the fact that we are
> > copying the oids we insert, which might result in a bug.
>
> When functions are built on top of other functions, I think it is good
> practice to point readers to those underlying functions. In this case
> the new function is a wrapper around oidset_insert() which does all the
> real work. Plus the helper function already has some documentation about
> copying behavior that we already thought was important enough to call
> out explicitly.
>
> So, tying this definition to that (foundational) helper function sounds
> like a good idea to me in terms of readability. IOW we can inform
> readers "hey, we're just a wrapper around this other important function
> --- go there if you're curious about internals" and emphasizing that
> sort of relationship which may not be immediately obvious to those not
> familiar with this area would be nice.
>
> Alternatively, we could repeat the same comment WRT copying here but
> that seems redundant and prone to maintenance burdens down the road (if
> we ever change this behavior we have to change the comment in multiple
> functions, possibly).
>
> > Also your wording ties the implementation with oidset_insert(), which
> > we might not want if we could find something more performant. See
> > Junio's comment on this patch saying his initial reaction was that
> > copying underlying bits may even be more efficient.
> >
> > So I prefer not to change this.
>
> OK.

I must say that in cases like this, it's difficult to be right for
sure because it's mostly with enough hindsight that we can tell what
turned out to be a good decision. Here for example, it might be that
someone will find something more performant soon or it might turn out
that the function will never change. We just can't know.

So as long as the wording is clear and good enough, I think there is
no point in trying to improve it as much as possible. Here both your
wording and my wording seem clear and good enough to me. Junio might
change his mind but so far it seems that he found my wording good
enough too. So in cases like this, it's just simpler to keep current
wording. This way I think there is a higher chance that things can be
merged sooner and that we can all be more efficient.

> >> > +void oidset_insert_from_set(struct oidset *dest, struct oidset *src=
);
> >>
> >> Perhaps "oidset_insert_all" would be a simpler name? I generally prefe=
r
> >> to reuse any descriptors in comments to guide the names. Plus this
> >> function used to be called "add_all()" so keeping the "all" naming sty=
le
> >> feels right.
> >
> > We already have other related types like 'struct oid-array' and
> > 'struct oidmap' to store oids, as well as code that inserts many oids
> > into an oidset from a 'struct ref *' linked list or array in a tight
> > loop.
>
> Thank you for the additional context I was not aware of.
>
> > So if we want to add functions inserting all the oids from
> > instances of such types, how should we call them?
> >
> > I would say we should use suffixes like: "_from_set", "_from_map",
> > "from_array", "_from_ref_list", "_from_ref_array", etc.
>
> I agree.
>
> However, I would like to point out that the function being added in this
> patch is a bit special: it is inserting from one "oidset" into another
> "oidset". IOW the both the dest and src types are the same.
>
> For the cases where the types are different, I totally agree that using
> the suffixes (to encode the type information of the src into the
> function name itself) is a good idea.
>
> So I think it's still fine to use "oidset_insert_all" because the only
> type in the parameter list is an oidset.

Yeah, here also I think both "oidset_insert_from_set" and
"oidset_insert_all" are clear and good enough.

> BUT, maybe in our codebase we already use suffixes like this even for
> cases where the types are the same? I don't know the answer to this
> question.

I agree that it could be a good thing to be consistent with similar
structs, but so far for oidmap there is only oidmap_put(), and, for
oid-array, only oid_array_append(). (And no, I didn't look further
than this.)

> However if we really wanted to be consistent then maybe we
> should be using the name oidset_insert_from_oidset() and not
> oidset_insert_from_set().

Yeah, "oidset_insert_from_oidset" and perhaps
"oidset_insert_all_from_oidset" would probably be fine too. Junio
found my wording good enough though, so I think it's just simpler not
to change it.

Also it's not like it can't be improved later if there is a good
reason like consistency with other oid related structs that might get
oidmap_put_all() or oid_array_append_all(). But again we can't predict
what will happen, so...
