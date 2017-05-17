Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D50C3201CF
	for <e@80x24.org>; Wed, 17 May 2017 07:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753437AbdEQHcw (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 03:32:52 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:34533 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753151AbdEQHcu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 03:32:50 -0400
Received: by mail-io0-f174.google.com with SMTP id k91so4194415ioi.1
        for <git@vger.kernel.org>; Wed, 17 May 2017 00:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CseNFZvBEtjw+8gAYqWo0eKF7h0RnFe8J3pyQR8wS3k=;
        b=rJo1L5osjMP0W/2uaCN8K6JhPNf5ttypGr4mU7yeeFuC3f0jFyc/HpyeBShGafaHqw
         B4ixIyrE6JyNjrZaggA4TZ7p4RRf67knFp6q2ZfXiHzYaTg6BM09PxFKSW51ydFXe+0c
         2+C9PA/syjsau0mldjbTsVF6Bo4l6X1nseAEK5D/6nHGUBMbU67ZgbMBgkf76wRZeCsh
         vi4jMX5EF/KWnorhZJG92tBILydPFp4admbgxr8UMtf2P7X2XGXGlymHw0mmhbC3u6+B
         qst48/4aIrebfJooMdyHU0JxYrSnkEuEapdTc7E2tsuFWDB7COLQm6yQv1vIxQisdOE0
         6h3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CseNFZvBEtjw+8gAYqWo0eKF7h0RnFe8J3pyQR8wS3k=;
        b=jKeW67MvoSUjP5VEPbYC6iYXlXzB4dkTJuWYYuQD4T1kd5JJG64I7DmyozFtMQbB4D
         a2XIpWNBhRyfI6QgdWWqrAAtBxy96XrhHYvnrGasTOl823n4eNDKTnkSxH1xi/oI5qjJ
         YQEd4BG1JboclLUdHM8wlqRBS1g+UcvmHQrwXNp/nTBafa8S4YJj3/38SZj6JYFnxeYB
         CXlOEdY6Y3p5Amxrfb2GeObFhA29roGeG3ff8FY5ZwUF4rvDV/H+vLebnWrd3Pf/rpyH
         xWIUhM1b1ujF+R5O/1x2romXaEsfiIem3l23qJ19J/5/x/tGKjR2jKRJLCFMLStEpgA+
         lAog==
X-Gm-Message-State: AODbwcBJVdDuyTKzcR51ROdBcZLrn2CpibUlAX3DLj8vxEqczBuV/7TH
        fYnd6gPEpNwKcQCHV4msA86z3WsZHVPA8Dc=
X-Received: by 10.107.195.70 with SMTP id t67mr2100092iof.17.1495006369731;
 Wed, 17 May 2017 00:32:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Wed, 17 May 2017 00:32:09 -0700 (PDT)
In-Reply-To: <xmqqo9usvv1m.fsf@gitster.mtv.corp.google.com>
References: <20170516073423.25762-1-sxlijin@gmail.com> <20170505104611.17845-1-sxlijin@gmail.com>
 <20170516073423.25762-5-sxlijin@gmail.com> <xmqqo9usvv1m.fsf@gitster.mtv.corp.google.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Wed, 17 May 2017 03:32:09 -0400
Message-ID: <CAJZjrdXVzYZ_77Eod6oq-CB+tn5wdF4B3nWzN5zQvjduL9Lnfw@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] dir: hide untracked contents of untracked dirs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 2:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Samuel Lijin <sxlijin@gmail.com> writes:
>
>> When we taught read_directory_recursive() to recurse into untracked
>> directories in search of ignored files given DIR_SHOW_IGNORED_TOO, that
>> had the side effect of teaching it to collect the untracked contents of
>> untracked directories. It doesn't always make sense to return these,
>> though (we do need them for `clean -d`), so we introduce a flag
>> (DIR_KEEP_UNTRACKED_CONTENTS) to control whether or not read_directory()
>> strips dir->entries of the untracked contents of untracked dirs.
>>
>> We also introduce check_contains() to check if one dir_entry corresponds
>> to a path which contains the path corresponding to another dir_entry.
>>
>> Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
>> ---
>>  dir.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  dir.h |  3 ++-
>>  2 files changed, 56 insertions(+), 1 deletion(-)
>>
>> diff --git a/dir.c b/dir.c
>> index 6bd0350e9..214a148ee 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -1852,6 +1852,14 @@ static int cmp_name(const void *p1, const void *p2)
>>       return name_compare(e1->name, e1->len, e2->name, e2->len);
>>  }
>>
>> +/* check if *out lexically contains *in */
>> +static int check_contains(const struct dir_entry *out, const struct dir_entry *in)
>> +{
>> +     return (out->len < in->len) &&
>> +                     (out->name[out->len - 1] == '/') &&
>> +                     !memcmp(out->name, in->name, out->len);
>> +}
>
> OK, treat_one_path() and treat_pah_fast() both ensure that a path to
> a directory is terminated with '/' before calling dir_add_name() and
> dir_add_ignored(), so we know a dir_entry "out" that is a directory
> must end with '/'.  Good.
>
> The second and third line being overly indented is a bit
> distracting, though.
>
>>  static int treat_leading_path(struct dir_struct *dir,
>>                             const char *path, int len,
>>                             const struct pathspec *pathspec)
>> @@ -2067,6 +2075,52 @@ int read_directory(struct dir_struct *dir, const char *path,
>>               read_directory_recursive(dir, path, len, untracked, 0, pathspec);
>>       QSORT(dir->entries, dir->nr, cmp_name);
>>       QSORT(dir->ignored, dir->ignored_nr, cmp_name);
>> +
>> +     // if DIR_SHOW_IGNORED_TOO, read_directory_recursive() will also pick
>> +     // up untracked contents of untracked dirs; by default we discard these,
>> +     // but given DIR_KEEP_UNTRACKED_CONTENTS we do not
>
>         /*
>          * Our multi-line comments are formatted like this
>          * example.  No C++/C99 // comments, outside of
>          * borrowed code and platform specific compat/ code,
>          * please.
>          */

Gahhhh, I keep forgetting about this, sorry. (There has to be a way to
tell my compiler to catch this, right? It's pretty embarrassing to get
called out for this twice...)

>> +     if ((dir->flags & DIR_SHOW_IGNORED_TOO)
>> +                  && !(dir->flags & DIR_KEEP_UNTRACKED_CONTENTS)) {
>
> Both having && at the end and && at the beginning are valid C, but
> please stick to one style in a single file.

Got it.

>> +             int i, j, nr_removed = 0;
>> +
>> +             // remove from dir->entries untracked contents of untracked dirs
>
>         /* And our single-liner comments look like this */
>
>> +             for (i = 0; i < dir->nr; i++) {
>> +                     if (!dir->entries[i])
>> +                             continue;
>> +
>> +                     for (j = i + 1; j < dir->nr; j++) {
>> +                             if (!dir->entries[j])
>> +                                     continue;
>> +                             if (check_contains(dir->entries[i], dir->entries[j])) {
>> +                                     nr_removed++;
>> +                                     free(dir->entries[j]);
>> +                                     dir->entries[j] = NULL;
>> +                             }
>> +                             else {
>> +                                     break;
>> +                             }
>> +                     }
>> +             }
>
> This loop is O(n^2).  I wonder if we can do better, especially we
> know dir->entries[] is sorted already.

Now that I think about it, dropping an `i = j - 1` into the inner loop
right before the break should work:

+                             else {
+                                     i = j - 1;
+                                     break;
+                             }

> Well, because it is sorted, if A/, A/B, and A/B/C are all untracked,
> the first round that scans for A/ will nuke both A/B and A/B/C, so
> we won't have to scan looking for entries inside A/B, which is a bit
> of consolation ;-)
>
>> +                     for (i = 0;;) {
>> +                             while (i < dir->nr && dir->entries[i])
>> +                                     i++;
>> +                             if (i == dir->nr)
>> +                                     break;
>> +                             j = i;
>> +                             while (j < dir->nr && !dir->entries[j])
>> +                                     j++;
>> +                             if (j == dir->nr)
>> +                                     break;
>> +                             dir->entries[i] = dir->entries[j];
>> +                             dir->entries[j] = NULL;
>> +                     }
>> +                     dir->nr -= nr_removed;
>
> This looks like an overly complicated way to scan an array and skip
> NULLs.  Are you doing an equivalent of this loop, or am I missing
> something subtle?
>
>         for (src = dst = 0; src < nr; src++)
>                 if (array[src])
>                         array[dst++] = src;
>         nr = dst;

Nope, that's pretty much it. Just me overthinking the problem.
