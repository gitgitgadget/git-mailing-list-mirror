Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89C4220705
	for <e@80x24.org>; Tue,  6 Sep 2016 02:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752924AbcIFCIC (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 22:08:02 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:34911 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752072AbcIFCIB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 22:08:01 -0400
Received: by mail-it0-f41.google.com with SMTP id e124so170696824ith.0
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 19:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Tg9+3vShb/qDfMkkF160O/OJmzXYjHj/xGpl5NGe9bQ=;
        b=oghCDAs9MDNoXOg7TXSgBrd7keWB/ze85zPnLYn4Piz5WETQ8QB9RePRpD0c28QFc1
         41fYxLMRKfhqK2mUdwAF/63yOru0PyfdcrrxH/KRmZVScVN8ulHW7hdG3kKyB7C5185v
         1aMEs9URu1ON3S4PPnfZV9vfkjxhVIGC/CSqwD+bdQ0ZMtfr46Z++Tm2SnbMJbH/rKgM
         a+AA4Xq9dv6zIRAMEWHVVEov2fpnlRcxhuqbuIeDMDXMr6VNP7m6pjUyK0EQf1PkngRi
         vJS+3nXRhtR7F/2gniDh/ttICoZbT8Md0z6prsd54PaPO9u7/NbgkAQXQ6WtDXJ+YpdX
         6QWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Tg9+3vShb/qDfMkkF160O/OJmzXYjHj/xGpl5NGe9bQ=;
        b=ULdvJk7RphKEiVeTPoSxWpId20lD3n8A6+ZfGTS6achQlD2uhaDoKMgMDw1LDwtO+I
         rWay+imyJbvRTrpf0X9cZ5T5m66FDjVh0CFsm4CBMc63LB57+kScNpwsDviNdhbhhi6S
         oml7P2qpfVeCn6/k2kRd/hofxI8HyI3HBoDvI5FMEl1lKgfl2PynTsk4p8UfPXvPZpK1
         bQrSXGBh0/9RtWV97r6x9a9F8q4oDEXJmYR+04at9P4Dt95wBycMeYMu+7rksuqxRrqp
         lztv/nlrl3CD8KI00jxpBenPEfxUrfFvlv1rXF1vxcxCUPn/xN0HPY50jADxK3DVEZor
         eA+w==
X-Gm-Message-State: AE9vXwP//VRX722rNUIYlKuNtLhPGXfDoQqp2YdFl+a2am+8D/BG0sF5rhiMmm2YVhLE4oWl8lJmUHVY42sjYwmG
X-Received: by 10.107.139.136 with SMTP id n130mr2231011iod.173.1473127652516;
 Mon, 05 Sep 2016 19:07:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Mon, 5 Sep 2016 19:07:32 -0700 (PDT)
In-Reply-To: <xmqq1t0yqinr.fsf@gitster.mtv.corp.google.com>
References: <20160904191435.14144-1-stefanbeller@gmail.com> <xmqq1t0yqinr.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Sep 2016 19:07:32 -0700
Message-ID: <CAGZ79kaCtYYSv-Wnz6-Xz6Mt1TwstO-GMBYWyhbO7tM9g5gumA@mail.gmail.com>
Subject: Re: [WIP PATCH v2] diff.c: emit moved lines with a different color
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 5, 2016 at 11:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> +     `new` (added lines), `commit` (commit headers), `whitespace`
>> +     (highlighting whitespace errors), `moved-old` (removed lines that
>> +     reappear), `moved-new` (added lines that were removed elsewhere).
>
> Could we have a config to disable this rather costly new feature,
> too?

And by config option you mean both a command line parameter
`--color=yes-but-no-move-detection` as well as a diff.color config option?

As it is currently `--color=<when>` with when={always, never,auto},
I don't think we want to add it as another parameter there, so maybe
--color-type=<style> with style={minimal, full} whereas the minimal/full
describes the amount of work needed. Though I think that is bad as there
might be other orthogonal features to this.

So maybe just a `--[no-]color-moved` ?

As a config option we'd go with color.moved=<bool> for now?

I imagine we may want to refine the moved detection algorithm in the
future, e.g. moved just in the patch, or moved from elsewhere in the
repo or whether the moved detection takes permutations into account
etc, so actually we'd want to have color.moved={none, this-patch} for
now. The command line parameter --color-moved=<style> would be the
same.

>
> Also the first and the third level configuration names (the <slot>
> is at the third level) used by the core-git do not use dashed-words
> format.  Please adhere to the current convention.

will do.

>
>> diff --git a/diff.c b/diff.c
>> index 534c12e..d37cb4f 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -18,6 +18,7 @@
>>  #include "ll-merge.h"
>>  #include "string-list.h"
>>  #include "argv-array.h"
>> +#include "git-compat-util.h"
>>
>>  #ifdef NO_FAST_WORKING_DIRECTORY
>>  #define FAST_WORKING_DIRECTORY 0
>> @@ -42,6 +43,11 @@ static int diff_dirstat_permille_default = 30;
>>  static struct diff_options default_diff_options;
>>  static long diff_algorithm;
>>
>> +static struct hashmap *duplicates_added;
>> +static struct hashmap *duplicates_removed;
>> +static int hash_previous_line_added;
>> +static int hash_previous_line_removed;
>
> I think these should be added as new fields to diff_options
> structure.

Makes sense.
