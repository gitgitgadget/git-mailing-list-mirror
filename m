Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4969820357
	for <e@80x24.org>; Mon, 17 Jul 2017 19:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbdGQTeo (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 15:34:44 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:32775 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdGQTen (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 15:34:43 -0400
Received: by mail-io0-f196.google.com with SMTP id z62so404407ioi.0
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 12:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaust.edu.sa; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=ErTCVK+qgDTSns9j2gFMT3+tojIjrEzwzCYkCBzsHZY=;
        b=b90g++qaYLdvmTpwwhM67UP3mSpmrszU/dkL4YmXZEOBuI9g0111KrWkuta8yBGd7S
         hRfMa+Wtnd0LjxdXYXeMAjvwbr8H8UhDy5ZMj9wgmWgtU9SkZQSYCJrgEyKpfw4ersPY
         tRzX1o+tcPqMJpRqP8tlK2vxWQ1KldvXzvHkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ErTCVK+qgDTSns9j2gFMT3+tojIjrEzwzCYkCBzsHZY=;
        b=EmirRqf6O/Uh1rDtI2S3zR6kH26FbhSB0kUhk7g+YChvMAu2LwMXwSGwxQo6mv6idu
         7kzhf3ewc9WAD6g6zo25hq+yAyqhoNgEbDCwj9g10TS3FdqxaabYOZEIch2k9CBjdGFC
         G6usjYU2iI3YUGHvPnc+Kftsm5p4W8uxWIJBlF9b4Kocn9wmS7jOvb4qphwSLf76oGoG
         iiARmoMa3pRw+Qn365AtiTjiSmpjGov7X7RrIn2PoOaaILfdidw/+bQjaz79tA3eYEJv
         0wLdi9sMxgnODUlHdsfJP5S4Xr6n7e6crgWtRiehHsrsWKfgzXtOnDAaOQuYl3OaQGc0
         Ab+A==
X-Gm-Message-State: AIVw113RdJLCOHdHkIx6BLYc10H7cxy3haN6VT8Y0qPm6HkuGU3svMIw
        X9iiCNB50SI5+LxasAcwJ2mE0B/Jxtmc4i1hn5MLb4rZwguZOKhEsNhCD3v3V4DXGFmWJ6d61jJ
        U9/x6pfQ675T0hg==
X-Received: by 10.107.151.21 with SMTP id z21mr20025683iod.205.1500320082395;
 Mon, 17 Jul 2017 12:34:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.129.152 with HTTP; Mon, 17 Jul 2017 12:34:41 -0700 (PDT)
From:   Yazeed Sabri <yazeed.sabri@kaust.edu.sa>
Date:   Mon, 17 Jul 2017 14:34:41 -0500
Message-ID: <CAL+VFimBfxTrRVme_aMzF4yYRnru0hHD4VzxEtD8hHY6rx2ykA@mail.gmail.com>
Subject: Documentation lingering inconsistency between working directory and
 working tree
To:     git@vger.kernel.org
X-KAUSTGmailUsers: PPSPAMCheckPass
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I have been reading the git documentation for a while now and came to
realize that in a
lot of commands the documentation is ambiguous when it comes to the difference
between "working directory" and "working tree". I'm aware of the
changes to status
in this commit for example:


commit 2a0e6cdedab306eccbd297c051035c13d0266343
Author: Lars Vogel <lars.vogel@gmail.com>
Date:   Thu Jun 9 20:19:30 2016 +0200

    Use "working tree" instead of "working directory" for git status

    Working directory can be easily confused with the current directory.
    In one of my patches I already updated the usage of working
directory
    with working tree for the man page but I noticed that git status
also
    uses this incorrect term.

    Signed-off-by: Lars Vogel <Lars.Vogel@vogella.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/wt-status.c b/wt-status.c
index 4f27bd62a..4ce4e35ac 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1554,7 +1554,7 @@ void wt_status_print(struct wt_status *s)
                        else
                                printf(_("nothing to commit\n"));
                } else
-                       printf(_("nothing to commit, working directory
clean\n"));
+                       printf(_("nothing to commit, working tree
clean\n"));
        }
 }



and more frequently used commands like add are consistent as well. But a
grep on the documentation to a pull I did today, shows that a lot of
commands are still
not updated accordingly.

This brings me to my next point, so what is the precise definition of
each concept? Is
working directory just an outdated mistake?

Was the change in status above made to solve the confusion and denote
that status
is unique per-working tree given its HEAD? If this is the case, then
is gc unique
per-working tree too, or is it done on the "database" like fsck? Same
idea with stash,
does stash care on what working tree it was called? If not, does it
make sense for
it to do so?


Best,
Yazeed

-- 

------------------------------
This message and its contents, including attachments are intended solely 
for the original recipient. If you are not the intended recipient or have 
received this message in error, please notify me immediately and delete 
this message from your computer system. Any unauthorized use or 
distribution is prohibited. Please consider the environment before printing 
this email.
