Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94B5D1F404
	for <e@80x24.org>; Thu, 26 Apr 2018 07:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbeDZHvK (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 03:51:10 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36157 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbeDZHvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 03:51:09 -0400
Received: by mail-wr0-f195.google.com with SMTP id u18-v6so28447359wrg.3
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 00:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LaPwT1NsITpuEYJyi9v5ZVihP8hsNPuMULOx509HvRU=;
        b=AFUJrgz1JEMrDeYJHOj8hMuB1lQk+uBiwBYutVWi1UlwcNejd8LrRw3idLWuAu+Ae2
         Fv6r/sPSwz47I1gYSIlGE6dUkmTRaIUEgydULFObWkSb21MMNk/VFqTY2ELv/gJTNL8R
         MzUdQiHlmfyZ7ZhBOnZUQhnu0jae2GbQKn8fnzXoLBH7ggnGYF5zdh0z2Y/SqdNGB5cT
         iqKexgj8LkyFjNMlW/1YIeJYZzbqiW01HGom28OmuAb758ZkWqhYHkzdx5zYyh3YoES5
         +NUig+NKJBQBUpJqYTDKSJXpGICOj2YQMiFaC2W2n4VU0TdZwlRNVaA4yNQLZGfQlUUK
         aDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LaPwT1NsITpuEYJyi9v5ZVihP8hsNPuMULOx509HvRU=;
        b=JCW974yHBJMgWgl7DuK5fmN9ljPWSz5/gYF3eP6IIJlNhLI1GsUH3TyAod4c+PefQ+
         OmGK6vNDgnCsywnKRgy3iOxkacTlurpjOKbthM0bR60+Gy2HQ8lkpMv0NqWWhBxYTzqZ
         u5/vR+oWO7a+mbfviCQw2GngIeY+XT68aPmUwXc4rXuAhf5V7e82ZSI//gs6Jp/0hHca
         rhuKLZi2UbC4buad+GA7dg89Y2Zg1QTOlWO1e3Vrb0Vg6Eu04Cmg3hu5DbkifLXpRO5j
         XVeFVh269albmqxiyF7ZhJIeDfNYOs40AFwhh7Z2q8IKTxWmIR9UdX38SKT/VsIu4FFq
         mCqQ==
X-Gm-Message-State: ALQs6tBGqP6iHQPBGyfi6sk6qBsT1G3jE8GT5cjBIbzHGbYYdIQWhcQQ
        e6Wy6HatAPL5URbyVill/9do1b+y
X-Google-Smtp-Source: AIpwx48TqgQot5+YC+MYiloD4+axmB/IqEWj5p6CdKONeRgq8REn8orTUms8KNNb6uqwWikUMoQjHw==
X-Received: by 2002:adf:8f72:: with SMTP id p105-v6mr26953419wrb.181.1524729067896;
        Thu, 26 Apr 2018 00:51:07 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w6-v6sm3424551wra.16.2018.04.26.00.51.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Apr 2018 00:51:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] enable userdiff for more things in git.git
Date:   Thu, 26 Apr 2018 07:50:55 +0000
Message-Id: <20180426075058.9322-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A noticed that git.git doesn't have userdiff enabled for perl files,
and looking over some recent patches this gave better results, while
I'm at it add one for Python too. I couldn't find anything in
gitattributes(5) that was worth the bother of enabling this (e.g. we
just have one Ruby file).

Ævar Arnfjörð Bjarmason (3):
  .gitattributes: add *.pl extension for Perl
  .gitattributes: use the "perl" differ for Perl
  .gitattributes: add a diff driver for Python

 .gitattributes | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.17.0.290.gded63e768a

