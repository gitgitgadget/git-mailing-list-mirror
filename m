Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EDB420374
	for <e@80x24.org>; Tue, 16 Apr 2019 07:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfDPHs6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 03:48:58 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:35576 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfDPHs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 03:48:57 -0400
Received: by mail-io1-f51.google.com with SMTP id p16so16896310iod.2
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 00:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MHuYQ9xZd2BC/6dO7noqoP7zy2V3MxuBT7/jcyoybEs=;
        b=HJd0lT0Pf/FCwMkt479I2a3NLIZctu/4kDLCApXvTzUli+hGPpb0Xs3p2eBTGIOXcF
         iUFkCBTBGGGzcPx0o7gc03k2HOnY3F8A9VkvH6WhR2LS932hXwcJ1GxwHqphmGqkA92C
         ozrWJL4zTi99bIUFmlVAVGiVkxNITyFK7IX3JaPWcsWpw5Zu4Gkwn8msDjvnPxL7qN/o
         1TjQzgwV5JW2cH4SAzjgWLION2NDD1i4aa2eaKJxnEdGgEgYlahMeWfMOybUe/peTZyd
         x9dq28HKpZyJV19KO2jhy7/LgAOMhxb48Wn9Vztuy+nyJk4S2Qalru+gdhw7YXHH5zcl
         ygug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MHuYQ9xZd2BC/6dO7noqoP7zy2V3MxuBT7/jcyoybEs=;
        b=n3vbg0i/jIsIauHcfdOkHkFk4/t+Naa869VDgtlvsDStR5iXlFrhsgtpgjXpKQWyVy
         ovmdSdAiWDCN9UOvccZcYmTW1MbEylE0COnruazWNmONypcu9kh7/iMm2p3Lrvy01RE8
         7yzf7o+bOw6phlnzzlnkl7hak1iDREaCjcD1CEVd6mcufHdWLT7eNEUvtQPGxI06pJL+
         4wCNTZOu8mNTDD3AYxxvFADJ87aztRkfTkxoU5eKqNnZ0MeyDNNXiJ7hVE81vbWcS46R
         OK/QseUBZPsLO9gPFEwCdq9Y2FsPUHmNC6XA2gAWk3tfAh9FfBQPZOuZrrC7B5ezA7mc
         38iw==
X-Gm-Message-State: APjAAAUaYj6NzASFlcFGywkTrzy5w2oY9ei4B23cROqCuqkMgg6r6sDj
        rZT612we4at+4kCAUzecFuQvZBbCuzgJx3/16ncMwg==
X-Google-Smtp-Source: APXvYqwC5+DnofhJ6At9aCxK6onrwaSFNtQMju21P3f8CFdBuEqJhfMSz3/99nrJl7URfBkxq9DaYatdE58nrxQ3Wdk=
X-Received: by 2002:a5d:840d:: with SMTP id i13mr45474115ion.186.1555400936891;
 Tue, 16 Apr 2019 00:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <robbat2-20180120T054223-685328376Z@orbis-terrarum.net>
 <robbat2-20190410T062730-540884809Z@orbis-terrarum.net> <20190410111834.GA25638@ash>
 <CAODn77oL6sj5zvxgPGw=4TNqmnSeBq4=j2r2nx_51YHooECo7w@mail.gmail.com>
In-Reply-To: <CAODn77oL6sj5zvxgPGw=4TNqmnSeBq4=j2r2nx_51YHooECo7w@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 16 Apr 2019 14:48:30 +0700
Message-ID: <CACsJy8AasZkzkR4apr1cywi1wpP92FOjAN2Oc7GYDYv4NPnXdQ@mail.gmail.com>
Subject: Re: regression AGAIN in output of git-pull --rebase
 --recurse-submodules=yes --quiet
To:     Paul Morelle <paul.morelle@gmail.com>
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        Prathamesh Chavan <pc44800@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 16, 2019 at 1:31 PM Paul Morelle <paul.morelle@gmail.com> wrote=
:
>> The problem here is the option parser of this command would try to
>> parse all options, so it considers both --quiet the same thing and are
>> to tell "submodule--foreach" to be quiet, the second --quiet is not
>> part of the "git pull" command anymore.
>>
>> So the fix would be to pass "--" to stop option parsing.
>> submodule--helper should not parse options it does not understand
>> anyway. Something like this should work.
>
>
> My expectation as a user (and probably Robin's too) would be that `git su=
bmodule foreach` stops parsing arguments at `--` or at the first not-recogn=
ized argument, whichever is encountered first. The rest of the arguments wo=
uld then be considered as the command.

I don't think I change any visible behavior though (or at least trying
not to). There are two command line parsers, the "front" one is in
git-submodule.sh and should do what you describe (or whatever the
current behavior is) and there's an internal one for "git
submodule--helper" which is more like internal API than anything.

The change here is to stop the internal parser from accidentally
interpret options that belong to the foreach's command. The "--" and
first non-recognized argument should be handled correctly by the front
parser.

The exact behavior of this front parser, I can't tell (I'm nowhere
near expert level of submodules) but yeah it should stop at either
`--` or the first non-option argument (e.g. something that does not
start with '-'). An argument that looks like an option (i.e. starts
with '-') but not recognized should result in an error. This is pretty
much standard behavior for all other commands, but I have not tested
this with git-submodule.sh.

> This would slightly break the retrocompatibility, but would also avoid si=
milar bugs in the future.
--=20
Duy
