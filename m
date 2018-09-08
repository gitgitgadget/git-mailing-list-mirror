Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C54AF1F404
	for <e@80x24.org>; Sat,  8 Sep 2018 06:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeIHL2k (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 07:28:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56013 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeIHL2j (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 07:28:39 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so16572990wmc.5
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 23:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=GqIw2bOLA9ckjf+FUV2mGDFMoV8YSa2jx3djkXykIAQ=;
        b=jsreBip0KMnW5Vzc1UjTPUJnWHPjapi6wAvnA4V3AqAA4O/po+qsysMOjJC8kDOe+K
         Ls8+mlLXYXeHmEO4np7Fb62MzyCsfSNDu+Nv/IezjKqHjqWRHn6YnADoRJ4OlIzPuBMb
         G4K3nijIBSFj9dIwanXE5I2N+DARNgDLe24tPA88OdIMoxEmyhBap23wt6E7b9XQiQPM
         JniT1KmYScY03bU+vXCL4TQjecktt7iMaMP1ulmkCnjNHoLvrOb7b/Cqtr/idWynlpJL
         mFNgrDwtS7fetgh6msWZ+zejMarwHZgLZMTM3Kb4pa7alHN476LRUUZdInZMeqYMt3f5
         kIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=GqIw2bOLA9ckjf+FUV2mGDFMoV8YSa2jx3djkXykIAQ=;
        b=WWdgfIzG416xw2bLjxh60ye6ySMzZBelZnM5Xr+Z8TqaF2H3ZCop45+6F/eaSlrFOw
         vJ+fGA8i1/Od0fAB7vxIvwf+Y8/tq82NpJezJ+TevM/uF9HGF3O07r/PZZXnOYTXiEve
         b8NTolLdWQFx+r04ny2jcfjIQ3PgJTnuhealHdmYJH1CHjS2mJzm7GSzErkjl2J6kpoR
         acxU+Paw63ah0LESR5wdOq6mapZ6mURmjuxAhqZvUFFYsDimKWIzvDw0hyNLscRE6Kqa
         Oky0HqG3XsomJeHeCTcufvADtNzQ+HYjN81a5Fukg2r4HRvnVolw3d0wQM2iwWGbp/O5
         lymQ==
X-Gm-Message-State: APzg51BXhObcLN1+SJp9/xx0o3TfPGUCkDCoEMh4FB6dsyxK0TKa8C91
        GccN07EHVZZs75EnQfFlFK4=
X-Google-Smtp-Source: ANB0VdZyQLGYUWu7vVRN9P23HSch9arX3UXH2DXYMu7c8NRrIJB0jiM5/3qGdFSh0YCSgjc4GJ811g==
X-Received: by 2002:a1c:80d8:: with SMTP id b207-v6mr7334267wmd.146.1536389038843;
        Fri, 07 Sep 2018 23:43:58 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id x23-v6sm6314830wmh.26.2018.09.07.23.43.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 23:43:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] un-breaking pack-objects with bitmaps
References: <20180821184140.GA24165@sigill.intra.peff.net>
        <20180821190701.GE30764@sigill.intra.peff.net>
        <8736uud0gq.fsf@evledraar.gmail.com>
        <20180831225558.GA22917@sigill.intra.peff.net>
        <20180901074145.GA24023@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180901074145.GA24023@sigill.intra.peff.net>
Date:   Sat, 08 Sep 2018 08:43:57 +0200
Message-ID: <87d0toqyj6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 01 2018, Jeff King wrote:

> On Fri, Aug 31, 2018 at 06:55:58PM -0400, Jeff King wrote:
>
>> On Fri, Aug 31, 2018 at 05:23:17PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>
>> > On Tue, Aug 21 2018, Jeff King wrote:
>> >
>> > > +int bitmap_has_sha1_in_uninteresting(struct bitmap_index *bitmap_git,
>> > > +				     const unsigned char *sha1)
>> > > +{
>> > > +	int pos;
>> > > +
>> > > +	if (!bitmap_git)
>> > > +		return 0; /* no bitmap loaded */
>> > > +	if (!bitmap_git->result)
>> > > +		BUG("failed to perform bitmap walk before querying");
>> >
>> > Some part of what calls this completely breaks pushing from the "next"
>> > branch when you have local bitmaps (we *really* should have some tests
>> > for this...).
>>
>> Yikes, thanks for reporting. I agree we need better tests here.
>
> OK, here is the fix. Since the problem is in 'next', this is done as a
> patch on top of jk/pack-delta-reuse-with-bitmap. But since we're set to
> rewind 'next' post-release anyway, we could squash it directly into
> 30cdc33fba from the original series. That would help later bisections
> from running into it, which may be worth it as it's a pretty severe
> breakage.  Or maybe not:

Junio: Just a reminder that next is still broken with this, and I see
e.g. the Debian "experimental" has the bug but not the fix at this
point.

I'm just reverting jk/pack-delta-reuse-with-bitmap out of next when
building my own package of git, but I think this really should be fixed
in that branch, either by merging the fix down or reverting the original
series out of next, I think just merging the fix down makes sense, but
have no strong opinion on it.
