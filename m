Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E20A91FA14
	for <e@80x24.org>; Sun, 16 Apr 2017 04:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbdDPE0C (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 00:26:02 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33149 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbdDPE0B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 00:26:01 -0400
Received: by mail-oi0-f67.google.com with SMTP id t63so23048036oih.0
        for <git@vger.kernel.org>; Sat, 15 Apr 2017 21:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wYVvMDGoFuH8tQGZ+Xv5/vJ/dT/aiLPz6hce2jbaGUI=;
        b=eUSigMcfh/AU6yy6yCrPkHIRGvrbwF8eD6SdZlpNaXd7jOH4mBe6GQbZC1cFQFRo2D
         cGX8jPA47cgxkltrzNAhe/9GOihWrTd519lUGVHp2JFfxu5GUgXBd5zKNWhXkTjmo9GY
         avLzHK8yggdePS6Fl379bnkpKkOFiLvq8mpK1glKei7NKBkzyCzxDr4AYh4FdabrX42L
         lAw+7LfppyerOFm2u/rrgTE4yNe0HlgCr6pKVKcnYie7NpNch7lOynQw8DYpRsWK82Ah
         f2FIcF4t9CWDGuwTtaV1o95gEQp3NJgJhXlue2NXS4s1pFjMo1oCX7b3WOIyuA5/Y57f
         8jIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wYVvMDGoFuH8tQGZ+Xv5/vJ/dT/aiLPz6hce2jbaGUI=;
        b=W/X37UHf0/j1z8ErvrBY8ZUlU2KHO1oV2B48fJJrzDS402NAa/ADIB9lloD4fuFVKw
         oH4N0mPiqEGASLmScA+pARJ9TW6f8LcU2XMtSujzaV/+0hsCPb+kbezd0zoM+Ag/Jfb0
         bWV8bhnJmnwVnpne0UOWeMq6wzwe+pH5jKOyAjNgRTNjYJZTaJwE+kKgABqipgLVT8uY
         bqt6cBPeqA874w+MZBzOO5LrIegmZemjhzaeboTnAvs8izslhKeRcpVtJBl8ug4odGGH
         GlMtzjvhC1/Lt3sowZyolRTPefWMgXMD5BrVZO/gjipDHgJlD/2e9JvX+k/Kz5DfDsay
         weNQ==
X-Gm-Message-State: AN3rC/4Ta4G0PLrvMnQ7xDchhC/UkT8anUpl5oW5xExTWdlBJlSlf2rh
        yo5Z+9ih0kbBwFxJRcA5qfqD0RgVKA==
X-Received: by 10.202.224.6 with SMTP id x6mr2024100oig.186.1492316760415;
 Sat, 15 Apr 2017 21:26:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Sat, 15 Apr 2017 21:25:30 -0700 (PDT)
In-Reply-To: <SN2PR03MB2333B9A0A7A3888F0402594DB7030@SN2PR03MB2333.namprd03.prod.outlook.com>
References: <20170407192357.948-1-kewillf@microsoft.com> <20170407192357.948-4-kewillf@microsoft.com>
 <20170410102429.GB19325@ash> <SN2PR03MB2333BCFD2E1A6A400706F94CB7000@SN2PR03MB2333.namprd03.prod.outlook.com>
 <CACsJy8Dw8qfS6G71y3FoT9w7H=FABMx=5R=v8JcPCEHtv1vLcw@mail.gmail.com> <SN2PR03MB2333B9A0A7A3888F0402594DB7030@SN2PR03MB2333.namprd03.prod.outlook.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 16 Apr 2017 11:25:30 +0700
Message-ID: <CACsJy8CbxGPeWHgR8s-ix_wxPODvisw6eaLnEUV4LDmoeXt5BQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] reset.c: update files when using sparse to avoid data loss.
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     Kevin Willford <kcwillford@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2017 at 10:37 PM, Kevin Willford <kewillf@microsoft.com> wrote:
>
>> -----Original Message-----
>> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
>> Behalf Of Duy Nguyen
>> Sent: Wednesday, April 12, 2017 7:21 AM
>> To: Kevin Willford <kewillf@microsoft.com>
>> Cc: Kevin Willford <kcwillford@gmail.com>; git@vger.kernel.org;
>> gitster@pobox.com; peff@peff.net
>> Subject: Re: [PATCH 3/3] reset.c: update files when using sparse to avoid
>> data loss.
>>
>> On Wed, Apr 12, 2017 at 5:30 AM, Kevin Willford <kewillf@microsoft.com>
>> wrote:
>> > The loss of the skip-worktree bits is part of the problem if you are
>> > talking about modified files.  The other issue that I was having is
>> > when running a reset and there were files added in the commit that is
>> > being reset, there will not be an entry in the index and not a file on
>> > disk so the data for that file is completely lost at that point.
>> > "status" also doesn't include anything about this loss of data.  On
>> > modified files status will at least have the file as deleted since
>> > there is still an index entry but again the previous version of the file and it's
>> data is lost.
>>
>> Well, we could have "deleted" index entries, those marked with
>> CE_REMOVE. They are never written down to file though, so 'status'
>> won't benefit from that. Hopefully we can restore the file before the index
>> file is written down and we really lose skip-worktree bits?
>
> Because this is a reset --mixed it will never run through unpack_trees and
> The entries are never marked with CE_REMOVE.

I know. But in my view, it should. All updates from a tree object to
the index should happen through unpack_trees().

>> > To me this is totally unexpected behavior, for example if I am on a
>> > commit where there are only files that where added and run a reset
>> > HEAD~1 and then a status, it will show a clean working directory.
>> > Regardless of skip-worktree bits the user needs to have the data in
>> > the working directory after the reset or data is lost which is always bad.
>>
>> I agree we no longer have a place to save the skip-worktree bit, we have to
>> restore the state back as if skip-worktree bit does not exist.
>> It would be good if we could keep the logic in unpack_trees() though.
>> For example, if the file is present on disk even if skip-worktree bit is on,
>> unpack_trees() would abort instead of silently overwriting it.
>> This is a difference between skip-worktree and assume-unchanged bits.
>> If you do explicit checkout_entry() you might have to add more checks to
>> keep behavior consistent.
>> --
>> Duy
>
> Because this is a reset --mixed it will follow the code path calling read_from_tree
> and ends up calling update_index_from_diff in the format_callback of the diff,
> so unpack_trees() is never called in the --mixed case.  This code change also only applies
> when the file does not exist and the skip-worktree bit is on and the updated
> index entry either will be missing (covers the added scenario) or was not missing
> before (covers the modified scenario).  If there is a better way to get the previous
> index entry to disk than what I am doing, I am happy to implement it correctly.

I think it's ok to just look at the diff (from update_index_from_diff)
and restore the on-disk version for now. I'd like to make --mixed use
unpack_trees() too but I haven't studied  this code long enough to see
why it went with "diff" instead of "read-tree" (which translates
directly to unpack_trees). Maybe there is some subtle reason for that.
Though it looks like it was more convenient to do "diff" in the
git-reset.sh version, and that got translated literally to C when the
command was rewritten.
-- 
Duy
