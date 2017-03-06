Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F2CC202D7
	for <e@80x24.org>; Mon,  6 Mar 2017 01:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbdCFBX0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Mar 2017 20:23:26 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:36452 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752398AbdCFBXY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2017 20:23:24 -0500
Received: by mail-it0-f43.google.com with SMTP id h10so40887440ith.1
        for <git@vger.kernel.org>; Sun, 05 Mar 2017 17:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=s6Kq8b7nuwLGxlp3ahKM3xNc+rjb+XP2G8IYK2YxyCQ=;
        b=WMmKugEm0USKxz0GFsyLXh6Zy4Sk2n19N7li31QjshRbJZRNnuIuNF1KeqqZemBfuT
         ncsx/8CoYKnxcnRUenPnIDN7WMm/aj9WuC30ozoaKgDhL3421Yp6LsyBGazLi9lsX2X4
         vWyQyReJ8d3nSMawngHAXEg1ZAjjnl1c2ZBfvP6UPgs3ChI11/aUaqB9IG37mrQ36AUj
         RQvY6c2Yl8l0YCogB+YOAS/z1i3b4axEh60T5pjApbmT57VJV2xFlP2dVVNDinMkwEJo
         CtRGbu9pv54evydJLosBzwMVGIClcC7x6tkBFqHhMYOrE7qdpA/pd4Xmkefz4m61VaTB
         I8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=s6Kq8b7nuwLGxlp3ahKM3xNc+rjb+XP2G8IYK2YxyCQ=;
        b=m8phLwQCa+mXWlzEgczYU2a/R6gXCwEn+R1UezsUQyZSdd3HG/gT3OvN98ctvVUZep
         YlMer1hilASkccgqVFW+zLHTI5OVlAfMK1TsKZWemAoPrjRSSkeQj3feWJLKqVTHDfSS
         Zh+Dz/E7zPBPDIFSz1r9vIwAFUd1LhEvTb/3Zi0HW3LCRu0n5Ejof4IBfUPhvswOh9jD
         HfXJQ5+DPUeMT4j6XkKu7FaaYO5YpHaQoL6nDLYkxUE3Mbafp5rJFrn/SanFx9tQdokr
         0V5PQcBHFJBGccKwKTkczMkLgz6XKvjiJOrOf6SqY2unMLw3jEvYzRMt4Diqxqad/NuO
         H1ow==
X-Gm-Message-State: AMke39ncxKc+Nsegv15UTSOhDDBCGgLia/3F6txe+TkH3cCdNvUTM+RdQBZia4LRTxuQEjzSjE3UKmV6Zmu0eA==
X-Received: by 10.36.204.137 with SMTP id x131mr12494179itf.35.1488762854952;
 Sun, 05 Mar 2017 17:14:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Sun, 5 Mar 2017 17:14:14 -0800 (PST)
In-Reply-To: <9961a973-0d5d-5ff9-ab78-eea07bdb5dbf@gmail.com>
References: <4d2a1852-8c84-2869-78ad-3c863f6dcaf7@gmail.com>
 <CA+55aFzQ0o2R2kShS=AuKu0TLnfPV-0JCkViqx5J_afCK0Yt5g@mail.gmail.com>
 <eba83461-34cf-6d64-4013-873b04af9b82@gmail.com> <CA+55aFx7QFqrHw4e72vOdM5z0rw1CCkL2-UX8ej5CLSBWjLNLA@mail.gmail.com>
 <603afdf2-159c-6bed-0e85-2824391185d1@gmail.com> <CA+55aFxxQUixAJWXkUgVvDNCHD4LuYYuQRTE7dJ_OZTo9Gxqew@mail.gmail.com>
 <9961a973-0d5d-5ff9-ab78-eea07bdb5dbf@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Mar 2017 17:14:14 -0800
X-Google-Sender-Auth: Ud5bAtgQB-mN0vWuCl6-mrh1TTw
Message-ID: <CA+55aFw=U4PbfvVzeyuWk2VOsgicZRRKZRkrGp7jr_ppvgP3ng@mail.gmail.com>
Subject: Re: Delta compression not so effective
To:     Marius Storm-Olsen <mstormo@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 4, 2017 at 12:27 AM, Marius Storm-Olsen <mstormo@gmail.com> wrote:
>
> I reran the repack with the options above (dropping the zlib=9, as you
> suggested)
>
>     $ time git -c pack.threads=4 repack -a -d -F \
>                --window=350 --depth=250 --window-memory=30g
>
> and ended up with
>     $ du -sh .
>     205G        .
>
> In other words, going from 6G to 30G window didn't help a lick on finding
> deltas for those binaries.

Ok.

> I did
>     fprintf(stderr, "%s %u %lu\n",
>             sha1_to_hex(delta_list[i]->idx.sha1),
>             delta_list[i]->hash,
>             delta_list[i]->size);
>
> I assume that's correct?

Looks good.

> I've removed all commit messages, and "sanitized" some filepaths etc, so
> name hashes won't match what's reported, but that should be fine. (the
> object_entry->hash seems to be just a trivial uint32 hash for sorting
> anyways)

Yes. I see your name list and your pack-file index.

> BUT, if I look at the last 3 entries of the sorted git verify-pack output,
> and look for them in the 'git log --oneline --raw -R --abbrev=40' output, I
> get:
...
> while I cannot find ANY of them in the delta_list output?? \

Yes. You have a lot of of object names in that log file you sent in
private that aren't in the delta list.

Now, objects smaller than 50 bytes we don't ever try to even delta. I
can't see the object sizes when they don't show up in the delta list,
but looking at some of those filenames I'd expect them to not fall in
that category.

I guess you could do the printout a bit earlier (on the
"to_pack.objects[]" array - to_pack.nr_objects is the count there).
That should show all of them. But the small objects shouldn't matter.

But if you have a file like

   extern/win/FlammableV3/x64/lib/FlameProxyLibD.lib

I would have assumed that it has a size that is > 50. Unless those
"extern" things are placeholders?

> You might get an idea for how to easily create a repo which reproduces the
> issue, and which would highlight it more easily for the ML.

Looking at your sorted object list ready for packing, it doesn't look
horrible. When sorting for size, it still shows a lot of those large
files with the same name hash, so they sorted together in that form
too.

I do wonder if your dll data just simply is absolutely horrible for
xdelta. We've also limited the delta finding a bit, simply because it
had some O(m*n) behavior that gets very expensive on some patterns.
Maybe your blobs trigger some of those case.

The diff-delta work all goes back to 2005 and 2006, so it's a long time ago.

What I'd ask you to do is try to find if you could make a reposity of
just one of the bigger DLL's with its history, particularly if you can
find some that you don't think is _that_ sensitive.

Looking at it, for example, I see that you have that file

   extern/redhat-5/FlammableV3/x64/plugins/libFlameCUDA-3.0.703.so

that seems to have changed several times, and is a largish blob. Could
you try creating a repository with git fast-import that *only*
contains that file (or pick another one), and see if that delta's
well?

And if you find some case that doesn't xdelta well, and that you feel
you could make available outside, we could have a test-case...

                 Linus
