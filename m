Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B909C25B0E
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 00:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbiHQA2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 20:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiHQA2E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 20:28:04 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBA972849
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 17:28:03 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bu15so5948244wrb.7
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 17:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=ZGQ4Y/jRoQBfPqT5IyDW+jOzPda3OkE+8G4pS7NUXEU=;
        b=kssipgPwe9kNUk4V+AsVZCSR/UtAWmMYBdpINZbljeZPU0WPGCwfSQC0uJRSdn6QI7
         QiF7Dw4QyPJmlwH70kYwhszmOy5tExaaHUIeDyClBL2dosn/GeJLuP2GiY3i+cUW/XrX
         E12GbXzBMnQeKR8yMuIQEjTabb4jytFcS3jan8FR6IsOf8HnMJmrtWBmD5Wp+Yv8V57U
         rU6AHQZG7zYsnQZDpt7+AW6kwHLRTZoDaBJExUWRn4VPVF00keBbVYx2ztVza8cbpwml
         JtPpj9w4tR6Bq8UV6cX/Nyk5npLOqDA/S3NsF6TIsSzBCQv42bxFOyhqv7AAMygzCUi6
         yfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=ZGQ4Y/jRoQBfPqT5IyDW+jOzPda3OkE+8G4pS7NUXEU=;
        b=V9Vcc/C+4Eso7+CvZJhdjSXJ0sIuUsVzDsRhhUWWoiQJkQ55mgFQgH715+vGbtIwqr
         q9K/5AIpmEbu90Sw+fGH15Ph54WxYM2Mwrmcb+3B9sXKarCHa59q+nIQTfXTic0nlLs4
         c4Lrmmy8fGuhmHrnGijos/xUkCbOAqhA6rYSv4isVrnJgdMq8twTyGcOzeScKimeHQgm
         DFCJ2u+086wWvBTm01+LmffF0HpZ+w+hPEE1ZMyY3iutItprMGp0eBArFZ43oagry62X
         V/50MSrQlgUpf0vIlAjS5Z67TtR7JssOXukfMWkQ3wo00z2D5lgJooC+VOHoJDxrSiOA
         UZXA==
X-Gm-Message-State: ACgBeo1eu3DlXDSIhw+M/LaBzxtkZy1mgMO/0xUmHJFAtszcoxKzD/Np
        snq3FjmgNV3FTwGgO1IvLQ69C6ix6zk=
X-Google-Smtp-Source: AA6agR4CO1FAXe6/bmN2x7X57QcN0oYLhpygTLJaTuipsj7O8ASpqotVkUkUFhaJm9ZMvdhAxywR9Q==
X-Received: by 2002:adf:a54a:0:b0:225:14b:36a with SMTP id j10-20020adfa54a000000b00225014b036amr7901418wrb.385.1660696082014;
        Tue, 16 Aug 2022 17:28:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j4-20020a05600c42c400b003a5c064717csm333169wme.22.2022.08.16.17.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 17:28:01 -0700 (PDT)
Message-Id: <pull.1325.git.1660696081.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Aug 2022 00:27:58 +0000
Subject: [PATCH 0/3] Fixups for cw/submodule-merge-messages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a few issues I noted in cw/submodule-merge-messages (which
merged to next a few days ago). Sorry for not responding before that topic
merged to next; I caught Covid near the end of my vacation and it took me
out for a while. So here are a few patches on top instead.

(Note that my first patch builds on Junio's patch-on-top, though it kind of
obviates the need for his patch. Let me know if you want me to rebase
directly on Calvin's patch and remove the need for your patch, Junio.)

Elijah Newren (3):
  merge-ort: remove translator lego in new "submodule conflict
    suggestion"
  merge-ort: add comment to avoid surprise with new sub_flag variable
  merge-ort: provide helpful submodule update message when possible

 merge-ort.c | 106 +++++++++++++++++-----------------------------------
 1 file changed, 34 insertions(+), 72 deletions(-)


base-commit: 38e3c211f000ebde511099b62be2af104eb20c12
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1325%2Fnewren%2Fsubmodule-merge-messages-fixups-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1325/newren/submodule-merge-messages-fixups-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1325
-- 
gitgitgadget
