Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7741D435F
	for <git@vger.kernel.org>; Sat,  4 Jan 2025 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736014206; cv=none; b=t3PQn3WxFAZhgDrU5QWfTqpAZk7bCs9YtTsVCV/XNTGmQhL5/qFLciS5UcxGEtI7YFfQnCb9cWC9MiJdcyc1BpmRkBhDnANHWAQKPC11TJhafIP/3d0lIi5Ylld3wKFyCJpSvLb3zphBukrkDHmgWjiNgdgjZsDMoqzI+xiivGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736014206; c=relaxed/simple;
	bh=PbajO4hUNMbc3HxB1YY/Wj10GW3gKVo6KkvSBUt086o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtI2dPwWllEHDszCo0iplqiRqrvueKAIIuE+QjoGKt9BdGohhg7kkqRm+5lp0ejcsLH8D8NuQfKfBmvAGC22Pq/ro5FUBkAb1TxXFsnORjA0n/cA0ZQq83/KvnbgGL5lgpuKM9wa+k//u4W5itybskshJFv7gCKkbrnXQizgLoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=saville.com; spf=none smtp.mailfrom=saville.com; dkim=pass (2048-bit key) header.d=saville-com.20230601.gappssmtp.com header.i=@saville-com.20230601.gappssmtp.com header.b=00xA6PUU; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=saville.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=saville.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=saville-com.20230601.gappssmtp.com header.i=@saville-com.20230601.gappssmtp.com header.b="00xA6PUU"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e549a71dd3dso1862262276.0
        for <git@vger.kernel.org>; Sat, 04 Jan 2025 10:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20230601.gappssmtp.com; s=20230601; t=1736014202; x=1736619002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mJo4dNM/wRIihoXRMJBfbptLhYozc1Hy4+vt94EULs=;
        b=00xA6PUUgjtlyZV0f9Zl+oQuT28EaIDWbaCsN3lQrJYkJKcZsTo+EFGSgdoZIEpxb+
         2ifG5eTe3ndDNxiVD3nlmQRRgQskvUj5FFnawbYQopfeKZidkP5PuhSn+/f1qIiUuO8/
         TypZeDq0ksemxrrKCzf+3biooMapZOi2a2b7d45h9VRR0mC/ZGjL9d4+Mqn0W2FsNBKk
         bUXt7H3kZQLnJXlAtjvyS/K9ybSW5KoOTTOE9C1E/Lmu9vhZVWQPP2IwHTQ9wjx4ZOyO
         p8Dctlih1IbV5uJv232jwzPHGVVx6H9ooG8wxWM8zRq0rRCdXQD1DPHgPkmO2imeNYcn
         IDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736014202; x=1736619002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mJo4dNM/wRIihoXRMJBfbptLhYozc1Hy4+vt94EULs=;
        b=g2WYeHvlDFTjMl2X5nssREulp4Cs4rv/hL0uRMGE912mbvYvbX6Nv2sezhPKciWyYr
         1KOE1cFtLOCVf1D78VFEW8zgnzOKbiPDFKA6dGioe3FszOx9maJANGG/ftSvUtZ4jYYW
         vpdPLrwEhCpP3OfrIw98jos3Nwn62kmsg0zdo5CFxZiPLMBV0WAgCKuCT4UmvtS3udFI
         tAIKaoXo6Z3awEx3n3ua2CEHiUA/5ih49Cn84OjZu/NzNCRjXJ8ZgSttCMF8uf/EH+vD
         w3k25lgyteDZT1q6FQV4CWtkwRCeviy0mbLzD2JRN0lIK6eTiumzGjH/cdewEGiH8RP/
         CaDA==
X-Forwarded-Encrypted: i=1; AJvYcCU2MzsM85+2fjTrZGUsuIzXdYFdPNCV1KQhccMy3OxWBq269OlEbrHWKGHuwmkNdN0Y8uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEpWyIR8Zx3Bfk6afBf9WLXefx1odSn618LTDzYSCO5GOOnkDj
	vHlo2E5Zn4DeqCcZK47K0t7N1t9mviPG6I5a63hT+3s8kUOip9Rk/WymWiYr2XhuWasHGl9Yvpc
	WZsMXqJ20+AbkE2a8Ho8U9mlF4MU1ZlT3YGKOHg==
