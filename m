Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 533561F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 12:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbeKLWfc (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 17:35:32 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:40871 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbeKLWfc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 17:35:32 -0500
Received: by mail-wr1-f53.google.com with SMTP id p4so4692wrt.7
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 04:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=btdHL+kz44h2Og70U6SPDjxVCY7+rnqlO+ZaHiv29/Y=;
        b=BqSqtnjcTMovzaYBfUF8CKMbxUQmjY7WkEb+zxt/42qDPr5g8AL9Svel4/LvhUIaId
         NR7wcgY7L5h8scG6rzG7T51ElkUKcjx1glGxIm9PJs0EhLRVq8DPaSEGoSXyH1K+k5Kz
         qfMhC1m9LjyI+VmOtm4UaD8z+lNdlwU8ZOvuJE7ssnG46sqHvoNZ61aNV/vhsxMJM2Pt
         V/QmEJu9M4y4NcHZ9CnRXvpG5cB9np5mzxHPb/ZpZC3B89KuhR9Md1kZ8qOZiU7SnWN0
         QODUTtrG00x9sGaYjUIYWiusxGzorcGZciNCcnAen7EzzH27fAMJRNgyRPj7D72GQ/rQ
         lqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=btdHL+kz44h2Og70U6SPDjxVCY7+rnqlO+ZaHiv29/Y=;
        b=tZuSefioBYDfldex20rEbc1K8bmLBAqSI+HTx2GIz+BGzcWysGs+YmqK99tD1qHCKD
         Nsbi3U9kZx9ZF8avSzi/POQLtpvk2aXQaiQ9JvySJc0Sw9FYUdvDvmitDfDfUX4oPUD1
         c16A6SWF7BB9pSelknkBnXO+GmL4ShteBnCbl3TSOx3Ec2emxAyd2cEY1fTXmbjfyOtb
         ZLbOFgEGVbBBeCq8cVy560BhuhiAKg3nHnCq2ZPU4TVvIPQXRHJDrUQwAr7KWJi6zk2i
         8It93SnKOzf8OuYxGJSdWNzvBMEA5MPxGJF8jYpCvvzOzKSyECxGKMqoKZaDE8kRZT4I
         9Reg==
X-Gm-Message-State: AGRZ1gJe+5cd6Mosu9odUQn6vGKBwMUuTFBKLYsrUEv9qogEEyBkvUN5
        h/NL/Vg05tSTNlre6yDPQZ4=
X-Google-Smtp-Source: AJdET5cAd+D2gRLumHM+jqT3E1Ru5LbCpccYF1bJG/7242hzouY7p0Ffwipu84HkHXV7YgIcm6S/tQ==
X-Received: by 2002:adf:ce0f:: with SMTP id p15-v6mr897695wrn.324.1542026543932;
        Mon, 12 Nov 2018 04:42:23 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id t4-v6sm14699025wrq.80.2018.11.12.04.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 04:42:22 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Mateusz Loskot <mateusz@loskot.net>, git@vger.kernel.org
Subject: Re: Migration to Git LFS inflates repository multiple times
References: <CABUeae-Bk5hxEsLuDi=MytzN-kBG0D4psLbc_1=B+=70D=JKCQ@mail.gmail.com> <20181112123058.GE3956@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181112123058.GE3956@sigill.intra.peff.net>
Date:   Mon, 12 Nov 2018 13:42:21 +0100
Message-ID: <87k1li31si.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 12 2018, Jeff King wrote:

> On Mon, Nov 12, 2018 at 12:47:42AM +0100, Mateusz Loskot wrote:
>
>> Hi,
>>
>> I'm posting here for the first time and I hope it's the right place to ask
>> questions about Git LFS.
>>
>> TL;TR: Is this normal a repository migrated to Git LFS inflates multiple times
>> and how to deal with it?
>
> That does sound odd to me. People with more LFS experience can probably
> give you a better answers, but one thought occurred to me: does LFS
> store backup copies of the original refs that it rewrites (similar to
> the way filter-branch stores refs/original)?
>
> If so, then the resulting repo has the new history _and_ the old
> history. Which might mean storing those large blobs both as Git objects
> (for the old history) and in an LFS cache directory (for the new
> history).
>
> And the right next step is probably to delete those backup refs, and
> then "git gc --prune=now". Hmm, actually thinking about it, reflogs
> could be making the old history reachable, too.
>
> Try looking at the output of "git for-each-ref" and seeing if there are
> any backup refs. After deleting them (or confirming that there aren't),
> prune the reflogs with:
>
>   git reflog expire --expire-unreachable=now --all
>
> and then "git gc --prune=now".

Even if it's only the most recent version of each file this could also
be explained by LFS storing each file inflated as-is on disk, whereas
git will store them delta-compressed.

According to the initial E-Mail "*.exe,*.dll,*.lib,*.pdb,*.zip" was
added to LFS. Depending on the content of those they might be delta
compressing somewhat better than random data.
