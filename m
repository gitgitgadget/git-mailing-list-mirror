Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B2DA1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 23:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404870AbfHHX6r (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 19:58:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37009 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403901AbfHHX6q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 19:58:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id z28so36271480ljn.4
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 16:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8fgG6JheHa2Pq4gbVIgtIebq5I8X2/Lm6zawPvL182w=;
        b=pMDQrrltVcSmUR86CMGwnJjFWyXtsgI6EC4gliQpV/TvL4RqEa9myejzT8Sin4O7VJ
         cvVx4oUd9b3fQgNAwmSDJggRq3QIlxkIYA8Gwx4UPTikwC085C2PdbgdCN8qAuMwmlf5
         riH9vADz/s4kWnEjLXoUg+e3JdUKrbTX6AvcavrNg2NXdaBVqot7ueCGAuBzfZM/5Hyi
         lSHkih86qrTCKcihgR8uVPkEBWMLQB50UnZeFrhbRMqyqph3MY5j2+4UsaQoFaJaI1wv
         mi1L+SBbR6xy1TMJcYcuABhbHi7skU7ucHQh27bzitb92JP/b0drGu8hTA0WsY+gHhIk
         wwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8fgG6JheHa2Pq4gbVIgtIebq5I8X2/Lm6zawPvL182w=;
        b=JdOA5XobgEb5fcSkC6w7QyhOdkyHRbbcK88gu5OHLKGVjRQ00GGOTGpm6Oteca3SW6
         Aozi9SaIh2SpOl2gx80TIt++f1tv/wuO55Wdd9iyZ307yiluAA8YDsUpZcFyuQ6ppAiE
         vsONyNGdW5UJt/Ntm9xlTcYt6J5j7IiE5I4zq+ualpsDI6BxIjCN182irMkpwNFhqL8c
         TjUXWmLbsq2OtsEtEg2af4+v6ADTqTyWYQRtuYw8P187igUqg+p7qCMqBnR62vNVgPub
         mlLUPy29/WHOabLT8QSY/QoyXbMk9cb3CSs7TSLyGh9jkZ1fHxbHVnMV6Mz35HpaMrou
         35Gw==
X-Gm-Message-State: APjAAAVyQdwZ7gecXqtGsgpknbsPEy1/PRWXpoZfb2Fo0+DCbgw5GN3i
        A8XFSDe8K156vX+/ytJEPOdZIR9amqd7HvOyeeQ=
X-Google-Smtp-Source: APXvYqx2PcUiCcX/GDKQPhAvCVQJr328WNzWGR8QPMxyxuhSIOYBZi8PzXqm3jtl/NE2ndc0SNYy+7Kq4IgwQEgD8oo=
X-Received: by 2002:a2e:85da:: with SMTP id h26mr9904403ljj.48.1565308724145;
 Thu, 08 Aug 2019 16:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190808035935.30023-1-phil.hord@gmail.com> <xmqq4l2rfnvl.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4l2rfnvl.fsf@gitster-ct.c.googlers.com>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Thu, 8 Aug 2019 16:58:30 -0700
Message-ID: <CABURp0qHmuNQD4qxL8A5fCJaRsNZfZ51d3e2N3nD-x0jCMhnBw@mail.gmail.com>
Subject: Re: [PATCH 1/1] delete multiple tags in a single transaction
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 8, 2019 at 12:39 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Phil Hord <phil.hord@gmail.com> writes:
>
> > From: Phil Hord <phil.hord@gmail.com>
> >
> > 'git tag -d' accepts one or more tag refs to delete, but each deletion
> > is done by calling `delete_ref` on each argv. This is painfully slow
> > when removing from packed refs. Use delete_refs instead so all the
> > removals can be done inside a single transaction with a single write.
> >
> > I have a repo with 24,000 tags, most of which are not useful to any
> > developers. Having this many refs slows down many operations that
> > would otherwise be very fast. Removing these tags when they've been
> > accidentally fetched again takes about 30 minutes using delete_ref.
> >
> >     git tag -l feature/* | xargs git tag -d
> >
> > Removing the same tags using delete_refs takes less than 5 seconds.
>
> Makes sense.  As mentioned elsewhere in the thread already,
> a batched update-ref would open the packed-refs ony once because
> everything is done in a single transaction, so presumably a pipeline
> like this
>
>         git tag -l feature/* |
>         sed -e 's|^|delete refs/tags/|' |
>         git update-ref --stdin
>
> may work well, and "git tag -d" that gets these refs on the command
> line should be capable of doing the same.
>
> > -static int delete_tag(const char *name, const char *ref,
> > -                   const struct object_id *oid, const void *cb_data)
> > +struct tag_args {
> > +     char *oid_abbrev;
> > +     char *refname;
> > +};
> > +
> > +static int make_string_list(const char *name, const char *ref,
> > +                         const struct object_id *oid, void *cb_data)
>
> Please think about a few more minutes before naming a function like
> this, and make it a habit for your future patches.
>
> We can see that the callback is used to insert more strings into a
> string list, but the type (i.e. string_list) used to represent the
> set is not all that important.  What is more important is why you
> are building that set for, and saying what is in the set (as opposed
> to saying that the container happens to be a string_list) would be a
> good first step.
>
> I presume that you are enumerating the tags to be deleted, together
> with the data necessary for you to report the deletion of the tags?

Hm.  collect_tags?  collect_tags_to_delete?

It's true I didn't put enought thought into that.  I was experimenting
a bit here and was surprised how little code I ended up needing.

> >  {
> > -     if (delete_ref(NULL, ref, oid, 0))
> > -             return 1;
> > -     printf(_("Deleted tag '%s' (was %s)\n"), name,
> > -            find_unique_abbrev(oid, DEFAULT_ABBREV));
> > +     struct string_list *ref_list = cb_data;
> > +     struct tag_args *info = xmalloc(sizeof(struct tag_args));
> > +
> > +     string_list_append(ref_list, ref);
> > +
> > +     info->oid_abbrev = xstrdup(find_unique_abbrev(oid, DEFAULT_ABBREV));
> > +     info->refname = xstrdup(name);
> > +     ref_list->items[ref_list->nr - 1].util = info;
> >       return 0;
> >  }
> >
> > +static int delete_tags(const char **argv)
> > +{
> > +     int result;
> > +     struct string_list ref_list = STRING_LIST_INIT_DUP;
> > +     struct string_list_item *ref_list_item;
> > +
> > +     result = for_each_tag_name(argv, make_string_list, (void *) &ref_list);
> > +     if (!result)
> > +             result = delete_refs(NULL, &ref_list, REF_NO_DEREF);
> > +
> > +     for_each_string_list_item(ref_list_item, &ref_list) {
> > +             struct tag_args * info = ref_list_item->util;
> > +             if (!result)
> > +                     printf(_("Deleted tag '%s' (was %s)\n"), info->refname,
> > +                             info->oid_abbrev);
> > +             free(info->oid_abbrev);
> > +             free(info->refname);
> > +             free(info);
>
> It is not performance critical, but info->refname is computable from
> ref_list_item->string, isn't it?

Oh, I guess it is.  It's a fixed offset into the string, after all.
Thanks.  I did look for a way to avoid the struct noise. Just not
well.

> I am just wondering if we can do
> this without having to allocate the .util field for each of 20,000
> tags.  We still need to remember oid (or oid_abbrev, but if I were
> writing this, I'd record the full oid in .util and make the code
> that prints call find_unique_abbrev() on it), so I guess we cannot
> really leave .util NULL.

My original patch did this (.util = oid).  But then I needed a name.
I'll go back to keeping the oid.  Much cleaner.

>
> > +     }
> > +     string_list_clear(&ref_list, 0);
> > +     return result;
>
> We used to return the returned value from for_each_tag_name() that
> repeatedly called delete_tag().
>
> Now we return value from delete_refs().  Are our caller(s) OK with
> the values that may come back from that function?  Can delete_refs()
> return a value that is not appropriate to be returned from
> cmd_tag(), for example a negative value?

Yes it does.  Will fix.

>
> > +}
> > +
> >  static int verify_tag(const char *name, const char *ref,
> > -                   const struct object_id *oid, const void *cb_data)
> > +                   const struct object_id *oid, void *cb_data)
> >  {
> >       int flags;
> >       const struct ref_format *format = cb_data;
> > @@ -511,7 +543,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
> >       if (filter.merge_commit)
> >               die(_("--merged and --no-merged options are only allowed in list mode"));
> >       if (cmdmode == 'd')
> > -             return for_each_tag_name(argv, delete_tag, NULL);
> > +             return delete_tags(argv);
>
> Thanks.
