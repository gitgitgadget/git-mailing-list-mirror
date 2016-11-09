Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FE6F2021E
	for <e@80x24.org>; Wed,  9 Nov 2016 22:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754320AbcKIWmy (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 17:42:54 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36050 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbcKIWmx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 17:42:53 -0500
Received: by mail-qk0-f180.google.com with SMTP id n21so164171356qka.3
        for <git@vger.kernel.org>; Wed, 09 Nov 2016 14:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OsE6ItKND64+ptpY33RLxw+Hx6cPz80g+2E1UyzSvt8=;
        b=VZ3PHjuZCosIYwGlUGxgWjAScqKXoyXkev2n95S7jNmO21XrgEPXQyxEgS4LxlEAWU
         FVAlKP0UY3TJpRkfRCoxqpMJESM+u5I6c7/gKV4CjxgjxAC7vesZfqlwiinjN+vO8anZ
         a6+e3aMKrzf1EV2jR4aAa7Ku/K6XylL59TmW5EwW5KuFeQfurxGnonYMD9VOnaOjSe6X
         wBeLdpvu9pIFttFHoZxlUNe4vS2m5Vxc29WqF74nHZzUv3G48OFFL9woNsg/iYylVEzc
         Jm7RpkowDMdqei0PeYUIhZiFX/Z0j9OEbDt94hxaWoitWXF+5JkjpWFGyMum8ceizjl6
         KT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OsE6ItKND64+ptpY33RLxw+Hx6cPz80g+2E1UyzSvt8=;
        b=gH+fC/n7sh+2q2wgc87Tr3fTwpTiliKAJkj9+SoSvJsaTDkn7lerOegtRHAObgbRs/
         J9wAQ+iskkp+qLITp7SNWVtdKWOJIfWOhArO8V/HLYZ1FhtpGReai+vVJ2/XBXyU+GAM
         ysi2NkXTZ8RkeG8ha+n3aAU6kXykTHfTJZN5jH/vmBQojpCCoG1cuBHsOfxK28Bl/d2V
         hGTI+AD/FHy3cKaxSW3QTUtIEjLTl1owJtneuHKW9UcQbNDsbZUMfFTBloezBmfWaiZq
         lKFBrNDJdlDtdipdOMReXTnQAS7rBbn5ma4DBymYMWlkHrw5rQuki5pmbZ0vGD+y+I6p
         9oGw==
X-Gm-Message-State: ABUngve6qgieJnbaefc0fF4Yhx+4rUmwvnJBSKEQGxS0sJRFVl8JgQyDW4CaGDdA7pmyrAEwra1fVJVg8bjV0yHm
X-Received: by 10.55.186.3 with SMTP id k3mr2543880qkf.47.1478731372292; Wed,
 09 Nov 2016 14:42:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Wed, 9 Nov 2016 14:42:51 -0800 (PST)
In-Reply-To: <CACsJy8BKwvaw8CsorZhoYDw6gxoosv0gPRRpdwW87+YMASCVcA@mail.gmail.com>
References: <20161028185502.8789-1-sbeller@google.com> <20161028185502.8789-33-sbeller@google.com>
 <CACsJy8BKwvaw8CsorZhoYDw6gxoosv0gPRRpdwW87+YMASCVcA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 Nov 2016 14:42:51 -0800
Message-ID: <CAGZ79kaFFJX6cvjq97fHz5e7Y=BjVXAGi_jHKJKjc+fJ4va2NA@mail.gmail.com>
Subject: Re: [PATCHv2 32/36] pathspec: allow querying for attributes
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 9, 2016 at 1:57 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Oct 29, 2016 at 1:54 AM, Stefan Beller <sbeller@google.com> wrote:
>> The pathspec mechanism is extended via the new
>> ":(attr:eol=input)pattern/to/match" syntax to filter paths so that it
>> requires paths to not just match the given pattern but also have the
>> specified attrs attached for them to be chosen.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  Documentation/glossary-content.txt |  20 +++++
>>  dir.c                              |  35 ++++++++
>
> Pathspec can be processed in a couple more places. The big two are
> match_pathspec and tree_entry_interesting, the former traverses a list
> while the latter does a tree. You don't have to implement attr
> matching in tree_entry_interesting right now because nobody needs it,
> probably. But you need to make sure if somebody accidentally calls
> tree_entry_interesting with an attr pathspec, then it should
> die("BUG"), not silently ignore attr.
>

I am looking into this now.
