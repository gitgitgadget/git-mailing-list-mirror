Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6284B1F461
	for <e@80x24.org>; Sun,  7 Jul 2019 08:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfGGIac (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jul 2019 04:30:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50262 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfGGIac (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jul 2019 04:30:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so2508700wml.0
        for <git@vger.kernel.org>; Sun, 07 Jul 2019 01:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aGHLnApbDximeZimCe42QJNdxwU3tofbP+p5/JeiLRM=;
        b=o289AKHe1M4Y79nJlyo9XqQdJB2l0cYNXgWjCqobyvwg7E8m02DpC1O20DJOYr23Ly
         8I7eDDn8pKSd/O8H581Gz0Trm1XDBwMfrqn8jkbJ0CA1sZuadyJMiWNfdtK/A8MOurK7
         1RX2w3N8SJJLcwhUZa/735gxmZ8TwolUezsFiFyXhR46THup5gHRoNLIKuhug00VIM20
         w+1vHzoFROe429Q5YszUSd4PybU8SECAHM/Uuen5yChowyxxPEZcNYVTT8Lyrsl++l9A
         dFBMp2ejThMwG293aEX38+NCPC82Sg+k62RCUouTKPn+2pZ9C1TX9ufi5BDE0Y+HxE+R
         aOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aGHLnApbDximeZimCe42QJNdxwU3tofbP+p5/JeiLRM=;
        b=e/932nANGWinFit9PfuMLrWSdgYQ6uXBLjV6MEPlsZnJy1cA93AzlBFCK8E5PQGDI+
         FlmO7Z7hAcUf+E5qvcSnOqItYKlDGM34K1QDsrL/YVGBrw5llV2gQAbxddRH+Tlgvi+U
         Pt1XE88na6woEWhmpWRENK5g2/sa0q08jT3HJhDvSHjhMQOsi9lHwodr1xrL+jvpYuO3
         Q9o7iwDHcttl8UKE/D1dcMZ9618AnEIOA5GLf4hxxkNCIg+Ml6h+guSMGwyBTD5SqNTC
         dGzgBWFe0nyDINL+Kj10YASScsS8GNL+KGfljKGaNljByCWj51KbEHcX/LAJhLrjJnCo
         W3ag==
X-Gm-Message-State: APjAAAVNL20VRqiI52ojTr9kg5GnapuHFszRO9v+TE6oFoce51zSx38t
        NLhLHQBeewkG5hD+wuaKZDPLM9zP50Y=
X-Google-Smtp-Source: APXvYqwtmKHjr34jVGaGmbhH5drpU1z6foAN+glTqJN88VxPS1/JL9Ts9CjZRPCVWIYQNx65AA1aLw==
X-Received: by 2002:a7b:c106:: with SMTP id w6mr12075662wmi.80.1562488229549;
        Sun, 07 Jul 2019 01:30:29 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:10c1:a195:f489:5ba4:f140:8c9a])
        by smtp.gmail.com with ESMTPSA id u186sm9606319wmu.26.2019.07.07.01.30.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Jul 2019 01:30:28 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC PATCH 0/5] oidmap: handle entries with the same key
Date:   Sun,  7 Jul 2019 10:29:57 +0200
Message-Id: <20190707083002.7037-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.514.g3228928bce.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an RFC patch series that is not intended to be merged for now,
as it looks like we don't need oidmaps that can handle several entries
with the same key yet.

As I needed this for my work on reftable, I thought that I might as
well post it, to get early feedback and to avoid duplicating work in
case someone else needs it before I start sending my reftable work
(hopefully in a few months).

Christian Couder (5):
  oidmap: add oidmap_add()
  oidmap: add oidmap_get_next()
  test-oidmap: add back proper 'add' subcommand
  test-oidmap: add 'get_all' subcommand
  t0016: add 'add' and 'get_all' subcommand test

 oidmap.c               | 20 ++++++++++++++++++++
 oidmap.h               | 12 ++++++++++++
 t/helper/test-oidmap.c | 34 ++++++++++++++++++++++++++++++++++
 t/t0016-oidmap.sh      | 26 ++++++++++++++++++++++++++
 4 files changed, 92 insertions(+)

-- 
2.22.0.514.g3228928bce.dirty

