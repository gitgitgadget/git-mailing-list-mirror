Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF19C433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 12:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5079461039
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 12:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbhJKMUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 08:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbhJKMUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 08:20:09 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93ADC061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 05:18:09 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so21422610otv.4
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NnQD923ZU+7LnpVFaKZABv0n3ccLyzcsOS5cm7++w2I=;
        b=MvOsKJs1FCT5g2jo0JHEd6CQrmsQGEKtzSRFK3mt3Aed9DfwihcPQhZfhODOMQ42yG
         sr5gB9QVN8Q164ITRU9PkUR02nIMKGKkYU/nrOFLC6g7H2sPKYS/Sm8fbVRsKJjgf9C9
         y52Iy6iCQ1uCAr0xs/jE8ceJufFVvfhdihsWYdNtp7Yyc7yIYH/uaWgRr19GI94C5lzU
         OO3jUm+U6BPmdyvlhBdRK34fVzsils8BN39JVPw50vkE/asZUCcL0S+HogOyUqZiTtRc
         c93OpdHkmooZZXuDVJ1IhVO3F9Pv0wv9r+ibKwl4ucVTGgS9f/9SiCA0uX/4B4+qa+sb
         R6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NnQD923ZU+7LnpVFaKZABv0n3ccLyzcsOS5cm7++w2I=;
        b=PSt/iTDdHbrBKuQsQhOq21nkkxoaDGipS3MzceSvn3pMtlQiMmXlCwXgUIbNA8x6yd
         l4cS/qu4zii9kesU98bbrm3PqZNFKvxcRXsded4/lKNrQ+TYTZ0ny4WJSLEM+UAOoECJ
         UKu0uJfz1XtlQucKklr4I+GfCg/nbAPVk/RUyJoMUB5Bt9pwDBwcmOWrtbgS5GQ5u9R/
         PAJ3B13+VgRA2xyzd1ptjzuZPPrxIFuZRlUxetGLlbCltNKdK28dVfA0FsN9h83UrKZJ
         TubfnZ1xoK6w/N2DGi94MhVtoEznzXXTL/xKzBrPL3/7RoJ+aEzwiRIcq29BK5HjAGhM
         1MpQ==
X-Gm-Message-State: AOAM533776jWnGqPPLs5QEEa2cGQwSmWlVZ9vHLhehqlXtkx/WybIQmE
        n6Y9geD7J6cs775pGzrU52KxzaWXmWtadw==
X-Google-Smtp-Source: ABdhPJwJt3MXUN+Wj/s7Mr1x9ATJp2mOBzinmu+hrtVf1/EeyHqwuiYWTTQNlJbJrg9ThEGWOuwtRA==
X-Received: by 2002:a05:6830:1d4d:: with SMTP id p13mr20493106oth.134.1633954689001;
        Mon, 11 Oct 2021 05:18:09 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id u21sm467892oiv.25.2021.10.11.05.18.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Oct 2021 05:18:08 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     angavrilov@gmail.com, me@yadavpratyush.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH 0/4] git-gui: support SHA-256 repositories
Date:   Mon, 11 Oct 2021 05:17:53 -0700
Message-Id: <20211011121757.627-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.1081.g099423f5b7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While poking a SHA-256 hash repository, was surprised to find gitk
would fail with a fatal error when called, hence this series.

Sending as an RFC, since I am not a git-gui or gitk user, and so
while this fixes the original issue and allows me to call gitk to
see the branch merge history (which is usually as much as I do with
it), it is likey missing some changes, as most of them where found
by lightly poking at all of the gui menus (except for remote or tool)

It could also be reordered to reduce unnecessary churn and of course
also needs the gitk change[1] that was sent independently, and better
commit messages.

[1] https://lore.kernel.org/git/20211011114723.204-1-carenas@gmail.com/

Carlo Marcelo Arenas Belón (4):
  blame: prefer null_sha1 over nullid and retire later
  rename all *_sha1 variables and make null_oid hash aware
  expand regexp matching an oid to be hash agnostic
  track oid_size to allow for checks that are hash agnostic

 git-gui.sh                   | 30 ++++++++++++++++--------------
 lib/blame.tcl                | 18 +++++++++---------
 lib/checkout_op.tcl          |  4 ++--
 lib/choose_repository.tcl    |  2 +-
 lib/commit.tcl               |  3 ++-
 lib/remote_branch_delete.tcl |  2 +-
 6 files changed, 31 insertions(+), 28 deletions(-)

-- 
2.33.0.1081.g099423f5b7

