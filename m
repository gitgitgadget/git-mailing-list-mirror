Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2D391F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 08:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeJLQNY (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 12:13:24 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:51442 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbeJLQNX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 12:13:23 -0400
Received: by mail-wm1-f54.google.com with SMTP id 143-v6so11429968wmf.1
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 01:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=U8irCWCx0PUaoK0y+y+0Gm+x+d7l1dkPkZLYD3tK5LY=;
        b=NYEqbV38HC9lyD2CBuRvSk73/ZfAfLm6Zmn3zEaT2A4+w5RDW9neK7IHiO6uZjc0d4
         4UkjyFwBAyhp5acPm8zQUkikN44DI3nxcEDlMKtMV/Uzlf6eu+ZDDImsolSgFD3RKmex
         DHcLj8ytmy1VLYJvppz9aPRV1IjbZj01TxvOcDiY0hri1YrS4COUd7gMmn2ObHN8DMXV
         Nl4OOZzy/xm6YWB+ZukWfbQKkcK2dWso89nyeb8Y8cdjEd4EhQ3u+0EhcVW6l5mJiWPB
         YmU+/QzxizkdB1pEaSlRvrisu4s0y+WKBV38tHxHWcO4XYPANRBoAPPFZ0IYoWIAKjZt
         Q8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=U8irCWCx0PUaoK0y+y+0Gm+x+d7l1dkPkZLYD3tK5LY=;
        b=RNrCQn6bq38DJgDVT8Z/eVRGCns+mPbzZ1qg11nYh7LhYf+79Gb1YqdRev90pE4vXk
         O3xv+fwk4w/k9Uo3NPSizsSJukdwyG7pFOAsUH/ma+m0ZSB9+Z6rG5SQQzLgJWytg9YF
         02c53XVH0tliZn/UFbhyoWaKAug0M7YXqwWxr66CGZtjySlpU8JOL7am+pDKqHAnYy+E
         3rBoY3oEtzCWZokEavyyF/9v9qSiKWS4+HxV7k7VhT6Dea1eUC3FmcfKkSq+Ss1SkFaz
         u73Mn4Sr2GnWd+uK0Jxr+XhX6V/n/FnVNamzk3kaqbpKp03MnW5ciT0fqcWNQOQbaZ2I
         D9wA==
X-Gm-Message-State: ABuFfognYBvotnnrclGSJqtI0V70Zyg5y39RM5T/bcNE9CkAzpt9zQJe
        CC9SmjrHWKx3K7fDOlI2s/Q=
X-Google-Smtp-Source: ACcGV60QI7LyLh4EvY3uEk1Aeg9X/GN8ccSuZg9ZHPxpg8G0hI17KNAX+zsLxXnULQvJ39SCCNTJDw==
X-Received: by 2002:a1c:c2c3:: with SMTP id s186-v6mr4458389wmf.16.1539333720081;
        Fri, 12 Oct 2018 01:42:00 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y65-v6sm570310wmg.40.2018.10.12.01.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 01:41:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Ananya Krishna Maram <ananyakittu1997@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] [Outreachy] git/userdiff.c fix regex pattern error
References: <20181004113015.GA30901@manohar-ssh>
        <nycvar.QRO.7.76.6.1810041624290.73@tvgsbejvaqbjf.bet>
        <CA+=o6KFN-p901GiJzj5BquU2RKCVTOKarGpjjuqsASN_uqGZSQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.1810041718480.73@tvgsbejvaqbjf.bet>
        <CA+=o6KHxwYdYsvFDzBaG1q2jvgtN5f4LruD5k=dqei8workWfQ@mail.gmail.com>
        <xmqq7eiuwsm7.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810120955090.45@tvgsbejvaqbjf.bet>
Date:   Fri, 12 Oct 2018 17:41:58 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1810120955090.45@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 12 Oct 2018 09:57:25 +0200 (DST)")
Message-ID: <xmqqftxbblpl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 7 Oct 2018, Junio C Hamano wrote:
>
>> And then there is an unnamed misdesigned language that has a
>> regmatch() function, which takes a string that contains a regular
>> expression, but somehow requires that string to begin and end with a
>> slash for no justifiable reason ;-).
>
> It makes more sense once you realize that /<regexp>/ is a very nice
> syntactic construct to obtain an instance of a regular expression object,
> rather than a string describing one.

In Perl, qr/<regexp>/ is often how you use that syntactic construct.

The unnamed misdesigned language literally uses a string whose
content is /<regexp>/; iow, 

	preg_match('/a.*b/', ...)

is what you see, and there is no "regex object involved.  As far as
the function is concerned, it is receiving a string, that represents
a regexp.  There is no reason to require the pattern _string_ to
begin and end with slash, but somehow they do.

> But in C, we do not have objects, so the way to describe a regular
> expression is a string (which you have to compile into an opaque data
> structure before applying it).

Absolutely.  C does not have regexp object literal and the literal
you write to represent a regexp is just a string that you would pass
to functions like regcomp().  But at least C is not so brain-dead to
require slashes on either end of that string ;-)
