Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E41B1F42D
	for <e@80x24.org>; Wed, 23 May 2018 20:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934946AbeEWUXi (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 16:23:38 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:40541 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934291AbeEWUXY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 16:23:24 -0400
Received: by mail-ua0-f172.google.com with SMTP id g9-v6so15664530uak.7
        for <git@vger.kernel.org>; Wed, 23 May 2018 13:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4OogWhQwNj3/L7SergWiM32o31JAIdefWUnkCUg8RfI=;
        b=r83L2ZYwRI7jJpB92Pk88T4Gh/gY9347OYzH8Qw/sfiB3Vp/Ajcs6VcjFzOVWMDTCP
         gmmxKWA3Xr/t8VbVlr90hZJZr+czcIyaCEIaY+j2a6+lfPg7tLwTSOK9xftMidAzsfn/
         FwpVV8XIoWCK6+Q7yx+eKG2byQozrpqatv02ZDhIGGgsG2k+OxEO3/VQG6UacD41FeEN
         PhRQIzMMwwP9nz4600LdorJLBX/VifahI6zeijBiOxSCVC1zzfeDGj84T0EFDSRiQjOK
         gNC2rJkyrapcpVjTLM+O835QOFlMAJ7dKy7pp6PUozIWz9EuXN/i7wf82jSwLRKmrj4x
         HMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4OogWhQwNj3/L7SergWiM32o31JAIdefWUnkCUg8RfI=;
        b=lZoJsHr9As5hyLYWhRnJJNM1NnxB+dd1p1rK2iSuTONQByrs7pEdZMxcHdWb6P+zaY
         2/HEDK1RZdDzVTDOBq2WULQM0azdNHyr7TCZ84VA/WdAENF9S7dAquw/RAQ7I5NiLNqx
         JVPsbdmHOYiQS6WRaMnIeEC67h6C5uIkKHMeF2P5hlgnmVjpI7CnNUoHFNcp5vnX3xO+
         8keacM2i9+8U5OLUvbWl8WVrjkJsZB7BPmJAWLlEZZSZF1jXiOc9P3+V9j10X//G1ywI
         ry1/mfdGrmiJLsTzha/+2HUNSSGevnWuzrBSA7m4ezrx8fC+uU0p3BZyHwfkU9Eo2ZJ5
         FkJw==
X-Gm-Message-State: ALKqPwcUsDxW/xCZiwS/fiol12+RMsBq3wLbYZnfK7WFwfngl6vcAwJN
        Lg162IwMfE9HTH+xqmk/j5oMJGmJdDWGcjSq7cM=
X-Google-Smtp-Source: AB8JxZr89nwjQLmFQ00SreUqlxtj3lnYIkvJ23YyNpReW/sYRT1BJ97LNaJowYalT0PCG+ahU3ZkeMnKvPM9Pw40Pd8=
X-Received: by 2002:ab0:5326:: with SMTP id x35-v6mr2945302uax.29.1527107003973;
 Wed, 23 May 2018 13:23:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f04:0:0:0:0:0 with HTTP; Wed, 23 May 2018 13:23:23
 -0700 (PDT)
In-Reply-To: <20180523195227.GT26695@zaya.teonanacatl.net>
References: <20180523195227.GT26695@zaya.teonanacatl.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 23 May 2018 13:23:23 -0700
Message-ID: <CABPp-BFOwWvDpfLFa2yrUDU_3BU6F68oLTtO5FvQo8nr62_WtQ@mail.gmail.com>
Subject: Re: BUG: rev-parse segfault with invalid input
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 23, 2018 at 12:52 PM, Todd Zullinger <tmz@pobox.com> wrote:
> Hi,
>
> Certain invalid input causes git rev-parse to crash rather
> than return a 'fatal: ambiguous argument ...' error.
>
> This was reported against the Fedora git package:
>
>     https://bugzilla.redhat.com/1581678
>
> Simple reproduction recipe and analysis, from the bug:
>
>     $ git init
>     Initialized empty Git repository in /tmp/t/.git/
>     $ git rev-parse ffffffffffffffffffffffffffffffffffffffff^@
>     Segmentation fault (core dumped)
>
>     gdb) break lookup_commit_reference
>     Breakpoint 1 at 0x555555609f00: lookup_commit_reference. (3 locations)
>     (gdb) r
>     Starting program: /usr/bin/git rev-parse ffffffffffffffffffffffffffffffffffffffff\^@
>     [Thread debugging using libthread_db enabled]
>     Using host libthread_db library "/lib64/libthread_db.so.1".
>
>     Breakpoint 1, lookup_commit_reference (oid=oid@entry=0x7fffffffd550) at commit.c:34
>     34              return lookup_commit_reference_gently(oid, 0);
>     (gdb) finish
>     Run till exit from #0  lookup_commit_reference (oid=oid@entry=0x7fffffffd550) at commit.c:34
>     try_parent_shorthands (arg=0x7fffffffdd44 'f' <repeats 40 times>) at builtin/rev-parse.c:314
>     314                     include_parents = 1;
>     Value returned is $1 = (struct commit *) 0x0
>     (gdb) c
>
>     (gdb) c
>     Continuing.
>
>     Program received signal SIGSEGV, Segmentation fault.
>     try_parent_shorthands (arg=0x7fffffffdd44 'f' <repeats 40 times>) at builtin/rev-parse.c:345
>     345             for (parents = commit->parents, parent_number = 1;
>     (gdb) l 336,+15
>     336             commit = lookup_commit_reference(&oid);
>     337             if (exclude_parent &&
>     338                 exclude_parent > commit_list_count(commit->parents)) {
>     339                     *dotdot = '^';
>     340                     return 0;
>     341             }
>     342
>     343             if (include_rev)
>     344                     show_rev(NORMAL, &oid, arg);
>     345             for (parents = commit->parents, parent_number = 1;
>     346                  parents;
>     347                  parents = parents->next, parent_number++) {
>     348                     char *name = NULL;
>     349
>     350                     if (exclude_parent && parent_number != exclude_parent)
>     351                             continue;
>
>     Looks like a null pointer check is missing.
>
> This occurs on master and as far back as 1.8.3.1 (what's in
> RHEL-6, I didn't try to test anything older).  Only a string
> with 40 valid hex characters and ^@, @-, of ^!  seems to
> trigger it.

Thanks for the detailed report.  This apparently goes back to
git-1.6.0 with commit 2122f8b963d4 ("rev-parse: Add support for the ^!
and ^@ syntax", 2008-07-26).  We aren't checking that the commit from
lookup_commit_reference() is non-NULL before proceeding.  Looks like
it's simple to fix.  I'll send a patch shortly...
