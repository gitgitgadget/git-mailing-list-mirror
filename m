Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F75D20248
	for <e@80x24.org>; Sun,  7 Apr 2019 18:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfDGSjD (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 14:39:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36914 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfDGSjD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 14:39:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so13724058wrm.4
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 11:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ir+fNBE/xpvVtSs9LXfzk3X54go0FBXrqsVOYN9rDz0=;
        b=aV3mFwdmpgSRbUyhckCluZ3R3knU3N2BnyRURB0pMhRlcGcUNk9XRQAWdMHao/OV2Q
         JV77FW8ewCMwDGQkd6NzYMnaOqN8HnGahbTi3Mp3457HRXLCs6iI76uqMDWP7bB0zCSC
         mKaLDxw+p9AVss74bkQm67KGP2HmyRaSGCZXp1C6NHLA4+ufHISais42TM7kDHGJ9gBA
         H3VKPlsYvgNeS9a/1xsc7eGxCXClsky0MwAi3bR9s9/gb/98fAbTAWGynQrLPNmrHgUc
         SrhdrvFkhzJgy0NEtb5PKndf/JJOCy4ydcGks/RsKHpzUicrBombMK4JE+ce9tZmn5XD
         Vybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ir+fNBE/xpvVtSs9LXfzk3X54go0FBXrqsVOYN9rDz0=;
        b=X7yFs0cYJnVCFsPqR/5TI/gDwQHTsMA17XA1JhYvmBy1WEbfv3x1L5rNAQkhl9m6qr
         RufKJ7lfDuuiKakIMVbAuZdBX8CjMzVQaRenmkvg3nZA6XnHRg2trHUOY/mJ/OYoKYBe
         IGHWVjbqWWf3UNy//+OzRaD2lw/tMsVpDws8zTxoirI1S6Kh6/6dMX/q0MzNZ3HVbAX/
         2AlEW5JDN2BbaEbebrCmjoxpsFse5q18OBj61aPlYq14WOtTdq2zxjZPpBJX77yt8C1l
         5u8Esqj2vTSZP0cxcMQg7z8TxRqL/RtV8ji7MLbuq89xUcirrPTmpci5uWAEqM/cM5H1
         YR6g==
X-Gm-Message-State: APjAAAU5YD1KXt3cJqYqr8nBgg+wAWAFV4NGYWlXMswSLO7loNr6Y8KK
        hi4F0tWkdaXSnIV/NkICyWw=
X-Google-Smtp-Source: APXvYqzx+GluM1vso92wOCOFPhu/86VQizj71ofQDyJW2lqV0uWAfIgnxOxdO7dmwhnmbqrlMMH4Kg==
X-Received: by 2002:a5d:4751:: with SMTP id o17mr15828426wrs.121.1554662340772;
        Sun, 07 Apr 2019 11:39:00 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id s21sm8974852wmh.22.2019.04.07.11.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 11:38:58 -0700 (PDT)
Date:   Sun, 7 Apr 2019 19:38:57 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GSoC][RFC] discussion about stashing with conflicts
Message-ID: <20190407183857.GA32487@hank.intra.tgummerer.com>
References: <CAMknYEN1x5zDPn4vaZmw3ch-Oy2=NQ=cfF9YmXumcbZGWvTToQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMknYEN1x5zDPn4vaZmw3ch-Oy2=NQ=cfF9YmXumcbZGWvTToQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/07, Kapil Jain wrote:
> below is my understanding from reading the parts of code as suggested on IRC.
> 
> what is the use of ce_stage macro ?
> tells about stage of an index entry.
> if ce_stage says, stage #0 i.e staging area, then that index entry is
> in staging area
> and nothing needs to be done.

I don't quite understand what you mean with "nothing needst to be
done" here.  In the context of teaching 'git stash' to handle unmerged
index entries, nothing that is not already being done needs to be done
with an index entry that is at stage #0.  The current implementation
already handles that correctly.

> else a temporary index entry is created and repo_read_index_unmerged()
> calls other function and tries to add it to index.
> if it fails, it issues an error.

