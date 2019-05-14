Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 277501F461
	for <e@80x24.org>; Tue, 14 May 2019 14:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfENOw5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 10:52:57 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:44053 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfENOw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 10:52:57 -0400
Received: by mail-oi1-f181.google.com with SMTP id z65so5098329oia.11
        for <git@vger.kernel.org>; Tue, 14 May 2019 07:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=EI2R/c9RJbtdykQMw14pGZk+C+6hnFlIS3crFuaPP+M=;
        b=qslBqn4XdiyNPoxhOATpVBoP86ZxfPIBprWmikD5EUOzY2iUw+ICo2CCPhEpvZwRN8
         S6sw2sHm0WAnqARwaHU+w80b2mdimQTyPpzDYXCe5WBM8YI25rjyRS4wEecGy0sv0zz7
         qcKF1nsnHhvS7UjMuxFVSmjsZFGSyLg0tyCY8r2brPD9NaTro/W6/NzRi1H+kZeimi+d
         6o/wszXHgmPkNzlACwKmol7coixIMtLNp21WkP02IemQ9CEhW7C7RK580akS6SB5ArxQ
         IY8spSbbKdjKfF6Pp6ATjwifSF23bKb5VTVoKd9POJQZwqis/S8nZl59JTatUM0Kx/89
         9vDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EI2R/c9RJbtdykQMw14pGZk+C+6hnFlIS3crFuaPP+M=;
        b=rOz9zkCeMSZH2a9RGbMw4BCn/zn0i47OionfqPnGN1AfozAqbiyKEzaSyMxqXj8hug
         +DLNLjshRf2vX3EW0SwdbaK6xJF1L40pjrqGZAJPPNN8zJgr+sLKH0Cz2y4IGnvtoKxV
         HoQxC8CAn0sGUIpa1oGbz7lG7fodATmpH/T7uk9CjztcU6hSuFJ8CyQESFD1uL+ltPnV
         lgSRaYhlYq/mWlDLxpn5li5/8yi9Xqfw0wSK5LGG5lsrbgjig1MXfqscS16BoRhrveKp
         dqBXBMnY34SVoIPGp2xQ4UCAUlgep4dHinNAKbtj1cdwCw/EelItEEgm8MXoFTUCm+Hj
         R2xw==
X-Gm-Message-State: APjAAAUT1N3git9speAQW9ie1Jp+yGckFK5vlv7k1aNmHNnf9Ho0Fran
        mRWQHMZCcDaDULGqbXhaYazEHrJvQIYpDHP68NPb3FOe
X-Google-Smtp-Source: APXvYqxyEdb6lD4paxw5hvZJJH2GwKHvBs7XFgzFkeP8er6raJCf9upyTGjbbwpWqLJQ5R6eZVwTtWg/XNc8m+6xjAE=
X-Received: by 2002:aca:fccf:: with SMTP id a198mr3064880oii.69.1557845576461;
 Tue, 14 May 2019 07:52:56 -0700 (PDT)
MIME-Version: 1.0
From:   Cosmin Polifronie <oppturbv@gmail.com>
Date:   Tue, 14 May 2019 17:52:45 +0300
Message-ID: <CAJFQqN+Z9eX6onaj8vVSqpvf-nOC7-Y0Un4NLUie6x6bGfmvZA@mail.gmail.com>
Subject: Running 'git worktree add' in 'pre-commit' hook
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello! I am trying to run 'git worktree add <path> HEAD' in the
'pre-commit' hook, more specifically in a Python script that is being
called from the hook. When doing so, I am greeted with the following
error:

On Windows 10:
Preparing worktree (detached HEAD cbfef18)
fatal: Unable to create 'C:/Users/meh/Desktop/abc/.git/index.lock': No
such file or directory

On Arch Linux:
Preparing worktree (detached HEAD cbfef18)
fatal: Unable to create '/home/cosmin/Downloads/abc/.git/index.lock':
Not a directory

Is it forbidden to call this command from a hook? If yes, what kind of
alternatives do I have? I need to make a copy of the repo in its HEAD
state, process it and then decide if I will pass the current commit or
not.

Thanks! :)
