Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22F281F576
	for <e@80x24.org>; Wed, 21 Feb 2018 09:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932629AbeBUJss (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 04:48:48 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:37874 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932381AbeBUJsr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 04:48:47 -0500
Received: by mail-wr0-f173.google.com with SMTP id z12so2628270wrg.4
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 01:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=boTCt1/TcGYY/nu5hKIHI3FZSP1ae8PX8B6BTv7un9k=;
        b=CKE0aQhslfcZi4FTLfRc4n/i4XvIKcTbqQwv8pOgY1jSBRTKnVb3FSy2zOYIyb8KNE
         CAKz4wDIPULVZ/pL2Z6vvHJOi+TnX97qRvAZo1hOuUIFlx21pYTzs3wUELZhZ10CmUk3
         iGKJUR/pLWZwnDTrDmbgGrIcNKt8vzHvm1GRl/I7wn95ZbI+r9PPyRQXlpxSGVF7s1+0
         VQFRWbqbgER8iTOjZqRWAjw5wQWIHKmjft07YiuClRwDym0X0dNNYc4DaOEselMenm9e
         /ICysaAVhuxHXapCXKgfqv0RgWTbcTtTY6bnn7iQcev+EGBgxpfG5ivn7cJBIGbfml2C
         74qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=boTCt1/TcGYY/nu5hKIHI3FZSP1ae8PX8B6BTv7un9k=;
        b=FZQX9xJidULORvQYsqhwBb0zDm/QTlJVfYUDcu9A0pgju0G6vAi9DmZJzMH9xg1ir3
         G+TXVCn7v8F4eWNi/RmRNle9/zxmDNryBgiIIxlz8AZvXCNE/8h/UHAQ1zolvlA7NwUC
         XAJtRiCWzcbXmwMaQq425TmQz64f7ozJsLqaIsUgVVIlN8qaq9DWMV7lMs+We4Oa8PEz
         p6SDZoD0X94tIkklHLmyl5A0qeIxcKYaXc7UGp1XR2TI9c0VJ/WHpUnt1vTNVrwk3eoa
         zdS68Z7R9TB7OPfzDaN2F8QIQr8Xq6kQrq+A2ecYAwQmQ0a2P6Qbvso1UJasRlTrtU72
         DRpQ==
X-Gm-Message-State: APf1xPCKB9laQuMuniSH4tT+15Fcd2VTRkEbZAn9PBaWFd/q7I3inoqm
        U/Pw3kVjazSscesIW0uCIVEhSepS19vplVHUfP012Q==
X-Google-Smtp-Source: AH8x224bc+e12UHSAPWe8QF8LQ631J+12BZgECCXHvRfmmDWLxjaoxeAUTNGXWDIyGbzgIJnJDye+p+725DeX/tMv/I=
X-Received: by 10.80.220.70 with SMTP id y6mr4138879edk.236.1519206525981;
 Wed, 21 Feb 2018 01:48:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.139.133 with HTTP; Wed, 21 Feb 2018 01:48:25 -0800 (PST)
In-Reply-To: <20180220220525.GA25134@helen.PLASMA.Xg8.DE>
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE> <20180220211634.GA15232@sigill.intra.peff.net>
 <20180220220525.GA25134@helen.PLASMA.Xg8.DE>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 21 Feb 2018 01:48:25 -0800
Message-ID: <CA+P7+xr=HXGi9ufeC5=Sm7bR3csxZPMExjD=QDrc2T9Pp46Yjg@mail.gmail.com>
Subject: Re: Git should preserve modification times at least on request
To:     Peter Backes <rtc@helen.plasma.xg8.de>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 20, 2018 at 2:05 PM, Peter Backes <rtc@helen.plasma.xg8.de> wrote:
> Hi Jeff,
>
> On Tue, Feb 20, 2018 at 04:16:34PM -0500, Jeff King wrote:
>> I think there are some references buried somewhere in that wiki, but did
>> you look at any of the third-party tools that store file metadata
>> alongside the files in the repository? E.g.:
>>
>>   https://etckeeper.branchable.com/
>>
>> or
>>
>>   https://github.com/przemoc/metastore
>>
>> I didn't see either of those mentioned in this thread (though I also do
>> not have personal experience with them, either).
>>
>> Modification times are a subset of the total metadata you might care
>> about, so they are solving a much more general problem. Which may also
>> partially answer your question about why this isn't built into git. The
>> general problem gets much bigger when you start wanting to carry things
>> like modes (which git doesn't actually track; we really only care about
>> the executable bit) or extended attributes (acls, etc).
>
> I know about those, but that's not what I am looking for. Those tools
> serve entirely different purposes, ie., tracking file system changes.
> I, however, am specifically interested in version control.
>
> In version control, the user checks out his own copy of the tree for
> working. For this purpose, it is thus pointless to track ownership,
> permissions (except for the x bit), xattrs, or any other metadata. In
> fact, it can be considered the wrong thing to do.
>
> The modification time, however, is special. It clearly has its place in
> version control. It tells us when the last modification was actually
> done to the file. I am often working on some feature, and one part is
> finished and is lying around, but I am still working on other parts in
> other files. Then, maybe after some weeks, the other parts are
> finished. Now, when committing, the information about modification time
> is lost. Maybe some weeks later I want to figure out when I last
> modified those files that were committed. But that information is now
> gone, at least in the git repository. Sure, I could do lots of WIP
> commits, but this would clutter up the history unneccessarly and I
> would have lots of versions that might not even compile, let alone run.

You could have git figure this out by the commit time of the last
commit which modified a file. This gets a bit weird for cherry-picks
or other things like rebase, but that should get what you want.

If you only ever need this information sometimes, you can look it up
by doing something like:

git log -1 --pretty="%cd" -- <path to file>

That should show the commit time of the latest commit which touches
that file, which is "essentially" the modify time of the file in terms
of  the version control history.

Obviously, this wouldn't work if you continually amend a change of
multiple files, since git wouldn't track the files separately, and
this only really shows you the time of the last commit.

However, in "version control" sense, this *is* the last time a file
was modified, since it doesn't really care about the stuff that
happens outside of version control.

I'm not really sure if this is enough for you, or if you really want
to store the actual mtime for some reason? (I think you can likely
solve your problem in some other way though).

>
> As far as I remember, bitkeeper had this distinction between checkins
> and commits. You could check in a file at any time, and any number of
> times, and then group all those checkins together with a commit. Git
> seems to have avoided this principle, or have kept it only
> rudimentarily via git add (but git add cannot add more than one version
> of the same file). Perhaps for simplificiation of use, perhaps for
> simplification of implementation, I don't know.
>

You can do lots of commits on a branch and then one merge commit to
merge it into the main line. This is a common strategy used by many
people.

Thanks,
Jake

> I assume, if it were not for the build tool issues, git would have
> tracked mtime from the very start.
>

Maybe. Personally, I would hate having my mtime not be "the time I
checked the file out", since this is intuitive to me at this point.
I'm sure if I lived in a different world I'd be used to that way also,
though.

The build issue *is* important though, because many build systems rely
on the mtime to figure out what to rebuild, and a complete rebuild
isn't a good idea for very large projects.

Thanks,
Jake

> Best wishes
> Peter
> --
> Peter Backes, rtc@helen.PLASMA.Xg8.DE
