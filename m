Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,URIBL_RED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B7A82098B
	for <e@80x24.org>; Mon, 17 Oct 2016 03:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754582AbcJQDHu (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 23:07:50 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33841 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753952AbcJQDHt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 23:07:49 -0400
Received: by mail-qk0-f180.google.com with SMTP id f128so202733809qkb.1
        for <git@vger.kernel.org>; Sun, 16 Oct 2016 20:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TKXMt4niMoeACnSsNWAvkunMygyn7kU+oxJq+OUYa5A=;
        b=f1+2wQkqfp+udSZb8XqwXCMAX0cj3Ti21m5luQ8Z0/ZUwrH0PEdB7SkI4w7mBITUrF
         7TvhuaXEwxIpOWeXylrOGmudLS3XWWEoSmGs/QzMhMXpzG72VTkaADsjiaCyivGBvk1L
         Se5jihNchGI/LxucsyxpQiJ4A9Gg8UGowUCJvLPWs4//js7am+baImYYkwhLtHQDGd3X
         LkTCjr4tQCaJHbIi5WDAn71qRv8BP9kDysoyA3UKMNOb8krT4mOSv8rl9aAkmslMSHov
         kqC9Y5ksbVTB99vhvXeCKlr2OrG436kXDwrROAZwvsJx142bzcdgIZ+utlYHyVdFUibY
         edlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TKXMt4niMoeACnSsNWAvkunMygyn7kU+oxJq+OUYa5A=;
        b=j4sYKahjiqk9GzCVJejlVvxyC6Bd6p4lA4t2Ye0GfqE+7Ee5vHR+1SPX7M/7sgdAvB
         PtrPFyHFz4j5rF+o87VrIMw1JrK6+0WzTrrro6PYUUJn7iKLo2I/mPvQGZOpZuEfErDF
         zGVeZDV3eXJbAdKmDUF1EbGyUgK0ct1RuFWwqDF0yevq9n2UQQM6JmNBsjufg7WIQ7++
         f0UXXRro5jf8G75B7w0MnCWE0d5SKGXCWMlnjPYxUlmGWTnrwtbn+VDSwFCBIFCuy2eq
         zLH9O4I3CMlmV0aaWrxhoLW0LzM0IUQdxPMlcpVtBQchaO18GCs8CDCiR8JdZcEYil4C
         p/lw==
X-Gm-Message-State: AA6/9RmPZ2WhfEJuzB2AvOP1cyl1PTBVg8N2kHpZqBfmofABNsx/sY3hrD1spqFLYCnfGoE0sGNK92+w/MVBiG/X
X-Received: by 10.55.64.80 with SMTP id n77mr24748745qka.173.1476673667945;
 Sun, 16 Oct 2016 20:07:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Sun, 16 Oct 2016 20:07:47 -0700 (PDT)
In-Reply-To: <C83BE22D-EAC8-49E2-AEE3-22D4A99AE205@gmail.com>
References: <C83BE22D-EAC8-49E2-AEE3-22D4A99AE205@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sun, 16 Oct 2016 20:07:47 -0700
Message-ID: <CAGZ79kZ6KaQ5gjGiEFQ-pRJCDAyS0oH=_4dK0nCU9hx8wZwdfw@mail.gmail.com>
Subject: Re: [RFC] Case insensitive Git attributes
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 16, 2016 at 6:04 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> Hi,
>
> Git attributes for path names are generally case sensitive. However, on
> a case insensitive file system (e.g. macOS/Windows) they appear to be
> case insensitive (`*.bar` would match `foo.bar` and `foo.BAR`). That
> works great until a Git users joins the party with a case sensitive file
> system. For this Git user only files that match the exact case of the
> attribute pattern get the attributes (only `foo.bar`).
>
> This inconsistent behavior can confuse Git users. An advanced Git user
> could use a glob pattern (e.g. `*.[bB][aA][rR]) to match files in a
> case insensitive way. However, this can get confusing quickly, too.
>
> I wonder if we can do something about this. One idea could be to add an
> attribute "case-sensitive" (or "caseSensitive") and set it to false
> (if desired) for all files in .gitattributes for a given repo.

FYI: I am currently refactoring the attr subsystem (e.g.
https://public-inbox.org/git/20161012224109.23410-1-sbeller@google.com/
"attr: convert to new threadsafe API")

>
> ### .gitattributes example ###
>
> * case-sensitive=false

Would this modify the current file only or the whole stack of attrs?
(In just one way or the whole stack, i.e. can you add this in .git/info/exclude
and the attribute file in the home dir also behaves differently? Or rather the
other way round when the system wide attr file enables case insensitivity,
each repository local config is set automatically? both ways?)

> *.bar something
>
> ###
>
> I haven't looked into the feasibility of an implementation, yet. However,
> would that be an acceptable approach?

Conceptually I would prefer if we had a single switch that indicates a
case insensitive FS. That could be used for different purposes as well,
that are FS relevant such as checking in, checking out/renaming files
in the working tree? (does any such switch already exist for case
sensitivity?)

Thanks,
Stefan

>
> Thanks,
> Lars
>
>
>
