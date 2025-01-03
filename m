Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AD51BC077
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 23:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735947312; cv=none; b=hrsmPbP4/UgL+bXQTLERLKRGd5KnJkQPnatBwRrmFfRUdynfqnk4f4Aye1PfG36YM7YlWym//xy283mQmralzuu52LCJdJ9mEezSImfMDNx/QjpRlg7pvsCWe31BKc/rPMUemAwMRMA70OPDK0OkHSatZN7s0NZXu9Y7jxSrbtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735947312; c=relaxed/simple;
	bh=NP0dbyCs8KgUAbmAuIMU3pshTtCsZ/gIvnQpO8jv+tE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iyf/gL5QUMRgHkG3U5YUKo+IiaD4Pz/UGW0MRSSmnRgXFIEL2nv+68iyosAE//B020Cvyt+X2keI6WuYsA8GqII/2hNKAIXGgnQGC289IEadG24/PHj06d6+Fdh6RhahRGhL6FSgI2BCaYGDtmi28tVL3l9NRIt7f22rxsYpX3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=saville.com; spf=none smtp.mailfrom=saville.com; dkim=pass (2048-bit key) header.d=saville-com.20230601.gappssmtp.com header.i=@saville-com.20230601.gappssmtp.com header.b=v/XeJ18r; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=saville.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=saville.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=saville-com.20230601.gappssmtp.com header.i=@saville-com.20230601.gappssmtp.com header.b="v/XeJ18r"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e53c9035003so14726144276.2
        for <git@vger.kernel.org>; Fri, 03 Jan 2025 15:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20230601.gappssmtp.com; s=20230601; t=1735947309; x=1736552109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UEf0dQ+kTUkAB+gev9XAt04zusRNlZmaRa8w7vn1Q4=;
        b=v/XeJ18rXtzyhyiR5UnENmWWqlj6V+tJRZVPdWdlh0kh2gRkwOJy45Gb89Kgd+ZtJs
         amDuP+aIeJE4IBpFUqOzXs0Sj3TyCeklqv0ZrQpl3vMGokk6w5LLfCRoDrMfEKkKBBTo
         R2O7NhywvpCK41Ir6I+iCXvcOuBJHORzoCEDEM3JrTQe2uxydqdwidOeZ8EvNg2rWRhQ
         ci7Vmyq+Zlaz4BYISk1b/N8CKPRWt9fTCuhz/JyQehHdoNfSm+hI/fU5yJIDVZEg8pKm
         XEziNVnhtNVBkvODcwE4uuafeV5bU1or5rg+8ybQ6HI+8hqJGp72J2pOnGJN+dL3SciA
         pz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735947310; x=1736552110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UEf0dQ+kTUkAB+gev9XAt04zusRNlZmaRa8w7vn1Q4=;
        b=dCCnWQjTJdHIKZLJO81GMiJ3No1suiDbG2SePx1d7N5RnRWgk9kV10Ygl/BJnxiJcx
         0VjMWI1ZgdXFcic+14tnOuGW1I1w1G8BoLnFtDvA8Jr7x8mvwAbcl0fkXxn8O2MZoWH4
         rtS/DfKP3zJVX68IgjxSMV4ClEa3haD8PmPwS5zW1Fn+vfkWeF6S/+/4RTY7RS0shOnp
         GdIGUmxTsaGMmEdLPZa6ivo2+GIcuvsF4+Yk1avWdbIGOuG83mMxrhuHSkorX7zQBuUW
         flUHT81rNq7/7KWdQQJazbhrPYo3x4Thn9ktxao9gIHo3o3e2CrFYPO4MmRayDy9pmmH
         NMgg==
X-Gm-Message-State: AOJu0Yxzu5bmv5yfSd4omqLSLKdEaUUJTxyLu3eiCQSefkmX181FIS4D
	1oQ/Fkve0c3OSmRITUlwwjiEbBcqxCNFEdMO/Y+QmRwSj4m8QPobcJRg3MkZ+ZUO7PNME21cGVp
	X3ZaocdATlIlKxPWe2oiSUUGfp38VQCKskjyNRl8ZAhnGUPLo2n8=
X-Gm-Gg: ASbGncvVvaTWanfkATCeanANxfLockO8CXEL0cLMCb+geX0tcKRlPn/N8mwgd2EAPSf
	uVxtFu/q5oPhCx1JSQf2b5KWjX01qBDPbKEdVFWI=
X-Google-Smtp-Source: AGHT+IGtW9lhvc3toycoVmPVaaJfrPnUfhCE/7shv1sxaGcVQ/mbvzScVz1+fRXU1lApixpUQk7vUIdpOivZucNLnxo=
X-Received: by 2002:a05:6902:13cb:b0:e53:7760:5401 with SMTP id
 3f1490d57ef6-e548eb17cc9mr3131410276.22.1735947309617; Fri, 03 Jan 2025
 15:35:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKk8isqpAXLoiXxOP3uAc00M+OM0FaU3Uhnt5R1FnFMD=xGARg@mail.gmail.com>
 <20250103204624.GE3212696@coredump.intra.peff.net>
