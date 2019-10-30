Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEAFA1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 05:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfJ3F0y (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 01:26:54 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:40638 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfJ3F0y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 01:26:54 -0400
Received: by mail-io1-f41.google.com with SMTP id p6so1066095iod.7
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 22:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=ZHf8clN3/uDlJYuYgi+g4RHbTKtC0FG5a8ngJTFUiHQ=;
        b=KhpZd1xaDn03aeovEAmObRjfYdnLnQIAoT9Fo4oa3wzjvoY2KOm0+N/JcmzxBl1j9G
         YbeHMqmxbEUoHR+7gX42jtJH2n3d/NkmCJcg8dEUblOAaldvAJ4TRCyiqN4nM/gNsn2u
         kNT7mb/y+EDn6yz+e3UZvpLBtquE1xrSjwRhcrDlnvaLtYIVM0ABF+nOLzkL52uZYaTw
         qjxqf96KO0u1qGXvFGb6EDlMhJpIn3Bjdtnb2GD3jiqW6PqkCz3CjvoJEuksxZOM4ao1
         rlUdjql+ah0s47TTCXEYukEOKJXZxNUny0t23UH2d7NFS5qq1Bp8V2mJNVRumRQzXs3s
         ixgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=ZHf8clN3/uDlJYuYgi+g4RHbTKtC0FG5a8ngJTFUiHQ=;
        b=Yxpbrr5IChi4Yy1GlzLzjd2kcQX4usTEEuDlAn7QW9aLe/Zep00ujeEDA7TtBpGOia
         ronlgRFi0gp7Rq19ssIaaozIXbRCv/26IEjWQvh2KpiRaqYBJBlbpZ6hWsIz5IvnP/gm
         EubvQyZ9J0j23ywscclI1FgBVetlrznWyTeIu3LefNEm9TJxBuEGqFSzDZL6h8LnIekk
         idBrCAR4ROHH6gGYFqou4G6kRqb3UaNVQH6s6XvNyUMKZRCAxkQEodcXWa0F7aNArNx8
         r2zN6fQ+YDzXz6cw4icYatxqUrM+ZtX1t+o70Fn73KRg+CuEFBoY/1qYq9MI7y7QdA3M
         tj/A==
X-Gm-Message-State: APjAAAVDL2vCsLk2JgrkSYhyREUh7c+7QdIADErGuoPQauNfx0bjA2Yk
        9waeXzCyu+SEtsFioMZ84j7bt0xG4QT9SYE2jesGUzvm
X-Google-Smtp-Source: APXvYqwTNMDH7QGfhM3ASzXJwC/mXSm/tRHQ4MysNBcrT7JehBPo/SzMGBZ+2YgtQrvUZn6uN9Lnuwwp6l0o0ps2bs0=
X-Received: by 2002:a5d:9a0c:: with SMTP id s12mr5830567iol.41.1572413213108;
 Tue, 29 Oct 2019 22:26:53 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Wed, 30 Oct 2019 01:26:18 -0400
Message-ID: <CAH8yC8=uGb3J+fvkSj7-gdhqy0vtQw90K-MWQ3T1TTMQzAJnJA@mail.gmail.com>
Subject: SELinux context for Git user on Fedora server?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I'm trying to setup a Git server on Fedora 30 server with SELinux in
enforcing mode. I am following
https://git-scm.com/book/en/v2/Git-on-the-Server-Setting-Up-the-Server
.

At the push on the local machine:

  $ git push -v origin master
  Pushing to ssh://git@euclid:/var/callboot/source.git
  Enter passphrase for key ...
  fatal: '/var/callboot/source.git' does not appear to be a git repository
  fatal: Could not read from remote repository.
  ...

I suspect the SELinux labels for /var/callboot/source.git are not
quite right. Right now it looks as follows. httpd_sys_content_t is
typical for a web server and I think it needs to be something else.

  # ls -Z /var/callboot/source.git
  unconfined_u:object_r:httpd_sys_content_t:s0 branches
  unconfined_u:object_r:httpd_sys_content_t:s0 config
  unconfined_u:object_r:httpd_sys_content_t:s0 description
  unconfined_u:object_r:httpd_sys_content_t:s0 HEAD
  unconfined_u:object_r:httpd_sys_content_t:s0 hooks
  unconfined_u:object_r:httpd_sys_content_t:s0 info
  unconfined_u:object_r:httpd_sys_content_t:s0 objects
  unconfined_u:object_r:httpd_sys_content_t:s0 refs

What should the SELinux labels be for the Git user?

Thanks in advance.
