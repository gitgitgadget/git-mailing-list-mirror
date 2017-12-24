Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 845601F424
	for <e@80x24.org>; Sun, 24 Dec 2017 19:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751095AbdLXTfo (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 14:35:44 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33179 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdLXTfn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 14:35:43 -0500
Received: by mail-wm0-f46.google.com with SMTP id g130so31315707wme.0
        for <git@vger.kernel.org>; Sun, 24 Dec 2017 11:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=MMvfeRUyNONQ4hD/27C6Few7HWoTLe/Dg+17KL5jLmc=;
        b=Oy9XXMRrS2JRgDOwmarybF7h94ff5bqDI9aUXL+GlFMeK4vK3oAEHOu2tV7zwZ+IDY
         H/E3wiwrVqRz4uzaYra3jfBaT9Qj+K9GORMIT8oOdW2OikZTPthN/rDZ2oV3asqshL9M
         HG4o8nUCDLueLyhMA8HOUFzutOxRZgALLvJ1Rpad85ffNCk50w7mNMRYIkTp6pj9n3F/
         bJGpThO8sKLwqLy8guKtxlxq6oYrrYykIJg6CCiMsiS6vfASLtS8M2Q9t5RZT2sCQaUS
         ye33WcCm0VvYS+eLIHe2k7XHaUePfTRWiUIlvKrKChZ5imI98lkvox1mG2NNhGYVfMK5
         HUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=MMvfeRUyNONQ4hD/27C6Few7HWoTLe/Dg+17KL5jLmc=;
        b=WpiLR+OL3jdTLOzZwhCsTUmStlP2YaZ7OK2kcmkaGERLA6YqOhbv5BCu+xNRv3yvmm
         Gh/uV87itrjZh+EIGMngsG59pHRC/J8bAkmk7ePyDqeGNyFwk880fd2pXdJrFF3+dQOX
         PO9X6qDSuO0wn/YLMm2OcJe2aOg7FdijJa7Qo/rpdnu2xhIXrG8Ep5ZLpbBkWYetUnSH
         E8Tlfg3a6fYiAvDGlLgi+JOd2npkP+SkxLEPmxvrZJ4xn/QuCPqDL428AC36srsIdOS4
         8r80qhk+7XRskm+COn3pEq7QdUaE+jhn0CDeG/EecmfPepH8hFqXfwrtGqd6o9zCUHvT
         ffew==
X-Gm-Message-State: AKGB3mIE341zgFQHIQpYuzfVSk+XTb8jSysAndHK/jC9pti65riB07Bs
        bAc0+q82ynA1qcMPUInwULI=
X-Google-Smtp-Source: ACJfBousehq5l5s+thNR5TGi1Z93O94NhmqOqUbXzmGnscHtQBPmV9z2WTMNUJdp3HLCH73L92DHPw==
X-Received: by 10.80.181.70 with SMTP id z6mr24448526edd.201.1514144142397;
        Sun, 24 Dec 2017 11:35:42 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id f16sm25658521edj.65.2017.12.24.11.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Dec 2017 11:35:41 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     Vadim Petrov <tridronet@yandex.ru>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Martin Erik Werner <martinerikwerner@gmail.com>
Subject: Re: [PATCH] setup.c: move statement under condition
References: <3853941514059379@web42g.yandex.ru> <alpine.DEB.2.21.1.1712232332000.406@MININT-6BKU6QN.europe.corp.microsoft.com> <1483761514103335@web45o.yandex.ru> <20171224171118.GD27280@alpha.vpn.ikke.info>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171224171118.GD27280@alpha.vpn.ikke.info>
Date:   Sun, 24 Dec 2017 20:35:40 +0100
Message-ID: <87zi67rkab.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Dec 24 2017, Kevin Daudt jotted:

> On Sun, Dec 24, 2017 at 12:15:35PM +0400, Vadim Petrov wrote:
>> Thank you for your replay.
>>
>> > I have to be honest: this commit message (including the subject) left me
>> > quite puzzled as to the intent of this patch.
>>
>> I still only learn English and correctly express my thoughts while somewhat difficult.
>>
>> > If you also have a background story that motivated you to work on this
>> > patch (for example, if you hit a huge performance bottleneck with some
>> > tool that fed thousands of absolute paths to Git that needed to be turned
>> > into paths relative to the worktree's top-level directory), I would
>> > definitely put that into the commit message, too, if I were you.
>>
>> I have no such reason. I just saw it and wanted to change it.
>
> A commit message contains the reason why this is a good change to make.
> It lets others know what problems it's trying to solve or what usecase
> it tries to satisfy.
>
> The commit message basically needs to convince others why the change is
> necessary / desired, now, and in the future.
>
> This will help others to follow your thought process and it gives you
> the possiblity to communicate trade-offs you made, all which cannot
> inferred from the patch.
>
> For simple changes, the motivation can be simple too.

...and a good example would be 6127ff63cf which introduced this logic
Vadim is trying to change, i.e. does this still retain the fix for
whatever issue that was trying to address?

It's also good to CC the people who've directly worked on the code
you're changing in the past, I've CC'd Martin.

> To make it concrete: You are talking about a condition. What condition?
> And you say that the previously obtained value will not be necessary.
> What do you do with that value then? Why does this change improve the
> situation?
>
> These are things you can state in your commit message.
>
> Hope this helps, Kevin
>
>> > Up until recently, we encouraged dropping the curly brackets from
>> > single-line statements, but apparently that changed. It is now no longer
>> > clear, and often left to the taste of the contributor. But not always.
>> > Sometimes we start a beautiful thread discussion the pros and cons of
>> > curly brackets in the middle of patch review, and drop altogether
>> > reviewing the actual patch.
>>
>> I was guided by the rule from the Documentation/CodingGuidelines:
>> 	When there are multiple arms to a conditional and some of them
>> 	require braces, enclose even a single line block in braces for
>> 	consistency.
>> And other code from setup.c:
>> 	from function get_common_dir:
>> 		if (!has_common) {
>> 			/* several commands */
>> 		} else {
>> 			free(candidate->work_tree);
>> 		}
>> 	from function get_common_dir_noenv:
>> 		if (file_exists(path.buf)) {
>> 			/* several commands */
>> 		} else {
>> 			strbuf_addstr(sb, gitdir);
>> 		}
>>
>> > In short: I think your patch does the right thing, and I hope that you
>> > find my suggestions to improve the patch useful.
>>
>> I fixed the patch according to your suggestions.
>>
>>
>> Signed-off-by: Vadim Petrov <tridronet@yandex.ru>
>> ---
>>  setup.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/setup.c b/setup.c
>> index 8cc34186c..1a414c256 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -27,26 +27,26 @@ static int abspath_part_inside_repo(char *path)
>>  {
>>  	size_t len;
>>  	size_t wtlen;
>>  	char *path0;
>>  	int off;
>>  	const char *work_tree = get_git_work_tree();
>>
>>  	if (!work_tree)
>>  		return -1;
>>  	wtlen = strlen(work_tree);
>>  	len = strlen(path);
>> -	off = offset_1st_component(path);
>>
>> -	/* check if work tree is already the prefix */
>> -	if (wtlen <= len && !strncmp(path, work_tree, wtlen)) {
>> +	if (wtlen > len || strncmp(path, work_tree, wtlen))
>> +		off = offset_1st_component(path);
>> +	else { /* check if work tree is already the prefix */
>>  		if (path[wtlen] == '/') {
>>  			memmove(path, path + wtlen + 1, len - wtlen);
>>  			return 0;
>>  		} else if (path[wtlen - 1] == '/' || path[wtlen] == '\0') {
>>  			/* work tree is the root, or the whole path */
>>  			memmove(path, path + wtlen, len - wtlen + 1);
>>  			return 0;
>>  		}
>>  		/* work tree might match beginning of a symlink to work tree */
>>  		off = wtlen;
>>  	}
>> --
>> 2.15.1.433.g936d1b989
