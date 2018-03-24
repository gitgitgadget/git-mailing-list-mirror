Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58A621F404
	for <e@80x24.org>; Sat, 24 Mar 2018 20:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752873AbeCXUiG (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 16:38:06 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37852 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752736AbeCXUiF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 16:38:05 -0400
Received: by mail-lf0-f68.google.com with SMTP id m16-v6so19183035lfc.4
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 13:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kKkA0c3eLAl1T21xwFwkoaoNBBwn3fk7xe7lwIPlmm0=;
        b=DdH6mpdKhbK4KNkETBtromms6QY+7bQFcGEYxkY7T0qVVGbHHjwOb7znJ5osw3wP7r
         weAZMvOiqwkBIHI+ZEN10Lf3pjHE8qEqPWN8c9ZpD6SzSsGzD15wkQNwxAp7yRjTA9xY
         xi4Cev9/cpFZo0oZTbpoI2LteCzmci4dYyUrUx+lYq7lWyvo9o1IVuD8WPxRFwV1OQLx
         kPtSMpwdOEeYZqyDWMkghhhom+JP4YopfrtdzD2jmlNU96CaE+FzTFSfiHj1eYHfWA94
         VLf2f66HvIU54LBV+ZDbYxH0NnW6mYp74i3aE+W1OF7UClkvKiYzZFd/fjKwOFy8GQHq
         RFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kKkA0c3eLAl1T21xwFwkoaoNBBwn3fk7xe7lwIPlmm0=;
        b=kWrmIA7/8f/gKmeowSRnHIexmILYUjErYyJJ+hkFnWtWC7ttvDWykeVWDEHYI+brMz
         LC3RmBRZNE7l1v+iW/My8j2P+Ml/fYmn8JB7YahunS33bArVrMqvs5u2zNJzgg1aXdhB
         oc5thTaLYU4dbwQm8qUe6Qo/XdgFLUbR1aBXPe3j3/x1GVNKeMLD7i0HMCayEPuORJCB
         /PFTK/h62E2PkiHEyDOYb2Q621Qt+LaRCfPr4vHHbUD65nsoZ2FlPHhO7UXiILY+f+cn
         2VUGc23bDIMGQl9vWGnIf0/xuj+d3/7+Oe1691DjdgS2GJqrdxljK5ioiFnJziRML/OS
         erPg==
X-Gm-Message-State: AElRT7EFput5ila8wMI96k88/JNdOlxWXAhkMh/RyrrFtO9VnIrq5pc4
        t4xSEI744HPWORSaRsvlJOA=
X-Google-Smtp-Source: AG47ELujrsYrGlZVlvrUep4b9tSvt04dDLDb/Fm8eawsSpfWbpK6x2sJgQYrAc1RiEsoO35SOlAvog==
X-Received: by 10.46.99.93 with SMTP id x90mr23604261ljb.2.1521923884327;
        Sat, 24 Mar 2018 13:38:04 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n2sm972680lji.75.2018.03.24.13.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 13:38:03 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/8] completion: add option completion for most builtin commands
Date:   Sat, 24 Mar 2018 21:35:17 +0100
Message-Id: <20180324203525.24159-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180321193039.19779-1-pclouds@gmail.com>
References: <20180321193039.19779-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds option completion for many more commands. More
importantly it introduces a generic completion function
__git_complete_common(). With --git-completion-helper providing more
and more information in future, this function can start to replace
many other _git_xxx() in this file.

Nguyễn Thái Ngọc Duy (8):
  git.c: move cmd_struct declaration up
  git.c: add hidden option --list-parseopt-builtins
  completion: mention the oldest version we need to support
  completion: factor out _git_xxx calling code
  completion: add --option completion for most builtin commands
  completion: delete option-only completion commands
  completion: use __gitcomp_builtin in _git_ls_tree
  completion: use __gitcomp_builtin in _git_cherry

 contrib/completion/git-completion.bash |  75 +++++++++++----
 git.c                                  | 122 +++++++++++++------------
 t/t9902-completion.sh                  |   6 ++
 3 files changed, 127 insertions(+), 76 deletions(-)

-- 
2.17.0.rc0.348.gd5a49e0b6f

