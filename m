Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF9FC201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 20:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751648AbdB1U3n (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 15:29:43 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:36423 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbdB1U3m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 15:29:42 -0500
Received: by mail-io0-f182.google.com with SMTP id l7so17314335ioe.3
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 12:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BRWTECTuwgjy8cJ6w2Leg/o/nefgMNOIgNnIhxMRCag=;
        b=UW8KHu/xVvdhRRtv6myApCqv0Wc52rmHB4ABDE5HZXMdRBj37nsKGGY26dA8clSowe
         UYbs2PNVf+8Nf/csjufwG9iSlx3aFVJsMyoU8mPqJ54bVYXCSJoThKKWzt4quRUZk7b/
         xSQlYjsuT6xIbIe/qxCzxXksoRbbgMQnJBbovKTuUwf0QGm0DmDbwiLpvHBV419O5AZ/
         unBx/CNEAgjXJ9nUspyWYp46xFr5xVRZyGIIHO067/2XZw5SHerS6YLiLs/LiC2psEqw
         e/Qf0vp/yzR3nNXDg2B0GRW64VXGlN2HBpFG8YMYcxve88kzpy/FlTYsrgbuAHNIRPIG
         80Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BRWTECTuwgjy8cJ6w2Leg/o/nefgMNOIgNnIhxMRCag=;
        b=FTcGOdJ1BD9qhKHPk3bfQd6gggDslKx5QoIbWAYjz0NEUqZ/LPkZA0sb6LePRzPI2F
         ZIpf2m94DQoc1GYAzpk5p07G/zXX2AK6MB/EyoMtTku7HmMy9Jozoc3Mfw4bIGISgb2U
         1dWHUjI0wsveuaeOfVzYudL4Qe4Mqi4bIoXDcl/SqeZY8omi5IugdhTh0H79x2sjNX97
         LifXc7chBEQmShKZSWerekKGAWj/cWovNGNSvKuvJyiAZEZrnDfzn0tpsza1bIkyPkun
         BSmDy0qQCR6tNXJ8+tPS945qNcoFs1ypamoxAWB0Yj6G8P86WrvAokvuv5f2pxSiQ9Ci
         h0KQ==
X-Gm-Message-State: AMke39kx2UjxBwET/jCAbLMIm732ZzMnQqJ5EZxJp2GAmstthEzMget03kbfHswu3dy7cYzSO+Z4O0JEF/Vx+Z78
X-Received: by 10.107.37.148 with SMTP id l142mr4432424iol.159.1488313318447;
 Tue, 28 Feb 2017 12:21:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.13.1 with HTTP; Tue, 28 Feb 2017 12:21:57 -0800 (PST)
In-Reply-To: <20170228200821.iojdzntjslwgrzcb@sigill.intra.peff.net>
References: <CAC+L6n0YeX_n_AysCLtBWkA+jPHwg7HmOWq2PLj75byxOZE=qQ@mail.gmail.com>
 <CAGZ79ka8saQMKeutE415WxOQ71MnEw1A4uV3b0Pa4gcehx8pdw@mail.gmail.com>
 <20170228143710.smbzo6b7wefjc62r@sigill.intra.peff.net> <CAGZ79kb8F9_9fd9uhfPpHVPQj-zm99qt5Tr=3TUhpe=K6JknEg@mail.gmail.com>
 <20170228200821.iojdzntjslwgrzcb@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 28 Feb 2017 12:21:57 -0800
Message-ID: <CAGZ79kZ8ANzjauzJAbPh7m7zYoBrB=ZjgDXHxNb57_H=RYm8cQ@mail.gmail.com>
Subject: Re: 'git submodules update' ignores credential.helper config of the
 parent repository
To:     Jeff King <peff@peff.net>
Cc:     Dmitry Neverov <dmitry.neverov@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 12:08 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 28, 2017 at 10:05:24AM -0800, Stefan Beller wrote:
>
>> > I have a feeling that something like this would create unwelcome corner
>> > cases in the config-writer, which is otherwise does not have to care
>> > about which existing section of a file it adds a key to.
>>
>> Yeah the writer would become a lot more involved, if we're not going
>> the stupid way (add these sections for nearly all keys. that would be
>> a mess but easy to implement)
>>
>> So I guess then we rather settle with multiple config files or a white/blacklist
>> of config options to propagate from the superproject to its submodules.
>
> I'm still open to the idea that we simply improve the documentation to
> make it clear that per-repo config really is per-repo, and is not shared
> between super-projects and submodules. And then something like Duy's
> proposed conditional config lets you set global config that flexibly
> covers a set of repos.

How would the workflow for that look like?
My naive thought on that is:

  (1)  $EDIT .git/config_to_be_included
  (2)  $ git config add-config-inclusion .git/config_to_be_included
  (3)  $ git submodule foreach git config add-inclusion-config
.git/config_to_be_included

which sounds a bit cumbersome to me.
So I guess we'd want some parts of that as part of another command, e.g.
(3) could be part of (2).

--
I am also open and willing to document this better; but were would
we want to put documentation? Obviously we would not want to put it
alongside each potentially useful config option to be inherited to
submodules. (that would imply repeating ourselves quite a lot in
the config man page).

I guess putting it into "man gitmodules" that I was writing tentatively
would make sense.
C.f
https://public-inbox.org/git/20161227234310.13264-4-sbeller@google.com/
(or search for "background story" in your emails)

Thanks,
Stefan
