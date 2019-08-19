Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 792DD1F461
	for <e@80x24.org>; Mon, 19 Aug 2019 02:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfHSChg (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 22:37:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44813 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfHSChf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Aug 2019 22:37:35 -0400
Received: by mail-io1-f67.google.com with SMTP id j4so761391iop.11
        for <git@vger.kernel.org>; Sun, 18 Aug 2019 19:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5jgmOL1tFf7BfR0RkNEpXVA6jn+R599+BRWN9H16R/w=;
        b=YRQp5YwSMcj64Hj4cuEe2Q/PfM+o4wKow9HqY+oY8SG1lELJLf7xYNJyYX8DlkMafp
         XZwIiUH2+Ex3rkKcetF/H9QyqOeq7yd+VMcmatgbGWNcBQYbw0OQ8yjOzirbneNuH61P
         IjY7qiklW7jDmgBKDlZqvw7GtYp7o8o5Y+fQHL7Jf8BxB44WA+Rp9/BIPz65wKxtMJ/6
         vVpEQUSIFDZtNZk3dETHJTGkhmkjIm8UXSL4TAH3zwNLpXOaf7Lu6Pl3aNJsPvSS0rtB
         TptrxV7F1A4BNUA/kcL6P4S57yV8e4jYrXGFZMSuHlY1pAgqEGG4wDVihsQK7XNJRXMV
         zVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5jgmOL1tFf7BfR0RkNEpXVA6jn+R599+BRWN9H16R/w=;
        b=HoUjeQg77HJHruVdbhB6YCp/hnM0tCoRcyXpzn1Ao5EDgglhC+wL/U/iP1eWrQjseA
         L8gKR0ap/pqTRvCX9H0iLShMq0KRwdrkWGb0lgn8jR29v8mY6DsbweVHjpDQ2/M+K/vq
         Ap3FL6Gb0o2Z7pMYBq4Hfcf9MgcUzYdgVU12sLHs+XTFYCuma2n7PRORxHLBRcFj1wPy
         QZx5uXBWJsyJxol54MzUKTDCb7d4IVFew4Z7TzD2eb+taBwKH985ATic3Kw/zJltmT/f
         WHbPDAeqTYJzz7Us1Gr/ZAMo9igvrFcsVqed81P5DmSTWwfOy6+AnW/lv1eT1vFo5JFK
         xnOg==
X-Gm-Message-State: APjAAAUhMxIv74MXZEhKlM5oSnNUyA27pPrhqQaBxUA+tuuwvKFNI6Kc
        htr6Fbk07339tFNXK9Xv6ciH2NBI
X-Google-Smtp-Source: APXvYqzanEmUGrkVEU+8QMA7XSCnxaEunwkQw68rcoKbgRvJtavttQc5E2pDe5yuKcq8TPwjoD9i9Q==
X-Received: by 2002:a05:6602:2289:: with SMTP id d9mr23531216iod.47.1566182254695;
        Sun, 18 Aug 2019 19:37:34 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id y20sm11882688ion.77.2019.08.18.19.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 19:37:33 -0700 (PDT)
Date:   Sun, 18 Aug 2019 22:37:31 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] format-patch: teach --infer-cover-subject option
Message-ID: <cover.1566182184.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, format-patch only puts "*** SUBJECT HERE ***" when a cover
letter is generated. However, it is already smart enough to be able to
populate the cover letter with the branch description so there's no
reason why it cannot populate the subject as well.

Teach format-patch the --infer-cover-subject and corresponding
format.inferCoverSubject configuration option which will read the
subject from the branch description using the same rules as for a commit
message (that is, it will expect a subject line followed by a blank
line).

Also includes some other cleanup along the way.

This was based on patches 1-3 of an earlier patchset I sent[1].

[1]: https://public-inbox.org/git/cover.1558492582.git.liu.denton@gmail.com/


Denton Liu (3):
  t4014: clean up style
  Doc: add more detail for git-format-patch
  format-patch: infer cover letter from branch description

 Documentation/config/format.txt    |   5 +
 Documentation/git-format-patch.txt |  35 +-
 builtin/log.c                      |  56 ++-
 t/t4014-format-patch.sh            | 656 ++++++++++++++++-------------
 4 files changed, 425 insertions(+), 327 deletions(-)

-- 
2.23.0.248.g3a9dd8fb08

