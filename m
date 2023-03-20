Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5849EC7618D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 13:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjCTNAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 09:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjCTNAF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 09:00:05 -0400
X-Greylist: delayed 2588 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Mar 2023 06:00:02 PDT
Received: from ms-10.1blu.de (ms-10.1blu.de [178.254.4.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323C45FFB
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 06:00:01 -0700 (PDT)
Received: from [178.254.11.41] (helo=sh4-5.1blu.de)
        by ms-10.1blu.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <guru@unixarea.de>)
        id 1peERY-0000EF-4F; Mon, 20 Mar 2023 13:16:52 +0100
Date:   Mon, 20 Mar 2023 13:16:51 +0100
From:   Matthias Apitz <guru@unixarea.de>
To:     git@vger.kernel.org
Cc:     Matthias Apitz <guru@unixarea.de>
Subject: small documentation issues
Message-ID: <20230320121651.GB9@sh4-5.1blu.de>
Reply-To: Matthias Apitz <guru@unixarea.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Operating-System: FreeBSD 12.0-CURRENT r314251 (amd64)
X-message-flag: Mails containing HTML will not be read!  Please send only
 plain text.
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Con-Id: 51246
X-Con-U: 0-guru
X-Originating-IP: 178.254.11.41
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hello,

For the migration from SVN to a local git repository I followed the
document https://git-scm.com/book/en/v2/Git-and-Other-Systems-Migrating-to-Git
Chapter 9.2 Git and Other Systems - Migrating to Git
and run into two small issues.

1)
It is explained as an example how the files users.txt should look:
schacon = Scott Chacon <schacon@geemail.com>
selse = Someo Nelse <selse@geemail.com>
I did the error and let away the user fullnames, puting only the mail
addr in the file, i.e. like
schacon = <schacon@geemail.com>
selse = <selse@geemail.com>
because in my case the file has ~50 entries and in some cases the
person's names are not know anymore. This gives the error:

...
        A       sip2slnp/src/main/Sip2SlnpDaemon.c
        A       sip2slnp/src/main/Sip2SlnpServer.c
fatal: name consists only of disallowed characters:
32768 at /usr/lib/perl5/vendor_perl/5.26.1/Git/SVN/Ra.pm line 476.

and it took me a while to understand that the message means that the
full name MUST be there. IMHO this should be noted.

2)
The page says in the section about cleanups after cloning that the
branch 'trunk' should be delted, but this gives an error:

    git branch -d trunk
    error: branch 'trunk' not found.

I do have only:

    git branch --list | egrep 'master|trunk|HEAD'
    * master
      origin/trunk

Thanks for the good doc.

	matthias
-- 
Matthias Apitz, ✉ guru@unixarea.de, http://www.unixarea.de/ +49-176-38902045
Public GnuPG key: http://www.unixarea.de/key.pub
