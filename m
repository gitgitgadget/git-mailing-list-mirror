Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C70001F404
	for <e@80x24.org>; Thu, 30 Aug 2018 18:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeH3Wwa (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 18:52:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54310 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeH3Wwa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 18:52:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so2963169wmb.4
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 11:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=mRlwrVZiyvCnP2wTyph+5KqJ/D9Ldimbvhd5PuBeEFg=;
        b=UuRlNHOFhE3FJ4px2TSaiJy5KGqBfLOAHXy6lUTjc3LYGHuMCEAKMwi2c0A/mh4bx0
         mVoSuz4jw49ue7k+MQ/XX0GU3fKu6PYWnVZXgbIllJH3MJL/oQM5hqZo0zpJZG63OAdn
         2kSCa9jx2NrhKUqYJlTD01KGdiAppXY57B/XP7+4+utOGqCQy7ab9HL1SEALPAVOKzgd
         EnPyUE4fNBa94TZqZ9V1F7s+at3NBvUhz2oGcxriC1Tb8x0YseuVU3Eof+EwUaLae2vE
         UPWQPMUHRYI1nEFjGmwOAfR10zw1+EA2tGF8RgVz5v8JZju3tErFHoRiMOzAeRqbKJRy
         ZOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=mRlwrVZiyvCnP2wTyph+5KqJ/D9Ldimbvhd5PuBeEFg=;
        b=PfGmWWfX1ogp9kc3h1RflMQvFeFocq2SB5mpNC+HpXrC4a73nuNh8V7lz5MZcH7lkd
         TqDrEY0FYXJ1BQGn/Ampl5wSAM42MtMMhdI/x2mJ5BmraQ/5jRVYjYML7tDfPOSvudg2
         8wR7n0itZvY6PVSPu8FTtaS1lDxgIihgWSmghfz1xGW914haDDXIXrlNcJXCb66VkuA1
         xsc6eLT9/QX+dxpk8SkW+Y5aVTPFCp9TlVLzBW/6j36Dw5kI/cCpKQAbCy1TpELeY8Lh
         PF8XJH3CAT28phC9FGjLgyy2pGkSp2mXZ+ThMoCuPXKDfb87m5dyoaqVIA6wOZOVNLBs
         90mg==
X-Gm-Message-State: APzg51A32tMGJQkKOuXD2jQNkREX8RMONfskSvOPUVrYaCUkIQpW/FvT
        EOZEpefVhXPxfjMVwg/Baf9shKLX
X-Google-Smtp-Source: ANB0Vda8Wktev7qcbOLsMzRrIvkRjYYcglZNQErOEw5L0sElWEy6qitvy6kid1YdOJb/3CW6/7dnKg==
X-Received: by 2002:a1c:8682:: with SMTP id i124-v6mr2763858wmd.77.1535654936564;
        Thu, 30 Aug 2018 11:48:56 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e7-v6sm5852025wru.46.2018.08.30.11.48.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 11:48:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v2 4/4] branch: make "-l" a synonym for "--list"
References: <20180622092327.GA8361@sigill.intra.peff.net>
        <20180622092459.GD13573@sigill.intra.peff.net>
        <87wos8cjt8.fsf@evledraar.gmail.com>
Date:   Thu, 30 Aug 2018 11:48:55 -0700
In-Reply-To: <87wos8cjt8.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 30 Aug 2018 10:58:27 +0200")
Message-ID: <xmqq4lfb667c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> +-l::
>>  --list::
>>  	List branches.  With optional `<pattern>...`, e.g. `git
>>  	branch --list 'maint-*'`, list only the branches that match
>
> I think it's better to have something like this on top:
>
>     diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
>     index 5552dfcec3..a03cb1ebc9 100644
>     --- a/Documentation/git-branch.txt
>     +++ b/Documentation/git-branch.txt
>     @@ -163,6 +163,11 @@ This option is only applicable in non-verbose mode.
>      This should not be confused with `git branch -l <branchname>`,
>      which creates a branch named `<branchname>` with a reflog.
>      See `--create-reflog` above for details.
>     ++
>     +
>     +Until Git version 2.20 `-l` was the short form of
>     +`--create-reflog`. As of version 2.19 using it would warn about a
>     +future deprecation.

Doesn't your patch show a more grave issue with the current state of
'next'?

The sentence in the pre-context in your suggested patch says that
"--list" should not be confused with "git branch -l <branchname>",
but --list and -l are now synonyms in the new world order.

Worse yet, '-l' is no longer a way to create the branch with a
reflog; in the new world, you would say "--create-reflog" if you
want to do so.  "git branch -l foo" would list branches that match
that pattern 'foo'.

In the SYNOPSIS section we still see "[-l]" listed; that also must
be replaced with "--create-reflog", or just dropped, as that is the
default.

I do not know if the documentation that is shipped in 2.20 should
talk about how the old world looked like, though.  `-l` was a short
for `--create-reflog` is worth saying, but I do not see much value
in talking about the warning given in 2.19.

Thanks.

