Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B841E1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 12:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732544AbfHHMrc (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 08:47:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39851 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbfHHMrc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 08:47:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so44022635pgi.6
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 05:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LoYFl7Zvph5/otjwK+0krCeU2ed6IOEmpExPG6ZBvQQ=;
        b=UC5MGlXVGglcCouark7r/hLOEoAUvGVCcQWET3fXj17EAdIXNxxixIMdRWkZWQR8p5
         nIgxbUYxT0/9zOMzz+P5Bug7n3urbAnPlvcGS3WtGnIUiwrPwXr9y5BWQWD7owSRlADT
         eAE3YRzaP1YY7lDtIyEhuNyYoqnZ3KOAvf/E3oUYPr+/oPwpWo+swD6h/JNWSl3R6Pnx
         h1QL9AuzuxBb9MW6OJhs07CvgPvGzqygSxRbA/MReEdHxgLetDr1TyJr/h3gnzThiC13
         IvX2GPue7IxYGvSm7EbdlKAIe2sZiExOFB5PcHy8yiG2XBGmoX+E8eTKyaYE575xAgNH
         PbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LoYFl7Zvph5/otjwK+0krCeU2ed6IOEmpExPG6ZBvQQ=;
        b=qmMGYlzvxJcqXIIZXacw88h5jOBqgAkohjMWX2cv5H1gOzF8lz2tbwzZmnFH3HAzXl
         KzLFgTpI2yLyCyrqJgLYc55HXmiVSstmJJnG1EBkg3OuvbEjofu7r5MgccgCYVeiPVy6
         nKwY5Td5kVdnGV2zfDJ1fMtlbee4yNBBxZphTOToMayJEWsval2/x6a0Kp+JZJatrQaU
         FFwW1xMzcXPwZn2jMnbwnpFUIKaoRKhv5CahM66100z+ina1m1X8fTXZGEMBjpIFjux4
         +g75ZflAvZzmXq9Ouu3Whll3F/5rnKR74oIGJgTrAeskbHIMu+EF1ywmndtX/gKYc9Ai
         4rIQ==
X-Gm-Message-State: APjAAAVdkTPr7+4oz1Ak4vgCfuJf9+oibR1HJ0gDLs8z933JxOZh8iXq
        Pab4wNcYXv0fp39x6OncCKicfv6hZerBvcnq/DE=
X-Google-Smtp-Source: APXvYqxJHHabMGqOchvd5waHhMyh8vO0uYW7af09y5OmQ0QjIGMbQsTyQ+rraGaGfAgDEQPPJx8zQoxoicKh9YP1J0c=
X-Received: by 2002:a63:d741:: with SMTP id w1mr12257224pgi.155.1565268451510;
 Thu, 08 Aug 2019 05:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190808035935.30023-1-phil.hord@gmail.com>
In-Reply-To: <20190808035935.30023-1-phil.hord@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 8 Aug 2019 14:47:20 +0200
Message-ID: <CAN0heSptKHL8mrU9DTXT9T7HDN56a3+DAGczxkEtbGxp9sB8hg@mail.gmail.com>
Subject: Re: [PATCH 1/1] delete multiple tags in a single transaction
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 8 Aug 2019 at 06:09, Phil Hord <phil.hord@gmail.com> wrote:
> I have a repo with 24,000 tags, most of which are not useful to any
> developers. Having this many refs slows down many operations that
> would otherwise be very fast. Removing these tags when they've been
> accidentally fetched again takes about 30 minutes using delete_ref.
>
>     git tag -l feature/* | xargs git tag -d
>
> Removing the same tags using delete_refs takes less than 5 seconds.

This looks worthwhile pursuing...

> -static int delete_tag(const char *name, const char *ref,
> -                     const struct object_id *oid, const void *cb_data)
> +struct tag_args {
> +       char *oid_abbrev;
> +       char *refname;
> +};
> +
> +static int make_string_list(const char *name, const char *ref,
> +                           const struct object_id *oid, void *cb_data)
>  {
> -       if (delete_ref(NULL, ref, oid, 0))
> -               return 1;

This provides `oid` for verifying that the tag actually points at that
particular oid before deleting. As far as I can tell, `oid` is no longer
used like that in the post-image. I'm not sure it matters, since we just
looked it up, but that might be worth mentioning, perhaps.

> -       printf(_("Deleted tag '%s' (was %s)\n"), name,
> -              find_unique_abbrev(oid, DEFAULT_ABBREV));
> +       struct string_list *ref_list = cb_data;
> +       struct tag_args *info = xmalloc(sizeof(struct tag_args));
> +
> +       string_list_append(ref_list, ref);
> +
> +       info->oid_abbrev = xstrdup(find_unique_abbrev(oid, DEFAULT_ABBREV));
> +       info->refname = xstrdup(name);
> +       ref_list->items[ref_list->nr - 1].util = info;
>         return 0;
>  }
>
> +static int delete_tags(const char **argv)
> +{
> +       int result;
> +       struct string_list ref_list = STRING_LIST_INIT_DUP;
> +       struct string_list_item *ref_list_item;
> +
> +       result = for_each_tag_name(argv, make_string_list, (void *) &ref_list);

If any tag is non-existing (or some other error happens here), we don't
continue to the actual deleting. That breaks t7004 which has a test for
removing an existing and a non-existing tag -- it wants the existing one
to be removed and the non-existing one not to interfere.

> +       if (!result)
> +               result = delete_refs(NULL, &ref_list, REF_NO_DEREF);

So this should perhaps be something more like an unconditional

        result |= delete_refs(...);

That makes the test suite happy, but perhaps only short-term ... See
below...

> +       for_each_string_list_item(ref_list_item, &ref_list) {
> +               struct tag_args * info = ref_list_item->util;
> +               if (!result)
> +                       printf(_("Deleted tag '%s' (was %s)\n"), info->refname,
> +                               info->oid_abbrev);

Change this conditional here, too, methinks. You'd need to separate
errors from looking up tags from errors about deleting refs, so having a
single "result" is probably not sufficient.

Probably worth inspecting the output of that `git tag -d` a bit in
t7004, to make sure we just claim to delete one tag, and have errors.

Your patch reshuffles the error and success messages (for certain
usages). I think that's ok, but might be worth mentioning.

I'm not too familiar with the refs API, so take this with a grain of
salt...

> +               free(info->oid_abbrev);
> +               free(info->refname);
> +               free(info);
> +       }
> +       string_list_clear(&ref_list, 0);
> +       return result;
> +}

Martin
