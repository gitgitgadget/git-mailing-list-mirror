Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E150A1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 16:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeJYAyJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 20:54:09 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:46436 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeJYAyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 20:54:09 -0400
Received: by mail-io1-f41.google.com with SMTP id y22-v6so3508618ioj.13
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 09:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BRc1BJevQDiKxEbJXs0MPTTZmB1W+nKzuobLDAqmzA4=;
        b=R5WcPdLZe9ny+7sdSlEB4T5dHrIloxAxZP+k+ScgLYiI4w5NGql1w8Er+Ct0cLZpN3
         sqrW8PhcveRImflZuqi9zqd03qJgHZ7r9873eqT1c6iFn6g/IhvRNljhEgruF/DOlfiB
         6490FbxD2PESaW1ddipMGb4A/Vsuj375irSkHPu+cCkYUMPyWPTESStYnaXPoVBzo+SG
         S2cPxy0rqAdqZC6BUNBe1Z/Jh8KBmRWcvYZvLs++Q7EYERoSCRQ6CHsVdAl9HU82Uu9w
         Jy3qyhLjKW5X+qUSIAZrWAe46gzxn5fGU92MXyU/8NxXX6jL2pVORbfOe2Bsa4f3ZFDN
         v+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BRc1BJevQDiKxEbJXs0MPTTZmB1W+nKzuobLDAqmzA4=;
        b=dYtKf+BCahSMC5JnpzbUQ94pMfs/0tbafv4ua1lPRjHIVp6puG0UIxbAliI5m2g84F
         4t+XDNwl07jy8mfxxhgocyJTBgRKWmCgIrhgljZ8/q9a65jlhjvMeNJuT6l6nznfsFAR
         tYJdMCSqCXqepAFjcSpgBAxUPdj/13vK5BM0Kf/A/3iU8PZYB+/LOaXt2B1jB2QuiKWU
         KKnvnOYxZmnibRfGuGiK3eRO5QvHRCns4ae2RqLmGQbon2u6N/GBDEWhWix66eTazM3c
         FyXCvHa7cSEAVKPNkXJQ1l/cT6xI0oNMZKVnmXfH0ax3vAl1RmkqhwYftpGfZsmxnenl
         kmsw==
X-Gm-Message-State: AGRZ1gKemO2Ahnl7C7eZP/yTX3RAimtfP1tsq81DwQbRpx//PmmqVCDV
        vrjoqY8lBwx/+uDahDuaaZEra5zz
X-Google-Smtp-Source: AJdET5cgqrq670xPlLAg6TFWhmEXz1fi/XjWzIGWmwzUxN7ZL1rTZae8fPZ27OnN42DiiYeRQgbS4Q==
X-Received: by 2002:a6b:b606:: with SMTP id g6-v6mr8480793iof.51.1540398325098;
        Wed, 24 Oct 2018 09:25:25 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id b5-v6sm2129642iof.74.2018.10.24.09.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 09:25:24 -0700 (PDT)
Date:   Wed, 24 Oct 2018 12:25:22 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     liu.denton@gmail.com, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com, davvid@gmail.com,
        gitster@pobox.com
Subject: [PATCH v3 0/3] Add --gui to mergetool
Message-ID: <cover.1540398076.git.liu.denton@gmail.com>
References: <b0a5d6926c130c0b143435a96ed956b3ed20dad7.1540360514.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0a5d6926c130c0b143435a96ed956b3ed20dad7.1540360514.git.liu.denton@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds another patch on top of the existing patchset in order to document the
guitool keys for `git config`. This way, the completions script will now be able
to complete these key values as well.

Denton Liu (3):
  mergetool: accept -g/--[no-]gui as arguments
  completion: support `git mergetool --[no-]gui`
  doc: document diff/merge.guitool config keys

 Documentation/diff-config.txt          |  8 ++++++++
 Documentation/git-mergetool.txt        | 11 +++++++++++
 Documentation/merge-config.txt         |  6 ++++++
 contrib/completion/git-completion.bash |  2 +-
 git-mergetool--lib.sh                  | 16 +++++++++++-----
 git-mergetool.sh                       | 11 +++++++++--
 6 files changed, 46 insertions(+), 8 deletions(-)

-- 
2.19.1.544.ge0b0585a1.dirty