Not sure what you mean here.  Index entries with higher stages are not
temporary, they are written out to the index file, and can then be
read back with 'repo_read_index()' for example.

repo_read_index_unmerged() drops entries to stage #0, and marks them
as CE_CONFLICTED, which callers can then use to distinguish index
entries that are conflicted and those that are not.

In the context of the GSoC project, this function is probably not
useful, because we need to separate out entries of different stages,
so we can create commits of those entries, as described in the thread
that's also linked from the project page [*1*].  Once
repo_read_index_unmerged() is called, we no longer know which entry is
at which stage (they are all at stage 0).

*1*: https://public-inbox.org/git/nycvar.QRO.7.76.6.1902072023250.41@tvgsbejvaqbjf.bet/

> is this correct interpretation ?
> 
> 1) in repo_read_index_unmerged(), why don't we make the value of
> `unmerged` 0, if adding index entry is successful; as the entry is no
> longer unmerged ?

Because the caller often wants to know if the index is unmerged in the
first place, and would refuse to operate on such an index.  Read the
comment documenting the function again, that explains this very
nicely.  Then see how some callers actually use the function, and
you'll see that they actually don't care about dropping the entry to
stage 0, but they care about knowing whether the index is unmerged or
not.

> 2) what is ADD_CACHE_SKIP_DFCHECK ?
> i am unsure if i get its meaning, cache.h says that it means "Ok to
> skip DF conflict checks"
> what are DF conflict checks ? something about diffing to check for
> conflicts ? if so why are we skipping it this entry had conflicts in
> the past maybe it will create again.

A DF conflict is a directory/file conflict, where one side of the
merge has created a file that has the same name as a directory created
on the other side of the merge.  From a bit of digging around in
git.git, t/t1000-read-tree-m-3way.sh seems to have some good
explanation on the various types of conflicts, not sure if it's
documented somewhere in Documentation/ in detail as well.

In this function we just care about creating an index that doesn't
contain any conflicts, so we are skipping the checks here.

> 3) what is cache_nr variable in index_state struct ? what is its use ?

If you look for cache_nr in the codebase you'll see that it's often
used when iterating through the whole index.  That could give you a
hint what it is.  Alternatively you could go have a look where it is
assigned, and what it is assigned to.  Looking through read-cache.c I
can find this line [*2*].  hdr_entries is in 'struct cache_header',
which is the header of the index file (cache is another name for the
index that's used in the codebase).

Now if you look at Documentation/technical/index-format.txt, you can
see that it's the number of entries that are in the index.

*2*: https://github.com/gitster/git/blob/041f5ea1cf987a4068ef5f39ba0a09be85952064/read-cache.c#L2163

> Now, about add_index_entry_with_check(), i don't fully understand this
> function but concentrating on the part pointed by dscho.
> https://github.com/git/git/blob/v2.21.0/read-cache.c#L1284-L1294
> 
>     /*
>      * Inserting a merged entry ("stage 0") into the index
>      * will always replace all non-merged entries..
>      */
> 
> so this is the part we need to play with for the project
> https://git.github.io/SoC-2019-Ideas/#teach-git-stash-to-handle-unmerged-index-entries
> try and change this in some-way to not replace those unmerged entries
> or store them some place else ?

It would be useful to repeat what the context is in which Dscho gave
you this code to read.  Looking back at the IRC logs, I can see:

    11:55:15 dscho | Also, here is some code that is helpful to understand
    what happens when unmerged entries are collapsed into a merged entry:
    https://github.com/git/git/blob/v2.21.0/read-cache.c#L1284-L1294

And the whole conversation was about trying to understand index
entries better, which is a fundamental part of the project, rather
than code that needs to be changed for the project itself.  Most
likely you will not change any functions in read-cache.c, but you'll
need an understanding of how they do things.

So the question is, did you read this function in depth and understand
what it does?  If you want to validate your understanding of the
function, try to repeat what it does in your own words, and ask for us
to correct you.
