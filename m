Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16B851F955
	for <e@80x24.org>; Fri, 29 Jul 2016 14:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbcG2OVQ (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 10:21:16 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36357 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbcG2OVO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 10:21:14 -0400
Received: by mail-wm0-f66.google.com with SMTP id x83so15929599wma.3
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 07:21:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/JGyUQo38EN3/4YZrIdiece/uHEqoVUiAU0NSomw+2U=;
        b=wipdo49HpSdpaiWk3F7MplfgcJxKVEZlddOvx4FOxCcIOBswYaPO2RzvziZEYQ7bW4
         BWXdO/p+HVO9S37w4gCR1YcmR4RjfH8OjWLVdlnZ1a3lPR7wV3/vxTv/Jv1xDWWFqwN8
         UWPLXn6mAF2mP8nbDAEf8p/gSXlOoUGvOhbx5nWN4THnSFZmX0xiuAre8+PSObvzSq/y
         MLxvArI14usqOjGbLVY/TIp8ZaM33rh3LQMAWWdVIVGJF9ut0/BS437BIZXQCEZ5Jobs
         jsHxdEFHFgntv19h1rE+YJSKGt1kkuvSsr0GBkOlfqxX9NDfTKBa3MjADgbDHuAJdXGc
         X2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/JGyUQo38EN3/4YZrIdiece/uHEqoVUiAU0NSomw+2U=;
        b=PDIaitX5w5mPlvf92z4EpQfbff8k4suntPZ9ErhoVQPJzyvnDtxxoE5n6RrZYan3dV
         pj189WSibzHR3dcoPrrQE3MOnGle8vh/esHl/q3gi0v4UVRpRGZVU7mlK5N34M+QpAyB
         gxdP0lcwjTVhdoZJbfA9BVF4IHykehBmqG+ir2ofd5STWYatvViZ2p/FBLBQ9k9mp9ep
         BtNx1j7fQObhhW5kLm7haINpCfemZ0ntT/jcNeG0Lu6pG+OkGZJt/wsWlwu9UriwW05w
         iWshVCgerQuJ0r1gpbCp+rz3lgmREUg7wHSoJ1t0Y67sozRCmrG3JK+T7875jMv06Mj9
         SKhA==
X-Gm-Message-State: AEkooutYpa4yKZpPJTICUQPJx/uY66Pu4S5o6ez+vFhjBVsWs6b9wPnqo+HgCw7PESKlIQXOX3NL8tcKTozMMA==
X-Received: by 10.28.167.80 with SMTP id q77mr1466456wme.62.1469802073126;
 Fri, 29 Jul 2016 07:21:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Fri, 29 Jul 2016 07:21:11 -0700 (PDT)
In-Reply-To: <CACsJy8Bi00yBb6UPm7_x8BDnwQKCXXpOPbswKtayRofmSOstcg@mail.gmail.com>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
 <20160627182429.31550-33-chriscool@tuxfamily.org> <xmqqinvs19ng.fsf@gitster.mtv.corp.google.com>
 <CACsJy8Bi00yBb6UPm7_x8BDnwQKCXXpOPbswKtayRofmSOstcg@mail.gmail.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Fri, 29 Jul 2016 16:21:12 +0200
Message-ID: <CAP8UFD1SSjSGV+1e+zP4s=p+ohgSz6mct3EhPXqbde_y48ST7g@mail.gmail.com>
Subject: Re: [PATCH v8 32/41] environment: add set_index_file()
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
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

On Wed, Jul 27, 2016 at 5:14 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Jul 26, 2016 at 9:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>> Introduce set_index_file() to be able to temporarily change the index file.
>>>
>>> It should be used like this:
>>>
>>>     /* Save current index file */
>>>     old_index_file = get_index_file();
>>>     set_index_file((char *)tmp_index_file);
>>>
>>>     /* Do stuff that will use tmp_index_file as the index file */
>>>     ...
>>>
>>>     /* When finished reset the index file */
>>>     set_index_file(old_index_file);
>>
>> WHY is glaringly missing.
>
> It's used in a4aaa23 (builtin/am: use apply api in run_apply() -
> 2016-06-27) as a straight conversion of "GIT_INDEX_FILE=xxx git apply"
> .

Yeah, I would add something like the following to clarify the WHY:

"It is intended to be used by builtins commands to temporarily change the
index file used by libified code.

This is useful when libified code uses the global index, but a builtin
command wants another index file to be used instead."

>> Doesn't calling this have a global effect that is flowned upon when
>> used by a library-ish function?  Who is the expected caller in this
>> series that wants to "libify" a part of the system?

The expected caller is a builtin, like "builtin/am.c".

> I agree we should avoid this. There's a bunch of cache_name_pos() (and
> even read_cache()) in the libified apply.c, those will need to be
> converted  to take struct index_state* directly (read_index_from or
> index_name_pos).

There is a lot of other "libified" code that is calling these functions:

$ git grep -l cache_name_pos -- '*.c' | grep -v builtin
apply.c
diff.c
dir.c
merge-recursive.c
pathspec.c
rerere.c
sha1_name.c
submodule.c
wt-status.c

$ git grep -l read_cache -- '*.c' | grep -v builtin | egrep -v '^t/'
apply.c
check-racy.c
diff.c
dir.c
merge-recursive.c
merge.c
read-cache.c
rerere.c
revision.c
sequencer.c
sha1_name.c
submodule.c

and some of that code is perhaps directly and indirectly called by the
libified apply code.

Also I am not sure that read_cache() and cache_name_pos() are the only
functions that should be changed.

So it looks like it is a very big and different project to make the
current libified code be explicit about which index it is using.
And by the way perhaps this other project should just remove the
"the_index" global altogether.

> But at least read-cache.c has supported multiple
> indexes for a long time.

This is great, but it is unfortunately not the only lib file involved.
