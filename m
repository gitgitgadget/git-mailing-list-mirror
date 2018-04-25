Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C71CE1F404
	for <e@80x24.org>; Wed, 25 Apr 2018 08:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbeDYIlY (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 04:41:24 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:40119 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeDYIlV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 04:41:21 -0400
Received: by mail-wm0-f51.google.com with SMTP id j5so5325844wme.5
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 01:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0L5mNIl1ppGqNFO+g08kHaEYFOfdOUXUptT2bYX2gZk=;
        b=N+gRN/HRLOspO7Dq9RL7E5cMQXhtQBbm/TKW4ItNoWtMC9U1cJRy+68e+4GnnfxgPR
         VlAwKJNwii4VBq5tESKbxPulT+HzCptWSRJ/ZGL/5UVzSD93dSdIkLQFi7JHnTh3A1oj
         lfMM06NajiOIeIf15k8yDLSdBwTGPThZwAwFHoblyiR2vuRVpEcUyjMxYo2HWjoEGZn1
         pyBCPnEJZ1GChPjUQbAnWbwUg/0phrRXSZiaSRxXIkDQ+UnuLy07K2AoLDj0SdlUZuS0
         5KaXqwW6qApyS3plXeY/FVYF1krGwmi7XVTEbUFHWCWlj1ZS8Mqt7eFtqUb0wUH9T6zf
         GB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=0L5mNIl1ppGqNFO+g08kHaEYFOfdOUXUptT2bYX2gZk=;
        b=Cq1NENifpsXfpssmYiLXkAKzl6eedQIwpbrnG2w4j5oah6TmT41q2MEI4qLT7qO94R
         cZMFYE1AuEIRTM18dbtGPaCqJhaze7nnDxgiLA4a1MkgIzXs7055qu3s/18Wsm/kkgYS
         tiub8D0DXw5jL8zCAkC6kKhQYk+RNzdBYOUSS02kr6oMMR5RCoXsIvDj/dvwqAtq6fKg
         vDBkJg5NAQPaVX72kihCF7uZZxmw3XEPMmmzJKIAeXkal3Z7V2Qjwb9LTd6AbMa2IIjD
         zaM33XOasG9DBgSZchiSXNO+wkkVxVAcO1XhHPd/pv/JeLj2/2BIzei9UOYN6J9Eig4e
         1UHw==
X-Gm-Message-State: ALQs6tBJV06PTTnYqaE5ZuddDz9nmwYiitkJzsouxhT41yrqCNDZ6VuL
        a6fKGyUWDm6akFilBSPmqCg=
X-Google-Smtp-Source: AB8JxZo9Vv+qdjRP8nq50dduE1itxRvJGxb4PLuIi1h3Oj+BK/U6S4rpSqCIyJtOy4DF/t/4dd/wZA==
X-Received: by 10.80.162.69 with SMTP id 63mr3026994edl.295.1524645680381;
        Wed, 25 Apr 2018 01:41:20 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id 60sm8761020edy.10.2018.04.25.01.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 01:41:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>,
        =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
References: <20180413170129.15310-1-mgorny@gentoo.org>
        <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
        <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 25 Apr 2018 10:41:18 +0200
Message-ID: <871sf3el01.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 23 2018, Junio C. Hamano wrote:

> "Robin H. Johnson" <robbat2@gentoo.org> writes:
>
>> On Fri, Apr 13, 2018 at 07:01:29PM +0200, Michał Górny wrote:
>>> Currently git does not control mtimes of files being checked out.  This
>>> means that the only assumption you could make is that all files created
>>> or modified within a single checkout action will have mtime between
>>> start time and end time of this checkout.  The relations between mtimes
>>> of different files depend on the order in which they are checked out,
>>> filesystem speed and timestamp precision.
>>> ...
>> Junio: ping for review or inclusion of this patch?
>
> I personally did not think this is a good idea and not worth any
> code contamination with calls to utime().  Is there anybody sane who
> thought this was a good idea in the discussion thread?

I think given that this keeps coming up it would be nice if Git had some
easy facility to do this type of thing, because it's clearly a common
use-case, but I don't think this is the route that should be taken.

By doing it this way we're imposing a fixed cost on checkouts for people
who don't care about this, and this will be mutually exclusive with
other potential approaches.

I think a sane path towards something like this is closer to:

 1. Add ability to have multiple hooks, similar to what I had as a WIP
    in
    https://public-inbox.org/git/CACBZZX6j6q2DUN_Z-Pnent1u714dVNPFBrL_PiEQyLmCzLUVxg@mail.gmail.com/
    and what
    e.g. https://docs.gitlab.com/ee/administration/custom_hooks.html
    implements (partially) in the wild.

 2. Add some config so we can have hook search paths, and ship with a
    default search path for hooks shipped with git.

 3. Then users can trivially enable e.g the
    post-checkout-consistent-mtimes hook, which could either ship with
    git itself, or be its own project.

As it is we've had several threads recently where people have wanted
different mtime solutions, e.g. consistent mtimes within one checkout,
or the mtime of when the file was last changed according to git etc.

I don't think it's a sane approach that the git checkout code learn to
do all of that natively, but I *do* think it's sane that we improve hook
support so we can run whatever custom logic people want at the right
time, which could run around re-setting mtimes.
