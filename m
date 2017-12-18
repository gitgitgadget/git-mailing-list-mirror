Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 739A71F424
	for <e@80x24.org>; Mon, 18 Dec 2017 19:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759486AbdLRT5I (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 14:57:08 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:46994 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758334AbdLRT5H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 14:57:07 -0500
Received: by mail-wr0-f180.google.com with SMTP id g17so6269174wrd.13
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 11:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tE+4KXN+bTsikMTh+tCs0NMyodx/NfVquHia4ox/PEQ=;
        b=mM89xHllgbrAnKjd9Zo0xRQioU69Kvv7OitVYV/GIMurAs0t3ltCFZV3fE3VG2l3j5
         gswbodzUR7OzXUyPkK5Y8KyBJ8yTXFKMukazCe7Uo+iSq6F59w7RU+pD7ds5OihFsRbd
         2qRdLA7TYWaC0jIr0T9Y2KerMqzcGrOjOWM8JJ4+rGjjjkQ/pJ1CFrLPoxOx1oq0Cla4
         EXPz4R32BcphytYudRXkisB5qXaX0e6+Vpwiwjgr122dAKL6161910hx1uGiwRJMOjuk
         qC1ZbPShlBtpZF1Jxpm03n/HTMSD/SP2SmTgllVp0GbG26PQyFDriCBrfSURyC1Y/4lL
         14Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tE+4KXN+bTsikMTh+tCs0NMyodx/NfVquHia4ox/PEQ=;
        b=mbNZNO7MpfNJlRNvysdhOD+iqCw1HYmMcuzJpV/Jw7FyXbIwEl8HmtFV2QlyYoSsBJ
         IeTxGwaxpnQumnYTI8txDb8h+lEGNVFEPBudtv7fpbbMR7wKOPlpQT/qGirBCtKGiOV/
         B6CaE9O/Weo/gL4d5mXhbG7e27dGo+6KcN9e9Ww9XuQkQVP0wYPAjCBkQUE9jrhsIM5Y
         XuYsjAWUmTXiuq6Z4q63HTWEYn6Zm+9U25YN6UtFuW+CMPjFLuJaRrMzZRVqooN3ebYs
         KGPIqsZbQXw85/RULTp1oRign3UNOXoQW+exZwdKzmykFDM/6BqC9Q1eCwBZb11RBjN6
         FFpw==
X-Gm-Message-State: AKGB3mKD9joXNxzWvy9z71GiySoKk6IQGOTAsV8kwPc5KTRuxRryfwgh
        Xqmd6QJd9Jw0N5H4UkAsQTBDPYZPO+Ju1P32V6rfrw==
X-Google-Smtp-Source: ACJfBosYHDA0WwsjR449RD1SbqNl9LSxoHSGKClqoQMMXk1zz/m/v45jo7Oltp41VGYiv9ofYnVVrd14zOB4sa2nPQg=
X-Received: by 10.223.157.206 with SMTP id q14mr1221208wre.223.1513627025584;
 Mon, 18 Dec 2017 11:57:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Mon, 18 Dec 2017 11:56:45 -0800 (PST)
In-Reply-To: <20171218064042.GA25733@sigill.intra.peff.net>
References: <20171211211102.rrxqd6yscnd33efd@hopa.kiewit.dartmouth.edu>
 <20171211225615.GC214273@aiede.mtv.corp.google.com> <xmqqtvww3gea.fsf@gitster.mtv.corp.google.com>
 <20171216220120.GB6217@genre.crustytoothpaste.net> <CA+P7+xpFyD0zuOz7XSCc6cV1T1zu6j-gZD=EMQs-t2WPxi1EMA@mail.gmail.com>
 <20171218064042.GA25733@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 18 Dec 2017 11:56:45 -0800
Message-ID: <CA+P7+xoH=wxYntERNiC4g32Kd9VmHmrBTCka-GCw+v6OsyjZ3w@mail.gmail.com>
Subject: Re: Q: rational for $XDG_CONFIG_HOME/git/config to be "non global" or
 just a bug?
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Yaroslav Halchenko <yoh@onerussian.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>, kyle@kyleam.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 17, 2017 at 10:40 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Dec 17, 2017 at 08:03:41PM -0800, Jacob Keller wrote:
>
>> I do find it a bit weird that --global writes to one of either file,
>> and doesn't read from both. I'd rather have --global "only" be
>> .gitconfig, and instead add a new option for handling XDG file, and
>> then have it such that it reads them in system -> xdg ->
>> home/.gitconfig -> local, which allows for local .gitconfig to
>> override XDG config, but logically treat them just like we do any
>> other files.
>
> I find it weird, too, but I'm not sure that's the right direction. It
> means that users have to start caring about using "--xdg" instead of
> "--global" if that's what they want to write to. The original idea was
> that the transition to xdg should be fairly seamless, and that --global
> would be an abstraction over both.
>
> To complete that abstraction it seems like reading via "--global" should
> read from both (in the same precedence order that normal config lookup
> uses). If you only use one, there wouldn't be any change in behavior.
> And if you use both, then the behavior makes sense as a subset of the
> normal config lookup. I.e., it could even be explained as:
>
>   If you give no "source", normal config lookup is similar to checking
>   "--system", then "--global", then "--local".
>
> The only person who might be affected is somebody who carries both files
> _and_ really wanted "--global" to read from one specific file (though I
> have no idea from which without looking at the source, and from reading
> this thread it seems I am not the only one who would be confused). So
> I'd be OK calling that an unintended and unsupported behavior, and the
> right thing all along should have been to use "--file=" if you really
> want to avoid "--global" automagic.
>
> -Peff

I think this end game is fine with me too, it's definitely better than
what we have now.

Thanks,
Jake
