Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D60B1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 22:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbeKCHqz (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 03:46:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37495 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbeKCHqz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 03:46:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id z3-v6so3458969wru.4
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 15:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3E+LksmNFuOLth9OvmtexXqIxlX51LywahuWzdVh74Y=;
        b=Iu1brws5FzTw1UIVRifumiKEsyYoYwh2wW/zqzLb67M/FgbHFNNZAxtdyOaaRsT8xG
         4+cg6jOBprSbdYDP2Q07ZDqAbFQU7TCwYq9wUhMDinZ214fP8RKMIHHs8l4aG801SYyx
         1j7QqKCYDBd86Gc9+IloqX8fK4WE/loINdW5i8rCmN6tlr0Zyn/ZUkpdiuYDd27iXU63
         Iedw/kKywo+FCdz6st2DICtDFKdYD0+9m3TggT+twfggXSkzCCGCbQjhpVHr7lJUlv/y
         0RUrZz+FkQm5OjNMeOwkWp6JF1dn9MgmYJXo5iy6uxNaowho+7dVFQuaI3UKVepECSRZ
         X1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3E+LksmNFuOLth9OvmtexXqIxlX51LywahuWzdVh74Y=;
        b=CW9ri+oBtxng+TGWg6c6CaAtA9HeIfT+t2b4WJBqulgHhJ4qiybjfUYqLWe99Mk4EZ
         qnQ5imH3/2++0FEKSD1ZIcAblfmTRr5q7ShmHrdA1CY2qTL07PVAkJzc6ZmlXLOHJiYW
         TPrWGekKrlt5OgyfAsNc0xVd+zWsoMmQSLRK0W5Io/a5Z0kQodt2WZME8urhSiIt0jNq
         tD00BiwVBtRNLSc5X8uA3tppR4Qn7R9tY2x2KXmL5XZY4KKemSALOTL3CqVJObzNh4IN
         sInbOBroEMABOjHXpZDQw4QwN2pJ9zDqG4f3Dk/TdxInociiS78jGEcGZnA7Ajvvvmq9
         VMOg==
X-Gm-Message-State: AGRZ1gLckFpFWudtDSoFC/ZjAbnjf98QUtAaiVBhwhRFIxo9j0gXRKwV
        LhmtdmvTOnIRf/m2rZr+uRo2/heS
X-Google-Smtp-Source: AJdET5ey0kpaAN3U2u+V1w8BHVVhIANYOOKwmzTCQeBP8tiMGWl57dhoh6wUA3gil9DKl3LJ4MHWUw==
X-Received: by 2002:adf:f501:: with SMTP id q1-v6mr11799581wro.63.1541198273237;
        Fri, 02 Nov 2018 15:37:53 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a12-v6sm21461469wrr.71.2018.11.02.15.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 15:37:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Daniel Jacques <dnj@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 0/5] stop installing old libexec aliases like "git-init"
Date:   Fri,  2 Nov 2018 22:37:38 +0000
Message-Id: <20181102223743.4331-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0
In-Reply-To: <87efkkdwcv.fsf@evledraar.gmail.com>
References: <87efkkdwcv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think up to patch 4 here should be near a state that's ready for
inclusion.

Although I'm on the fence with the approach in 1/5. Should this be a
giant getopt switch statement like that in a helper script? An
alternative would be to write out a shell file similar to
GIT-BUILD-OPTIONS and source that from this thing. I don't know, what
do you all think?

The idea with 4/5 was to make this symlink mode the default in
config.mak.uname and have a blacklist of systems like Windows that
couldn't deal with it.

Since my ad874608d8 ("Makefile: optionally symlink libexec/git-core
binaries to bin/git", 2018-03-13) I see that e.g. Debian and GitLab
have started shipping with the INSTALL_SYMLINKS flag, so making that
unconditional is the next logical step.

The 5th one is more radical. See
https://public-inbox.org/git/87woyfdkoi.fsf@evledraar.gmail.com/ from
back in March for context.

I'd like to say it's ready, but I've spotted some fallout:

 * Help like "git ninit" suggesting "git init" doesn't work, this is
   because load_command_list() in help.c doesn't look out our
   in-memory idea of builtins, it reads the libexecdir, so if we don't
   have the programs there it doesn't know about it.

 * GIT_TEST_INSTALLED breaks entirely under this, as early as the
   heuristic for "are we built?" being "do we have git-init in
   libexecdir?". I tried a bit to make this work, but there's a lot of
   dependencies there.

 * We still (and this is also true of my ad874608d8) hardlink
   everything in the build dir via a different part of the Makefile,
   ideally we should do exactly the same thing there so also normal
   tests and not just GIT_TEST_INSTALLED (if that worked) would test
   in the same mode.

   I gave making that work a bit of a try and gave up in the Makefile
   jungle.

Ævar Arnfjörð Bjarmason (5):
  Makefile: move long inline shell loops in "install" into helper
  Makefile: conform some of the code to our coding standards
  Makefile: stop hiding failures during "install"
  Makefile: add NO_INSTALL_SYMLINKS_FALLBACK switch
  Makefile: Add a NO_INSTALL_BUILTIN_EXECDIR_ALIASES flag

 Makefile         |  65 +++++++++++--------------
 install_programs | 124 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+), 38 deletions(-)
 create mode 100755 install_programs

-- 
2.19.1.930.g4563a0d9d0

