Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0377C20756
	for <e@80x24.org>; Sat,  7 Jan 2017 21:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753257AbdAGVrI (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 16:47:08 -0500
Received: from mail-wj0-f177.google.com ([209.85.210.177]:35791 "EHLO
        mail-wj0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbdAGVrG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 16:47:06 -0500
Received: by mail-wj0-f177.google.com with SMTP id i20so50811972wjn.2
        for <git@vger.kernel.org>; Sat, 07 Jan 2017 13:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PwF7EGg0UMPvvCwQhzDrR/BOyqeJrtARrJdF7JuepAU=;
        b=THUP6eUbAuApewh2cWHVGxTnPS0B1AmWx/c/z6h1JnTFqTCevfX4+urtYWg9jcU5Fi
         RNjjwTcdAMH2U4N0jrZ6xjgZYxmiAd++WVkmxENE1WpXhM1Plz2qSTJpbOUZCBIjMzjO
         CpfibbPw5gdFJIvEAYnurwSIVQYn89oV9lksUfY3uQX5hcTd2yhLWt9uQ/MfpcoJBqW1
         3Bj+6JVGG23P3M2zwgY2Wsid/hyPYS+utSeUy8Gac+Zvx8nfgMmDjqq0q5m7EOjlEUos
         cvLsh5KnfLRQfobSUgkGpuOjHRzVaWAyhFWXQtruCIy7m5mmPoQWhWdysZxS5wbqrC1d
         Mwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PwF7EGg0UMPvvCwQhzDrR/BOyqeJrtARrJdF7JuepAU=;
        b=UdcZda/QIdwmugrZYWmnf79Zqd//ggxjFtJ6ANxs3kW5nLL4zwQG+rLlo4FNKQfBqK
         ajKYc2LbdzYuTJQ+qDc0MWiLpvyUywxlLHdi/0MfQZHxFzW2Y34Z7lxERa6H69SvDqr9
         IkluLqg6FZDeGrf/G4I6t0QI2bmSdqvmdz3LgV+efwwErrBff89fHl5PbJCY6cRBqXhb
         LIRo+VIBHOWsqwjBt79mTo7izuCFuzHAaCz2Mqf/weGO4mK7FYdqqFpaJW31eRjnz6R7
         u5n92E/PGLBKxULAU0oy6VLn7rFv43kp783FyFQkP4rN/NxnDVlZpWgYR0ROyae0S2eR
         VNaA==
X-Gm-Message-State: AIkVDXJNW8SGNN1E0vVA40c7IAfdUpcqk7MfHxpE56nGKlzNvEI2PoyWqw404PuQv9B/Ug==
X-Received: by 10.194.202.133 with SMTP id ki5mr72314080wjc.191.1483825624995;
        Sat, 07 Jan 2017 13:47:04 -0800 (PST)
Received: from [192.168.1.80] ([145.129.9.233])
        by smtp.gmail.com with ESMTPSA id 138sm10317322wms.20.2017.01.07.13.47.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jan 2017 13:47:04 -0800 (PST)
Message-ID: <1483825623.31837.9.camel@kaarsemaker.net>
Subject: Re: "git fsck" not detecting garbage at the end of blob object
 files...
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     John Szakmeister <john@szakmeister.net>, git@vger.kernel.org
Date:   Sat, 07 Jan 2017 22:47:03 +0100
In-Reply-To: <CAEBDL5Uc39JagdmXUxfxh1TPSK3H5wxoTfjK-pfLRYjciBnHpA@mail.gmail.com>
References: <CAEBDL5Uc39JagdmXUxfxh1TPSK3H5wxoTfjK-pfLRYjciBnHpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.1-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-01-07 at 07:50 -0500, John Szakmeister wrote:
> I was perusing StackOverflow this morning and ran across this
> question: http://stackoverflow.com/questions/41521143/git-fsck-full-only-checking-directories/
> 
> It was a simple question about why "checking objects" was not
> appearing, but in it was another issue.  The user purposefully
> corrupted a blob object file to see if `git fsck` would catch it by
> tacking extra data on at the end.  `git fsck` happily said everything
> was okay, but when I played with things locally I found out that `git
> gc` does not like that extra garbage.  I'm not sure what the trade-off
> needs to be here, but my expectation is that if `git fsck` says
> everything is okay, then all operations using that object (file)
> should work too.
> 
> Is that unreasonable?  What would be the impact of fixing this issue?

If you do this with a commit object or tree object, fsck does complain.
I think it's sensible to do so for blob objects as well.

Editing blob object:

hurricane:/tmp/moo (master)$ hexer .git/objects/a1/b3ebb97f10ff8d85a9472bcba50cb575dbd485 
hurricane:/tmp/moo (master)$ git status
On branch master
nothing to commit, working tree clean
hurricane:/tmp/moo (master)$ git fsck
Checking object directories: 100% (256/256), done.
hurricane:/tmp/moo (master)$ git gc
Counting objects: 3, done.
error: garbage at end of loose object 'a1b3ebb97f10ff8d85a9472bcba50cb575dbd485'
fatal: loose object a1b3ebb97f10ff8d85a9472bcba50cb575dbd485 (stored in .git/objects/a1/b3ebb97f10ff8d85a9472bcba50cb575dbd485) is corrupt
error: failed to run repack

Editing tree object:

hurricane:/tmp/moo (master)$ hexer .git/objects/d4/eda486f02e3e862e23f6eb3739a25a2ca43f20
hurricane:/tmp/moo (master +)$ git status
error: garbage at end of loose object 'd4eda486f02e3e862e23f6eb3739a25a2ca43f20'
fatal: loose object d4eda486f02e3e862e23f6eb3739a25a2ca43f20 (stored in .git/objects/d4/eda486f02e3e862e23f6eb3739a25a2ca43f20) is corrupt
error: garbage at end of loose object 'd4eda486f02e3e862e23f6eb3739a25a2ca43f20'
fatal: loose object d4eda486f02e3e862e23f6eb3739a25a2ca43f20 (stored in .git/objects/d4/eda486f02e3e862e23f6eb3739a25a2ca43f20) is corrupt
hurricane:/tmp/moo (master +)$ git fsck
error: garbage at end of loose object 'd4eda486f02e3e862e23f6eb3739a25a2ca43f20'
fatal: loose object d4eda486f02e3e862e23f6eb3739a25a2ca43f20 (stored in .git/objects/d4/eda486f02e3e862e23f6eb3739a25a2ca43f20) is corrupt
error: garbage at end of loose object 'd4eda486f02e3e862e23f6eb3739a25a2ca43f20'
fatal: loose object d4eda486f02e3e862e23f6eb3739a25a2ca43f20 (stored in .git/objects/d4/eda486f02e3e862e23f6eb3739a25a2ca43f20) is corrupt

Editing commit object:

hurricane:/tmp/moo (master)$ echo test >> .git/objects/47/59a693f7e8362c724d3365fe6df398083fafa0 
hurricane:/tmp/moo (master +)$ git status
error: garbage at end of loose object '4759a693f7e8362c724d3365fe6df398083fafa0'
fatal: loose object 4759a693f7e8362c724d3365fe6df398083fafa0 (stored in .git/objects/47/59a693f7e8362c724d3365fe6df398083fafa0) is corrupt
error: garbage at end of loose object '4759a693f7e8362c724d3365fe6df398083fafa0'
fatal: loose object 4759a693f7e8362c724d3365fe6df398083fafa0 (stored in .git/objects/47/59a693f7e8362c724d3365fe6df398083fafa0) is corrupt
!(128) hurricane:/tmp/moo (master +)$ git fsck
error: garbage at end of loose object '4759a693f7e8362c724d3365fe6df398083fafa0'
fatal: loose object 4759a693f7e8362c724d3365fe6df398083fafa0 (stored in .git/objects/47/59a693f7e8362c724d3365fe6df398083fafa0) is corrupt
error: garbage at end of loose object '4759a693f7e8362c724d3365fe6df398083fafa0'
fatal: loose object 4759a693f7e8362c724d3365fe6df398083fafa0 (stored in .git/objects/47/59a693f7e8362c724d3365fe6df398083fafa0) is corrupt

D.
