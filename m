Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD11E1F453
	for <e@80x24.org>; Sat, 27 Apr 2019 19:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfD0TZX (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Apr 2019 15:25:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38018 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfD0TZX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Apr 2019 15:25:23 -0400
Received: by mail-io1-f66.google.com with SMTP id y6so5701319ior.5
        for <git@vger.kernel.org>; Sat, 27 Apr 2019 12:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=28rR+xquf27dFHj3fnXgHo947X2aS+oC2XtbX/O6YqQ=;
        b=h1Uy3y5JQwt9iMirBjATu2UaGuaw7Bq9O7wqbExftAdB49AxSBPhpMcJ4MTJxZFIqt
         /VWdj+2SydThwW9b8GanqmoUDaPOc6ORhYcHMehONZQikYgLULsGRwmU+EfeFaJG+el2
         LbdETw4FeTKxfUYV5mOhBmDJoYSP9jOXSBsAfL1MuJeSUT0Ashmpg/7dazY/dzgz2ntK
         25JWp6g6CcKTuSQ6Yp7F9Vlf/lVjHZ3eMbcsqMxmqUxFEDqAqTcHZ8m0KoUgmIS+yhkI
         2WMG1hFWvDu4FbtAiO/tu/GUfKrYIA4mT6rjmJrqPKbFI+rNTNrVbEBJ4bqixapnNh02
         Y1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=28rR+xquf27dFHj3fnXgHo947X2aS+oC2XtbX/O6YqQ=;
        b=RxAXuLrW6GSD2V5//yrFCTPmoa52p8scXE1z0oIODV6bsg8XaLLmAlNNBwauM89x63
         mcENZX+DgyC9DJYb311p68yXAFseg+ZToPGC38UNPtZEWcdZ8Ig1TIF4l6BSdFSWKgNp
         3/VbMqPyyGUvKzDIv/6BF9g8uinMccGDAJ2ScRUPHBcqOTeKIt5o+hyyCtMdtPnamSxl
         gPJQoKs0jDUb71Rg2bdrrYr1WJ6KB2Nh4N2YKSSQWthMm1dlievNFru0nKWukvjFLAW9
         4YNQ7rs1F57ktsOWoJbzn+JKsVb4IQPv7zpasgR13I+qxcfh3KWCnk1lOJIuFiIyHhE/
         K0Vw==
X-Gm-Message-State: APjAAAVbDGs+Qf/y947Ex31VFM36vWDD4RJE8z1J+VrKY8yOvrBdMoMH
        IXDqjHn0+o14HvoUDFIZeF7cc2bh
X-Google-Smtp-Source: APXvYqzpJoGZWzEkOoHJj2g9lnBVo2ep5xidGgu4F1r3knZzD+ZXCw1ASNr2QZjZGyN0hLXy5gSr8w==
X-Received: by 2002:a5d:898a:: with SMTP id m10mr33142823iol.296.1556393122275;
        Sat, 27 Apr 2019 12:25:22 -0700 (PDT)
Received: from archbookpro.localdomain (mobile-107-77-160-135.mobile.att.net. [107.77.160.135])
        by smtp.gmail.com with ESMTPSA id t22sm10165656iob.16.2019.04.27.12.25.20
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Apr 2019 12:25:21 -0700 (PDT)
Date:   Sat, 27 Apr 2019 15:25:12 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/2] format-patch: teach format.notes config option
Message-ID: <cover.1556388260.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a user sends patches with git-format-patch, they might want to take
advantage of notes to add additional commentary. However, if they are
forgetful (like me) they may forget to include the `--notes` option in
their invocation of git-format-patch.

Teach git-format-patch the `format.notes` config option where if its
value is true, notes will automatically be appended.

Denton Liu (2):
  git-format-patch.txt: document --no-notes option
  format-patch: teach format.notes config option

 Documentation/config/format.txt    |  4 ++++
 Documentation/git-format-patch.txt |  7 ++++++-
 builtin/log.c                      |  6 ++++++
 t/t4014-format-patch.sh            | 28 ++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 1 deletion(-)

-- 
2.21.0.1033.g0e8cc1100c

