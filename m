Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5282B20282
	for <e@80x24.org>; Tue, 20 Jun 2017 20:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbdFTU5R (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 16:57:17 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34682 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbdFTU5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 16:57:16 -0400
Received: by mail-pf0-f179.google.com with SMTP id s66so74741827pfs.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 13:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2vfwXttbcF+LVUeGbJyGmkDvh25d6Zl4HiUzVWtZ3fQ=;
        b=aQW5QXZN47qDBpCbH8q6v693sJYLEJK3MmIGI5QFKnDczn6sKPy0x3i4rjbp54Ehd2
         iABn2D2Jo8WIT2LyxH0MH8Epl4WfeQqALNgQkEHruIfqnQAiepYSWMcAUMNYqL0/QrdN
         +9wTLY3r49DKuhivdXGpwnghoxPzkTF0ULXdk5MoooBMaXSYSmbGfWchKCY5R2vhdj6R
         HvdvJLEBXfIPklAynUMGpD2DfNo0tCSGTQF/ZjN2GJX5RwgTIEhQ2f2SAv9XpRzv6yHi
         KokX3VW+Wwi68r1P4zJ3xaZUFh1Pn3PNF9jHloxDLAE+CTi+aCGZOuC8B5DqWfwzcoYE
         Anbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2vfwXttbcF+LVUeGbJyGmkDvh25d6Zl4HiUzVWtZ3fQ=;
        b=USdngsZPQTVCIP3JHEmAVcHzKxQ42ZGf77AaCIDfebTD+ViwR+K/sfvwZCVYjD6RD3
         BstyL7UDuD5MEbzlz2BxKocuaH4YaAr7epj1tD5g24FLePbgnNLjKRZmjI9KNJA5UPIh
         Vwuz0+ow9e2lrTk5RuQf1JgavNBRQAiYWAEfiFtJpXJSrPFyBzCK8ipTiyVYUhB++fMc
         u6Eh+GcA4XhuOg/hV1hO0h2GRZC2WswsmCOqKIfEtRYIWqifGbWMu9Ms+drYoA6ECgko
         J7aq5GTYZQJzcAJNBfDh9NLDdq+jpRVHcA7MtgyZmY8DoBrLTZSsqY4pBQHbELzu/Ugf
         Waeg==
X-Gm-Message-State: AKS2vOzcbtEGelm0Qq5PxL8TJ67tT35P/5l6NoEnRQ9lbf9qkIYCG3j4
        vtUbXth5h2esBfjp5bcizY1CfGmoiB73
X-Received: by 10.84.209.228 with SMTP id y91mr37798565plh.210.1497992235418;
 Tue, 20 Jun 2017 13:57:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Tue, 20 Jun 2017 13:57:14 -0700 (PDT)
In-Reply-To: <20170620131339.3f56bcf0@twelve2.svl.corp.google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com> <20170620024816.20021-23-sbeller@google.com>
 <20170620131339.3f56bcf0@twelve2.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Jun 2017 13:57:14 -0700
Message-ID: <CAGZ79kbHzmZE_uUUbFbMN-Gv8oegkEOry1i6G28GKbHmSJzmRA@mail.gmail.com>
Subject: Re: [PATCH 22/26] diff.c: color moved lines differently
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2017 at 1:13 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> I just glanced through this file, because it seems similar to the
> versions I have previously reviewed.

Yes, this has not changed much.
The thing that took so long were patches 1-20 to do.
In these later patches (22) the UX was changed slightly.
The mode is zebra instead of alternating for example

> I'll skip patches 23 onwards in this round of review because (i) I would
> be happy if just patches 1-22 were included in the tree

patch 22 just introduced the zebra mode, which contains all
information necessary, the later "dimming" is purely
UI excitement, no further information added.

In former series, I had documentation at each
patch that added a new mode, now I rolled all of
documentation in patch 25. I will add the basic docs
to that patch in a reroll.

> and (ii) those
> patches might end up changing anyway because of review comments in the
> prior patches.

plain, dimming, docs, and this RFC for machine parsable output,
ok with me.

So I'll focus on the first 22 patches.

>
> On Mon, 19 Jun 2017 19:48:12 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> +/* Find blocks of moved code, delegate actual coloring decision to helper */
>> +static void mark_color_as_moved(struct diff_options *o,
>> +                             struct hashmap *add_lines,
>> +                             struct hashmap *del_lines)
>> +{
>
> [snip]
>
>> +             if (flipped_block)
>> +                     l->flags |= DIFF_SYMBOL_MOVED_LINE_ZEBRA;
>
> This should probably be DIFF_SYMBOL_MOVED_LINE_ALT. "Zebra" refers to
> both the stripes, not just the alternate stripe.


ok
