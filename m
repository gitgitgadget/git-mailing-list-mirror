Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F13381F597
	for <e@80x24.org>; Thu, 19 Jul 2018 08:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbeGSInn (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 04:43:43 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:37110 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeGSInn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 04:43:43 -0400
Received: by mail-wr1-f53.google.com with SMTP id q10-v6so7074554wrd.4
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 01:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=OE2sBqs4anYzlEx0OwDeK/abXpag7AUrPBH2jZKQGEM=;
        b=ij6i7tVAXafjoGmxG+j4zkbISN/EtWaj7aQBXxYS/Yboz7R+8SQOdwQI7RfKZng86e
         h04fL8JZMP5tRdX1oARJX3YP0/DVHQiNPBvvgS6o2cj4jspk1Qq0wbN73wDiWth4kT4V
         HSlzpdHGwvn0at7X3uCvuC0uYfKSBUvVakAocZpH1KYIbuVA1iC/v8V8iPW+xnhJP3oR
         W9kl8Q83yzobtCxvcW/wzIvV5OpGkYC/9WgaJTl0LfMBAED8kv8olJHQVMIPeAcbNCKe
         HsSPJ9nG1gFuUVgclBdiwfBKqOuKJZpHpNH54IbB+TeESY//ipKK22xJTputeee6v9yp
         EPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=OE2sBqs4anYzlEx0OwDeK/abXpag7AUrPBH2jZKQGEM=;
        b=ByQcxRchJ3xFahvsOVkZlMd2edoqGeHR5rlCklsXO1YeXuCWdbVmsPAv09yEaR0YPa
         WCcJAELS0dN1a1vaZ/m8J+6tq5PVsCTVawGBpASPwDXqHJBw+zGnUOprHor0M/APWCTp
         8FRMZRYKN9UKjl3oTYg6MCq+1CzvcPcDe1oJcgZHa8cEzM8JKj5ZSHl6752Qgmx2udtt
         J4hu5ywTw6bLi4s6LR+FOhO0FL/AtFhH3/wIJiR3YZfIIzfUqD6aEUVW++b0+AqX/eGn
         IR36L15hDAqdsrYxu+2JSMuXVVbHBvoDyfDut3yfi1R5gJDNGHz2eNNiP1QQ+fydPrCT
         ewJA==
X-Gm-Message-State: AOUpUlFGLnsTElT4goBoE+TVKqF9suIkJamUXfve9frCt5wg5vJ7eL8R
        Hu52CB75dNo3vNy3I5yZvPC7NjH2WvY=
X-Google-Smtp-Source: AAOMgpdd5Z2V0zDtxpS0eDKfg7kmZE+bRbmkSu7PT3Qt8ciFUMsr/q8PH4GAZTgT84dLY8alkShyPg==
X-Received: by 2002:adf:e542:: with SMTP id z2-v6mr6709151wrm.40.1531987307794;
        Thu, 19 Jul 2018 01:01:47 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id z7-v6sm3715901wrh.85.2018.07.19.01.01.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 01:01:47 -0700 (PDT)
From:   =?utf-8?B?M8OGdmFyIEFybmZqw7Zyw7A=?= Bjarmason <avarab@gmail.com>
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     git@vger.kernel.org
Subject: Re: Q: Ignore ./foo, but not script/foo
References: <5B503FF0020000A10002C6B5@gwsmtp1.uni-regensburg.de>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <5B503FF0020000A10002C6B5@gwsmtp1.uni-regensburg.de>
Date:   Thu, 19 Jul 2018 10:01:46 +0200
Message-ID: <8736wfd579.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 19 2018, Ulrich Windl wrote:

> Hi!
>
> I have a (simple) question I could not answer elegantly from the gitignore(5) manual page:
>
> A project produces a "foo" binary in the root directory that I want to ignore (So I put "foo" into .gitignore)
> Unfortunately I found out taht I cannot have a "script/foo" added while "foo" is in .gitignore.
> So I changed "foo" to "./foo" in .gitignore. I can could add "script/foo", but now "foo" is not ignored any more!
>
> Is there as solution other than:?
> --
> foo
> !script/foo
> !bla/foo
> #etc.

The solution is to just do:

    echo /foo >.gitignore

Then it'll ignore the top-level /foo, but nothing else. How did you come
up with this "./" syntax? It's not understood by gitignore. From
gitignore(5):

   A leading slash matches the beginning of the pathname. For example,
   "/*.c" matches "cat-file.c" but not "mozilla-sha1/sha1.c".
