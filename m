Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5248B207EC
	for <e@80x24.org>; Tue,  4 Oct 2016 06:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbcJDGCY (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 02:02:24 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33467 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbcJDGCX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 02:02:23 -0400
Received: by mail-yb0-f193.google.com with SMTP id e2so4144500ybi.0
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 23:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ku9cZnlv5JQZzIW9zbcoQCTUzrGxQ8ApaxsG9ScwHZQ=;
        b=wKVA8Cy8fXQzuwIbOlsDdCIQAatAGE8X1YgrdVS5akYuDljX62qoHaqz0ygdI49+pa
         qvUxmvEDPxdYuCwHANh2DZVH3bca+WZ3XopKQRitMHIW2eULdNcGZ6vOZ9lTL0Utebr3
         422SboNW82sSzVpPtivudNfPc5La0cTy5xvKGDqsUgM8KjcbvdPj1aYTcAVR+/8q7deC
         DovjOpNd5LJ5HJbNdxMY/lq/K5yMGLvwPu5nuTiE789/9qAdE/lEPh5S7KxrDnQMM+q/
         5VZjKAPt/SKoa8XtMZNGK9QWpxF+We6Tt0CMc+8GeNlJZ7zzAY09ouxpJQatDzlocb//
         DTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ku9cZnlv5JQZzIW9zbcoQCTUzrGxQ8ApaxsG9ScwHZQ=;
        b=W9MKvLGknylA+iBcXy96FC7HGXDHZ/Ntt3Di/hE2ymftMasbluehAEPiQiM7CXwxGx
         OILA2lsTXhuZElwROXXnT2rLb8CV/auD2uLBAZLoPKoygH61rgonXSXbCXh8D41HGm4g
         6aukrvHIlBdJ41CTkAN9ZOUeKEu58cVpHI1Bh4unMJI2tYY7ZUGXyvN1N79MboivfaP9
         ZDIsxsH2pS09tpbUD05+vhj8hX6EIwEYEQGXNgt6u+W34GuOajlXZHEgAyZH2xsuLEEJ
         S//+Y+r8VAB2cVBXthHG4gSvDKRo1Mrgh1Qndpd4xMJ4h482nPRGOSmjPgZ1CQfgG4pz
         1Z3A==
X-Gm-Message-State: AA6/9RlYDIsjYR9c4GJ1InvPTOH3B58kSfnpZPZGPn8JqxKm8TBLIguwMSXRrsRqR38o7sd4W9bbT4tkYfr2Fw==
X-Received: by 10.37.163.104 with SMTP id d95mr1370220ybi.132.1475560937493;
 Mon, 03 Oct 2016 23:02:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 3 Oct 2016 23:01:57 -0700 (PDT)
In-Reply-To: <20161003203417.izcgwt4yz3yspdnm@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net> <20161003203417.izcgwt4yz3yspdnm@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 3 Oct 2016 23:01:57 -0700
Message-ID: <CA+P7+xrJZatmKDJR=JY9U_JH5BOpQGZ_G2jBM9qi1utUmAM8YQ@mail.gmail.com>
Subject: Re: [PATCH 07/18] link_alt_odb_entry: handle normalize_path errors
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 3, 2016 at 1:34 PM, Jeff King <peff@peff.net> wrote:
> When we add a new alternate to the list, we try to normalize
> out any redundant "..", etc. However, we do not look at the
> return value of normalize_path_copy(), and will happily
> continue with a path that could not be normalized. Worse,
> the normalizing process is done in-place, so we are left
> with whatever half-finished working state the normalizing
> function was in.
>
> Fortunately, this cannot cause us to read past the end of
> our buffer, as that working state will always leave the
> NUL from the original path in place. And we do tend to
> notice problems when we check is_directory() on the path.
> But you can see the nonsense that we feed to is_directory
> with an entry like:
>
>   this/../../is/../../way/../../too/../../deep/../../to/../../resolve
>
> in your objects/info/alternates, which yields:
>
>   error: object directory
>   /to/e/deep/too/way//ects/this/../../is/../../way/../../too/../../deep/../../to/../../resolve
>   does not exist; check .git/objects/info/alternates.
>

Yikes, that doesn't seem helpful.

> We can easily fix this just by checking the return value.
> But that makes it hard to generate a good error message,
> since we're normalizing in-place and our input value has
> been overwritten by cruft.

Right. Definitely want to check the return value here...

>
> Instead, let's provide a strbuf helper that does an in-place
> normalize, but restores the original contents on error. This
> uses a second buffer under the hood, which is slightly less
> efficient, but this is not a performance-critical code path.
>

I agree, I don't think this duplication is really a big deal, since it
helps ensure that the function doesn't modify its arguments on error.

> The strbuf helper can also properly set the "len" parameter
> of the strbuf before returning. Just doing:
>
>   normalize_path_copy(buf.buf, buf.buf);
>
> will shorten the string, but leave buf.len at the original
> length. That may be confusing to later code which uses the
> strbuf.
>

Makes sense here. Properly setting the length will help prevent future issues.

Thanks,
Jake

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  sha1_file.c | 11 +++++++++--
>  strbuf.c    | 20 ++++++++++++++++++++
>  strbuf.h    |  8 ++++++++
>  3 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index b9c1fa3..68571bd 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -263,7 +263,12 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
>         }
>         strbuf_addstr(&pathbuf, entry);
>
> -       normalize_path_copy(pathbuf.buf, pathbuf.buf);
> +       if (strbuf_normalize_path(&pathbuf) < 0) {
> +               error("unable to normalize alternate object path: %s",
> +                     pathbuf.buf);
> +               strbuf_release(&pathbuf);
> +               return -1;
> +       }
>
>         pfxlen = strlen(pathbuf.buf);
>
> @@ -335,7 +340,9 @@ static void link_alt_odb_entries(const char *alt, int len, int sep,
>         }
>
>         strbuf_add_absolute_path(&objdirbuf, get_object_directory());
> -       normalize_path_copy(objdirbuf.buf, objdirbuf.buf);
> +       if (strbuf_normalize_path(&objdirbuf) < 0)
> +               die("unable to normalize object directory: %s",
> +                   objdirbuf.buf);
>
>         alt_copy = xmemdupz(alt, len);
>         string_list_split_in_place(&entries, alt_copy, sep, -1);
> diff --git a/strbuf.c b/strbuf.c
> index b839be4..8fec657 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -870,3 +870,23 @@ void strbuf_stripspace(struct strbuf *sb, int skip_comments)
>
>         strbuf_setlen(sb, j);
>  }
> +
> +int strbuf_normalize_path(struct strbuf *src)
> +{
> +       struct strbuf dst = STRBUF_INIT;
> +
> +       strbuf_grow(&dst, src->len);
> +       if (normalize_path_copy(dst.buf, src->buf) < 0) {
> +               strbuf_release(&dst);
> +               return -1;
> +       }
> +
> +       /*
> +        * normalize_path does not tell us the new length, so we have to
> +        * compute it by looking for the new NUL it placed
> +        */

And we can't correctly set the length inside normalize_path_copy
because it just takes C strings directly and not actually a strbuf. Ok
so it makes sense that we have to set it here.

Thanks,
Jake

> +       strbuf_setlen(&dst, strlen(dst.buf));
> +       strbuf_swap(src, &dst);
> +       strbuf_release(&dst);
> +       return 0;
> +}
> diff --git a/strbuf.h b/strbuf.h
> index ba8d5f1..2262b12 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -443,6 +443,14 @@ extern int strbuf_getcwd(struct strbuf *sb);
>   */
>  extern void strbuf_add_absolute_path(struct strbuf *sb, const char *path);
>
