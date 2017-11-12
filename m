Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A9F1201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 12:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbdKLMtu (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 07:49:50 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:55763 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbdKLMtt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 07:49:49 -0500
Received: by mail-ot0-f194.google.com with SMTP id u10so4270367otc.12
        for <git@vger.kernel.org>; Sun, 12 Nov 2017 04:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8kD+uDO9UBdoLoTT6MUuswkdlOnDHyJHggNz71aETKk=;
        b=uZYf9P+p7xgLDxt1i5Ym3iztMqlw/2IRn9Q2epsPZttW0jtq4ozAK8zPhza7uK1C58
         nfnK0aslfMJdByy9r3FjQA4OnM0jM0IbzcOweK0SeDMKJcrbwcm99dgk10CQDmKP6dSm
         xfyCuoeCPDlczXIEL/PVoCSQj6M6+9qUX+vrvgwHePaQ47TyWo8hD7BY6hhRvoBvjo1z
         Si9PqcQDgFPvfOle208G53Wxg9vzXvXI+bmXH8RPJBc+1EGxbB2n9kGUKDV4d5ip7pp5
         9XCnS5vkS/j9D5QpvAVr+sYxTg+hHRommk1gpADR81nnbE+lbJMcz9VQ40XDxLOgTg4v
         QkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8kD+uDO9UBdoLoTT6MUuswkdlOnDHyJHggNz71aETKk=;
        b=dcxtft/gVqaNUjK19of1AXe46/xYs9G8XZNbMrntVXmoc5zDKBTOFBtm88oZ4pfnK1
         6lkW4vOdN1TYoi09CQfV0/2yMPEYshnh8tefv4t5z9f7yCLz0XmHm6n2x4v/YP8fdx4M
         GcuYXJ45M5Ndgl+PsIoUCuj1462W8Kb6+rQcTUQT6xgBVyWKds3fnFAV7wtEwzCoYk8a
         rXv/bd4oM20xTK1+r8RGutPGOJk3OUXH3W6+xCeeviyLLb/HNfcuWzdwsLVrKk19F5uI
         4UqnHmQ0Cd/yRIRbt6lTpCkh7Lq+f5+Ym8WVJC1O1QbY88Fn6wL4Y/JlFe47MNTVW48j
         8png==
X-Gm-Message-State: AJaThX4tUmYWW5Kz2M5POTQ1VtPWYijAiX9x6NtAa6dZS4l+ZMLWQFJV
        SiSv7PWY6hHPYmIhsTYoB9vtymmi+Ti5iRWpNJo=
X-Google-Smtp-Source: AGs4zMYcCvIP38Mwi9yZmJcnsLlzWlrKwkCgdUGpxu+2h/E+sO2+fkk/Ijrdui1B6DjasJEN0VOCk4ELqHBvpWLN3pQ=
X-Received: by 10.157.4.197 with SMTP id 63mr4243667otm.346.1510490988481;
 Sun, 12 Nov 2017 04:49:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.181.193 with HTTP; Sun, 12 Nov 2017 04:49:17 -0800 (PST)
In-Reply-To: <20171112095435.f4o662ygtt2taf5y@sigill.intra.peff.net>
References: <1510423606-9616-1-git-send-email-gs051095@gmail.com> <20171112095435.f4o662ygtt2taf5y@sigill.intra.peff.net>
From:   Gargi Sharma <gs051095@gmail.com>
Date:   Sun, 12 Nov 2017 12:49:17 +0000
Message-ID: <CAOCi2DGYQr4jFf5ObY2buyhNJeaAPQKF8tbojn2W0b18Eo+Wgw@mail.gmail.com>
Subject: Re: [PATCH] mru: Replace mru.[ch] with list.h implementation
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 12, 2017 at 9:54 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Nov 11, 2017 at 01:06:46PM -0500, Gargi Sharma wrote:
>
>> Replace custom allocation in mru.[ch] with generic calls
>> to list.h API.
>>
>> Signed-off-by: Gargi Sharma <gs051095@gmail.com>
>
> Thanks, and welcome to the git list. :)
>
> This looks like a good start on the topic, but I have a few comments.
>
> It's a good idea to explain in the commit message not just what we're
> doing, but why we want to do it, to help later readers of "git log". I
> know that you picked this up from the discussion in the thread at:
>
>   https://public-inbox.org/git/xmqq8tgz13x7.fsf@gitster.mtv.corp.google.com/
>
> so it might be a good idea to summarize the ideas there (and add your
> own thoughts, of course).
>
>> ---
>>  builtin/pack-objects.c | 14 ++++++++------
>>  cache.h                |  9 +++++----
>>  mru.c                  | 27 ---------------------------
>>  mru.h                  | 40 ----------------------------------------
>>  packfile.c             | 28 +++++++++++++++++++---------
>>  5 files changed, 32 insertions(+), 86 deletions(-)
>>  delete mode 100644 mru.c
>>  delete mode 100644 mru.h
>
> After the "---" line, you can put any information that people on the
> list might want to know but that doesn't need to go into the commit
> message. The big thing the maintainer would want to know here is that
> your patch is prepared on top of the ot/mru-on-list topic, so he knows
> where to apply it.
>
> The diffstat is certainly encouraging so far. :)
>
>> @@ -1012,9 +1012,9 @@ static int want_object_in_pack(const unsigned char *sha1,
>>                       return want;
>>       }
>>
>> -     list_for_each(pos, &packed_git_mru.list) {
>> -             struct mru *entry = list_entry(pos, struct mru, list);
>> -             struct packed_git *p = entry->item;
>> +     list_for_each(pos, &packed_git_mru) {
>> +             struct packed_git *p = list_entry(pos, struct packed_git, mru);
>> +             struct list_head *entry = &(p->mru);
>>               off_t offset;
>>
>>               if (p == *found_pack)
>
> I think "entry" here is going to be the same as "pos". That said, I
> think it's only use is in bumping us to the front of the mru list later:
>
>> @@ -1030,8 +1030,10 @@ static int want_object_in_pack(const unsigned char *sha1,
>>                               *found_pack = p;
>>                       }
>>                       want = want_found_object(exclude, p);
>> -                     if (!exclude && want > 0)
>> -                             mru_mark(&packed_git_mru, entry);
>> +                     if (!exclude && want > 0) {
>> +                             list_del(entry);
>> +                             list_add(entry, &packed_git_mru);
>> +                     }
>
> And I think this might be more obvious if we drop "entry" entirely and
> just do:
>
>   list_del(&p->mru);
>   list_add(&p->mru, &packed_git_mru);
>
> It might merit a comment like "/* bump to the front of the mru list */"
> or similar to make it clear what's going on (or even adding a
> list_move_to_front() helper).

I will add a helper to list.h, for doing this :)
>
>> @@ -1566,6 +1566,7 @@ struct pack_window {
>>
>>  extern struct packed_git {
>>       struct packed_git *next;
>> +     struct list_head mru;
>>       struct pack_window *windows;
>>       off_t pack_size;
>>       const void *index_data;
>
> Sort of a side note, but seeing these two list pointers together makes
> me wonder what we should do with the list created by the "next" pointer.
> It seems like there are three options:
>
>   1. Convert it to "struct list_head", too, for consistency.
>
>   2. Leave it as-is. We never delete from the list nor do any fancy
>      manipulation, so it doesn't benefit from the reusable code.
>
>   3. I wonder if we could drop it entirely, and just keep a single list
>      of packs, ordered by mru. I'm not sure if anybody actually cares
>      about accessing them in the "original" order. That order is
>      reverse-chronological (by prepare_packed_git()), but I think that
>      was mostly out of a sense that recent packs would be accessed more
>      than older ones (but having a real mru strategy replaces that
>      anyway).
>
> What do you think?
I think in the long run, it'll be easier if there is only a single
list of packs given
that no one needs to access the list in order.

If we go down road 1/3, would it be better if I sent an entirely
different patch or
a patch series with patch 1 as removing mru[.ch] and patch 2 as removing
next pointer from the struct?

>
>> diff --git a/mru.c b/mru.c
>> deleted file mode 100644
>> index 8f3f34c..0000000
>
> Yay, this hunk (and the one for mru.h) is satisfying.
>
>> @@ -40,7 +40,7 @@ static unsigned int pack_max_fds;
>>  static size_t peak_pack_mapped;
>>  static size_t pack_mapped;
>>  struct packed_git *packed_git;
>> -struct mru packed_git_mru = {{&packed_git_mru.list, &packed_git_mru.list}};
>> +LIST_HEAD(packed_git_mru);
>
> Much nicer.
>
>> @@ -859,9 +859,18 @@ static void prepare_packed_git_mru(void)
>>  {
>>       struct packed_git *p;
>>
>> -     mru_clear(&packed_git_mru);
>> -     for (p = packed_git; p; p = p->next)
>> -             mru_append(&packed_git_mru, p);
>> +     struct list_head *pos;
>> +     struct list_head *tmp;
>> +     list_for_each_safe(pos, tmp, &packed_git_mru)
>> +             list_del_init(pos);
>
> This matches the original code, which did the clear/re-create, resetting
> the mru to the "original" pack order. But I do wonder if that's actually
> necessary. Could we skip that and just add any new packs to the list?

But if we do not clear the older entries from the list, wouldn't there be a
problem when you access packed_git_mru->next, since that will be populated
instead of being empty? Or am I misunderstanding something here?

>
> That goes hand-in-hand with the idea of dropping the "next" pointer that
> I mentioned above.
>
>> +     INIT_LIST_HEAD(&packed_git_mru);
>
> I think this INIT_LIST_HEAD() isn't necessary anymore. In the original
> code, we just freed each of the mru_entry structs, which meant we had to
> forcibly reset the list head to be empty. But here you've used
> list_del_init(), so after deleting everything, packed_git_mru should
> already be empty.
>
>> +     for (p = packed_git; p; p = p->next) {
>> +             struct packed_git *cur = xmalloc(sizeof(*packed_git));
>> +             cur = p;
>> +             list_add_tail(&cur->mru, &packed_git_mru);
>> +     }
>
> This malloc can go away. The original mru code kept a separate entry,
> but now we don't need that. So here you're just leaking it when you
> assign "cur = p" (in fact, I think you can get rid of cur entirely).

Ah yes, I'll fix this.

>
>> @@ -1830,10 +1839,11 @@ int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
>>       if (!packed_git)
>>               return 0;
>>
>> -     list_for_each(pos, &packed_git_mru.list) {
>> -             struct mru *p = list_entry(pos, struct mru, list);
>> -             if (fill_pack_entry(sha1, e, p->item)) {
>> -                     mru_mark(&packed_git_mru, p);
>> +     list_for_each(pos, &packed_git_mru) {
>> +             struct packed_git *p = list_entry(pos, struct packed_git, mru);
>> +             if (fill_pack_entry(sha1, e, p)) {
>> +                     list_del(&p->mru);
>> +                     list_add(&p->mru, &packed_git_mru);
>>                       return 1;
>>               }
>>       }
>
> And this hunk looks pretty good (though if we added a move-to-front
> helper, it could be used here, too).

Thanks!
gargi
>
> -Peff
