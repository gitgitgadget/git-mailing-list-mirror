Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEFDA1F4B6
	for <e@80x24.org>; Fri, 21 Jun 2019 22:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfFUWbK (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 18:31:10 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37174 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfFUWbK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 18:31:10 -0400
Received: by mail-oi1-f196.google.com with SMTP id t76so5778886oih.4
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 15:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TiNwCZJflNYZRi+NOnd+vhCjmfMO8p8eO9bw5FUSS+I=;
        b=vQztBb3+vfemT/uRBiJ2ujRU4nQVZ+/H21OlwQSVS0LSDXTVATc8e20Tvn5fmLhM6D
         IKdd6PWdV5nLZHFhDm/7FK0e+jND9Xa4ZiexK8tK8d6uWL8AllppIyxrNxDf2FgDXr75
         jRf/UrMCIVRxOeRQlRhYY9YdiEnQyVid0AwLfu/kiIelCkp4T2Ni/XAjQ/elEFwpScSN
         Tr9hjWpCDO+E930xCdTD+ttGcrglP3I3I1tEG/FHQuJh3E0CX34xGkbmbYof6cF9O0J9
         X2NgcSrqF4ub8bkeYe+DYT1Ov7uv34K6nr38lXnR/8Vfseo7MxC0xrPkMaJWo1KD/Gxk
         JV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TiNwCZJflNYZRi+NOnd+vhCjmfMO8p8eO9bw5FUSS+I=;
        b=mlb1VTC/SI6vj4wR3Ai+x5rXuKz0SegfngPJmOuvBYYgpZRiErZ3YOMZeRGI9sBKKG
         xwqwz4N1gCrXhDtlOrgmCkOcnvTSWaH1mW+bxXHT6+GokkCgDx3Fjs/Bxegp9UEGn/u/
         vBaNOpdmtdDsRb5LlpwZxOpuJ1w81rhYq0ZEXVWqpqJ/Ta6Hi+ll2O7sZiHb1zLWVY7S
         tBkCMPpZJ+9ZciaH+PBRv7S9X7h8FIhow09wOKiENBedf4duqtjuLv6I8H91X7xHspyy
         YZ0+Zs/xszkLrNTQLuo9axq1tmnePZf4ho0jywAmDAD25MkuEUt4m8uXQamPt67tl8rH
         qxNQ==
X-Gm-Message-State: APjAAAUiFTzNRyZB/WgBtl+IDQ8siliU5VPSsaYBYGtTtnZYGAMCGen2
        0HvU5UpL9Xb1RJLFufT5v2yVMB4r1vc=
X-Google-Smtp-Source: APXvYqwU/tOfvpDPmgASOlvRwMlIeBCSvP///4NKH1yYzJhxOtRDQW7+9cK96zDAvLeLCBrFXa65sA==
X-Received: by 2002:a05:6808:49a:: with SMTP id z26mr4382530oid.177.1561156269542;
        Fri, 21 Jun 2019 15:31:09 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id b25sm1415262oti.31.2019.06.21.15.31.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 15:31:08 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/14] completion: a bunch of updates
Date:   Fri, 21 Jun 2019 17:30:53 -0500
Message-Id: <20190621223107.8022-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here's another try at completion fixes, cleanups, and more tests. Some
of these have already been sent.

Felipe Contreras (14):
  completion: zsh: fix __gitcomp_direct()
  completion: zsh: fix for directories with spaces
  completion: remove zsh hack
  completion: zsh: improve main function selection
  completion: prompt: fix color for Zsh
  completion: bash: cleanup cygwin check
  completion: zsh: update installation instructions
  completion: bash: remove old compat wrappers
  completion: bash: remove zsh wrapper
  completion: zsh: trivial cleanups
  test: completion: tests for __gitcomp regression
  test: completion: use global config
  completion: add default options
  completion: add default merge strategies

 contrib/completion/git-completion.bash | 202 +++++++++++++------------
 contrib/completion/git-completion.zsh  |  53 +++----
 contrib/completion/git-prompt.sh       |  10 +-
 t/t9902-completion.sh                  |  37 +++--
 4 files changed, 161 insertions(+), 141 deletions(-)

-- 
2.22.0

