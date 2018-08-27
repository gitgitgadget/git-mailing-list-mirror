Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 152BA1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 07:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeH0LWl (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 07:22:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41158 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbeH0LWl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 07:22:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id f38-v6so9741271edd.8
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 00:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=o0D1xOdqatO3irrQU9eKVVSveuTdv7yCBOHzYOWFvxo=;
        b=vbWmjl+BtTuFThLe8yJbzIS2SZ7IW9OK8saEjp7Yxr8R0wCI/I5aXoSkK7gr4gwkr4
         zVwRM0PNxQdRpECKyqrfr3pCvD0OU23aUYFYOjYejGmyP4wK2vhn03a7WtgPPrI77HL4
         7MDklgwIprOkXiTIgwpbQ7Kp0qPuOYehTqeHYXAt2eZp4EmM84EuAvl959lyWXARx6yj
         iOR7/UVk/AX5PrFWS5cKIY98yVj666kwMh+65D7hgYEk84GtfXCZtyiU6IGYPAJbH4+9
         JR4WWhjkZ75gccfq2xep4/BM5AQg1U/l9HjBIIPNZEhJ4vsa2HnQvoZ3suQTJlzvNfL7
         KUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=o0D1xOdqatO3irrQU9eKVVSveuTdv7yCBOHzYOWFvxo=;
        b=t3D7mIJc0XdnhOhzLR8IE6eDDZlhwEKjdxjm6tYuU/5xyNcSLlb1Nd7F/aJqDv+r/8
         xr1qI1xw94nhL6v1HKcoHOFnUaqi1w27L1KFab8gM6xJ5w4JeJzddbDxC0UmQJV/XTze
         /iduH9V8XTQLIds/xeHKt5cdNHhWpQQId9Uz+Lulw/1C+ZFRXkbB7tYJYkE/FEUXER/o
         izHKzq9I82cIYtVFoZ3R27Jlp9tt7BSersV6X1RLpv3M9g0oMOFyosT3+pm/GZsf5QKU
         wZ8IXoGe1Rz+S/iqSrzoNAx841PSKIw/Qvjm153R7W1rUArzufOp40Ojp19U59GQHv2x
         gfvQ==
X-Gm-Message-State: APzg51DmesFCsypRFN1+b7SNpO2dMo6fjNAChc2H3xvMrX4DSTQkP9GI
        dIy7Co5ruOH6SV67rZ6/oZ8=
X-Google-Smtp-Source: ANB0VdZkk7o/sBxeZhRk50uEzw5Eirk52biedYR/rIuKU4QNXDtMOsl4P6IvdkKrw8mgs+DUSUsEgw==
X-Received: by 2002:a50:9b5c:: with SMTP id a28-v6mr15592330edj.167.1535355432680;
        Mon, 27 Aug 2018 00:37:12 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id k28-v6sm7012233ede.11.2018.08.27.00.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 00:37:11 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] fsck: use oidset for skiplist
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de> <ae61a845-16fa-e2d6-935d-ce5eb1e33e5a@web.de>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <ae61a845-16fa-e2d6-935d-ce5eb1e33e5a@web.de>
Date:   Mon, 27 Aug 2018 09:37:11 +0200
Message-ID: <87r2ikdzvc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Aug 25 2018, René Scharfe wrote:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 2fa65b7516..80ab570579 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1715,7 +1715,7 @@ doing the same for `receive.fsck.<msg-id>` and `fetch.fsck.<msg-id>`
>  will only cause git to warn.
>
>  fsck.skipList::
> -	The path to a sorted list of object names (i.e. one SHA-1 per
> +	The path to a list of object names (i.e. one SHA-1 per
>  	line) that are known to be broken in a non-fatal way and should
>  	be ignored. This feature is useful when an established project
>  	should be accepted despite early commits containing errors that

I was going to say that since this is a file format we're likely to
support across versions we should make a note that "up to version
so-and-so this needed to be sorted, but that's longer the case. So
e.g. someone wouldn't test this on 2.20 (or read the online docs) and
then deploy this for older clients..

But...

> -	if (options->skiplist)
> -		sorted = options->skiplist->sorted;
> -	else {
> -		sorted = 1;
> -		options->skiplist = &skiplist;
> -	}
> -
>  	fp = fopen(path, "r");
>  	if (!fp)
>  		die("Could not open skip list: %s", path);
> @@ -202,19 +192,12 @@ static void init_skiplist(struct fsck_options *options, const char *path)
>  		const char *p;
>  		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
>  			die("Invalid SHA-1: %s", sb.buf);
> -		oid_array_append(&skiplist, &oid);
> -		if (sorted && skiplist.nr > 1 &&
> -				oidcmp(&skiplist.oid[skiplist.nr - 2],
> -				       &oid) > 0)
> -			sorted = 0;
> +		oidset_insert(&options->skiplist, &oid);

...reading this implementation, where we always called
oid_array_append(), but then just kept track of whether the set was
sorted...

>  	}
>  	if (ferror(fp))
>  		die_errno("Could not read '%s'", path);
>  	fclose(fp);
>  	strbuf_release(&sb);
> -
> -	if (sorted)
> -		skiplist.sorted = 1;

