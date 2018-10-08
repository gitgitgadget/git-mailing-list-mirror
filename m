Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B447D1F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 22:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbeJIGNu (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 02:13:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36899 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeJIGNu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 02:13:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id c22-v6so19004717edc.4
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 15:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E78O2526mVfyxG2tOquIED0eYggoOGK+VJMKcBHKDq4=;
        b=psvgSVKjaZee6uV8QknZHdQeaQaHEnJtmHjhHbbfzqGdh5xHTREtTZmX9b4SRKSANZ
         JYBWxiKMCf+vTDcjAsgataQQCl/gdT/w/MBQK62sAPfilWlkw0Yesj5j6VEOwpKcPWur
         Xn0mpKTWZrhz84APusf7Wx1b24GQeQrvnRBtTYTG3yxqirbNvPJYEhHD6gx6JvjHhhkD
         STX1SNbIdwT6y8//hctsnodr+dUSEd1H8hW4onOhsJD4qSoF9q0m343XQxwDCnJC8Jwv
         0DV7X+dBc4qJP1HwboMdGNhdlx1mtqwfcmYE0vq0HrzTPhF1pkDhLXg4tzhmIhJhh7Tg
         VPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E78O2526mVfyxG2tOquIED0eYggoOGK+VJMKcBHKDq4=;
        b=qBASYmP/1HU9+jLykkPeDuqsFZ1ACQc3Fp5rqRZsIUeEbfBOpKvMKB0yZ59hv83n7K
         aCbDcg0xMv2nDv7V+7fhocVebbqhRFt379tuJkoJR6SZsxgNs0LBbcl3uuINC1mWQIBw
         sHhh8+GeFLPlGhikwc7SBq1+/7BoOThkF1Yk0Z0rEvrGTN+R+Uj1ZyPWkCY+mH4JnZBt
         DOiFXWkmPoS1Zz/r/qFJdaII0tWQGJMljggThMjIHbFsAJySlwNycB7Uwt8XipuayZKT
         lSYszyv4F9SjQ6NrTearBSHMosWm//GdNcEjfFufjB9NyBdXFcOsaTrT0eTtYT20Vj+o
         2pew==
X-Gm-Message-State: ABuFfojKD5H9NrK9mPuMAqu5hgleINK7dWhjscSzSO+O1diF6m+GRVAa
        RHrbHh3eUH3wXU0nQG/6BxkpZgGP4mZ9J291ZEFlrw==
X-Google-Smtp-Source: ACcGV633eW7Q8Y4WEKdf+wrQ1JfcdZx/fqeh4A805icZ09FoO7GDOuUhwf/EtHm45KkeJ8i2IWiKw9Njls+YqS5sJXU=
X-Received: by 2002:a50:b607:: with SMTP id b7-v6mr9300804ede.215.1539039587434;
 Mon, 08 Oct 2018 15:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181008215701.779099-1-sandals@crustytoothpaste.net> <20181008215701.779099-7-sandals@crustytoothpaste.net>
In-Reply-To: <20181008215701.779099-7-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 Oct 2018 15:59:36 -0700
Message-ID: <CAGZ79kbirX6i+qkig6R1YOAsv=0BirhAVkar+AdBLyHgkrXYyg@mail.gmail.com>
Subject: Re: [PATCH 06/14] packfile: express constants in terms of the_hash_algo
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 8, 2018 at 2:57 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Replace uses of GIT_SHA1_RAWSZ with references to the_hash_algo to avoid
> dependence on a particular hash length.

Unlike the previous patches, this is dealing directly with packfiles,
which (I would think) carry their own hash function selector?
(i.e. packfiles up to version 4 are sha1 hardcoded and version
5 and onwards will have a hash type field. Usually that hash type would
match what is in the_repository, but you could obtain packfiles
out of band, or the translation table that we plan to have might
be part of the packfile/idx file?)


>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  packfile.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/packfile.c b/packfile.c
> index 841b36182f..17f993b5bf 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1121,13 +1121,14 @@ int unpack_object_header(struct packed_git *p,
>  void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1)
>  {
>         unsigned i;
> +       const unsigned hashsz = the_hash_algo->rawsz;
>         for (i = 0; i < p->num_bad_objects; i++)
> -               if (hasheq(sha1, p->bad_object_sha1 + GIT_SHA1_RAWSZ * i))
> +               if (hasheq(sha1, p->bad_object_sha1 + hashsz * i))
>                         return;
>         p->bad_object_sha1 = xrealloc(p->bad_object_sha1,
>                                       st_mult(GIT_MAX_RAWSZ,
>                                               st_add(p->num_bad_objects, 1)));
> -       hashcpy(p->bad_object_sha1 + GIT_SHA1_RAWSZ * p->num_bad_objects, sha1);
> +       hashcpy(p->bad_object_sha1 + hashsz * p->num_bad_objects, sha1);
>         p->num_bad_objects++;
>  }
>
