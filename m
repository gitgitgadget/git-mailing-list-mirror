Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81B541F667
	for <e@80x24.org>; Tue, 22 Aug 2017 21:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbdHVVz2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 17:55:28 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33583 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbdHVVz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 17:55:27 -0400
Received: by mail-oi0-f52.google.com with SMTP id f11so277964oic.0
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 14:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=OL5jFg6euRXm/0UFtDvCKjQhyGoeMiTtAF/OpZkLuOc=;
        b=evbGGA0fSmsfDbt+/KfIQjq6EP2R3S2vp09u6poi9u251JlKU6ENT5AQNNA/sD5YLP
         80Q2xT5wU01tRBpVsU8t7yxdWUW7ePVL3cKxvWswxxA00tYmXcFj2H7C4EmPK7/EGBQq
         hRDhqYlLvvG1uKFd/u/8Y2IL7tbsMH6aOf5zUn2Av4BNyjNIan7XqkixK9bZnB9WUajN
         HteaQ4VixRvKn4JpBBGiJ18inco4rmpbgyaKZ0EDseLpVQKtPXDUBS4yY+uFzTBihPxi
         VCIrn6IJVqTXn2oXlQt1joC17jKkkGrFGNJ0snSkvCXuvREv0Hwj7zBgsy7B2nO/9K4Q
         xy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=OL5jFg6euRXm/0UFtDvCKjQhyGoeMiTtAF/OpZkLuOc=;
        b=QRf0aFWgrZVDbWJHBRS8/s//n85x/mjXV7TuKGhbgLLE7KymOojjqj30P5YJRTpRlV
         xVMlwrI+xk2qkyOzrnY2GoH/HCtMum0lIMOchSjgnRKnPTsHA8YrRbYMeif18hvG8Jus
         NWQdU0Scry3H84EJs/xjLsDWENoNc0ZrGdhOvCLxu7YcrqT5YTHxxAW7RcJQWk1kLqgI
         mdohgIy/SjVHK3dE1oQc8c3ELbeHYDLPTo4RWvQwtWIBbYRBCDRJeJH/LUNXSKILuo8r
         6Ue9Yp6MDlFxkItuWNSslJJxa/Os9SnR+FpoClvsZgirsJhCwF7nqJv6DvT5mXByiDX9
         J3Tw==
X-Gm-Message-State: AHYfb5jKXtn3GDJllikr3VMo3ETOIZlWMHQ7mrZ18Atm6TfbWHdWKHtp
        o/Jy6gTl4+sS0J6A7Mzoo/cyXnStbC7j9wE=
X-Received: by 10.202.75.137 with SMTP id y131mr893838oia.26.1503438926716;
 Tue, 22 Aug 2017 14:55:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.98.28 with HTTP; Tue, 22 Aug 2017 14:55:25 -0700 (PDT)
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Tue, 22 Aug 2017 17:55:25 -0400
Message-ID: <CAH8yC8=A0-geqduTNNJw0yb1BREqsB75_bKSp+06Rb5fY6oiuQ@mail.gmail.com>
Subject: How to force a push to succeed?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I tested some changes that lead to a dead end. The changes need to be
removed. The changes were added in 7 commits.

I went back in time to the point before the changes:

    $ git reset --hard HEAD~7
    HEAD is now at 559fc3b Fix benchmark selection code (GH #464)

When I attempted to push:

    $ git push
    Username for 'https://github.com': noloader
    To https://github.com/noloader/cryptopp.git
     ! [rejected]        master -> master (non-fast-forward)

I tried to commit, but Git claims there's nothing to add:

    $ git commit
    On branch master
    Your branch is behind 'origin/master' by 7 commits, and can be
fast-forwarded.

Commit seems to be the wrong command as Git appears to be trying to do
something I don't want.

How do I force the push to succeed?

Thanks in advance.
