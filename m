Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F05420D09
	for <e@80x24.org>; Sat, 15 Apr 2017 10:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753012AbdDOKja (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 06:39:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36448 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752091AbdDOKj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 06:39:28 -0400
Received: by mail-wm0-f66.google.com with SMTP id q125so1998377wmd.3
        for <git@vger.kernel.org>; Sat, 15 Apr 2017 03:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=spsSTuNw5zQTWQu7k2+0/V/WwRFp2KKs+wTKiYaOD+Q=;
        b=gNtTyO5YaZuC5KUAYArt8AKjOpU4bbNRlHahSp99LEhlHp1emBagbsV4n1ks1MD2yb
         yGr5iP0FwPNBa9qPRQ4GlleCpVdfqTWfH+vRjFpYxj1vQCNCRiG6k9887PzfmYwjIHvP
         JM2e1DsW7XZsNA3I0pLzCAV8BAPet0IeE/jP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=spsSTuNw5zQTWQu7k2+0/V/WwRFp2KKs+wTKiYaOD+Q=;
        b=feq71xx/0i8+78FZ9tvcX+R6LABO6o2RWssUrZ9z4THnlI0bSgMIX72c2evORwgXGp
         8h0h92MZEq2UPNfrzV+bHwyCVCwyNv2UaVlHN0qfmQaGEaXTTG3QOsawCzQvZw0cCFEQ
         oE14wa7+4mqzi5ZNTS+0DcrxEmEN955CHratCzj+XdFWWzfKdINfM8Pzs93Zly0sKmcK
         8SdFz2GaPViyHU5puWeFHlixxqx4mD2TX59qR8Qc26j/ahtG1yem1yS9jT1zG6v9uxhM
         Ni5eZReHkmjQ5QUq7EU0UWOizBoAijtNbHVjzLBCBXrQBBgn5h0sLvlKVNFupahuAzR3
         jKOQ==
X-Gm-Message-State: AN3rC/7OmdnVEmxkoQAdOG+67f7kEClJRpMpkDBvu8y/glaUFPWMOHdz
        CR9ZpZJf21/V6Q==
X-Received: by 10.28.148.143 with SMTP id w137mr2108841wmd.72.1492252767426;
        Sat, 15 Apr 2017 03:39:27 -0700 (PDT)
Received: from ldiamand-t3610.corp.roku ([81.145.207.254])
        by smtp.gmail.com with ESMTPSA id y63sm2072774wme.31.2017.04.15.03.39.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 15 Apr 2017 03:39:26 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Sam Hocevar <sam@hocevar.net>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH 0/3] git-p4: use symbolic-ref instead of name-rev
Date:   Sat, 15 Apr 2017 11:36:06 +0100
Message-Id: <20170415103609.6002-1-luke@diamand.org>
X-Mailer: git-send-email 2.12.2.719.gcbd162c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Followup to earlier discussion about use of name-rev in git-p4.

http://marc.info/?l=git&m=148979063421355

Luke Diamand (3):
  git-p4: add failing test for name-rev rather than symbolic-ref
  git-p4: add read_pipe_text() internal function
  git-p4: don't use name-rev to get current branch

 git-p4.py                | 38 +++++++++++++++++++++++++++++---------
 t/t9807-git-p4-submit.sh | 16 ++++++++++++++++
 2 files changed, 45 insertions(+), 9 deletions(-)

-- 
2.12.2.719.gcbd162c

