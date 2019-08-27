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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F3921F461
	for <e@80x24.org>; Tue, 27 Aug 2019 16:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbfH0Q13 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 12:27:29 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:34425 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0Q13 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 12:27:29 -0400
Received: by mail-ed1-f53.google.com with SMTP id s49so32154250edb.1
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 09:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lbUVNNjkuRyzIYQfh99xKrXWa3oftEJxGHsRRuG8PMo=;
        b=inOyn8qTWtTD1lQcC4tZfG07p1DRc1587PQ7P1V6W7rwrFPLW8dREp+cR6PrejQdVs
         A1vaJztJ2pIsbndloq7iPFIZRHqkgWqkiRVONc8jbMa5kkD46/AYziXMkjpoH/IFurXc
         GbAGr/DrTUyk0fHq7AbDsRfNAI7JGSNmOklSsSVVoyNw3J9nCf6MDd8/iSWII7AqcdV2
         nZPKkFfNBPAkolgWx/yN6qLXb7hvDzosMkvFziBkxmTsDhjlvC4xoiiZVMIsuTdlclyk
         FskkyMx8mQkUD3+y4grDNVo1am5EIF9XOA84ipyuSOdn9CjZye0Q3gahkiFGj7EDiYzO
         PlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lbUVNNjkuRyzIYQfh99xKrXWa3oftEJxGHsRRuG8PMo=;
        b=ZLw3Jx0hH1dliIibCmNUOh6+2/sXz512Zgc48xwfOTuAtGihG2DNqaamODsxfFldDo
         gTG8Uy01AEOvdO7L8a/WqArPxC6oU2/jsCIrA1YrmivR3zSDL8TQUdu4B4OfPbuOEDMk
         RJ7hNxvBBKfrlodcFwwagkIPJKruD21yhhpHMSezLZzklbmg4p6HVUGeSsNwjhX6oH2Z
         ApYIKeklp5RJVH0/n/c0Dtsm2D8Ytn7aLnv4VODItHpnQ7PtetCt7GjfIrMhZfgeEWRe
         f4g4wR7zd4ARBrH9Zqxx2tXfmFXQkrZOWlETTbSyZ+FSX2lPLTpwF75kDE8cq3NnVFV7
         WXjw==
X-Gm-Message-State: APjAAAXWtQtFjuBLvqH0kXtSnGoCgA7nb5n3cMR+Ps7aIFvx4sPu0A/F
        qxxGjn8JzVfvw72AVLxV1JiOF/7ZfUE=
X-Google-Smtp-Source: APXvYqw5uZe3nFPtf6qPHdSi4I8q5B251FAusfKXb5eYpWz+tLu3kG2K0QZNOs+rvVbgFDiRS7c6mw==
X-Received: by 2002:a50:f315:: with SMTP id p21mr25573565edm.195.1566923247179;
        Tue, 27 Aug 2019 09:27:27 -0700 (PDT)
Received: from instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal (1.133.65.34.bc.googleusercontent.com. [34.65.133.1])
        by smtp.gmail.com with ESMTPSA id b15sm2081220edb.46.2019.08.27.09.27.26
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 09:27:26 -0700 (PDT)
Date:   Tue, 27 Aug 2019 16:27:25 +0000
From:   Giuseppe Crino' <giuscri@gmail.com>
To:     git@vger.kernel.org
Subject: How to build to debug with gdb?
Message-ID: <20190827162725.GA29263@instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, to debug some issues I built and installed git via

$ make prefix=/usr/local DEVELOPER=1 CFLAGS="-O0 -g"
$ sudo make install
$ git --version # git version 2.23.0.40.g4d8aada92f 

But it seems there's still some optimization going on that prevents gdb from working correctly.

For example

(gdb) b builtin/config.c:752
Breakpoint 1 at 0x43942: file builtin/config.c, line 752.
(gdb) r config --global --edit
Starting program: /usr/local/bin/git config --global --edit
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libth
read_db.so.1".

Breakpoint 1, cmd_config (argc=0, argv=<optimized out>,
    prefix=<optimized out>) at builtin/config.c:753
    753                             if (fd >= 0) {
    (gdb) p fd
    $1 = <optimized out>

 What am I missing?

 -Giuseppe
