Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 158AE20288
	for <e@80x24.org>; Wed, 19 Jul 2017 23:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932203AbdGSXhW (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 19:37:22 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33618 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754096AbdGSXhV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 19:37:21 -0400
Received: by mail-pg0-f48.google.com with SMTP id k14so6630894pgr.0
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 16:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=An31F33koa1fDQkSlJ6tWkgjZ045XtNBghfbLbm9HMc=;
        b=BXC9/XGd0WDuNbHhRY3fCYdxMLOibaIx7TkcXeNqVFcE7TWomIH3U4vcrI1Hu6IabG
         MDdEBLdb/t40oeeNaoGxnzqwuthzPgIh3saQz06NrstHyjCwK5vmV8qawFajjPHKmWRM
         k/shGEqzd+yZWAPmkM4zb5otVR6KrpDxzMnj5vB6b+kNXqCPs4tzhAWzbF+Gq6lGHx4n
         p14hXYTIoJi8vkHhlgeYWLMfSvaWmjselb3AdorHybUgXqFdsoU+0kdiEMqSdO0X13H2
         gvH7jwkmt1JxJrnLeuhIOs2fIXbDK+gP2Q/ezuEmCiEl/zr65RBXz5OzkEUxFT2udVgr
         OioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=An31F33koa1fDQkSlJ6tWkgjZ045XtNBghfbLbm9HMc=;
        b=MoZupusHc0JB7wIc+XfP9Ue1/IQOr3ZzPjL+T9n7REL1Nc3p2HIWyP+XsAXsc8nppp
         cxKXwQkPcb+JKnjymnUAHc2JelwFdMjCcttnMnMAWMW59Mg+ojUJqGceKOSqdzs9CAVO
         fULHAJUbD/Xwy8+r1NrMf9HsJWC//sf4edTZHSyzkyHC5iAReM2NLdJTXb0xIbOVYAFF
         8zI+hT0tvqR6qYBIW0+R/abDMQY+ezW19Hhum3he2NWSmN9frJihNp7JLLA28FTDmI+A
         m/9Qvwe/B/LKCBDXnNEeOCP1gX8KOVZcodnQ2CVOdiSkkucLGYAJG92u5JJ2YeJ6bhfp
         4+YA==
X-Gm-Message-State: AIVw1136jY+PrsFW2RHY1f1USY458LqrvFODpP4rBBX/CxIlFlVMqCQS
        jAkPsUW7U2CPgbUa
X-Received: by 10.98.78.73 with SMTP id c70mr1753871pfb.17.1500507440870;
        Wed, 19 Jul 2017 16:37:20 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:f109:8044:bbc9:49ff])
        by smtp.gmail.com with ESMTPSA id y2sm1392117pgy.60.2017.07.19.16.37.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 19 Jul 2017 16:37:20 -0700 (PDT)
Date:   Wed, 19 Jul 2017 16:37:13 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 1/3] promised-blob, fsck: introduce promised blobs
Message-ID: <20170719163713.2d01f6e7@twelve2.svl.corp.google.com>
In-Reply-To: <CAGZ79kZ8i0Xqp2Yft19JKzPFMUdbzEDNJ01zER9RoM8ZzKPu8A@mail.gmail.com>
References: <cover.1499800530.git.jonathantanmy@google.com>
        <f9c7d4b3f800ea31e85e4897ee7048fec1e3c2f0.1499800530.git.jonathantanmy@google.com>
        <CAGZ79kZ8i0Xqp2Yft19JKzPFMUdbzEDNJ01zER9RoM8ZzKPu8A@mail.gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 11 Jul 2017 15:02:09 -0700
Stefan Beller <sbeller@google.com> wrote:

> Here I wondered what this file looks like, in a later patch you
> add documentation:
> 
>   +objects/promisedblob::
>   +       This file records the sha1 object names and sizes of promised
>   +       blobs.
>   +
> 
> but that leaves more fundamental questions:
> * Is that a list of sha1s, separated by LF? (CRLF? How would Windows
>   users interact with it, are they supposed to ever modify this file?)
> * Similar to .git/packed-refs, would we want to have a first line
>   that has some sort of comment?
> * In the first question I assumed a linear list, will that be a sorted list,
>   or do we want to have some fancy data structure here?
>   (critbit tree, bloom filter)
> * is the contents in ASCII or binary? (What are the separators?)
> * In the future I presume we'd want to quickly answer "Is X in the
>   promised blobs list?" so would it be possible (in the future) to
>   improve the searching e.g. binary search?
> * ... I'll read on to see my questions answered, but I'd guess
>   others would prefer to see it in the docs. :)

I'll write more documentation once the file format is finalized. At the
time this patch was written, this was a sorted binary file, where each
entry consists of a 20-byte SHA-1 and an 8-byte size. Now each entry is
a 20-byte SHA-1, a 1-byte type, and an 8-byte size (I will send this
patch out soon).

> Similar to other files, would we want to prefix the file with
> a 4 letter magic number and a version number?

That's a good idea.

> Later down the road, do we want to have a
> (plumbing) command to move an object from
> standard blob to promised blob (as of now I'd think
> it would perform this rm call as well as an insert into
> the promised blobs file) ?
> (Well, we'd also have to think about how to get objects
> out of a pack)
> 
> With such a command you can easily write your own custom
> filter to free up blobs again.

This sounds reasonable, but probably not in the initial set of patches.

> > +       test_must_fail git -C repo fsck
> 
>     test_i18n_grep missing out ?
> 
> maybe, too? (Maybe that is already tested elsewhere,
> so no need for it)

This test is just meant to show that configuration can make fsck pass,
not the existing behavior of fsck when it fails (which is tested
elsewhere - I guess that was your question).