...and here where we assigned to the .sorted member of the oid_array...

>  static int object_on_skiplist(struct fsck_options *opts, struct object *obj)
>  {
> -	if (opts && opts->skiplist && obj)
> -		return oid_array_lookup(opts->skiplist, &obj->oid) >= 0;
> -	return 0;
> +	return opts && obj && oidset_contains(&opts->skiplist, &obj->oid);
>  }

....and here where we'd always do the lookup if the skiplist was
initialized, *not* just if it's sorted, and how the sha1-array.c code
has looked ever since cd94c6f91 ("fsck: git receive-pack: support
excluding objects from fsck'ing", 2015-06-22) when this was first added:

    $ git show cd94c6f91:sha1-array.c|grep -A5 sha1_array_lookup
    int sha1_array_lookup(struct sha1_array *array, const unsigned char *sha1)
    {
            if (!array->sorted)
                    sha1_array_sort(array);
            return sha1_pos(sha1, array->sha1, array->nr, sha1_access);
    }

So I think it makes sense to make this series a three-part, where in the
first part we only change these docs to say s/sorted //, and modify the
tests I added in 65a836fa6b ("fsck: add stress tests for fsck.skipList",
2018-07-27) to assert that an unsorted & sorted list of SHA-1s works
just as well.

Then following up with your [12]/2, where the internal implementation is
changed, but we make it clear that it's *just* the internal
implementation. I.e. from a UI perspective the list never had to be
pre-sorted, we'd just spend some work sorting it on the first lookup if
it wasn't sorted already.

Now without some very careful reading it's not clear what "we don't need
to worry about any sort order anymore" in the commit message means,
i.e. what it really means is "for the purposes of the internal
implementation, and as an opt-in user-side optimization ...".

I.e. an alternate version of this whole patch series could also be:

    diff --git a/Documentation/config.txt b/Documentation/config.txt
    index 1c4236498..930807e43 100644
    --- a/Documentation/config.txt
    +++ b/Documentation/config.txt
    @@ -1709,5 +1709,5 @@ will only cause git to warn.

     fsck.skipList::
    -       The path to a sorted list of object names (i.e. one SHA-1 per
    +       The path to a list of object names (i.e. one SHA-1 per
            line) that are known to be broken in a non-fatal way and should
            be ignored. This feature is useful when an established project
    diff --git a/fsck.c b/fsck.c
    index a0cee0be5..9d4e938ad 100644
    --- a/fsck.c
    +++ b/fsck.c
    @@ -184,14 +184,10 @@ static void init_skiplist(struct fsck_options *options, const char *path)
     {
            static struct oid_array skiplist = OID_ARRAY_INIT;
    -       int sorted, fd;
    +       int fd;
            char buffer[GIT_MAX_HEXSZ + 1];
            struct object_id oid;

    -       if (options->skiplist)
    -               sorted = options->skiplist->sorted;
    -       else {
    -               sorted = 1;
    +       if (!options->skiplist)
                    options->skiplist = &skiplist;
    -       }

            fd = open(path, O_RDONLY);
    @@ -208,13 +204,6 @@ static void init_skiplist(struct fsck_options *options, const char *path)
                            die("Invalid SHA-1: %s", buffer);
                    oid_array_append(&skiplist, &oid);
    -               if (sorted && skiplist.nr > 1 &&
    -                               oidcmp(&skiplist.oid[skiplist.nr - 2],
    -                                      &oid) > 0)
    -                       sorted = 0;
            }
            close(fd);
    -
    -       if (sorted)
    -               skiplist.sorted = 1;
     }

Now, I like yours much better. I'm just saying that currently the
patch/commit message combo is confusing about *what* it's
doing. I.e. let's not mix up the correction of docs that were always
wrong with a non-change in the user facing implementation, and some
internal optimization all in one patch.
