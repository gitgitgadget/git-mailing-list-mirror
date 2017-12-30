Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 989AD1F428
	for <e@80x24.org>; Sat, 30 Dec 2017 15:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750984AbdL3PEy (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Dec 2017 10:04:54 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:33462 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbdL3PEx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Dec 2017 10:04:53 -0500
Received: by mail-wr0-f178.google.com with SMTP id v21so32951543wrc.0
        for <git@vger.kernel.org>; Sat, 30 Dec 2017 07:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=miqcNOgPtQQ+QrPo2FhioK4zoudlMDjUpIbnn3j/fgs=;
        b=UQno+j7Ky+9SMCmxlkHabmpHhEWSJZX7mPiK8TkZwPewxAbXPhZFn9ccFQcvVeXMrF
         Lj9vaUfhp6qyPQprjmSavPOVkQq0YnJCxJZ8DqKh2+b6wJQcFskf2fh7tU1CY0Xhs+AY
         sBb3I2wOR1LL3i247xWCI2ODzRazFcfGxksOQadOZJOQvC/nrY05NFir0ebck5wOR+Gp
         PAhP0kff5MBQtCtFyqwH+TTnjvYSRunEDjb4VwWQ4apT2xoqCrGpgBHGGgVGXhukW6YY
         3sNWkEYj73ng2GR1nlA3k+5QhRdAoGFLN/kEYBzUQ0xr5dj48ViyezldBZNG3KJ6DPjE
         4Eag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=miqcNOgPtQQ+QrPo2FhioK4zoudlMDjUpIbnn3j/fgs=;
        b=sd9f8mRJOvesF8hJbldd2tVfNTjdyh4fw3ZHMrQ4OpJREypV1FMGqmt0C5DP76daZW
         vl8WH0euX0pj9xVL+tKl9lbXt7IRbVnzsgS9AZuQ0eyRYgWFjuC4FZ2bRlyxwd7BEzY/
         M+eNJQVCZh2Muk/9zBGDmoDBwdu72hZL/BdRzzDKhDSXIyJePDfYWTMgIsO2PRLKTYfK
         IfL4RFMR25yW6J9vGglHWccjLWR3ArCxY7sNLZeQ4rMI4ShQiPuWJzXmDe9HpcS6zV74
         WRp/d9bmlajP1DNej6AgMV04N9fON70S9/zo4ogUVziJah05X+3sOdbANuv/la844Qto
         i28g==
X-Gm-Message-State: AKGB3mKWYK3YV/J+j0kWK4VshZLVSIt8atP3BAVAlm3QEbaoV6xICzXG
        tRNip9I2y6IDJEpujcVbSaFRCdQv
X-Google-Smtp-Source: ACJfBoutRDoDCb09mxSfVQCtWtIKePio4aVNA9Dx22ObuSeKBIvgTK67p8QlH9s0v0nM1857gQCYGQ==
X-Received: by 10.223.148.97 with SMTP id 88mr38191274wrq.265.1514646292411;
        Sat, 30 Dec 2017 07:04:52 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id y42sm57862325wrc.96.2017.12.30.07.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Dec 2017 07:04:51 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, Zefram <zefram@fysh.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] diff-tree: obey the color.ui configuration
References: <87zi616vgf.fsf@evledraar.gmail.com> <20171229225121.13805-1-avarab@gmail.com> <20171229231631.GS3693@zaya.teonanacatl.net> <20171230015533.GA27130@sigill.intra.peff.net> <87tvw875vh.fsf@evledraar.gmail.com> <20171230144505.GA29252@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171230144505.GA29252@sigill.intra.peff.net>
Date:   Sat, 30 Dec 2017 16:04:50 +0100
Message-ID: <87po6w6yul.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 30 2017, Jeff King jotted:

> On Sat, Dec 30, 2017 at 01:33:06PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
>> >   - we ended up with 33c643bb08 (Revert "color: check color.ui in
>> >     git_default_config()", 2017-10-13), which just reverts the whole
>> >     mess back to the pre-v2.14 state. This shipped in v2.15.
>>
>> Thanks. What a mess.
>>
>> I haven't tried that add-interactive case you mentioned, an earlier
>> version of this patch where I tried adding the color detection in
>> git_diff_basic_config() did break one of its tests, but not my ptch, but
>> it's probably still broken with =always (haven't tested.
>
> It should break a test, since I added one in 33c643bb083. :)

Right, the one I tried first broke that, but not this version....

> That covers "add -p", though, which only does diff-files under the hood.
> You can convince it to run "diff-index", too, but I don't think
> diff-tree. So technically your patch doesn't break add--interactive, but
> probably does break some other script we don't know about. ;)

...Yeah, for sure.

>> > So I don't think we want to go down that road again. If anything, we
>> > want to either fix the original sin from 4c7f1819b3, or we want to do
>> > the "respect only never" hack.
>>
>> Getting back to the bug report that prompted this whole thing, wouldn't
>> the easiest solution just to run "git show --stat $commit" instead of
>> "git diff-tree --pretty $commit" when bisect wants to report the commit
>> it found?
>>
>> I've always thought the output was a bit ugly, it's plumbing command, so
>> why wouldn't we just show the commit as the user usually prefers to see
>> commits?
>
> I like that solution. I've often found the output ugly, too. And in
> particular, it doesn't show any output at all for merge commits. Doing
> "diff-tree --cc --stat" would be the minimal output improvement there.
>
> I do like the idea of using "show", though. We know the point is to show
> the output to the user, so we don't mind at all if the behavior or
> output of show changes in future versions (unless we consider the final
> output of bisect to be machine-readable, but I certainly don't).

Not knowing the internal APIs for that well, is this basically a matter
of copy/pasting (or factoring out into a function), some of this:

    git grep -W cmd_show -- builtin/log.c

I.e. boilerplate + calling cmd_log_walk() to yield a result similar to
e22278c0a0 ("bisect: display first bad commit without forking a new
process", 2009-05-28).

Or is it preferred to just fake up argc/argv and call cmd_show()
directly? I haven't seen many examples of that in the codebase:

    git grep -W '(return|=)\s*cmd.*argc' -- '*.c'

But I don't see why it wouldn't work, the cmd_show() doesn't call exit()
itself, and we're right about to call exit anyway when our current
diff-tree invocation is called.
