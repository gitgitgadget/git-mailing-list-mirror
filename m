Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80ECD1F576
	for <e@80x24.org>; Sat, 10 Feb 2018 10:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbeBJKVh (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 05:21:37 -0500
Received: from mail-oi0-f54.google.com ([209.85.218.54]:44512 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbeBJKVg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 05:21:36 -0500
Received: by mail-oi0-f54.google.com with SMTP id b3so7913393oib.11
        for <git@vger.kernel.org>; Sat, 10 Feb 2018 02:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+UVDJ1N0GF2XdpCIqSxBJYBAUu/JRdMTmeBCJlnn8rM=;
        b=oYJVODoKPv0kUatWdQa8QVOoHAraoL76/9AJ2En6qFoizZdkt5hyX9Dv6/V3l+dch3
         TlIKy0T62FhgCzwtsbt0Qh3DHJxMQPgSdDV9w/Wf94NuUqb32acOIwcIQm0fz5uQ1frA
         HlN/oa2aucgF+gsxCESAvmr8UC+BQbkcMwFHXmG1ezZisOcAO1uqvDSUR3Uuud+cyxIQ
         hZ3n3m9GuOgWG5IlVrQ6Tsv96yMO36ycctiawpiV8pqv/+ae0PUFRpb+VT3eZaXQhNPY
         x3fCY71X7pQqIUlE7MNTWasHoxtksQk1KMAv6XqFByqZS1kqFEuERDijaAbpZKD9CE8+
         05Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+UVDJ1N0GF2XdpCIqSxBJYBAUu/JRdMTmeBCJlnn8rM=;
        b=pQCf1An0D8hULdoVFMNKYFnadRrMKbNpIJRaDaImM6cFKoeOuu47AzlyPco396MMrW
         LyNK6g5IFyPN+n/3P7sGgHGIcIHV/OinErYM/52RqGY+i/OUIhrIDOQ5+XyjfwrH2qXB
         KUgv3KAFgQYY3/i0qzPooz8Tlarj4a3H4yg3lJ/rx4elP6puC2eHZK6786seh6rDw6Zs
         kTgL7o1w1WT9AhAlhhTeIVxQFJiZLXhAMmrKgcIBZ5855tKKxYzexSCU0fuZBlaBZZOy
         s8/TLTEWTB3cBPdmzDHVz7UHaaDdWzcrFNWOwLyrgCh0XXt/4wGB/Ds1OAMiGPDLdujC
         inAA==
X-Gm-Message-State: APf1xPC85M4UiBtaRIavLNCTOgFyd57FdyZK+Cx89RySmluhuW7gx/o/
        xWJK1GG7X23LEC09pAaTGd0RYmGV0yi/SDDyxDI=
X-Google-Smtp-Source: AH8x227lhR29omvzLB1IF/mUt9ihWV9RkAhv2T4FAinaZkD/jFrvdklndOVtMarwJvoYv3fOy6Ykb+egAPSJLsZq5iY=
X-Received: by 10.202.66.10 with SMTP id p10mr3788485oia.297.1518258095870;
 Sat, 10 Feb 2018 02:21:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Sat, 10 Feb 2018 02:21:05 -0800 (PST)
In-Reply-To: <20180207204520.GA31757@sigill.intra.peff.net>
References: <trinity-cb66d9d6-9035-4c98-948e-6857a7bd4de2-1517838396145@3c-app-gmx-bs16>
 <trinity-5e3c4029-b348-4bd5-9337-215808436a12-1517838482997@3c-app-gmx-bs16>
 <CACsJy8CGQ4ynYFT0mY1DfcGGdzwP36eonMvr-kEZazX_82ag2Q@mail.gmail.com> <20180207204520.GA31757@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 10 Feb 2018 17:21:05 +0700
Message-ID: <CACsJy8C72Gv4D46tOmgTqi=8aHVG7D=yZR2F7VPLRcm1e_jTYg@mail.gmail.com>
Subject: Re: Bug? Error during commit
To:     Jeff King <peff@peff.net>
Cc:     Andreas Kalz <andreas-kalz@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 8, 2018 at 3:45 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 05, 2018 at 08:59:52PM +0700, Duy Nguyen wrote:
>
>> On Mon, Feb 5, 2018 at 8:48 PM, Andreas Kalz <andreas-kalz@gmx.de> wrote:
>> > Hello,
>> >
>> > I am using git frequently and usually it is running great.
>> >
>> > I read to write to this eMail address regarding problems and possible bugs.
>> > I am using git version 2.16.1.windows.2 / 64 Bit and during commit the following error message comes up:
>> > e:\Internet>git commit -m 2018-01-27
>> > fatal: unable to generate diffstat for Thunderbird/andreas-kalz.de/Mail/pop.gmx.net/Inbox
>> > [master f74cf30] 2018-01-27
>> >
>> > I also tried this before with an older git version with same problem.
>> >
>> > Can you help me with this problem please? Thanks in advance.
>>
>> I think if you add -q to that "git commit" command, diffstat is not
>> generated and you can get past that. If that particular commit can be
>> published in public, it'll help us find out why diffstat could not be
>> generated.
>
> I think that's the first time I've seen that particular error. :)
>
> I think the only reason that xdiff would report failure is if malloc()
> failed, or if one of the files exceeds MAX_XDIFF_SIZE, which is ~1GB.
> I think we'd usually avoid doing a text diff on anything over
> core.bigFileThreshold, though.
>
> But it doesn't seem to work:
>
>   $ yes | head -c $((1024*1024*1024 - 10*1024*1024)) >file
>   $ git add file
>   $ git commit -m one
>   $ yes | head -c $((1024*1024*1024)) >file
>   $ git commit -am two
>   fatal: unable to generate diffstat for file
>
> What's weird is that if I run "git show --stat" on the same commit, it
> works! So there's something about how commit invokes the diff that
> doesn't let the big-file check kick in.

I have a flashback about checking big_file_threshold in this code. I
vaguely remember doing something in this code but not sure if it was
merged.

I finally found 6bf3b81348 (diff --stat: mark any file larger than
core.bigfilethreshold binary - 2014-08-16) so it's merged after all,
but this commit is about --stat apparently ;-)

> It looks like the logic in diff_filespec_is_binary() will only check
> big_file_threshold if we haven't already loaded the contents into RAM.
> So "commit" does that, but "diff" is more careful about not loading the
> file contents.
>
> I think we probably ought to consider anything over big_file_threshold
> to be binary, no matter what. Possibly even if the user gave us a
> .gitattribute that says "no really, this is text". Because that 1GB
> limit is a hard limit that the code can't cope with; our options are
> either to generate a binary diff or to die.

Agreed. While at there perhaps we need to improve this "unable to
generate diffstat" message a bit too.
-- 
Duy
