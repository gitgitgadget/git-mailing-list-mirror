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
	by dcvr.yhbt.net (Postfix) with ESMTP id D35FF1F463
	for <e@80x24.org>; Mon, 16 Sep 2019 20:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfIPUyu (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 16:54:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38361 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfIPUyu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 16:54:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id l11so861399wrx.5
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 13:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fYVRcwIJ/BKdEM0tNIThl7bCCiNLu/TWCEzZH56lEow=;
        b=Zr+6eFelk0Dvm8CQy7dsI4vTdVABu1phv7xaT4IET1Wf3EYs+AMOjUCv/qQiWNwi/8
         NaxUdC1o/wHuZ1NZf+quiBZezuvH0/kkz6kgb9r1XMGVQvJBlEa/L8wG/GsbGAX9qKTd
         o6Jw6ERA2JV1BTkJM+sI9Ucs7IWDQXt34/EaEVHKjVEe77OlTp+OFuioyKeVizrYkZgv
         4HmpjG8q52S87ToVHXtzs4ASwGRKijXLLsBHqyjG1MNWOjkeOqQiMTOXrMz7gWju7cQm
         Y1JLM9QCvCDEXJwYnkowZAbGo+wKKZVt1YFgejfuLJPs5eFviAY87U0A+lAgdVxhCGq5
         CLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fYVRcwIJ/BKdEM0tNIThl7bCCiNLu/TWCEzZH56lEow=;
        b=eCZVk5cHlbh8y90o5vFrJsHBFIjTG8pOPuL9ktI2Cfm1tr30SB/lQljLXtZZUlKodc
         6TdzfSaOi67QZaFOOGNWX4NVZDP6QSIEDPiK/1zrKwloRZgwub2r1ifRpP38vsogDj6d
         UquvpyK5fJLUfHrPUFehbw0VIvw8ZTBjFd1/slNemU8WKV4KOgLFIdy3Tm/OlvDXybf3
         vx+OBhWnUtyi/z7NL3XwaYkEai9aasirgFZ2CG+4+tRMCgE1oPvODIrzQaMtZWRcOEcz
         uHUXG3I3WL1tmL20DmlWtGIuPoAJxqliZb6L7Zqh0GAZMJTnUYr0D4S/1P+8d08azb/2
         /yaQ==
X-Gm-Message-State: APjAAAUnKwYW7nwa2RwPM0nx0V1oLKfhORTUHHe9Aq1CNDDxe2n8i/nH
        7WUDFjDusorSYFCuRjL9xfE=
X-Google-Smtp-Source: APXvYqx/OxJRB/Al/Q4NEw0u1+zmv+BnmTQxiXksBC9PJFc9laNU0HW7zOenKFL/dmMylVK/oCGJGw==
X-Received: by 2002:a05:6000:50:: with SMTP id k16mr176993wrx.161.1568667287815;
        Mon, 16 Sep 2019 13:54:47 -0700 (PDT)
Received: from localhost.localdomain (x4db93de7.dyn.telefonica.de. [77.185.61.231])
        by smtp.gmail.com with ESMTPSA id u22sm102944wru.72.2019.09.16.13.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 13:54:47 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>, Charles Diza <chdiza@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/2] Revert "progress: use term_clear_line()"
Date:   Mon, 16 Sep 2019 22:54:10 +0200
Message-Id: <20190916205412.8602-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
In-Reply-To: <20190822162907.GA17013@sigill.intra.peff.net>
References: <20190822162907.GA17013@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 22, 2019 at 12:29:08PM -0400, Jeff King wrote:
> On Thu, Aug 22, 2019 at 06:07:02PM +0200, SZEDER Gábor wrote:
> 
> > On Thu, Aug 22, 2019 at 10:20:08AM -0400, Charles Diza wrote:
> > > By 2.22.1 at the latest (and continuing into 2.23.0) there is a
> > > problem with the display of progress indication during `git pull`
> > > (and possibly other commands, I don't know).
> > > 
> > > I'm on macOS, and this happens in both Terminal.app and iTerm2.app,
> > > on both macOS 10.13.6 and 10.14.6:  In a standard 80-column wide
> > > terminal window, cd into a git repo and do `git pull`.  The chances
> > > are high (though not 100%) that one will see this:
> > 
> > I noticed this today when pushing to GitHub (I suppose they have very
> > recently upgraded?) from Linux, so this is neither specific to 'git
> > pull' nor to macOS.
> > 
> > I'm sure the culprits are commits cd1096b282 (pager: add a helper
> > function to clear the last line in the terminal, 2019-06-24) and
> > 5b12e3123b (progress: use term_clear_line(), 2019-06-24) with the
> > added complication of communicating with a remote.

> > I'm not sure how to handle the situation.  A few ideas to consider:

> >   4. Revert, and go back to calculating how many spaces we need to
> >      append to clear the previously displayed progress line, and hope
> >      that we don't mess it up (or even if we do, it still won't be as
> >      noticable as this).
> > 
> > I suppose this issue affects other git clients as well, so (1), (2),
> > and (3) might not even be an option.
> 
> Yes on that final bit. We could always fall back to (4) if the terminal
> information is not available, but given that the benefit is mostly in
> simplifying the code, I don't know if it's worth carrying around _two_
> solutions.

Ok, so here is a patch to revert 5b12e3123b (progress: use
term_clear_line(), 2019-06-24) with proper explanation.

As a bonus there is a new test script exercising the progress display
as well, in particular how it covers up the previous progress line, so
we may have a bit more confidence in it.


SZEDER Gábor (2):
  Revert "progress: use term_clear_line()"
  Test the progress display

 Makefile                    |   1 +
 progress.c                  |  61 ++++++--
 t/helper/test-progress.c    |  81 ++++++++++
 t/helper/test-tool.c        |   1 +
 t/helper/test-tool.h        |   1 +
 t/t0500-progress-display.sh | 286 ++++++++++++++++++++++++++++++++++++
 t/t5541-http-push-smart.sh  |   6 +-
 7 files changed, 421 insertions(+), 16 deletions(-)
 create mode 100644 t/helper/test-progress.c
 create mode 100755 t/t0500-progress-display.sh

-- 
2.23.0.331.g4e51dcdf11

