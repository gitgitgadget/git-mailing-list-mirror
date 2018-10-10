Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E92C1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 20:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbeJKEXn (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 00:23:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37943 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeJKEXn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 00:23:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id c1-v6so6243271ede.5
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 13:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Z1mF9rSDZF6x3zD2kILaSQtoBFDkVs6k0+NPLiIBubs=;
        b=DHnhcJcE8tk37wl3TB11nKHQsq1QI+9FQDboAi0NV26PmOVNVBKOy3bljsqQ2Ne+/h
         X9cdbl4QFReAVj4HcsFIl6uFdOckuCPp6AI6lu78pbsXqT0N5apCauDuRv/orQr2orq8
         M8RSzlSHSon0quV+QAak78l9AaBioXeKdx32MlvI8i5npPKBv9h8pJFutB/wR1l/HGgB
         AfP3BwTt9k7HoSS3G3DM5fa+28MlgSOSec9lJ4nEB8Nbc5HI2dt1Mv/e51tO8P0ZfR5C
         Yz1qJ5DNUnIKmmxUaI3BajTUvYNEb6cg/6pBFBqT1m6DZ23LyOT8hFWDhe8CKXrT5iag
         AVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Z1mF9rSDZF6x3zD2kILaSQtoBFDkVs6k0+NPLiIBubs=;
        b=QtJwT/vpcwdfVJDbMDuqbVBp0D+tTS+f6eetRTDnPNEdDPv/HBqLSXZqAfCtRxweSl
         f+BfzACsi8VNcxJR0i4iy5uNWIXUW2hswLlBYq5jrTC5u0F8VYpwA+371zo9cxcS5+Ne
         YZMZQDE4YNC8JpGlzBVQ3rur7l4Kw9DeLgLIzUzEYpRoOlmv8pls+tkGKJYXChY3sMvO
         ijnOw4pRpaEY7AqCEdNksAk4Uvcg1As/xDvU0p21IrPmOToVUI/SOV0KrsRlmYUo8r2D
         jwv+scMfAjQbJuOz4pYmO4hhpcduuNv70RAHA5wYU9tPfTVfdJWcQjIgjuARpG8AX9HT
         zLZg==
X-Gm-Message-State: ABuFfoidsEJTf59nznxQYtWjWPsiEVzgth7GbwQzvFF/1PuyNEhUKDvJ
        yxftrno8hWa5XYzh1+3zaYM=
X-Google-Smtp-Source: ACcGV60M3tYm0bJw5txNtn0VUnuvc3TLZZ3fwRNcAQYc6NVoG0LckqFn6X5BcOyc9SwWF7drirEmRQ==
X-Received: by 2002:a05:6402:884:: with SMTP id e4mr45652097edy.1.1539205186917;
        Wed, 10 Oct 2018 13:59:46 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id j22-v6sm7455053edr.96.2018.10.10.13.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 13:59:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gc: introduce an --auto-exit-code option for undoing 3029970275
References: <20181010174624.GC8786@sigill.intra.peff.net> <20181010192732.13918-1-avarab@gmail.com> <20181010203531.GA12949@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181010203531.GA12949@sigill.intra.peff.net>
Date:   Wed, 10 Oct 2018 22:59:45 +0200
Message-ID: <87tvltecvy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 10 2018, Jeff King wrote:

> On Wed, Oct 10, 2018 at 07:27:32PM +0000, Ævar Arnfjörð Bjarmason wrote:
>
>> Add an --auto-exit-code variable and a corresponding 'gc.autoExitCode'
>> configuration option to optionally bring back the 'git gc --auto' exit
>> code behavior as it existed between 2.6.3..2.19.0 (inclusive).
>>
>> This was changed in 3029970275 ("gc: do not return error for prior
>> errors in daemonized mode", 2018-07-16). The motivation for that patch
>> was to appease 3rd party tools whose treatment of the 'git gc --auto'
>> exit code is different from that of git core where it has always been
>> ignored.
>
> OK. I wouldn't want to use this myself, but I think you've made clear
> why you find it useful. So I don't mind making it an optional behavior
> (and it probably beats you trying to poke at the logfile yourself).

[...]

> I'm not sure if the config is going to actually help that much, though.
> The callers within Git will generally ignore the exit code anyway. So
> for those cases, setting it will at best do nothing, and at worst it may
> confuse the few stragglers (e.g., the git-svn one under recent
> discussion).

Yeah git internals don't care, but we've never advertised the
combination of --auto and gc.autoDetach=true as being something
internal-only, so e.g. I wrote stuff expecting errors, and one might run
"git gc --auto" in a repo whose .git/objects state is uncertain to see
if it needed repack (and have a shell integration that reports
failures...).

> Callers who _are_ prepared to act on the exit code probably ought to
> just use --auto-exit-code in their invocation.
>
> That said, I'm not entirely opposed to the matching config. There's
> enough history here that somebody might want a sledgehammer setting to
> go back to the old behavior.

If it's not a config option then as git is upgraded I'll need to change
my across-server invocation to be some variant of checking git version,
then etiher using the --auto-exit-code option or not (which'll error on
older gits). Easier to be able to just drop in a config setting before
the upgrade.
