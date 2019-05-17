Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CD601F461
	for <e@80x24.org>; Fri, 17 May 2019 17:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfEQRDq (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 13:03:46 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:41262 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfEQRDq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 13:03:46 -0400
Received: by mail-lf1-f42.google.com with SMTP id d8so5829188lfb.8
        for <git@vger.kernel.org>; Fri, 17 May 2019 10:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ARdXs5lu/lU9h5LWgoyD+65xLgXzKF9d2Z9DEHO49c0=;
        b=bB4N9u1DLakSubY0tbT+qx5UKtdrVmwd3SbWGyzsSX/wA8iPXumYEvF3pzt0zCW3xf
         dADz0Tb0pnU7oVuqX/IllHhjAsA+AL2GdMxsOeBhRnEKVVOuQvnHmwYElpZi9LTzRvpM
         GGfd42Owm9Tf7eRlNofRmumVEQoh6B4sd9kYVDJkO7yD7z2OnqhTTiWbdlJK5nrGr6Ak
         1rtCtFJLsD4KNIR9V9hB5zj36yjqt8Qt5wYJ0i1fwNHSGdtRnfRc7aYKvvZD1eolGkCC
         PRwSqOi2VvSJlY5/FjRuhSlwexm2Owp0lm2wb+ze724PS4hh2P0sGpCEdLbNXqIBe4Va
         oEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ARdXs5lu/lU9h5LWgoyD+65xLgXzKF9d2Z9DEHO49c0=;
        b=BGe5ZK/DHyYd2sIYu3ZgZJsBqedrYtTS+c58gXxokD2u7aiHynKHPIFTwaEGtOH+oz
         ByCoTGC9jzA/RhT+mB5vRhZ+FvgfsYUMw3Jbv9kkPoVXgwQLoysfyWMsudj9UPtukECZ
         gfYzqhfI8lpsrq6Tff4TKvk6lgrZiLqMdbixJTMF5s9ZElEZL6to06b/6EHMqZvBHQZc
         QM+C/YnL2I1kT/HYTFirA5JxdAcCtMYde/MsF5bWne2tNajMKFjItj3UFV3KTW9s4MK5
         tcca7n1axFmzHtAhtiZNFuMgsIJ2wqIqQjh8aZt/KGfmJMtZ7WJDRXCwjDFqY84DxT0D
         KTaQ==
X-Gm-Message-State: APjAAAXXByh+wa0aBIth+Gd5IK/jQ80YcRSRmeaQ/PtT/Od6GnzSfCF0
        nwYO1UCFtg6vRvX2TsVO/BeG1N9IKbEF+ZJYbgaEVlrg
X-Google-Smtp-Source: APXvYqxBxDmy6pPh0TODxNAqECgbAL6x08ghBSaGC8w6VKTFp7t0mUbooiGd73a8l8oDf0CKXWTXuyhI1j5T9uQFnUI=
X-Received: by 2002:a19:9154:: with SMTP id y20mr19955811lfj.87.1558112624561;
 Fri, 17 May 2019 10:03:44 -0700 (PDT)
MIME-Version: 1.0
From:   Rocky Ji <rockyji3438@gmail.com>
Date:   Fri, 17 May 2019 22:34:31 +0530
Message-ID: <CAN2Gq-Rb3v8-8PKmKUGKJ3wP-UvAF2n59a9UGbtjiGibE8q=zg@mail.gmail.com>
Subject: How to update Git's metadata without affecting working dir?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am working individually at the moment.
I have the habit of committing related changes on a regular basis, but
I push to GitLab only at the end of class session.

-------Events to reproduce the situation--------

Thursday, in school:
- `git clone https://gitlab.../my-repo`
- create a few .rst documentation files
- commit the above changes before I `git push -U origin master`

Friday, in school:
- start working on new feature, create a test file `test_A.rb`
- I commit the changes but forget to push

Sunday, **in home**:
- I `git clone https://gitlab.../my-repo`
- work on the exciting new feature that popped in my head, create `feature.rb`
- commit the changes before I `git push -U origin master`

Monday, in school:
- running `git status` shows `Your branch is ahead of 'origin/master'
by 1 commit.`

--------end problem reproduction----------------

Questions I have

1. What will happen if I follow Git's recommendation `use "git push"
to publish your local commits`?
2. How do I resolve this situation? I don't want loose any information
i.e. preserve `test_A.rb` and `feature.rb` along with their commit
messages and timestamps.
3. Why does Git assume that local-working-dir is "ahead" without
consulting the Gitlab server first?
4. How to make Git "consult" (but not mess the working-dir) GitLab
repo before starting my day's work?

Thank you.
