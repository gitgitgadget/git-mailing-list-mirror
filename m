Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB67DC48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 16:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE76461042
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 16:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhFTQzb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 12:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhFTQz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 12:55:29 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3AEC061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 09:53:16 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id q12so2250527ilv.5
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 09:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=OzX+9NNg78TD2NkDWXfXlueFZLkCRksqbt6n6TEJkzE=;
        b=cZlNfFZ4mjdOKpiz5RV6MqTLGGlL7G2CKGjbZrtmgrgdplovJcU3d3ix64yeVHBHUW
         /f1uyPvgeC28mhEegiKN5zDKaKb/gHG1vfND5nU9SBQ0Qz8U+bWEidbc+g6efa0EVUWW
         oqr1iaa9FDo9FbQefgtx0xmCN/TRD1zL3aX4jIJdjlMwCxM8JhAGJxK5QEx9qX+dJFaL
         1Jxa5vtKIL2tv4n4f1yJpcp2eztYHnrzlVgt02AIH4ztuejK3xyZLVbxNBcbitm6uN5l
         WI6zVtVwvvTBzjx0jMDd9p5KpfcZSw7IXVo1Jk0rVfrfIw/dDn99nMvglZJ+/URCFs+t
         9l2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=OzX+9NNg78TD2NkDWXfXlueFZLkCRksqbt6n6TEJkzE=;
        b=ZxGy7SKSoPdGja5lyPw34grZ9CMmgIN+6fNt0crqEJmroneQo1oI/Q6l6lvnkoMxyO
         jgmYk5+FuJZWCy6aokPLLAQ6pLYgjseF+Tvl3BwJdBshClHXP/M67MzwW1bYrH39q/54
         N7MxPHJz/cae7nxp5yeOL+eCXakmtHT+EvbsYibIFm0VLF36tmQTPlT/iHove42qJRAn
         18M8HGeHDWslY/kuy2hYncTVP3Om3a4MVwPwpWaZoXPl9aLP5ZF0BWBDw28J+4k8zps0
         WX18VruZ0v6PG4WVVl8fbTUkpqmGDidDbB3wLP720r/AziJwAJukfdGu81+TrVCaXUky
         rzog==
X-Gm-Message-State: AOAM530EJHPBStSOb6w7VDpk6iY0FkuG2JWqfwjCGzK1HrUr7jm3liko
        +hvfa1AXGzbQaK3zGtRtO9ROLs/YB2zoemEj8iibniHOC73+o7Sd
X-Google-Smtp-Source: ABdhPJwNvjbr9Jo8HACV4DXor/JpvIKg1nVuOpB8HZmlMz6vXKWoq1SjZas6otHfN2b8UhQeLqDwXT2fzxnr9fVvTxs=
X-Received: by 2002:a92:5401:: with SMTP id i1mr6329297ilb.17.1624207994830;
 Sun, 20 Jun 2021 09:53:14 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 21 Jun 2021 00:53:03 +0800
Message-ID: <CAOLTT8TZqKQ1vkRX7apvzAJ04Cv9aHJ9kF1+wJcEvyi-pibOOw@mail.gmail.com>
Subject: [GSoC] Git Blog 5
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My fifth week blog finished:
The web version is here:
https://adlternative.github.io/GSOC-Git-Blog-5/

## Week5: Tempting apple

This week, I spent a lot of time working on the digital circuit
course design of the school. So this week's patches for git
was completed in a hurry. This week `=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
`
gave a lot of useful suggestions for the patch I wrote earlier.
Some are related to code style improvements, and some are
better design ideas.

Before, I wanted to use a `<s, s_size>` style string in `atom_value`
to help copy and compare data containing '\0'.

Like this:

```c
struct atom_value {
const char *s;
size_t s_size;
...
};
```

But `=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason` thinks it is more reasonable t=
o
use `strbuf` instead of `<s, s_size>`.

Like this:

```c
struct atom_value {
struct strbuf s;
...
};
```

Since the `strbuf` API has a natural `<s, s_size>`, we can add data
that may contain '\0' through `strbuf_add()`, `strbuf_addbuf()`, and
`strbuf_addf()` can also be used to fill strbuf with format string. Use
 `strbuf_addstr()` to replace `xstrdup()`, `strbuf_add()` to replace
 `xmemdupz()`, this is indeed a very tempting choice.

But in my actual refactoring process, this is not very easy to achieve.

For example, the original interface is like this,

```c
v->s =3D copy_email(wholine, &used_atom[i]);
```

`v->s` will be filled with the data dynamically allocated by `copy_email()`=
.

```c
static const char *copy_email(const char *buf, struct used_atom *atom)
{
...
if (!eoemail)
return xstrdup("");
return xmemdupz(email, eoemail - email);
}
```

Then if we want use `strbuf` type `v->s`, we should change the
 `copy_email()` interface parameters and return value.

```c
static void copy_email(struct strbuf *str, const char *buf, struct
used_atom *atom)
{
...
if (!eoemail)
return;
return strbuf_add(str, email, eoemail - email);
}
```

Then the caller can do:

```c
copy_email(&v->s, wholine, &used_atom[i]);
```

This is in line with our expectations.

But something like `fill_remote_ref_details()`, things gradually
become complicated and difficult. `fill_remote_ref_details()`.
Just consider the `show_ref()` called in `fill_remote_ref_details()`,
`show_ref()` may call `shorten_unambiguous_ref()` internally, and
then another function is called internally in `shorten_unambiguous_ref()`..=
.
This makes us fail the method of passing `v->s` in parameters like
`copy_email()` does. Another way of thinking: what if I can "attach"
the data directly? Using `strbuf_attach()` may be a viable option, but...

```c
size_t len;
void *data =3D shorten_unambiguous_ref(refname, warn_ambiguous_refs);
len =3D strlen(data);
strbuf_attach(&str, data, len, len);
```

...we need to get the length of the data, but this is not easy to do,
`strlen()` can only be used on data that does not contain '\0',
and we are not sure whether a function like `shorten_unambiguous_ref()`
will return a `NULL`.

Well, this is one of the reasons why I cannot move on.

On the other hand, look at the following piece of code, it appears
in `populate_value()`.

```c
for (i =3D 0; i < used_atom_cnt; i++) {
struct atom_value *v =3D &ref->value[i];
if (v->s =3D=3D NULL && used_atom[i].source =3D=3D SOURCE_NONE)
return strbuf_addf_ret(err, -1, _("missing object %s for %s"),
oid_to_hex(&ref->objectname), ref->refname);
}
```

We need to determine whether `v->s` equals to `NULL`. We can use
c-style strings to easily distinguish between empty strings(`xstrdup("")`)
and `NULL`, but if we use strbuf, it is not easy to distinguish, because
an empty strbuf has the following characteristics: `s.buf =3D=3D strbuf_slo=
pbuf`
or `sb->buf[0] =3D=3D '\0'`. It can be said that we shouldn=E2=80=99t even =
use `NULL`
to assign to `s.buf`.

So in the end, I rejected this seemingly very attractive solution, and use =
the
previous strategy: `<s, s_size>`, unless someone can think of a better
solution later `;-)`.

* FootNote:
1. Why is there no `strbuf_empty()` in `strbuf` API? I think this may be
a very important thing.

```c
#define strbuf_empty(sb) \
(sb->buf =3D=3D strbuf_slopbuf) ? \
(!strbuf_slopbuf[0]) : \
(sb->buf[0] =3D=3D '\0')
```

2. Another thing worth mentioning is: I will have the school final exam
between July 7th and July 14th, I may be busy during this period.

Thanks for Git community, reviewers and mentors.
--
ZheNing Hu
