Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1410C433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 14:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F9660F0F
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 14:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbhKLOaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 09:30:14 -0500
Received: from gateway30.websitewelcome.com ([192.185.179.30]:30494 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235211AbhKLOaN (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 12 Nov 2021 09:30:13 -0500
X-Greylist: delayed 1283 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Nov 2021 09:30:13 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 4CA9C2ADEE
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 08:05:58 -0600 (CST)
Received: from box5922.bluehost.com ([162.241.30.80])
        by cmsmtp with SMTP
        id lXBmmbY2kG0jLlXBmmWELQ; Fri, 12 Nov 2021 08:05:58 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jsqBFApZBo/oekxu6MbzfaOfLhWrulqDP2pQ1ijIF/U=; b=sdF76MAUI8sECoMY8H7Uw/+CEP
        HKVgDjOosyjDmnfbenfV+4T2n7bK4imP0aSWPi2I68tcsXK8VbPRF3MVcf5mdPDGTN55wnUzf41Dy
        VnQkbuHA23H2hNcf7SMRFlS4j;
Received: from pool-96-233-64-159.bstnma.fios.verizon.net ([96.233.64.159]:44028 helo=pdslaptop.home.arpa)
        by box5922.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <paul@mad-scientist.net>)
        id 1mlXBl-003DpR-WB; Fri, 12 Nov 2021 07:05:58 -0700
Message-ID: <fd7946fac4e1e43b8fd9dbeb8cab22d83d7094a8.camel@mad-scientist.net>
Subject: Re: bug report
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Theodore Li <teddy.litheodore@gmail.com>
Cc:     git@vger.kernel.org
Date:   Fri, 12 Nov 2021 09:05:56 -0500
In-Reply-To: <CAHPjYFyH+GuBG8QNzD36JhoJWyNnEXfqpn4PUJV0ANF2ertYZg@mail.gmail.com>
References: <CAHPjYFyzPpUmfoCbvaVg25ZbhkHU8QtxHBmAh2gdT++Xr38HcQ@mail.gmail.com>
         <xmqq8rxuj8s8.fsf@gitster.g>
         <CAHPjYFyH+GuBG8QNzD36JhoJWyNnEXfqpn4PUJV0ANF2ertYZg@mail.gmail.com>
Organization: Please remain calm--I may be mad but I am a professional!
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5922.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 96.233.64.159
X-Source-L: No
X-Exim-ID: 1mlXBl-003DpR-WB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-96-233-64-159.bstnma.fios.verizon.net (pdslaptop.home.arpa) [96.233.64.159]:44028
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2021-11-12 at 01:59 -0500, Theodore Li wrote:
> Yes, though other patterns like !/*/ don't need the quotes. I thought
> it worked the same way without the quotes in earlier versions, but
> after testing with version 2.32.0, it seems like the behavior is the
> same. Guess I remembered wrong.

It's important to realize that in a POSIX-style shell (as you'll find
on GNU/Linux or MacOS, or in the Git for Windows shell), wildcard
expansion is performed _by the shell_ before the program is even
invoked.  It's not performed by the program itself (in this case, Git).

In a POSIX-style shell it works like this (by default): first the shell
will try to expand the wildcards in your command line by matching them
for files.  If any match, the wildcard expression is replaced on the
command line.  If no files match, then the wildcard expression is
passed to the command without change.

So if you run:

  git sparse-checkout /*

then the shell will check if any files match the wildcard /*: since
clearly you will get matches for this expression, they will be expanded
and the shell will actually run:

  git sparse-checkout /bin /boot /cdrom /dev /...

Note, Git does not receive any indication that there ever was a
wildcard expression here!

On the other hand if you run:

  git sparse-checkout /blah/*/blah

(assuming you don't have any files on your system that match this
wildcard) then it won't match and the shell will run:

  git sparse-checkout /blah/*/blah

Now Git can examine this wildcard and do an appropriate thing with it.

In short, if you want to be _sure_ that a wildcard expression is passed
to the command and not expanded by the shell, you must always quote it:

  git sparse-checkout "/*"

If you don't quote it then it may or may not do what you intended,
depending on whether the wildcard happens to match any files.

