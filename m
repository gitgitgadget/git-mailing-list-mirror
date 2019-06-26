Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47EAB1F461
	for <e@80x24.org>; Wed, 26 Jun 2019 23:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfFZXuw (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 19:50:52 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:49036 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFZXuw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 19:50:52 -0400
Received: by mail-pl1-f202.google.com with SMTP id i33so281781pld.15
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 16:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=u1OtBtd4xViXZ7TrjzR230uogD6R7YXvGNSpnC7pvYg=;
        b=wCoyD5NPEdMe7rhMYIWMCJrTqxtkGly916jcQTXEzYLqZi9BsbnjFgoDT7QfO/nPVp
         neh2VJNyDr/rTAQFTatmpCrWKHc0vLXNDP64J0L8dGNDCIYJSrYEjhLzOx3DYvBagyZO
         y4VXCyNGX3+5864A5ZXPamnFUlVA7LGhlwgRpKDkz80/9ag4gsdPRwn27n9lL1m0L+p2
         VH+VTZ0Xfp1lpl/cyoCW0jfgBtfui3x4ux3sRtfG7McEaAmfopN5PWtgREpf6xch2+B0
         PqgpViWeU7FDXX/AroD0JbLr8JLnoFGcnbL9FY9SX1hBSwhn1r8Ga3iT8D6+U+EOVZgK
         XkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=u1OtBtd4xViXZ7TrjzR230uogD6R7YXvGNSpnC7pvYg=;
        b=PsoCG7urkUrCwBBr21ugnLUkTF9IV7wTg6QF9ndvfEKf16mCEz3o2h7zEbU8PaY7XY
         HwsHdjmNUsJRMcOJ4otBEBOPh5991WQuieb8YEjmYHh38JHKkREIWURGfQ7fu42oEixs
         AajTFoVWWgJ4gIH77P300wfoIp5N4HW/dEGvXq8k4+jThviABwAH8Hk1DWM8ZkKwp0q1
         ZeYz3Ij6c4HCC7HUfhnXqVuq34KiK+Ixe6YWWsTSxanVTpOuMEUE33zxhCzjj2MxK4Wn
         guGl1WD3IUSXBOxB+tZp2vTZaqExHNp4qvcCT9Q6R6irAZbqOC69L5e9bLLw+DE651Xx
         Q+vQ==
X-Gm-Message-State: APjAAAUrAjrnT39VNEM86/pFRUlC0YKdycGt/GJC80EJt7GIiXNHWP+l
        c/FOyUFFD9H87fdJdXNM3bIVrByFV3IsUGqByyGZ0TdxBaA2PxWvBQ45dJ2y6okaM1mV/p2Qbiv
        6JP1ouq3cWGTO2u9k4fv2LFIq+aBjWB7LgImIcntiWlGpoHIX/TXNJPaJBVhjGk5Th5kZmr0xmg
        ==
X-Google-Smtp-Source: APXvYqxlkf6fXf+2BwGLir0bnAF1plBUAQd6iit3gmfK+ziQrSN3SxE3/uTYvu39GzOHQUj1PmfFiNEYdOmUQB7iITI=
X-Received: by 2002:a63:3349:: with SMTP id z70mr603927pgz.355.1561593051219;
 Wed, 26 Jun 2019 16:50:51 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:50:19 -0700
In-Reply-To: <20190626234915.171658-1-emilyshaffer@google.com>
Message-Id: <20190626235032.177551-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v2 00/13] example implementation of revwalk tutorial
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since r1, made some significant changes.

 - Added a commit for counting the 'omitted' list, to match the new
   section added to the tutorial.
 - Added significant comments to allow the sample to better stand on its
   own.
 - Fixed style issues (die() formatting, etc)
 - Distinguished between human- and machine-readable output with
   trace_printf() and printf(), to turn the command into plumbing.
 - More changes as mentioned in the tutorial patch.

Thanks.
 - Emily

Emily Shaffer (13):
  walken: add infrastructure for revwalk demo
  walken: add usage to enable -h
  walken: add placeholder to initialize defaults
  walken: add handler to git_config
  walken: configure rev_info and prepare for walk
  walken: perform our basic revision walk
  walken: filter for authors from gmail address
  walken: demonstrate various topographical sorts
  walken: demonstrate reversing a revision walk list
  walken: add unfiltered object walk from HEAD
  walken: add filtered object walk
  walken: count omitted objects
  walken: reverse the object walk order

 Makefile         |   1 +
 builtin.h        |   1 +
 builtin/walken.c | 290 +++++++++++++++++++++++++++++++++++++++++++++++
 git.c            |   1 +
 4 files changed, 293 insertions(+)
 create mode 100644 builtin/walken.c

-- 
2.22.0.410.gd8fdbe21b5-goog

