Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64FF31F404
	for <e@80x24.org>; Mon, 18 Dec 2017 04:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932415AbdLREEE (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Dec 2017 23:04:04 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37374 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932168AbdLREED (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Dec 2017 23:04:03 -0500
Received: by mail-wm0-f45.google.com with SMTP id f140so26796078wmd.2
        for <git@vger.kernel.org>; Sun, 17 Dec 2017 20:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=lHtT2KVbcQpEfNrFDPwOn/+iUkspl1ST1bOyw6lZrwM=;
        b=bhoOtgvZEhLXB6ZVcMYGeDtyc41t8mKP8n6LXJX4S8qhieURywf0n0fEfmiMxngppj
         xezL/1Qoc837LSx0uTpWiWpe/0PTjtq9E+pUDCHLjZVtDs4XrklBNkV1DwcJsXp1Pebn
         sen4k7Oomm/++ilyESoxeAW1iAYeXk9tlNLCxsr+58AqrBa8jcOzqPt1aAkrXrIpB+ND
         e36ntSkLbSGaRH/NucsTx4d8v88fIM4QghSb/rs/z6tioV7F2l7JUbBbo/NP0TLV33X9
         bO+G4ptMurjqSgGkkURCjjtdUhoGJQZwME357KXghYTv/EI6ixXORW9qspcPzcFXBIyO
         Waxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=lHtT2KVbcQpEfNrFDPwOn/+iUkspl1ST1bOyw6lZrwM=;
        b=BxAGrTeQ3Gmo68SNt9uA9RzuSQlxnE6JzsC07q0YvYD2bfjgHKDtdUQ/XotXao7VFo
         ssaY943Yjxkreq74m6pMn+EKdq7XWTxDrMxcOeuIz99MALGpibrTFKcovP5RDSCvkI9m
         jAuOPE2vQgpAj1XyFV8NZcnm8Pxezmv/CTDk165b9axjZH/b2bguQOPUg2THbLf9F4V2
         jW0ZBkrQwOa0+YSLWVnw9DQ12jH7az9Wxy5nVUfM/sfp7mlM4PTMH6spiTetZekkZ+4I
         aKuVWeGUhS0PVOygYq5AIndwR29w2M8vItD5xYp0mXWfFksUd8F5XbmcTGzX/4xBJTti
         BWvg==
X-Gm-Message-State: AKGB3mK65qPUgxFF7uuDDbqxbgIA048XtChKpqEKMaYrIHUf932gAopl
        h3pigha21OhnclI3Y6/B816jQ9/W6h2Ow9sgDRQ=
X-Google-Smtp-Source: ACJfBou6Xqh5ck9k7cK9gr6ghDT9KxmS3dmm3h762EiVgMCF7zvTbMwf5k+q5PvBE1nFsgEmGkW344jbmHAmfn23e98=
X-Received: by 10.80.137.106 with SMTP id f39mr20082353edf.148.1513569841654;
 Sun, 17 Dec 2017 20:04:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Sun, 17 Dec 2017 20:03:41 -0800 (PST)
In-Reply-To: <20171216220120.GB6217@genre.crustytoothpaste.net>
References: <20171211211102.rrxqd6yscnd33efd@hopa.kiewit.dartmouth.edu>
 <20171211225615.GC214273@aiede.mtv.corp.google.com> <xmqqtvww3gea.fsf@gitster.mtv.corp.google.com>
 <20171216220120.GB6217@genre.crustytoothpaste.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 17 Dec 2017 20:03:41 -0800
Message-ID: <CA+P7+xpFyD0zuOz7XSCc6cV1T1zu6j-gZD=EMQs-t2WPxi1EMA@mail.gmail.com>
Subject: Re: Q: rational for $XDG_CONFIG_HOME/git/config to be "non global" or
 just a bug?
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Yaroslav Halchenko <yoh@onerussian.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>, kyle@kyleam.com,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 16, 2017 at 2:01 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Mon, Dec 11, 2017 at 05:05:01PM -0800, Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>> > As for "git config --global", I think the best thing would be to split
>> > it into two options: something like "git config --user" and "git
>> > config --xdg-user".  That way, it is unambiguous which configuration
>> > file the user intends to inspect or modify.  When a user calls "git
>> > config --global" and both files exist, it could warn that the command
>> > is ambiguous.
>> >
>> > Thoughts?
>>
>> I actually thought that the plan was "you either have this, or the
>> other one, never both at the same time" (and I think those who
>> pushed the XDG thing in to the system made us favor it over the
>> traditional one).  So as long as --global updates the one that
>> exists, and updates XDG one when both or neither do, I think we
>> should be OK.  And from that viewpoint, we definitely do not want
>> two kinds of --global to pretend as if we support use of both at the
>> same time.
>
> Sorry for coming late to the discussion, but I actually use both.
>
> ~/.gitconfig is checked into my Git repo for my home directory and
> contains settings I preserve across all systems, and the XDG dir is not
> checked in and contains per-system settings (currently just
> commit.gpgsign).  On my main systems I have a key and sign commits; if
> it's just some server I log into, I don't.
>
> Now, I don't use git config to set options, so I'm happy as long as git
> config can read both, which it does.
> --
> brian m. carlson / brian with sandals: Houston, Texas, US
> https://www.crustytoothpaste.net/~bmc | My opinion only
> OpenPGP: https://keybase.io/bk2204


Ok, so my patch documentation is wrong. Perhaps we could further
clarify in the documentation how it works, but I'm not really sure
what the best approach is.

I do find it a bit weird that --global writes to one of either file,
and doesn't read from both. I'd rather have --global "only" be
.gitconfig, and instead add a new option for handling XDG file, and
then have it such that it reads them in system -> xdg ->
home/.gitconfig -> local, which allows for local .gitconfig to
override XDG config, but logically treat them just like we do any
other files.

Thanks,
Jake