In-Reply-To: <20250103204624.GE3212696@coredump.intra.peff.net>
From: Wink Saville <wink@saville.com>
Date: Fri, 3 Jan 2025 15:34:58 -0800
Message-ID: <CAKk8isrz1NQ=3=2aZ3tANymo0eSsCy=r6W5yKgn6gxmOom54CA@mail.gmail.com>
Subject: Re: [BUGREPORT] git diff-tree --cc SEGFAUTs
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 12:46=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Fri, Jan 03, 2025 at 11:28:47AM -0800, Wink Saville wrote:
>
> > `git diff-tree --cc` SEGFAUTs after adding trace_printf to diff_tree_co=
mbined.
>
> Hmm, is it really a bug in Git if you had to add new code which contains
> the bug? :)
>
> > @@ -1595,8 +1597,16 @@ void diff_tree_combined(const struct object_id *=
oid,
> >       }
> >
> >       /* find out number of surviving paths */
> > -     for (num_paths =3D 0, p =3D paths; p; p =3D p->next)
> > +     trace_printf("Wink diff_tree_combined: find number of surviving p=
aths num_parent=3D%d\n", num_parent);
> > +     for (num_paths =3D 0, p =3D paths; p; p =3D p->next) {
> > +             trace_printf("Wink diff_tree_combined: num_paths=3D%d &p=
=3D%p mode=3D%0x, oid=3D%s path=3D%s\n", num_paths, p, p->mode, oid_to_hex(=
&p->oid), p->path);
> > +             for (i =3D 0; i < num_parent; i++) {
> > +                     trace_printf("Wink diff_tree_combined:  &p->paren=
t[%d]=3D%p status=3D%c mode=3D%x oid=3D%s path.buf=3D%p contents path.buf=
=3D%s\n",
> > +                              i, &p->parent[i], p->parent[i].status, p=
->parent[i].mode, oid_to_hex(&p->parent[i].oid), p->parent[i].path.buf, p->=
parent[i].path.buf);
> > +             }
>
> The parent "path" strbufs are only initialized in intersect_paths() if
> combined_all_paths is set, and if there was an actual path change (a
> copy or rename).
>
> So you'd probably need something like this:
>
> diff --git a/combine-diff.c b/combine-diff.c
> index 455bc19087..1e58809c4e 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -1601,8 +1601,11 @@ void diff_tree_combined(const struct object_id *oi=
d,
>         for (num_paths =3D 0, p =3D paths; p; p =3D p->next) {
>                 trace_printf("Wink diff_tree_combined: num_paths=3D%d &p=
=3D%p mode=3D%0x, oid=3D%s path=3D%s\n", num_paths, p, p->mode, oid_to_hex(=
&p->oid), p->path);
>                 for (i =3D 0; i < num_parent; i++) {
> +                       const char *path =3D rev->combine_all_paths &&
> +                                          filename_changed(p->parent[i].=
status) ?
> +                                          p->parent[i].path.buf : NULL;
>                         trace_printf("Wink diff_tree_combined:  &p->paren=
t[%d]=3D%p status=3D%c mode=3D%x oid=3D%s path.buf=3D%p contents path.buf=
=3D%s\n",
> -                                i, &p->parent[i], p->parent[i].status, p=
->parent[i].mode, oid_to_hex(&p->parent[i].oid), p->parent[i].path.buf, p->=
parent[i].path.buf);
> +                                    i, &p->parent[i], p->parent[i].statu=
s, p->parent[i].mode, oid_to_hex(&p->parent[i].oid), path, path);
>                 }
>                 num_paths++;
>         }
>
> -Peff

TYVM!

That worked but changed the name and fixed a typo in `combined_all_paths`:
```
wink@3900x 25-01-03T23:06:08.344Z:~/data/prgs/forks/git
(wink-segfault-with-minimal-changes)
$ git diff
diff --git a/combine-diff.c b/combine-diff.c
index 455bc19087..70394c3350 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1601,8 +1601,9 @@ void diff_tree_combined(const struct object_id *oid,
        for (num_paths =3D 0, p =3D paths; p; p =3D p->next) {
                trace_printf("Wink diff_tree_combined: num_paths=3D%d
&p=3D%p mode=3D%0x, oid=3D%s path=3D%s\n", num_paths, p, p->mode,
oid_to_hex(&p->oid), p->path);
                for (i =3D 0; i < num_parent; i++) {
+                       const char *parent_path =3D
rev->combined_all_paths && filename_changed(p->parent[i].status) ?
p->parent[i].path.buf : NULL;
                        trace_printf("Wink diff_tree_combined:
&p->parent[%d]=3D%p status=3D%c mode=3D%x oid=3D%s path.buf=3D%p contents
path.buf=3D%s\n",
-                                i, &p->parent[i],
p->parent[i].status, p->parent[i].mode, oid_to_hex(&p->parent[i].oid),
p->parent[i].path.buf, p->parent[i].path.buf);
+                                i, &p->parent[i],
p->parent[i].status, p->parent[i].mode, oid_to_hex(&p->parent[i].oid),
parent_path, parent_path);
                }
                num_paths++;
        }
```

But having to protect yourself is unobvious and especially if it isn't nece=
ssary
when using the `fetch_paths_generic`.

In addition, from strbuf.h `buf` is never NULL:

"
* strbufs have some invariants that are very important to keep in mind:
 *
 *  - The `buf` member is never NULL, so it can be used in any usual C
 *    string operations safely. strbufs _have_ to be initialized either by
 *    `strbuf_init()` or by `=3D STRBUF_INIT` before the invariants, though=
.
 *
"

So I'd say this could be considered a bug in git at least in how
combine_diff_path
is being managed. I assume you agree that neither find_paths_generic or
find_paths_multitree are adhering to at least that strbuf invariant and I w=
onder
if the other strbuf invariants are being upheld.

So, should this bug be "closed" and a new one "created"?

Actually, using the mailing list to identify bugs and initially discuss
them, seems fine. But is there a place where there is a list of current bug=
s and
their state?

-- wink
