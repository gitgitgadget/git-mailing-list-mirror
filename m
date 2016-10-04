Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 657291F4F8
	for <e@80x24.org>; Tue,  4 Oct 2016 06:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbcJDGo7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 02:44:59 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34093 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbcJDGo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 02:44:58 -0400
Received: by mail-yw0-f196.google.com with SMTP id u124so1857173ywg.1
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 23:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G1nrNNL2UBOy1Q4cp5T/itoF+w1CY63CTKtfzUXS8Ic=;
        b=vT9bDilexjbqq93F2YVb3TvaipO8IEMaUpcQMALjA6x6G8ZNKjIZFGyqCTf5XtXgxN
         fyZl3RuLgyEWMBvGOs0QEQWbGONtLgQ8M4zo2F33QJ8aslz8tE/tBMICl0jcl3f3k5J+
         f5BJDaQIgCgZ745bWcPn5Z1WvMJpZBNSCo4WBmEevnG4SavZwyyqKjapCMwWRJx9Iyqw
         BNTqOf7l7hpmrIMJbY0GTozX59cFBJiofIY3bRjyX689XleUJPrAny+ExPQ6Sag4zOtj
         uNpC/M7tqF81awY84e4cgu2kD70QtYDGaZp3UBydKotqWFV1yjz8vyb/mjhnZ3HTXRIZ
         dRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G1nrNNL2UBOy1Q4cp5T/itoF+w1CY63CTKtfzUXS8Ic=;
        b=UG1ynCPi1JDla00EoGt5Fi82GyIS2Hxk2bGn/QzZ5s2xT+Bpmsuxk2JFL4CVPylhZW
         otpHobLQAnOVBtM2IGZH6K9vAlIwUsxANf5NukL++/uJwDwfKTpFQbBIgmFrZNyeGa/X
         om/Nn3/mlDb00ka8WxvTjOv4yIsEdQcyez9GAhr8K+sQydO8zSMz2S7gUgj/pZaqdE1p
         dt9XPrf70tXpset2aLwv+a3cg7wOg6hRG1oayat65VqPAgf7W7inPMTEQlMA14JTHaGE
         JZt3CVq0CatJNdFKc8wmLf6a1lEJtn5EPcDHGNQm7Qwk7NcCuElmXow4rvt9IZHV9qYH
         dHQw==
X-Gm-Message-State: AA6/9RkKzWLJBUnv0etA3KP/j5qS8Qc4+g1CRjnl7lTrdzHXrJqmP62P6/NfqrRqiWvTDB6lYEqlYyT2jcbWVg==
X-Received: by 10.13.244.129 with SMTP id d123mr1322028ywf.276.1475563497840;
 Mon, 03 Oct 2016 23:44:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 3 Oct 2016 23:44:37 -0700 (PDT)
In-Reply-To: <20161003203609.4hig3e24lyvswdcf@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net> <20161003203609.4hig3e24lyvswdcf@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 3 Oct 2016 23:44:37 -0700
Message-ID: <CA+P7+xrVSsNfHo_+tT2+tmXkzAiETVRDVwud-2ADGX8G42W+GQ@mail.gmail.com>
Subject: Re: [PATCH 15/18] fill_sha1_file: write into a strbuf
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 3, 2016 at 1:36 PM, Jeff King <peff@peff.net> wrote:
> It's currently the responsibility of the caller to give
> fill_sha1_file() enough bytes to write into, leading them to
> manually compute the required lengths. Instead, let's just
> write into a strbuf so that it's impossible to get this
> wrong.

Yea this makes sense.

>
> The alt_odb caller already has a strbuf, so this makes
> things strictly simpler. The other caller, sha1_file_name(),
> uses a static PATH_MAX buffer and dies when it would
> overflow. We can convert this to a static strbuf, which
> means our allocation cost is amortized (and as a bonus, we
> no longer have to worry about PATH_MAX being too short for
> normal use).
>
> This does introduce some small overhead in fill_sha1_file(),
> as each strbuf_addchar() will check whether it needs to
> grow. However, between the optimization in fec501d
> (strbuf_addch: avoid calling strbuf_grow, 2015-04-16) and
> the fact that this is not generally called in a tight loop
> (after all, the next step is typically to access the file!)
> this probably doesn't matter. And even if it did, the right
> place to micro-optimize is inside fill_sha1_file(), by
> calling a single strbuf_grow() there.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  sha1_file.c | 34 ++++++++++------------------------
>  1 file changed, 10 insertions(+), 24 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index efc8cee..80a3333 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -172,36 +172,28 @@ enum scld_error safe_create_leading_directories_const(const char *path)
>         return result;
>  }
>
> -static void fill_sha1_path(char *pathbuf, const unsigned char *sha1)
> +static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
>  {
>         int i;
>         for (i = 0; i < 20; i++) {
>                 static char hex[] = "0123456789abcdef";
>                 unsigned int val = sha1[i];
> -               *pathbuf++ = hex[val >> 4];
> -               *pathbuf++ = hex[val & 0xf];
> +               strbuf_addch(buf, hex[val >> 4]);
> +               strbuf_addch(buf, hex[val & 0xf]);
>                 if (!i)
> -                       *pathbuf++ = '/';
> +                       strbuf_addch(buf, '/');
>         }
> -       *pathbuf = '\0';
>  }
>
>  const char *sha1_file_name(const unsigned char *sha1)
>  {
> -       static char buf[PATH_MAX];
> -       const char *objdir;
> -       int len;
> +       static struct strbuf buf = STRBUF_INIT;
>
> -       objdir = get_object_directory();
> -       len = strlen(objdir);
> +       strbuf_reset(&buf);
> +       strbuf_addf(&buf, "%s/", get_object_directory());
>
> -       /* '/' + sha1(2) + '/' + sha1(38) + '\0' */
> -       if (len + 43 > PATH_MAX)
> -               die("insanely long object directory %s", objdir);
> -       memcpy(buf, objdir, len);
> -       buf[len] = '/';
> -       fill_sha1_path(buf + len + 1, sha1);
> -       return buf;

I'm definitely a fan of seeing the magic number here go away.

> +       fill_sha1_path(&buf, sha1);
> +       return buf.buf;
>  }
>
>  struct strbuf *alt_scratch_buf(struct alternate_object_database *alt)
> @@ -213,14 +205,8 @@ struct strbuf *alt_scratch_buf(struct alternate_object_database *alt)
>  static const char *alt_sha1_path(struct alternate_object_database *alt,
>                                  const unsigned char *sha1)
>  {
> -       /* hex sha1 plus internal "/" */
> -       size_t len = GIT_SHA1_HEXSZ + 1;
>         struct strbuf *buf = alt_scratch_buf(alt);

Funny story.. While reviewing this code on my screen, my monitor has a
nice little bit of gunk just between the lines that made this one look
like it was being deleted. So I was really confused as to what strbuf
you were using and why you removed a call to alt_scratch_buf()..
Obviously this line just isn't being removed.

> -
> -       strbuf_grow(buf, len);
> -       fill_sha1_path(buf->buf + buf->len, sha1);
> -       strbuf_setlen(buf, buf->len + len);
> -
> +       fill_sha1_path(buf, sha1);
>         return buf->buf;
>  }
>
> --
> 2.10.0.618.g82cc264
>
