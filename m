Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82C851F404
	for <e@80x24.org>; Mon, 16 Apr 2018 22:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbeDPWz0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 18:55:26 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:34022 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeDPWzU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 18:55:20 -0400
Received: by mail-ua0-f171.google.com with SMTP id t4so5533609ual.1
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 15:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=44xPfZrtRm6Vh666Fzo/dLAcJ94SwGlJf4FZ+NQSsZQ=;
        b=A3RjhGoWKkuXznmwuR0BfhsCEvMZiFxEkK6ob6W3L1RsL5fEWNp5omQAXrQ2CQlxXi
         0qUSjT4nO5fZC9kc2BIYbhogx/BPiFePDkXF+vsjLYtqvBPzcpaWHWWJTSkfA6qTJoQY
         n8eGXm5HPheChBGmXilkYyFhZU/eZrKDGBn4PitKluJ+HnhCGukAX01KDB+hTfs+Ylyd
         hzGLG2Ze8vQeJLlGcqy63btXkQAry6uPZ7LNgruDJocoV46RCrDSIEXfTekkJ3owD5Gi
         41KdFz05lJw3VmfI9DnED4/dqYfsncySak2lEiW69NNtPsqxDDNTPwO0dK2ziE8Kokee
         piug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=44xPfZrtRm6Vh666Fzo/dLAcJ94SwGlJf4FZ+NQSsZQ=;
        b=U0u5/aSuIRhGV+N0YlkfRQ7D3Tq8LeIHov83j09S3c6h3bPW66L9AcRMhIG29fFfu4
         3H5vmP7mT34tQ9/uO3NQoT41eH7yyKXQe3E79jy7Oxm59KLQLGNxjajCWAmS+fbr8bC3
         O0nXcAZSbIRWRjGTgefoJ3gOdIwmaRrQk7d2fy6yRffvwdabBW/HCzVJWisdKYrt4Mk4
         rR/6vlPqXPuetcHpptBQyd6e+ShSU3W2SQAcH152g9Qi0dDZmNSzDDH7Egb6dtaXHHj9
         oS5FI6KaBVxWo+BM0GwMtgN6TzDDOQAbeFF5VgiQD2bn6hk4pQhGfiZSeXlMgUnserOt
         z5DQ==
X-Gm-Message-State: ALQs6tA3wDsfiZ7VvtDJtKfH8SI/rc89LCRKxOOr19fwBSVRi5hkp/+z
        mz8Nwbb5ic8JqKgBSNzN4oHF3a62C2AcZ8Ratdo=
X-Google-Smtp-Source: AIpwx48ZlTne11a8O/RwsQlkNrEx3cCtTOJ38rC1Vi5kZ6nn/jQoRqKm4CZH8N080hLl+fjvPQxY86mkyOGVoroqlE8=
X-Received: by 10.176.20.201 with SMTP id f9mr5514880uae.29.1523919319973;
 Mon, 16 Apr 2018 15:55:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.40.42 with HTTP; Mon, 16 Apr 2018 15:55:19 -0700 (PDT)
In-Reply-To: <CA+55aFxP8j7YbYaRXt-8Y0n8cHafB=FPKMy8gKFYH5QsKX4S=Q@mail.gmail.com>
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
 <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com> <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com>
 <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com>
 <CA+55aFwM2CaafNGq8_=GkYAw9inpm-4xcyHUmKprLv4Gb3-aVg@mail.gmail.com>
 <CA+55aFw5mpEcEpPTOWych-kjNLc8pEn8FdjJHe2u7HUBBLy-Fw@mail.gmail.com>
 <CA+55aFwwVZDetd-SobOzzLQW4_GEwm3krxEGR+cpqzkzK-yiwQ@mail.gmail.com>
 <CABPp-BHQsOSCJiPU9Ku5b67QTkAjnEBrhx04mTXf2QdPBriHmw@mail.gmail.com>
 <CA+55aFwi9pTAJT_qtv=vHLgu=B1fdXBoD96i8Y5xnbS=zrfSzg@mail.gmail.com>
 <xmqqbmekylgc.fsf@gitster-ct.c.googlers.com> <CA+55aFxP8j7YbYaRXt-8Y0n8cHafB=FPKMy8gKFYH5QsKX4S=Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 16 Apr 2018 15:55:19 -0700
Message-ID: <CABPp-BHuAUzvFcVdTUjZnmEkSfwU3qe5RXU7bf6sxu051pbzug@mail.gmail.com>
Subject: Re: Optimizing writes to unchanged files during merges?
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 15, 2018 at 7:03 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sun, Apr 15, 2018 at 6:44 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> One thing that makes me curious is what happens (and what we want to
>> happen) when such a "we already have the changes the side branch
>> tries to bring in" path has local (i.e. not yet in the index)
>> changes.  For a dirty file that trivially merges (e.g. a path we
>> modified since our histories forked, while the other side didn't do
>> anything, has local changes in the working tree), we try hard to
>> make the merge succeed while keeping the local changes, and we
>> should be able to do the same in this case, too.
>
> I think it might be nice, but probably not really worth it.
<snip>
> So I don't think it's a big deal, and I'd rather have the merge fail
> very early with "that file has seen changes in the branch you are
> merging" than add any real complexity to the merge logic.

That's actually problematic, and not yet possible with the current
merge-recursive code.  The fail-very-early code is in unpack_trees(),
and it doesn't understand renames.  By the time we get to the rest of
the logic of merge-recursive, unpack_trees() has already written
updates to lots of files throughout the tree, so bailing and leaving
the tree in a half-merged state is no longer an option.  (The logic in
merge-recursive.c is excessively complex in part due to this issue,
making it implement what amounts to a four-way merge instead of just a
three-way merge.  It's gross.)

So, if we were to use the brute-force scheme here, when renames are
involved, we'd need to have some special logic for handling dirty
files.  That logic would probably include checking the original index
for both modification times (to determine if the file is dirty), and
for comparison of contents.  In short, we'd still need all the logic
that this scheme was trying to get rid of in the first place.
