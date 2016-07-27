Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1D54203EB
	for <e@80x24.org>; Wed, 27 Jul 2016 15:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797AbcG0PPV (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 11:15:21 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34205 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815AbcG0PPU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 11:15:20 -0400
Received: by mail-it0-f66.google.com with SMTP id u186so2960426ita.1
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 08:15:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+WDHR+7wiMU9mrP2kz13w8gspaIswdbHZ/SOMGDxuLQ=;
        b=OcoommmT6fBaIBxMRizNSApiry7p4xmfRk7ObwH8IJYOOZWIzMMGAk1edN0x2kDxHZ
         XuuiPU0pix27kj0BeBlCjRQwuGeGho99+HkzS82p6QCvxbm/AN8/qljP9y+CM7dVJQPj
         iOgJIntr1SFMlWKqxexa0H/Y3w6OLB5t+oQb1dbGJF/Qbw3UzfoI6LKYzsGASSvtWEZ+
         jfMBDqxxLlHvIOMnynN1yW8LIHJPDqZgdojZuba/vKIMaxsR5JxTyQc6FMc7EcJHCjLw
         I4k5G+LqemtFrVaUKm+NKB7z7I33GvRJiFtisRvLGubHKcfP8TWsnJZyOCJEcKPKEcXQ
         Zlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+WDHR+7wiMU9mrP2kz13w8gspaIswdbHZ/SOMGDxuLQ=;
        b=TWUVkuaAXkvS9dTSWv0mybc8tXVl9IqsRUiFrK/nr9rAVLknaa/c3YQIWnOCUuHip6
         OQkHbh84cw+JIr5RlwvLV9RADhT3AUOnNqTZcwGkxcn0q2Cv0QA5u+fY8MhNsvQPmXl4
         xNC48LbZqTorKsVw5vgWpe8hdsg8KD1in2WhDF0CHGrF83M9mD+t+Fht8ogMBLOqHj+u
         kobGzKZydIj3nhxUr5ucGi+a3rW/NH2zV5+oLz4i791m2Uc8dIufnzaKCW8IMRUtaL9i
         tKj95Jz7sUlVSdERfLD9MZ1un0X/E3jUMFevz37riPyFpgS+G0x/GkMXsYFQIU3dznK6
         gkZA==
X-Gm-Message-State: ALyK8tLOYlvoPglXS7JxRHpQjcbBNz4zvPUG79rA9AmR583llbQEYneu/3eKxPMVgu6P+XPmqZiz8HtPJk3Icg==
X-Received: by 10.36.43.88 with SMTP id h85mr82774837ita.57.1469632519470;
 Wed, 27 Jul 2016 08:15:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 27 Jul 2016 08:14:50 -0700 (PDT)
In-Reply-To: <xmqqinvs19ng.fsf@gitster.mtv.corp.google.com>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
 <20160627182429.31550-33-chriscool@tuxfamily.org> <xmqqinvs19ng.fsf@gitster.mtv.corp.google.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 27 Jul 2016 17:14:50 +0200
Message-ID: <CACsJy8Bi00yBb6UPm7_x8BDnwQKCXXpOPbswKtayRofmSOstcg@mail.gmail.com>
Subject: Re: [PATCH v8 32/41] environment: add set_index_file()
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Christian Couder <christian.couder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 26, 2016 at 9:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Introduce set_index_file() to be able to temporarily change the index file.
>>
>> It should be used like this:
>>
>>     /* Save current index file */
>>     old_index_file = get_index_file();
>>     set_index_file((char *)tmp_index_file);
>>
>>     /* Do stuff that will use tmp_index_file as the index file */
>>     ...
>>
>>     /* When finished reset the index file */
>>     set_index_file(old_index_file);
>
> WHY is glaringly missing.

It's used in a4aaa23 (builtin/am: use apply api in run_apply() -
2016-06-27) as a straight conversion of "GIT_INDEX_FILE=xxx git apply"
.

> Doesn't calling this have a global effect that is flowned upon when
> used by a library-ish function?  Who is the expected caller in this
> series that wants to "libify" a part of the system?

I agree we should avoid this. There's a bunch of cache_name_pos() (and
even read_cache()) in the libified apply.c, those will need to be
converted  to take struct index_state* directly (read_index_from or
index_name_pos). But at least read-cache.c has supported multiple
indexes for a long time.
-- 
Duy
