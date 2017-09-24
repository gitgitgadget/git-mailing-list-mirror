Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C54E520A26
	for <e@80x24.org>; Sun, 24 Sep 2017 19:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752797AbdIXT7a (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 15:59:30 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36560 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752758AbdIXT73 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 15:59:29 -0400
Received: by mail-pf0-f196.google.com with SMTP id f84so2760349pfj.3
        for <git@vger.kernel.org>; Sun, 24 Sep 2017 12:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zTIjEJ0HkuMtuMxyjWyre9jz/1CUJN5CCCj0jHLfdmM=;
        b=THp0jEgEr9f6qNpIrIq+IRx59hJzQ8bPQj6Wcc4iBciEHhUAoR3RKW6Co6wGkqe5eJ
         d9M1QMZy6UCqICViRtgRYu9axNk7BmvagcbLi4yO//ugkqn20SIDbRpqk+B69xkpb+ce
         frRAT8yBpoeaMa4jibir/apCrGfRKw7wzcRXRwnZJwHF+TcUrbY0kVVJJ2PneLKjtJzM
         tG6tTfj5Cozp8qjW4bmLNEGl5B9kmZ9lLTcsplYEIAAvhDfPbU9sRC+RRFKD/C4zyRJ6
         fgKwhqCCuHSvgO/Sl7E9A/eUl+f7iU3DL6ERpor+G+I7KUvbgwaBux28Nx7/BE0vSjbs
         rZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zTIjEJ0HkuMtuMxyjWyre9jz/1CUJN5CCCj0jHLfdmM=;
        b=jqMwBmQ+b/ylQh8yn9RY5K2qGzfd2H69upubRCaNWYW7HiQ6TkbNKoFhd0FJtBGATb
         OnTntQEHwD+DaEdh7fRQu9bFQ0G4IODEiPGepHGrr24I68b2u1zdQloaRuC4eGYxxrER
         ywoTZ6rJ2jyq0gcjkBpRK2rZD4s1bw+GqUCrH1IUNAEMm9AZko6ekY/c3d9qcpaswNDp
         2O1Jc27gAz/tIBkDIg02IQ2ezTVUt8tOyK98iyiLgYHtUiMir+wWuPCuzpWNmUB+ohlu
         J08TYrpe9Id+b72L69AxCCqSy/1ex+GTg/taPNntswdMegf4UVEqzjshkh5WmGuNHNC5
         qPgg==
X-Gm-Message-State: AHPjjUiQqpUVz58vP5gNJJ802Ru6XfXyemP1CsjNg+bq5ded19VopCDw
        /beykk0Mur0qjNorn4C0AFCJ6LTnIYgNwTWDuII=
X-Google-Smtp-Source: AOwi7QAEFmCui1kcxHVPlLkVe54hYRiVZ5Gw80dvZcLhZTeEolAMfKDcSQ5IkqU/AEV8OfY1jbuKMCAVRegM/d+H8IU=
X-Received: by 10.99.126.84 with SMTP id o20mr5474332pgn.201.1506283169234;
 Sun, 24 Sep 2017 12:59:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.142.137 with HTTP; Sun, 24 Sep 2017 12:59:28 -0700 (PDT)
In-Reply-To: <20170923163817.7ltmkav2ytk7n43k@sigill.intra.peff.net>
References: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net>
 <cover.1506120291.git.martin.agren@gmail.com> <20170923043701.4s3xuytp5hdjwmsy@sigill.intra.peff.net>
 <CAN0heSrPBDi4q9fqr=qoTbjRHpFS_VEL0O8=MFFJ4DLCuJwahA@mail.gmail.com>
 <20170923161316.yntnccqrhv5d3jza@sigill.intra.peff.net> <20170923163817.7ltmkav2ytk7n43k@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 24 Sep 2017 21:59:28 +0200
Message-ID: <CAN0heSqQ3Etj1mkGhuft8JzKA8SNhpF0jcnVEdFeKX5NHpyqTw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] reroll ma/plugleaks; more `object_array`-fixes
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23 September 2017 at 18:38, Jeff King <peff@peff.net> wrote:
> On Sat, Sep 23, 2017 at 12:13:16PM -0400, Jeff King wrote:
>
>> In theory you should be able to just add "log_path=/tmp/lsan/output" to
>> that, which should put all the logs in a convenient place (and stop the
>> extra output from confusing any tests which capture stderr). But I can't
>> seem to get log_path to do anything, contrary to the documentation.
>>
>> Doing log_to_syslog=1 does work for me. I'm not sure if it's a bug or
>> I'm holding it wrong. But it does seem like it should be possible to do
>> what you want.
>
> Hrm. log_path doesn't seem to work for me directly from LSAN_OPTIONS.
> But if you compile with ASan, it _does_ work from there. That seems like
> a bug from my reading of the documentation, but maybe I'm missing
> something.
>
> Anyway, doing:
>
>   ASAN_OPTIONS=detect_leaks=1:abort_on_error=0:exitcode=0:log_path=/tmp/lsan/output \
>   make SANITIZE=address,leak test
>
> should pass the whole suite and give you a host of files to analyze.

Thanks. My reading of the documentation was off. Turns out exitcode=0
does not set the exit code to 0, but rather turns it off. Duh. It also
didn't help that I tested with (my) gcc, which seems to have some
issues. With clang, things work fine. Thanks for looking into this.

> I'm not sure of the best way to count things.

Right. It's a tricky problem. And in the end, all we find out is where
we allocate and how we got there. Exactly where we lose/leak that piece
of allocated memory is another question...
