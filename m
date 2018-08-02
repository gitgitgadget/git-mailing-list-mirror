Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 492811F597
	for <e@80x24.org>; Thu,  2 Aug 2018 11:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732322AbeHBNir (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 09:38:47 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:37677 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbeHBNir (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 09:38:47 -0400
Received: by mail-vk0-f74.google.com with SMTP id b77-v6so724405vke.4
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 04:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Rv6I9PnAAw3jzhli04QbXyjQWA8aydDHmvurBoEQwEc=;
        b=Mh9gdYOkKeWUGHasZB7vwYiZWXg+moQpYB+5qKPLLXIs7VIaKGPiQZh+L3U+sDFjMU
         Qq9Koxwk4/3mBldFBgCP9uJbbagxL7OUmtD3Yxx6Rvb7kZzPegBCVNh2yeZIWaTG6Ifk
         MqLW5mIp9eqyeqEzdG8V7PO+YEDwfO0r/VaxeVCoMRnGxphdx/bnXWI6yL6uWeZaTWrx
         iZUzKhJP128Zv4Bt+Hz+oqzqnA7mbDKNKcbJdP0OLqWcTMP8mjudu7SqOuq/1v0SMgVB
         yEcpHU6eY6SgPeNAuM9Ba4oKHTNcsRV898YVHyr7/RRfF1iJvQ53nHayqi6tzGcLZlJH
         L/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Rv6I9PnAAw3jzhli04QbXyjQWA8aydDHmvurBoEQwEc=;
        b=WiDG5t8tF3pnYAjHUPPqYdh/D3PQdUXvrrNQnb8tmtpoPsUy7oojNbZnfCOpIjE1aI
         OrPcl/AhLF8C8hBCPv+X7NKOThtOg3QLdwrcYrmsFTE61dbarL9dVcft6TkeCNbubb8k
         C9IyrzPQYPYsaaMhb/bl7huMEyLSNdtSe193i/r25MOsqxHy672SbmgAY/TwflNFiStE
         RGIVtoc0Txb8dEH0i+pGPj5cABHF4+28aERsIdhyCqQnMIecSIhhYtYDZP0gatiwCpK6
         6irX22iPNRGSERf8KfbxVAF1fsyDbN/CDsFTMfNaWWETs8DKCKU+K9QUNDGrGLS+RL2q
         laQA==
X-Gm-Message-State: AOUpUlECMb5D5Mr56zTYUQFLVlBktuJqu3XZEmScHxMoK2LIjk5Ma5kv
        72Y8S9ywexAf63hgASdK/T+/DxYD6Kk=
X-Google-Smtp-Source: AAOMgpffggEtLr9zrmeKzEpreZLuZaMS67cWYGRBTIoLDXDncWy38BcIkCOu6ryRxyJahy90MmWYKDpyYTU=
X-Received: by 2002:a1f:9b4d:: with SMTP id d74-v6mr1080871vke.65.1533210478083;
 Thu, 02 Aug 2018 04:47:58 -0700 (PDT)
Date:   Thu,  2 Aug 2018 13:47:51 +0200
Message-Id: <20180802114753.9715-1-hanwen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 0/2 v4] sideband: highlight keywords in remote sideband output
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Address Eric Sunshine's comments.

Han-Wen Nienhuys (2):
  config: document git config getter return value.
  sideband: highlight keywords in remote sideband output

 Documentation/config.txt            |   9 +++
 config.h                            |  10 ++-
 help.c                              |   1 +
 help.h                              |   1 +
 sideband.c                          | 119 +++++++++++++++++++++++++---
 t/t5409-colorize-remote-messages.sh |  47 +++++++++++
 6 files changed, 176 insertions(+), 11 deletions(-)
 create mode 100644 t/t5409-colorize-remote-messages.sh

--
2.18.0.597.ga71716f1ad-goog
