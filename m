Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E9951F404
	for <e@80x24.org>; Sat, 27 Jan 2018 19:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbeA0TBm (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 14:01:42 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36438 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeA0TBl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 14:01:41 -0500
Received: by mail-wm0-f42.google.com with SMTP id f3so26784581wmc.1
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 11:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Byd+rRGk8c1lYHsVSIR/YGmObtAqH/XAw+2AG+w5DI4=;
        b=VOfp9GAqtAZF/0W0BpL3VWsdDN6rXwgkjfzGJHygQ+Y+M0d78q6KnNAAfceET5YBYl
         AXz3uJ+jNXEkdnTxsbnju76RhrLXC+naXUWZC2O07ByY/aeHsX3fAd/4WIC6PmIC4hhN
         7ZxSOucSSFxlmBbJQn6CBuejXejs8aUFfQTXCTrxUd19nMcdjKJg4PzIpKwhHr4XInaL
         NsFgwP2MavK1cX9e11h226LIiPLoXDbG8W0r61yjHSRMSA2fkahQ4C+ZOvfMg2MzOcQr
         FjVvtqv/9I7qw/AYqjzPlBsz3jjGfaAjT5UQ8xSjER79nmjZMgFF8Zl+9P/srf7jf0OQ
         w0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Byd+rRGk8c1lYHsVSIR/YGmObtAqH/XAw+2AG+w5DI4=;
        b=TdILVe51k4IyAC/+/xG/y1GSnxMvl84i7OOqN18Reppi/e3SSbe+MXJgHAqf+3ll+b
         Pe48md06WakGWBReibOwqKajxCNtE2IuN7UsVyQSETPmK9p+ZSp6bWNE1ft5QU4UnB8z
         RM/soG8UMk2IzTcY/cWAQnYzFWBUvwlavnCRKauJrwg78Uh4zo9Jj9mdWXZBvWMwEFAK
         O4qJChbVD4j2gE34SgVBGjG8KhQKqk/MClZd5lJV02Z6LKSaU7HQKYzlXahrUqgK77Wz
         /8NRbZPKvloM2yCBFRxBBTnwwylJPXCRvM6PfCIMloGHLayCfBVuPYn66x10WlxV9ZzP
         LIrg==
X-Gm-Message-State: AKwxyteX0P9w91bPWq+nJEOzlxa44dlSsiIy963xQNyrm2pQOyXzcocy
        IEx/gP3/FRLr/MT3A+dPok81isKw
X-Google-Smtp-Source: AH8x226BF2YnnaE/UOPQOyt98hR2XTwCcjrJmeIjt/6N/hMuZsFurIFVPrEpWt1r+P6l8YC89AZ8eg==
X-Received: by 10.80.180.16 with SMTP id b16mr7426797edh.111.1517079700099;
        Sat, 27 Jan 2018 11:01:40 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id e40sm4567020ede.21.2018.01.27.11.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jan 2018 11:01:39 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: Some rough edges of core.fsmonitor
References: <87efmcw3fa.fsf@evledraar.gmail.com> <CACsJy8BpO0s6facg+zcKC9icijpefkipM326n6xOArjn=ZW6+w@mail.gmail.com> <87bmhfwmqa.fsf@evledraar.gmail.com> <CACsJy8CJtW3LZ+4Z_06uM4rJO88FXsNvcw+zzVqdFpsQUKrvrg@mail.gmail.com> <20180127130954.GA19922@ash>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <20180127130954.GA19922@ash>
Date:   Sat, 27 Jan 2018 20:01:38 +0100
Message-ID: <878tcjw2gd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jan 27 2018, Duy Nguyen jotted:

> On Sat, Jan 27, 2018 at 07:39:27PM +0700, Duy Nguyen wrote:
>> On Sat, Jan 27, 2018 at 6:43 PM, Ævar Arnfjörð Bjarmason
>> <avarab@gmail.com> wrote:
>> > a) no fsmonitor
>> >
>> >     $ time GIT_TRACE_PERFORMANCE=1 ~/g/git/git-status
>> >     12:32:44.947651 read-cache.c:1890       performance: 0.053153609 s: read cache .git/index
>> >     12:32:44.967943 preload-index.c:112     performance: 0.020161093 s: preload index
>> >     12:32:44.974217 read-cache.c:1446       performance: 0.006230611 s: refresh index
>> >
>> > ...
>> >
>> > b) with fsmonitor
>> >
>> >     $ time GIT_TRACE_PERFORMANCE=1 ~/g/git/git-status
>> >     12:34:23.833625 read-cache.c:1890       performance: 0.049485685 s: read cache .git/index
>> >     12:34:23.838622 preload-index.c:112     performance: 0.001221197 s: preload index
>> >     12:34:23.858723 fsmonitor.c:170         performance: 0.020059647 s: fsmonitor process '.git/hooks/fsmonitor-watchman'
>> >     12:34:23.871532 read-cache.c:1446       performance: 0.032870818 s: refresh index
>>
>> Hmm.. why does refresh take longer with fsmonitor/watchman? With the
>> help from watchman, we know what files are modified. We don't need
>> manual stat()'ing and this line should be lower than the "no
>> fsmonitor" case, which is 0.006230611s.
>
> Ahh.. my patch probably does not see that fsmonitor could be activated
> lazily inside refresh_index() call. The patch below should fix it.

Will have to get those numbers to you later, or alternatively clone
https://github.com/avar/2015-04-03-1M-git (or some other test repo) and
test it yourself, sorry. Don't have time to follow-up much this weekend.

> But between your normal refresh time (0.020 preload + 0.006 actual
> refresh) and fsmonitor taking 0.020 just to talk to watchman, this
> repo seems "too small" for fsmonitor/watchman to shine.

Surely that's an implementation limitation and not something inherent,
given that watchman itself returns in 5ms?

I.e. status could work like this, no?:

 1. At start, record the timestamp & find out canonical state via some
    expansive method.
 2. Print out xyz changed, abc added etc.
 3. Record *just* what status would report about xyz, abc etc.
 4. On subsequent git status, just amend that information, e.g. if
    watchman says nothing changed $(cat .git/last-status-output).

We shouldn't need to be reading the entire index in the common case
where just a few things change.

There's also a lot of things that use status to just check "are we
clean?", those would only need to record the last known timestamp when
the tree was clean, and then ask watchman if there were any changes, if
not we're done.

> I'm still a bit curious that refresh index time, after excluding 0.020
> for fsmonitor, is stil 0.012s. What does it do? It should really be
> doing nothing. Either way, read index time seems to be the elephant in
> the room now.
>
> -- 8< --
> diff --git a/read-cache.c b/read-cache.c
> index eac74bc9f1..d60e0a8480 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1367,12 +1367,21 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>  	unsigned int options = (CE_MATCH_REFRESH |
>  				(really ? CE_MATCH_IGNORE_VALID : 0) |
>  				(not_new ? CE_MATCH_IGNORE_MISSING : 0));
> +	int ignore_fsmonitor = options & CE_MATCH_IGNORE_FSMONITOR;
>  	const char *modified_fmt;
>  	const char *deleted_fmt;
>  	const char *typechange_fmt;
>  	const char *added_fmt;
>  	const char *unmerged_fmt;
> -	uint64_t start = getnanotime();
> +	uint64_t start;
> +
> +	/*
> +	 * If fsmonitor is used, force its communication early to
> +	 * accurately measure how long this function takes without it.
> +	 */
> +	if (!ignore_fsmonitor)
> +		refresh_fsmonitor(istate);
> +	start = getnanotime();
>
>  	modified_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
>  	deleted_fmt = (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
> -- 8< --