X-Gm-Gg: ASbGncu8otcx99t6vcXx6+YHQLA7PaacZvQB74DfXLbVsv7NHItmSsHBAQV/GDXXN/L
	5+u1rQ3kjXNPwF8ze0NlnMm+x/PnuD34AFz6HDTQ=
X-Google-Smtp-Source: AGHT+IFKwMjyQSHeg3H8vwqITIg9ENfm2AnYrNHeWFrB27pI5cisybzUYRL606w9Xcje3dNnUpht75Cx8xNllp3pSjw=
X-Received: by 2002:a05:6902:1003:b0:e3a:3432:d307 with SMTP id
 3f1490d57ef6-e538c27c75dmr30111693276.26.1736014202244; Sat, 04 Jan 2025
 10:10:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKk8isqpAXLoiXxOP3uAc00M+OM0FaU3Uhnt5R1FnFMD=xGARg@mail.gmail.com>
 <20250103204624.GE3212696@coredump.intra.peff.net> <CAKk8isrz1NQ=3=2aZ3tANymo0eSsCy=r6W5yKgn6gxmOom54CA@mail.gmail.com>
 <20250104003154.GB3244554@coredump.intra.peff.net> <xmqq4j2fnv8p.fsf@gitster.g>
 <20250104033210.GA892381@coredump.intra.peff.net>
In-Reply-To: <20250104033210.GA892381@coredump.intra.peff.net>
From: Wink Saville <wink@saville.com>
Date: Sat, 4 Jan 2025 10:09:51 -0800
Message-ID: <CAKk8isrRCZsrt=2YB+L3EjK3ZAYbSk0e+1YZexqZUhB78L36dg@mail.gmail.com>
Subject: Re: [BUGREPORT] git diff-tree --cc SEGFAUTs
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 7:32=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Fri, Jan 03, 2025 at 06:55:18PM -0800, Junio C Hamano wrote:
>
> > Jeff King <peff@peff.net> writes:
> >
> > > ... OTOH it is not really
> > > solving the more fundamental problem, which is that p->parent[i].path=
 is
