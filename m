Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 489851F405
	for <e@80x24.org>; Wed, 19 Dec 2018 18:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbeLSSv4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 13:51:56 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34534 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbeLSSvz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 13:51:55 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so17887207ede.1
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 10:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=op7lxStH1sMYJ/r0v71rMa+lMjNaGzsQhToIjDvR52c=;
        b=fbYnfyeBBnZaVzqejYF0dABAWsYPyeqWEG30WtWAkyIHqioiFRXBWU/+Ew2f3O3/No
         EROpVAVCT1HnPfMVUasp5bSbH0QmHQ+UKuqP5B2SsWrDGzIq7LuuEZH5VZDgr9+RWTJh
         4QFvNNmHBGAR8qMDPL0dPCgleZjyvqKn5DwTzxGYA4JSa7F5WkVc1GFpx5NzRZMIg3uF
         lafUlcOSO85QiYaelB4UZDQY7cginmlBVzLBENf/kq9m6294V2rqR4Bxdr33qSIhXlcc
         IhlaZz3DtOaBZ2RTcUVwNynateseN0/V3JhcMWZDpZPIcbLA0I/vTEJXJoum58xo7rce
         axpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=op7lxStH1sMYJ/r0v71rMa+lMjNaGzsQhToIjDvR52c=;
        b=qc3maXEPRifGOpUWpzAcSjYWK5RRTzrVoSbGfxE3rhRFXFIw9i3/GcM2NileOcbUSb
         HUMq32bdLcV3qRD0hw5JjsbXUyxiZgVaGzAsCPTw/KUkqEloDDYNeQagEE/NkDxkjx0R
         QL1DyVuWTCi3SshBajC/ytedrDQNITEwaGX1LLMRGUP4aRGGHZbbMulICJPEq8nj4BNz
         Fpcw4l5pvC4L76gsmOaHkCIwDVkylEeTQR28wVY+EO5aWX6AvsZ9ImkKlyxXuQJABI7H
         /Af5uGafuXxmZdww8nU469llQRMtZbabxNeazzbfL9990UxSAhNb0feJe3bBUqGFbmlq
         lrhg==
X-Gm-Message-State: AA+aEWaE6mkbRKQZMXh3wTjsbqZP09QYdTbfNwuo4E66gcEoT4vP3AS0
        M/ohppXeEThpwkNzk7cGVpA=
X-Google-Smtp-Source: AFSGD/XIIK43pAOzD1ohbjqtQzEMIiTguTWQbymQBGyOM8YF514UBadJuYS1mDxnxrPtSZmiWavYxg==
X-Received: by 2002:a17:906:5e46:: with SMTP id b6-v6mr14784023eju.44.1545245513368;
        Wed, 19 Dec 2018 10:51:53 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id n10sm5494356edq.33.2018.12.19.10.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 10:51:51 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Referring to commits in commit messages
References: <20181217165957.GA60293@google.com> <877eg5fwd5.fsf@evledraar.gmail.com> <20181219182216.GA17309@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181219182216.GA17309@sigill.intra.peff.net>
Date:   Wed, 19 Dec 2018 19:52:01 +0100
Message-ID: <875zvpfiy6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 19 2018, Jeff King wrote:

> On Wed, Dec 19, 2018 at 03:02:14PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
>> On Mon, Dec 17 2018, Jonathan Nieder wrote:
>>
>> > v2.11.0-rc3~3^2~1 (stripspace: respect repository config, 2016-11-21)
>>
>> Minor nit not just on this patch, but your patches in general: I think
>> you're the only one using this type of template instead of the `%h
>> ("%s", %ad)` format documented in SubmittingPatches.
>>
>> I've had at least a couple of cases where I've git log --grep=<abbr sha>
>> and missed a commit of yours when you referred to another commit.
>>
>> E.g. when composing
>> https://public-inbox.org/git/878t0lfwrj.fsf@evledraar.gmail.com/ I
>> remembered PERLLIB_EXTRA went back & forth between
>> working/breaking/working with your/my/your patch, so:
>>
>>     git log --grep=0386dd37b1
>>
>> Just found the chain up to my breaking change, but not your 7a7bfc7adc,
>> which refers to that commit as v1.9-rc0~88^2.
>>
>> Maybe this is really a feature request. I.e. maybe we should have some
>> mode where --grep=<commitish> will be combined with some mode where we
>> try to find various forms of <commitish> in commit messages, then
>> normalize & match them....
>
> That would help when you're using --grep, but not other things that are
> trying to parse the commit message. Two instances I've noticed:
>
>   - web interfaces like GitHub won't linkify this type of reference
>     (whereas they will for something that looks like a hex object id)

I wonder if we had some canonical plumbing combination of to `git
cat-file -p` and/or a utility like git-interpret-trailers that would
take a commit message and spew out BEGIN/END/SHA-1 positions for
commitish that we found whether sites like GitHub would use it.

They'd still need to do a second pass to for any of their own markup,
e.g. the elsewhere@<commitish> syntax, or referring to PRs/MRs issues
etc....

>   - my terminal makes it easy to select hex strings, but doesn't
>     understand this git-describe output :)
>
> These tools _could_ be taught a regex like /v(\d+.)(-rc\d+)?([~^]+d)*/.
> But matching hex strings is a lot simpler, and works across many
> projects.
>
> So I agree with you that this git-describe format is less convenient for
> readers, but my preferred solution is to use a different format, rather
> than try to teach every reading tool to be more clever.
>
> As far as I can tell, the main advantage of using "v2.11.0-rc3~3^2~1"
> over its hex id is that it gives a better sense in time of which Git
> version we're talking about.  The date in the parentheses does something
> similar for wall-clock time, but it's left to the reader to map that to
> a Git version if they choose.
>
> Personally, I find the wall-clock time to be enough, since usually what
> I want to know is "how ancient is this". And in the rare instance that I
> care about the containing version, it's not a big deal to use "git tag
> --contains".  If we really want to convey that information in the text,
> I think it would be reasonable to say something like:
>
>   In commit 1234abcd (the subject line, 2016-01-01, v2.11.0), we did
>   blah blah blah
>
> with a few simple rules:
>
>   - only mention a single version, the oldest one that contains the
>     commit[1]. If it's in v2.11.1, we can infer that it's in v2.12.0,
>     etc.
>
>   - only mention released commits; for the granularity we're talking
>     about here, the distinction between v2.11.0 and v2.11.0-rc3 is not
>     important
>
>   - if it hasn't been in a released version, don't include a version at
>     all.
>
> That's probably over-engineering, and I'm perfectly fine with the
> oid/subject/date format most people use. Just trying to give an option
> if people really think the tag name is useful.
>
> -Peff
>
> [1] I usually compute the containing version with:
>
>       $ git help has
>       'has' is aliased to '!f() { git tag --contains "$@" | grep ^v | grep -v -- -rc | sort -V | head -1; }; f'
>
>     though I suspect it could be done these days with fewer processes
>     using "tag --sort".
