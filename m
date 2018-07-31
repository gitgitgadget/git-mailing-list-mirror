Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7DC01F597
	for <e@80x24.org>; Tue, 31 Jul 2018 18:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbeGaU0F (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 16:26:05 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33679 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbeGaU0F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 16:26:05 -0400
Received: by mail-vk0-f68.google.com with SMTP id y70-v6so8032632vkc.0
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 11:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B8rjV28SFuUi8o6RAMMVEC9RXxAOR/X88NTvCfhO8Hc=;
        b=JfX7wWXYVgEoMnC8K0oyUuzDPMzLzq1Eebsw+Gp/yP6FRBnRabEmAeQTNFTr6JBTJL
         aksTqG0D2UE/IupZWr37R6ONugDqrXvHoNGa0JAU5VacWZkNL0J1c5QQnmmHqk0Io9nH
         v35aTBMgLuPWjKQvWOk6DHl3Wl2KyovWog++ynIVzd/dXr6OiWZA+XMTgbF2Q+nTCGis
         bDvUvMZ8cZzqOPMJAKamClRWuOfTRHHf+rfZtV6RmjiTNcy2c+bmm0qAmT410gOJo2ic
         Zc1r3WkNrEcT1MbvSHDR4oP5HriOZwup0yGQIoeL9XBUgFm61YCWbvr17FIzVXes+jvj
         HFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B8rjV28SFuUi8o6RAMMVEC9RXxAOR/X88NTvCfhO8Hc=;
        b=HmOOjrJrlrPe7bX6BPolz0+tMOW2GUuHYjepWXs5VHh5Rrlvm5srJ5fJfuf3yArAMw
         zHJNCKb+kHWMTp0L7Z3/R+M/cM1yLP9IDy8FZ8gIV95v+r333qWqdhwfM1sssBLFwIxi
         qwzXkVEGihPK5JD/hEmXUfeJQhSvtrC/ZHtqHONyPq+Zwh2+sRwHWPnNlK49qRFif/nt
         Ib2SDwuTTpNk336+YEqFZp6ObVh9d7o2cTPXgnNyOYI7vqU6Zl60l2jaRpIZ5CdKiCCC
         BKhUpQjv1h5XohG73NirdI5J6+ABcECoVg2Xpd/C16IvBxDwB3zWNdFjKwuqSYcpd6Lp
         FuzA==
X-Gm-Message-State: AOUpUlEs7xAO2akIqtRgPdKd+LDVHXabHIIIqhsuFXTBEEW2RtWmlGwC
        BA78D5q4hFOowDoT4jb+WvRha5J2Zv0coJMIBaDuzw==
X-Google-Smtp-Source: AAOMgpckFIRAo7T8nuQyCJlU+AS67j2grCCSd7rhlzcL0PAKQ5yQg1MlJ+75+dA8kilFMynJs89e2XEkOWgdQtaNUxM=
X-Received: by 2002:a1f:207:: with SMTP id 7-v6mr14909936vkc.0.1533062668345;
 Tue, 31 Jul 2018 11:44:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 11:44:27
 -0700 (PDT)
In-Reply-To: <20180730152756.15012-1-pclouds@gmail.com>
References: <20180729092759.GA14484@sigill.intra.peff.net> <20180730152756.15012-1-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 31 Jul 2018 11:44:27 -0700
Message-ID: <CABPp-BG+nB+ifRbCdMpXnnxQ+rzhM8W-=sfQf8TYmXvuPy5WXg@mail.gmail.com>
Subject: Re: [PATCH/RFC] clone: report duplicate entries on case-insensitive filesystems
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        pawelparuzel95@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 30, 2018 at 8:27 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Paths that only differ in case work fine in a case-sensitive
> filesystems, but if those repos are cloned in a case-insensitive one,
> you'll get problems. The first thing to notice is "git status" will
> never be clean with no indication what's exactly is "dirty".

"what" rather than "what's"?

> This patch helps the situation a bit by pointing out the problem at
> clone time. I have not suggested any way to work around or fix this
> problem. But I guess we could probably have a section in
> Documentation/ dedicated to this problem and point there instead of
> a long advice in this warning.
>
> Another thing we probably should do is catch in "git checkout" too,
> not just "git clone" since your linux/unix colleage colleague may

drop "colleage", keep "colleague"?

> accidentally add some files that your mac/windows machine is not very
> happy with. But then there's another problem, once the problem is
> known, we probably should stop spamming this warning at every
> checkout, but how?

Good questions.  I have no answers.

>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  builtin/clone.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 5c439f1394..32738c2737 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -711,6 +711,33 @@ static void update_head(const struct ref *our, const=
 struct ref *remote,
>         }
>  }
>
> +static void find_duplicate_icase_entries(struct index_state *istate,
> +                                        struct string_list *dup)
> +{
> +       struct string_list list =3D STRING_LIST_INIT_NODUP;
> +       int i;
> +
> +       for (i =3D 0; i < istate->cache_nr; i++)
> +               string_list_append(&list, istate->cache[i]->name);
> +
> +       list.cmp =3D fspathcmp;
> +       string_list_sort(&list);

So, you sort the list by fspathcmp to get the entries that differ in
case only next to each other.  Makes sense...

> +
> +       for (i =3D 1; i < list.nr; i++) {
> +               const char *cur =3D list.items[i].string;
> +               const char *prev =3D list.items[i - 1].string;
> +
> +               if (dup->nr &&
> +                   !fspathcmp(cur, dup->items[dup->nr - 1].string)) {
> +                       string_list_append(dup, cur);

If we have at least one duplicate in dup (and currently we'd have to
have at least two), and we now hit yet another (i.e. a third or
fourth...) way of spelling the same path, then we add it.

> +               } else if (!fspathcmp(cur, prev)) {
> +                       string_list_append(dup, prev);
> +                       string_list_append(dup, cur);
> +               }

...otherwise, if we find a duplicate, we add both spellings to the dup list=
.

> +       }
> +       string_list_clear(&list, 0);
> +}
> +
>  static int checkout(int submodule_progress)
>  {
>         struct object_id oid;
> @@ -761,6 +788,20 @@ static int checkout(int submodule_progress)
>         if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
>                 die(_("unable to write new index file"));
>
> +       if (ignore_case) {
> +               struct string_list dup =3D STRING_LIST_INIT_DUP;
> +               int i;
> +
> +               find_duplicate_icase_entries(&the_index, &dup);
> +               if (dup.nr) {
> +                       warning(_("the following paths in this repository=
 only differ in case and will\n"

Perhaps I'm being excessively pedantic, but what if there are multiple
pairs of paths differing in case?  E.g. if someone has readme.txt,
README.txt, foo.txt, and FOO.txt, you'll list all four files but
readme.txt and foo.txt do not only differ in case.

Maybe something like "...only differ in case from another path and
will... " or is that too verbose and annoying?

> +                                 "cause problems because you have cloned=
 it on an case-insensitive filesytem:\n"));
> +                       for (i =3D 0; i < dup.nr; i++)
> +                               fprintf(stderr, "\t%s\n", dup.items[i].st=
ring);
> +               }
> +               string_list_clear(&dup, 0);
> +       }
> +
>         err |=3D run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1=
),
>                            oid_to_hex(&oid), "1", NULL);

Is it worth attempting to also warn about paths that only differ in
UTF-normalization on relevant MacOS systems?
