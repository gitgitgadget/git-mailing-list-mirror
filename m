Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 474271F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 19:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934811AbeGFThE (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 15:37:04 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:48231 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934870AbeGFTeO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 15:34:14 -0400
Received: by mail-qk0-f202.google.com with SMTP id p184-v6so14496073qkc.15
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 12:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=HFAjPpyR2wF9ITBTBlD3Cics0M4K00As3eUi089r1fU=;
        b=rRyuu0pYMF/Wg8oA3hpQDvRodlY6MKHh1YWG911diMhjJogjaRaE3wtM4vku2TZD+z
         rjN6ZCQyFblob1Srb+U2oQWealPuNxXRTVBqnC5db6PRid1yyZx8/ZzG3ItqZKYaVoVi
         T1XTWjz9QX1TAZi+030Mu73k/hkBe056M1dL37n9HR/XP5VN9gPH5wkyxcG9qeZ2b0GF
         v4l9CTg50utv1+/S51wVCMBkjVnthRY35VGKkhcQLcP2xmWmvWge/dv0rjRF1kllao1E
         RkIz6G++YgZn4ed0c4dIQcfKoFEMpvvH1oaH5E9CEhKuzl3Es6Fu2dzX2+B04qVRxuv/
         DRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=HFAjPpyR2wF9ITBTBlD3Cics0M4K00As3eUi089r1fU=;
        b=pKXCladVl+6VXTt3gw1dduXX/PZ4bvOnvi20dcq6oKw8pMSQpRDWxVjPWjxYFxhWtt
         F1eknA8Zb+en/a3ZljcSAhj0YS6v6H/565tTMgwSuxhIzs0DBf835xQYvLt6GyHdkLka
         jKVRroqcYqrGpwwX+fs506jIobKwb+SA8ATtAA+dCs+FjYs69qD3kyGf2t/gLyO6eJiX
         Nyzojscq1xI0JBTbfuU6hcbMpRGmDlOnCJ0B4A65Uudubqt5bS6Okz1ZCVZmnH6ZHMZl
         OboAyKV3qUhfEV5Zb/CczSWT2C7e/cpGjvDaoPA1bwSVJXvyCtEEnhQ+9gDh838iypOt
         2UsA==
X-Gm-Message-State: APt69E1vJ0hupIhNACcxyOmsdkFyjPVm84Y2sJjD1nAFTrTdqUJpMz47
        DWTw4YzkiGP2ZLZitForvVqTTfXBIbctEHc6/EtrK3F7SCPOotzKZhQljT+wjjStkfXmuqAjL+T
        RJKAhYR0n07TVpZxXK1fiuu4Ocs1r280DdcmObL7uhrDi+1lmOgxFXgICOlONMxSY9CvikIYjEs
        lu
X-Google-Smtp-Source: AAOMgpfGjL0pPTHxmrK/q0xya8x1k9g1H96kYnr6Ac/IrFcDoj79cW0diy61BSdmUqgpvGf+MNMvEkZBDaqcNRS5E9Rp
MIME-Version: 1.0
X-Received: by 2002:ac8:707:: with SMTP id g7-v6mr6401887qth.26.1530905653474;
 Fri, 06 Jul 2018 12:34:13 -0700 (PDT)
Date:   Fri,  6 Jul 2018 12:34:08 -0700
Message-Id: <cover.1530905323.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 0/2] Avoiding errors when partial cloning a tagged blob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cloning a repository with a tagged blob (like the Git repository)
with --filter=blob:none, the following message appears:

        error: missing object referenced by 'refs/tags/junio-gpg-pub'

and the resulting repository also fails fsck.

Patch 1 fixes the protocol documentation and the server side of Git, and
patch 2 makes clone error out when such a situation occurs.

An argument could be made that we should not merge patch 2 just yet due
to the fact that some server implementations (such as Git and JGit)
still exhibit the old behavior, and the resulting clones (albeit failing
fsck) are still usable, because when attempting to load the blob, Git
will automatically fetch it. I'm on the fence about this, and have
included patch 2 in this patch set nevertheless for completeness.

Jonathan Tan (2):
  upload-pack: send refs' objects despite "filter"
  clone: check connectivity even if clone is partial

 Documentation/technical/pack-protocol.txt |  4 +-
 builtin/clone.c                           |  2 +-
 list-objects.c                            |  6 +--
 object.h                                  |  2 +-
 revision.c                                |  1 +
 revision.h                                |  3 +-
 t/t5317-pack-objects-filter-objects.sh    | 16 ++++++
 t/t5616-partial-clone.sh                  | 64 +++++++++++++++++++++++
 8 files changed, 91 insertions(+), 7 deletions(-)

-- 
2.18.0.203.gfac676dfb9-goog

