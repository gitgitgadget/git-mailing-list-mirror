Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C27D61FF40
	for <e@80x24.org>; Sat, 25 Jun 2016 08:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbcFYIBI (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 04:01:08 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35755 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbcFYIBH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 04:01:07 -0400
Received: by mail-lf0-f54.google.com with SMTP id l188so127680246lfe.2
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 01:01:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uX1e/qld8x7sYEyEiXBJBXIjsnIqiYI0GHfgRgZX7gU=;
        b=JSoUTri+iYCDjMtAcDrmNOy31HIRBQHs3SIkwMw/tTKOQkFNbI3EzhRz7qxmRc9RVX
         UsYQJeXW7DIsK/Epl2OiKTnBB1+XDVYOE3YyVatvI+SPnXlCr5t+VtILRezwyqA4HEm2
         BWNCCutKAMAXBpkpxp6dEjidtEmpTbyvpwfq6l9j4IR+QgenUXj3nPgUes9az/vTjvWp
         iadl3JzUVTc/zuIqcsWeh7859u4KXjv2WfUslP/cmK/67vbc4qnOuVe4xYQnd6Tr7P4D
         HogITEek5xLhYxNHIT5aJWWSvzdmIiD9PmT+EywOacGBZ/yFXXelznoftqrf0uYzh0o0
         qyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uX1e/qld8x7sYEyEiXBJBXIjsnIqiYI0GHfgRgZX7gU=;
        b=fbDLeUXk2b3C2oXrErtE7siQPwAFhIUVA9IumTlG5FgOer0fcC4d51q1jvvVelzF01
         dCwfufoixXJ2Ds8eFDQxvgMO5LCrxlYLUM/V1hcGpIUMguzVuQm/aYa0LGRLxWdfE1Zt
         ynkBx3GVzzcH3m+DqRCgbzmn571qL73TOQDIm9tNt5kL8IaJs+Leipj93nvzTofLXg1b
         eSjQG2q8wcYWFGSaFjf4fqnvI7KW5CgeFwmqmjTMkViBV6D82tDmAH0F6TO9RZRcbu18
         e6l7knWE8wLHK0eIt7pZ0OnVjTX9ZgvYFXIKKx1rd5Uaqh5hmWKuH8jH1tw6FQyaTh9X
         PAyg==
X-Gm-Message-State: ALyK8tLu50+njMv74htiQ0UePtjNObRSwpbGRVUKuJ8WDr4RfnziEXE1zRg2kdzo712r4g==
X-Received: by 10.25.17.92 with SMTP id g89mr2081545lfi.119.1466841279361;
        Sat, 25 Jun 2016 00:54:39 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g79sm1536122ljg.26.2016.06.25.00.54.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Jun 2016 00:54:38 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/10] git worktree (re)move
Date:	Sat, 25 Jun 2016 09:54:23 +0200
Message-Id: <20160625075433.4608-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Now that nd/worktree-lock seems to be on its way to 'next', let's
continue to review this one. The first 5 patches bring busybox's copy
functionality to git. The last 5 add support functions and the two new
commands.

This series needs both nd/worktree-lock (for find_worktree) and
'master' (for error_errno).

Nguyễn Thái Ngọc Duy (10):
  copy.c: import copy_file() from busybox
  copy.c: delete unused code in copy_file()
  copy.c: convert bb_(p)error_msg to error(_errno)
  copy.c: style fix
  copy.c: convert copy_file() to copy_dir_recursively()
  worktree.c: add validate_worktree()
  worktree.c: add update_worktree_location()
  worktree: add "move" commmand
  worktree move: accept destination as directory
  worktree: add "remove" command

 Documentation/git-worktree.txt         |  28 ++-
 builtin/worktree.c                     | 156 ++++++++++++++
 cache.h                                |   1 +
 contrib/completion/git-completion.bash |   5 +-
 copy.c                                 | 369 +++++++++++++++++++++++++++++++++
 t/t2028-worktree-move.sh               |  56 +++++
 worktree.c                             |  88 ++++++++
 worktree.h                             |  11 +
 8 files changed, 703 insertions(+), 11 deletions(-)

-- 
2.8.2.526.g02eed6d

