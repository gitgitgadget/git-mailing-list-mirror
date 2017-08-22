Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1A0B208D0
	for <e@80x24.org>; Tue, 22 Aug 2017 23:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752810AbdHVXhg (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 19:37:36 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35413 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752376AbdHVXhf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 19:37:35 -0400
Received: by mail-pf0-f195.google.com with SMTP id k3so149400pfc.2
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 16:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SECbTRns1U3EZ2KHcZ+cEHHE0mbmpT4xoZZPpOOIPhE=;
        b=XishfWAzifJ2Yiecb6bPHSbKiBQuPx2HsxTTGJKxA9MXa/QLO+ufv0/5udehw8PLVI
         jjnx6QZiYK/z2ZHn/ImCNp/RO9h1ZQDQ1bKqimFNWN9XhObWELI/ixJCAJbAbIOpR5Ir
         8KCnS1gzSJFNYK9ufr4TOnoMuq9UfclIzNucVAMo1BTQm8w9egFcdAVabIRKKjwBQ547
         3fbUKvOa0OTTo6ENgxaBFxyrF9E8Ipfkb6M9ud5skwnn+hPfsX8EbeVBF+9te1qmlSXy
         cyKutd2ypMVZUjxMhvCKZuzfrUvf3j+Qtpin2IUNmW1zlisIPFL5hjKZvBKu3B1aWazA
         lILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SECbTRns1U3EZ2KHcZ+cEHHE0mbmpT4xoZZPpOOIPhE=;
        b=CLhABblfgW/HE52RQkRmmXZttYB9ndJKmL219ZBr0UnIDq1WFACHM58A12K51RtqhI
         hPfaJb/u9Cuo0vLWI5MzhX4ZOrIoB09LklhFlmoEUriivuC/BbZQHlBdnDBlhg5XvF5Q
         6L6C22ehbGzlBY6rRQsNQzxxlf/CzLRbp39l9uALM1oYAmsJBnlHMrvPhNnRf+8eVSZM
         4HdkYAKYta8CoEzfRR8Xz1Jy2RJlUpLgHoEcI/Cdv5SgndVL/yxlv+zhW/xvr3aXxZpb
         1rvT78+dkZ6ZRRjyqGzy4l38E+qH4OGIUzIJPp6/dOBqX8nkItzVCy+qaKCEGjXnC+Ny
         l+iw==
X-Gm-Message-State: AHYfb5gQHyvW18ZRa8KGJz1Eq9lo/52y/twEIPOcdSMVT5QrMQi6nub8
        3G9Ytl3B1uHWYfTq7LU=
X-Received: by 10.84.171.132 with SMTP id l4mr834798plb.183.1503445054603;
        Tue, 22 Aug 2017 16:37:34 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:dc68:f470:52d1:2c63])
        by smtp.gmail.com with ESMTPSA id v78sm146588pfd.121.2017.08.22.16.37.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Aug 2017 16:37:34 -0700 (PDT)
Date:   Tue, 22 Aug 2017 16:37:32 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] vcs-svn: remove repo_tree library
Message-ID: <20170822233732.GX13924@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan noticed that repo_init from vcs-svn/repo_tree.h conflicts with
repository.h[1].  Earlier brian m. carlson noticed the same thing[2].

Originally repo_tree.h was used to manage an in-memory representation
of the state of the svn tree being imported.  When that in-memory
representation was retired, we were lazy and left some utility
functions there.  Here is a patch series to finish cleaning up and
remove vcs-svn/repo_tree.h completely.

This is an alternative to bc/vcs-svn-cleanup from 'next'.  Those
patches weren't cc-ed to me and I missed them --- sorry about that.  I
can rebase on top of them if that is more convenient.

Thoughts of all kinds welcome, as always.

Thanks,
Jonathan

Jonathan Nieder (4):
  vcs-svn: remove prototypes for missing functions
  vcs-svn: remove custom mode constants
  vcs-svn: remove repo_delete wrapper function
  vcs-svn: move remaining repo_tree functions to fast_export.h

 Makefile              |  1 -
 vcs-svn/fast_export.c | 41 +++++++++++++++++++++++++++++++++++++----
 vcs-svn/fast_export.h |  3 +++
 vcs-svn/repo_tree.c   | 48 ------------------------------------------------
 vcs-svn/repo_tree.h   | 23 -----------------------
 vcs-svn/svndump.c     | 33 ++++++++++++++++-----------------
 6 files changed, 56 insertions(+), 93 deletions(-)
 delete mode 100644 vcs-svn/repo_tree.c
 delete mode 100644 vcs-svn/repo_tree.h

[1] https://public-inbox.org/git/20170822213501.5928-1-sbeller@google.com
[2] https://public-inbox.org/git/20170821000022.26729-3-sandals@crustytoothpaste.net
