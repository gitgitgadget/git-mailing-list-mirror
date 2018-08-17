Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9FC11F97E
	for <e@80x24.org>; Fri, 17 Aug 2018 13:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbeHQQRb (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 12:17:31 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:35632 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbeHQQRb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 12:17:31 -0400
Received: by mail-lj1-f175.google.com with SMTP id p10-v6so6340293ljg.2
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 06:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=eS1Oi0q38mTa46astenWKE1YthLYB6YGMVXRCRKnZlM=;
        b=iMuwKY+8jSwgeEZIkSEI17AJO1+zCWIP4xBDElmSrVMc8J82/WrZRt4buxyFSQEnkL
         IB26fEs1cCnZOu/kq/Yh69zKIcd2tsa3zvffJ+hJFbiy/XUUYYnzXZTI74XyDhzEq/hO
         KVtMjyY9QshheHup/81JqODbaTotjD6nM0v8wo5Z0AnjNLjT2yIBPAtTIV6Y1wSEVk4f
         RmXZEDt8hHh83Biyi+FZuPwNT/5a7lJ4KuNNoNnhRQrFoCLyHJhGpkbOddmJIppY49rZ
         /+nQEpdqjh1PUD9D2U/Iz1R+fhzHG1vDUzlfr7jNC6vwwKFwd7fm8KHJDleYpO5kKI10
         w8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eS1Oi0q38mTa46astenWKE1YthLYB6YGMVXRCRKnZlM=;
        b=OaGupYITe0TTebljum80KGwG1Yn+BJ2ZKEeY2J7zvcnN7GD9v0bQWACph/tqUe7ua5
         WapBoeS72QZjzGDJWLfrNDIYpOPt/1yGOZCxPmCwthcRp4cR8YKDNb0OyKTCu6z0SyCC
         b35M88FaTMaQn0k3JkpntZn7i7DGujNkt0JpfMuVIofvdSffb3LgxlkuDfngXqRCyPEH
         ddEjD9bGwC6hKePyQGGYhYHjca9wVglXMRY4W7m785o9tfh0T8WZir0Bv1qVJSMuGrN0
         486WgCukBgIGkV/k0eq58c4Hx6vfYkYE3tpm9GYRhKe7xlWYXghtsIfKoPP+ufuuHqNg
         tBLQ==
X-Gm-Message-State: AOUpUlFi6iNgVO6x4wXTKJhw557vrbw/d5pjFLzFLpkSOr/ouFo9i4go
        dAfqTthTsUOFdueeZlOpMn5kUJcFMrV0ZJmUcx+2JUKa
X-Google-Smtp-Source: AA+uWPyifS2VvAYgHSALazdQ7m0katrycMZJhLAoEj0Tfrd9RyWKWfWfQYdq2pIt47g5gu5FGHt1SJ73x/t7Lngkk08=
X-Received: by 2002:a2e:83d7:: with SMTP id s23-v6mr8386929ljh.82.1534511647373;
 Fri, 17 Aug 2018 06:14:07 -0700 (PDT)
MIME-Version: 1.0
From:   Samuel Maftoul <samuel.maftoul@gmail.com>
Date:   Fri, 17 Aug 2018 15:13:56 +0200
Message-ID: <CAFj+z07x=X0_8Tdg6KsVwyRhcaUTGrSA2=t5W91m9b702A0xUA@mail.gmail.com>
Subject: [RFC] git send-email hashbang
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently contributed for the first time patches on this maillist and
used for the first time `git format-patch` and `git send-email`.
I had hard times making `git send-email` work on my mac, because the
OSX bundled perl was missing the Net::SMTP::SSL module.
So I did `cpan -f Net::SMTP::SSL` (I'm using gmail with smtps/ssl)
which asked me some questions (to setup cpan, I'm not really using
perl usually), and installed the module.
Still `git send-email` wasn't able to find the module.
Actually, during the setup of cpan, I have been asked this:

--------------------------
Warning: You do not have write permission for Perl library directories.

To install modules, you need to configure a local Perl library directory or
escalate your privileges.  CPAN can help you by bootstrapping the local::lib
module or by configuring itself to use 'sudo' (if available).  You may also
resolve this problem manually if you need to customize your setup.

What approach do you want?  (Choose 'local::lib', 'sudo' or 'manual')
--------------------------

I have naturally choosed the default ('local::lib'), but it still didn't worked.

So I choose to not use the system bundled perl and installed my own
perl with homebrew, installed the Net::SMTP::SSL module ... but still
, it didn't worked.
I looked at the send-email script, changed the hashbang to use
/usr/local/bin/perl instead of /usr/bin/perl and it worked !

Then I wondered what happened, and I discovered that using the bundled
cpan's "sudo" approach works, but I'm not very satisfied that I need
to be root to make this script work.
I also found several stackoverflow questions, gists and other
discussiond with people having this exact problem (on osx) with some
different solution (mostly not working, using `sudo cpan` or
whatever).

It seems strange to me that the script doesn't uses "the perl I use in
my environment", that is, I would have thought the `git-send-email.pl`
script had `#!/usr/bin/env perl` as hashbang.
Then, I read that some environment (namely busybox) don't bundle
`/usr/bin/env`, so I understood this might not be portable.
I think there is a solution involving using a combination of /bin/sh
as hashbang and there executing perl with probably the `-x` flag (see
`perldoc perlrun`).
Is it worth proposing a solution for this problem ?

Thanks !
