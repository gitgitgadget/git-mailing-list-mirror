Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32804201A7
	for <e@80x24.org>; Sat, 13 May 2017 01:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752976AbdEMBX1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 21:23:27 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:36660 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751830AbdEMBX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 21:23:26 -0400
Received: by mail-wr0-f170.google.com with SMTP id l50so51901464wrc.3
        for <git@vger.kernel.org>; Fri, 12 May 2017 18:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pkoeS2d/AvL6ADwMkfGufckLMyxZGNi3uEaW/gHDGUU=;
        b=uBH91s8H2yuukCnadqymVswFD9ITYGaVT5Gj7INza528y0LsZOcoX8Eqzya3zyeATJ
         Mzp4pEWpqGRvDRUoDn5N3qY7VNgb/2+YuyBXNk8QRqRPrC/+qho8W3asuz1JfsWhZrDZ
         YQOon95oBJBN7/N7qBJiwt6GPevG3aLK3X8u8KF584DTx/QS4tfax9M/z9Iedy4AY/CG
         RTXBoFBbh5xNqwz15rr8JqhqNGVFG1tqXK5DhoCzBwiInxHcNq+t9LnYwccrMIBhnUYo
         Smfh7tedY9e/J2qOeWdG0Hf1QITmgaW5qfY4b5WahjiY46NcERbVMLTSj4c5MrxkYOEB
         sEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pkoeS2d/AvL6ADwMkfGufckLMyxZGNi3uEaW/gHDGUU=;
        b=K0myL+ia/Z/lTUJTcgOKIogR11GClvsHSbetu/xVYj/y0CqrmXg62M8tw1SveiwUE4
         ivam4i/OH5FC7n5kFDy1majrVxCikLiCZSJifRcwdfiY5C1d0GJDyMgvrFX/houleOIE
         ymgHkVYycsztY3BNwSTmdsKTlDJQD8ceLie+GGZZoaYFS+Bc2UCynj5uHot/OJBVhMoi
         GEf7iNP5a90Nv9h/K+X5Iu3xuRcLkpDb5dpt9f6uTYf4Wh45I/o+m1CCdzdlkshVRwm+
         RPd3F7eC762+8i9VDsD9fUWG/naAdatyeAA/Nr9vsg0klYM0Wao+j5aci/+7qJgx2Fcp
         iD2w==
X-Gm-Message-State: AODbwcD5vSZgEFDr5rPV3mVy6zw1n07rcL07i2FB91qBumXSPe6HTjpk
        lvcnZAh3MZEqKleN6eUBQZ+2TZ9fxw==
X-Received: by 10.223.168.120 with SMTP id l111mr4322221wrc.137.1494638605415;
 Fri, 12 May 2017 18:23:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.100.213 with HTTP; Fri, 12 May 2017 18:23:04 -0700 (PDT)
In-Reply-To: <20170512234814.GG27400@aiede.svl.corp.google.com>
References: <20170512220704.txmdk45s66aqhexi@genre.crustytoothpaste.net>
 <20170512221221.406645-1-sandals@crustytoothpaste.net> <20170512233214.GE27400@aiede.svl.corp.google.com>
 <20170512233753.rz2g7quews4ny5iq@genre.crustytoothpaste.net> <20170512234814.GG27400@aiede.svl.corp.google.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 12 May 2017 19:23:04 -0600
Message-ID: <CAMMLpeRkVsvp_fzt+bHSQ_F9gsMhYqej_oyqrjhAXsY1xs7=Qw@mail.gmail.com>
Subject: Re: [PATCH v2] builtin/log: honor log.decorate
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-05-12 17:48 GMT-06:00 Jonathan Nieder <jrnieder@gmail.com>:
> Hi,
>
> brian m. carlson wrote:
>
>> Does anyone else have views on whether this is good thing to test for?
>
> I know you don't mean to be rude, but this comes across as a bit of
> a dismissive question.

The question sounded neutral to me.

>> On Fri, May 12, 2017 at 04:32:14PM -0700, Jonathan Nieder wrote:
>>> brian m. carlson wrote:
>
>>>> The recent change that introduced autodecorating of refs accidentally
>>>> broke the ability of users to set log.decorate = false to override it.
>>>
>>> Yikes.  It sounds to me like we need a test to ensure we don't regress
>>> it again later.
>>
>> I can add one, but it's going to be a bit odd.  The issue is that as far
>> as I can tell, the option is honored only if it's the last one read, so
>> it necessarily has to be in the per-repository configuration.
>>
>> I'm not sure it makes that much sense to add a test for this case.  Do
>> we generally want to write such tests for all config options?  I don't
>> suppose it's that common a mistake to make.
>
> In my humble opinion, the bug being subtle makes it especially useful
> to have a test that describes that bug.  That way, if someone is
> refactoring this code later then they know what to watch out for not
> reintroducing.
>
> I'm happy to hear other opinions, especially if they come with data or
> a principle attached that I can use when writing future patches of my
> own.

When I saw Brian's email today, my first thought was "What was I
thinking?" My mistake was pretty obvious. Then I remembered that when
I wrote the original patch, I wasn't sure where to set the default
value, because there were no clear examples in this file. Now that
we've established a clear precedent for setting the log.decorate
default (and other defaults like it) in init_log_defaults, I don't
expect any more problems with log.decorate. And since it's not
practical to add tests for similar bugs for every command and
configuration option in Git, we'll just have to be a little more
vigilant about code review.

Again, I apologize for the trouble.

-Alex