> > > only sometimes useful (we do not fill it in if it would just be the s=
ame
> > > as p->path, so the patch only changes it from uninitialized memory in=
to
> > > an empty strbuf).
> > >
> > > And that is probably not something we want to change, as allocating
> > > duplicates of each path may be expensive.
> >
> > Nicely said.  I reached the same conclusion after looking at the
> > existing code, even though I have to admit that I am not a huge fan
> > of the more recent part of combine-diff.c and its data structures.
>
> I poked at this a little bit more, so here are a few tidbits:
>
>   - the patch I showed earlier is not sufficient! There are lots of
>     other spots that create combine_diff_path structs but don't bother
>     to put anything in the parent paths at all. It works now because
>     they also don't set a status that triggers filename_changed(). But
>     what I showed earlier was wrong, because it was assuming in the
>     cleanup functions that the strbufs were always initialized.
>
>   - there's really no need for a strbuf at all here. It is always
>     uninitialized/empty, or contains a direct copy of a path string. So
>     a raw pointer with xstrdup() is plenty. And then we can use NULL to
>     mean "it was not set".
>
>     Which would Just Work for all those other spots if they bothered to
>     zero the memory they allocated, but they don't. So we have to update
>     them to set it to NULL anyway. That patch is below.
>
>   - it is not at all clear to me that we need to be allocating at all.
>     We always copy a string from the diff_queue. Do our
>     combine_diff_path structs persist beyond then? I'm not sure. It is
>     probably asking for trouble to just point to them directly without
>     copying, as it creates a dependency (that even if it is not needed
>     now, is a trap for somebody later). But it would drop some
>     allocation/cleanup code, and we could just have p->parent[i].path
>     fall back to p->path naturally.
>
> diff --git a/combine-diff.c b/combine-diff.c
> index 641bc92dbd..0d9d344c4e 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -66,13 +66,9 @@ static struct combine_diff_path *intersect_paths(
>                         oidcpy(&p->parent[n].oid, &q->queue[i]->one->oid)=
;
>                         p->parent[n].mode =3D q->queue[i]->one->mode;
>                         p->parent[n].status =3D q->queue[i]->status;
> -
> -                       if (combined_all_paths &&
> -                           filename_changed(p->parent[n].status)) {
> -                               strbuf_init(&p->parent[n].path, 0);
> -                               strbuf_addstr(&p->parent[n].path,
> -                                             q->queue[i]->one->path);
> -                       }
> +                       p->parent[n].path =3D combined_all_paths &&
> +                                           filename_changed(p->parent[n]=
.status) ?
> +                                           xstrdup(q->queue[i]->one->pat=
h) : NULL;
>                         *tail =3D p;
>                         tail =3D &p->next;
>                 }
> @@ -92,9 +88,7 @@ static struct combine_diff_path *intersect_paths(
>                         /* p->path not in q->queue[]; drop it */
>                         *tail =3D p->next;
>                         for (j =3D 0; j < num_parent; j++)
> -                               if (combined_all_paths &&
> -                                   filename_changed(p->parent[j].status)=
)
> -                                       strbuf_release(&p->parent[j].path=
);
> +                               free(p->parent[j].path);
>                         free(p);
>                         continue;
>                 }
> @@ -108,10 +102,9 @@ static struct combine_diff_path *intersect_paths(
>                 oidcpy(&p->parent[n].oid, &q->queue[i]->one->oid);
>                 p->parent[n].mode =3D q->queue[i]->one->mode;
>                 p->parent[n].status =3D q->queue[i]->status;
> -               if (combined_all_paths &&
> -                   filename_changed(p->parent[n].status))
> -                       strbuf_addstr(&p->parent[n].path,
> -                                     q->queue[i]->one->path);
> +               p->parent[n].path =3D combined_all_paths &&
> +                                   filename_changed(p->parent[n].status)=
 ?
> +                                   xstrdup(q->queue[i]->one->path) : NUL=
L;
>
>                 tail =3D &p->next;
>                 i++;
> @@ -996,8 +989,9 @@ static void show_combined_header(struct combine_diff_=
path *elem,
>
>         if (rev->combined_all_paths) {
>                 for (i =3D 0; i < num_parent; i++) {
> -                       char *path =3D filename_changed(elem->parent[i].s=
tatus)
> -                               ? elem->parent[i].path.buf : elem->path;
> +                       const char *path =3D elem->parent[i].path ?
> +                                          elem->parent[i].path :
> +                                          elem->path;
>                         if (elem->parent[i].status =3D=3D DIFF_STATUS_ADD=
ED)
>                                 dump_quoted_path("--- ", "", "/dev/null",
>                                                  line_prefix, c_meta, c_r=
eset);
> @@ -1278,12 +1272,10 @@ static void show_raw_diff(struct combine_diff_pat=
h *p, int num_parent, struct re
>
>         for (i =3D 0; i < num_parent; i++)
>                 if (rev->combined_all_paths) {
> -                       if (filename_changed(p->parent[i].status))
> -                               write_name_quoted(p->parent[i].path.buf, =
stdout,
> -                                                 inter_name_termination)=
;
> -                       else
> -                               write_name_quoted(p->path, stdout,
> -                                                 inter_name_termination)=
;
> +                       const char *path =3D p->parent[i].path ?
> +                                          p->parent[i].path :
> +                                          p->path;
> +                       write_name_quoted(path, stdout, inter_name_termin=
ation);
>                 }
>         write_name_quoted(p->path, stdout, line_termination);
>  }
> @@ -1645,9 +1637,7 @@ void diff_tree_combined(const struct object_id *oid=
,
>                 struct combine_diff_path *tmp =3D paths;
>                 paths =3D paths->next;
>                 for (i =3D 0; i < num_parent; i++)
> -                       if (rev->combined_all_paths &&
> -                           filename_changed(tmp->parent[i].status))
> -                               strbuf_release(&tmp->parent[i].path);
> +                       free(tmp->parent[i].path);
>                 free(tmp);
>         }
>
> diff --git a/diff-lib.c b/diff-lib.c
> index c6d3bc4d37..88a5aed736 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -417,9 +417,11 @@ static int show_modified(struct rev_info *revs,
>                 memset(p->parent, 0, 2 * sizeof(struct combine_diff_paren=
t));
>                 p->parent[0].status =3D DIFF_STATUS_MODIFIED;
>                 p->parent[0].mode =3D new_entry->ce_mode;
> +               p->parent[0].path =3D NULL;
>                 oidcpy(&p->parent[0].oid, &new_entry->oid);
>                 p->parent[1].status =3D DIFF_STATUS_MODIFIED;
>                 p->parent[1].mode =3D old_entry->ce_mode;
> +               p->parent[1].path =3D NULL;
>                 oidcpy(&p->parent[1].oid, &old_entry->oid);
>                 show_combined_diff(p, 2, revs);
>                 free(p);
> diff --git a/diff.h b/diff.h
> index 6e6007c17b..3157faeabb 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -480,7 +480,7 @@ struct combine_diff_path {
>                 char status;
>                 unsigned int mode;
>                 struct object_id oid;
> -               struct strbuf path;
> +               char *path;
>         } parent[FLEX_ARRAY];
>  };
>  #define combine_diff_path_size(n, l) \
> diff --git a/tree-diff.c b/tree-diff.c
> index d9237ffd9b..57af377c2b 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -272,6 +272,7 @@ static struct combine_diff_path *emit_path(struct com=
bine_diff_path *p,
>                         }
>
>                         p->parent[i].mode =3D mode_i;
> +                       p->parent[i].path =3D NULL;
>                         oidcpy(&p->parent[i].oid, oid_i);
>                 }

The above LGTM and hopefully it can be accepted.

With that change I can revert my trace_printfs of combine_diff_path
back to something simple:
```
$ git diff HEAD^
diff --git a/combine-diff.c b/combine-diff.c
index 5e0b7919bc..4764383f20 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1593,8 +1593,8 @@ void diff_tree_combined(const struct object_id *oid,
        for (num_paths =3D 0, p =3D paths; p; p =3D p->next) {
                trace_printf("Wink diff_tree_combined: num_paths=3D%d
&p=3D%p mode=3D%0x, oid=3D%s path=3D%s\n", num_paths, p, p->mode,
oid_to_hex(&p->oid), p->path);
                for (i =3D 0; i < num_parent; i++) {
-                       trace_printf("Wink diff_tree_combined:
&p->parent[%d]=3D%p status=3D%c mode=3D%x oid=3D%s path.buf=3D%p contents
path.buf=3D%s\n",
-                                i, &p->parent[i],
p->parent[i].status, p->parent[i].mode, oid_to_hex(&p->parent[i].oid),
p->parent[i].path.buf, p->parent[i].path.buf);
+                       trace_printf("Wink diff_tree_combined:
&p->parent[%d]=3D%p status=3D%c mode=3D%x oid=3D%s path=3D%s\n",
+                                i, &p->parent[i],
p->parent[i].status, p->parent[i].mode, oid_to_hex(&p->parent[i].oid),
p->parent[i].path);
                }
                num_paths++;
        }
```

And the output doesn't SEGFAULT :)
```
$ GIT_TRACE=3D1 ./git diff-tree --cc 6f8ae955bda8ad246cc1f5f7a15f1c3b1c0469=
6a
10:06:11.716284 git.c:476               trace: built-in: git diff-tree
--cc 6f8ae955bda8ad246cc1f5f7a15f1c3b1c04696a
6f8ae955bda8ad246cc1f5f7a15f1c3b1c04696a
10:06:11.718102 combine-diff.c:1592     Wink diff_tree_combined: find
number of surviving paths num_parent=3D2
10:06:11.718108 combine-diff.c:1594     Wink diff_tree_combined:
num_paths=3D0 &p=3D0x643ac70f7ef0 mode=3D81a4,
oid=3D0f41b2fd4a6b679a1cfcaa9a584c382068146212 path=3Drefs.c
10:06:11.718112 combine-diff.c:1596     Wink diff_tree_combined:
&p->parent[0]=3D0x643ac70f7f28 status=3DM mode=3D81a4
oid=3D7dd5e9fa3323111f06303674b213ae24ed2d04b6 path=3D(null)
10:06:11.718116 combine-diff.c:1596     Wink diff_tree_combined:
&p->parent[1]=3D0x643ac70f7f60 status=3DM mode=3D81a4
oid=3Dc55583986940d8ef1e1c839364c03cd92d4f7114 path=3D(null)
10:06:11.718120 combine-diff.c:1594     Wink diff_tree_combined:
num_paths=3D1 &p=3D0x643ac70f7fb0 mode=3D81a4,
oid=3Da0cdd99250e8286b55808b697b0a94afac5d8319 path=3Drefs.h
10:06:11.718123 combine-diff.c:1596     Wink diff_tree_combined:
&p->parent[0]=3D0x643ac70f7fe8 status=3DM mode=3D81a4
oid=3D09be47afbee51e99f4ae49588cd65596ccfcb07e path=3D(null)
10:06:11.718126 combine-diff.c:1596     Wink diff_tree_combined:
&p->parent[1]=3D0x643ac70f8020 status=3DM mode=3D81a4
oid=3Db0dfc65ed2e59c4b66967840339f81e7746a96d3 path=3D(null)
10:06:11.718129 combine-diff.c:1594     Wink diff_tree_combined:
num_paths=3D2 &p=3D0x643ac70f8900 mode=3D81a4,
oid=3D5cfb8b7ca8678e171b8e8a7ad6daf1af74a81b59 path=3Drefs/files-backend.c
10:06:11.718132 combine-diff.c:1596     Wink diff_tree_combined:
&p->parent[0]=3D0x643ac70f8938 status=3DM mode=3D81a4
oid=3D467fe347fa7e7d82ed7a2836e43ea749bb90ad7d path=3D(null)
10:06:11.718135 combine-diff.c:1596     Wink diff_tree_combined:
&p->parent[1]=3D0x643ac70f8970 status=3DM mode=3D81a4
oid=3D8953d1c6d37b13b0db701888b3db92fd87a68aaa path=3D(null)
10:06:11.718138 combine-diff.c:1594     Wink diff_tree_combined:
num_paths=3D3 &p=3D0x643ac70f89d0 mode=3D81a4,
oid=3D16550862d3ebe3b357c52254088b143c7ba000d6 path=3Drefs/refs-internal.h
10:06:11.718142 combine-diff.c:1596     Wink diff_tree_combined:
&p->parent[0]=3D0x643ac70f8a08 status=3DM mode=3D81a4
oid=3D66e66e0fc1e812ebebd1d4b0119899c84bf1c0ae path=3D(null)
10:06:11.718162 combine-diff.c:1596     Wink diff_tree_combined:
&p->parent[1]=3D0x643ac70f8a40 status=3DM mode=3D81a4
oid=3D79b287c5ec5c7d8f759869cf93cda405640186dc path=3D(null)
10:06:11.718181 combine-diff.c:1594     Wink diff_tree_combined:
num_paths=3D4 &p=3D0x643ac70f8aa0 mode=3D81a4,
oid=3D00d95a9a2f42ce74c5cb4a42175b0953287851a6
path=3Drefs/reftable-backend.c
10:06:11.718184 combine-diff.c:1596     Wink diff_tree_combined:
&p->parent[0]=3D0x643ac70f8ad8 status=3DM mode=3D81a4
oid=3D8a2a5b847c3d86332e319da69bfb5c8a56a10e86 path=3D(null)
10:06:11.718188 combine-diff.c:1596     Wink diff_tree_combined:
&p->parent[1]=3D0x643ac70f8b10 status=3DM mode=3D81a4
oid=3Dbec5962debea7b62572d08f6fa8fd38ab4cd8af6 path=3D(null)
10:06:11.718192 combine-diff.c:1601     Wink diff_tree_combined: found
5 surviving paths
diff --cc refs/files-backend.c
index 467fe347fa,8953d1c6d3..5cfb8b7ca8
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@@ -2533,9 -2539,15 +2543,15 @@@ static int check_old_oid(struct ref_upd
                            oid_to_hex(oid),
                            oid_to_hex(&update->old_oid));

 -      return -1;
 +      return ret;
  }

+ struct files_transaction_backend_data {
+       struct ref_transaction *packed_transaction;
+       int packed_refs_locked;
+       struct strmap ref_locks;
+ };
+
  /*
   * Prepare for carrying out update:
   * - Lock the reference referred to by update.
```
