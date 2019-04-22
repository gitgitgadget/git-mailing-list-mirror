Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14B8B1F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 05:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfDVFHm (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 01:07:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45351 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfDVFHl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 01:07:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so5287903pgk.12
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 22:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LGeuips4qj0xrgfIy8hpbh71Wo8TpSfc/2BPoGZKSug=;
        b=UMabMb6KcaCG6ijslCHbnEWliqdxFek8ymVoY2uUKcDtsQSdiflb25+xEN+vKuuFAz
         PNi0J77trRf3tTb3PDwvZNoiw7xrU7X+j6/Q1IIfZ4VV5vqaTAd2yOqroQbRKRi7qUyc
         iiKRxX+6oKBV/SfysuaAsEOn3V4vuTrBU0eqBnkOY+KL2FXjREF/ROmAfD9gRdl35sW2
         xVaJBwJ2v8y3At7EiaYqjlgCwqnzQ02kKdQ0RMiyfPiGurst+TYv0Y6xh9ukD6EZ+8Bs
         Oi9oFqgoAMcVuv9soYdKipZ7toOLfoFYBbeLMbRd8hUoXHuzVtzikMGEqkhuASh3hyY3
         YRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LGeuips4qj0xrgfIy8hpbh71Wo8TpSfc/2BPoGZKSug=;
        b=jXBbdawgr1xXRot9dC9bD8jGfGWQdsY4bh52yfvyq92kgFI079pk14l16GhWJnHT7o
         bFqRbzaWjs5fopNerMiqaRxFwlBX/n1IgGFWjpwdx5cD1QX4DMJYRNM3WoyAFK+dG0Ck
         2CKmJqPXL2WYSWLkCQJj9zWX9HBTfLrlVKjHl6I6eG3oov7pcTDtCon8i2GIZE73xh3K
         KubIdm181jmUHV3n8sD/IArXVV3ev9JYj8yBe7vVlfxSB/dZQLHkGOqUUVMw8R0QIvmA
         OUZg9RhszUaxw+/OCGe8lELd/IAaqEHeuQ2LqsVnSkg16kgLDAOwpMez9CY/NGbSDtAB
         BmqQ==
X-Gm-Message-State: APjAAAWclIcULAOvwUa/JamzQJVMIMFCuzt6zo9elVAhOYmGODBp5OT9
        68LrsP13ePGtwQrCnWwYqj0eG2PY
X-Google-Smtp-Source: APXvYqx5e14x0ysVWtWlLC/RKmJnR3xVVfmvKqNKFBnuQkDRBQNdrpReufyTn7VXutTAp991lynjag==
X-Received: by 2002:aa7:92d1:: with SMTP id k17mr18723208pfa.91.1555909660872;
        Sun, 21 Apr 2019 22:07:40 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id t64sm23698898pfa.86.2019.04.21.22.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 22:07:40 -0700 (PDT)
Date:   Sun, 21 Apr 2019 22:07:38 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>
Subject: [PATCH 0/5] difftool and mergetool improvements
Message-ID: <cover.1555880168.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed earlier that when running 'git difftool --gui', we do not
fallback to 'merge.guitool' when 'diff.guitool' isn't set, even though
this behaviour exists for when we invoke 'git difftool' (i.e. it falls
back from diff.tool to merge.tool).

While fixing this bug up, I noticed a few other places where we could do
some code cleanup/add tests so I did that as well.

Denton Liu (5):
  t7610: add mergetool --gui tests
  mergetool: use get_merge_tool function
  mergetool: fallback to tool when guitool unavailable
  difftool: make --gui, --tool and --extcmd exclusive
  difftool: fallback on merge.guitool

 Documentation/git-difftool.txt       |  4 ++-
 Documentation/git-mergetool--lib.txt |  5 +++-
 Documentation/git-mergetool.txt      |  4 ++-
 builtin/difftool.c                   | 21 ++++++++------
 git-difftool--helper.sh              |  2 +-
 git-mergetool--lib.sh                | 33 ++++++++++++++--------
 git-mergetool.sh                     | 11 ++------
 t/t7610-mergetool.sh                 | 41 ++++++++++++++++++++++++++++
 t/t7800-difftool.sh                  | 24 ++++++++++++++++
 9 files changed, 113 insertions(+), 32 deletions(-)

-- 
2.21.0.967.gf85e14fd49

