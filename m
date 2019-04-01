Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48D4820248
	for <e@80x24.org>; Mon,  1 Apr 2019 18:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfDASwU (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 14:52:20 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33397 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbfDASwU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 14:52:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id q3so9290985edg.0
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 11:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vdwaa-nl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jNMxKIkGPI1QIshdDrnWatCnZuJDYjUxeq7Vc/Eib84=;
        b=KGfnMGwJrIpmMXX62F1GXUBOrvcg7rtcgQgJ8OPGZyZu0y7umk4WXs3oS0kGd7543z
         EtmUxlvnRXn1Upa5Wa+60au6ykqAusL42XYZ6NIx4qNWLUILSPhSAZ+4evO2m0Pj18ez
         89WofqmYTywz0Ww9sI8rDU6BVczik5MNJ2M60pTWxk0+1W/I19KA5XtB09lgYrIg0NBn
         rW2heiXiXZuWgH8+LFyjNh0mTo6HFyk5lRfQIMxwDmquSaGXEQMeUecBDNvSHBf2ldQU
         Qs3Ykflqr3q21C0dusDJQXsrzV+BW24DNMdujuPuheEjS0sESAHDjOoJlekrK1cs9uKK
         B9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jNMxKIkGPI1QIshdDrnWatCnZuJDYjUxeq7Vc/Eib84=;
        b=udyrYt2tmMEQB9y1gqGDQQ73wajMd+gvCcASltO+FYb2QR+LPnoVgnKtzGVC5fo9Ow
         vyYA1O80xn8pGT0CCdQlxXvLAACCF6CibXlz+Pf/1QV3BdEq9VsC/CBJQM4nuRP1dHX/
         GpcMsza9vtHI6YhPuDbR7gjvWJZkPXlrg6+xE3CEfCT4DwMB6wWyyKJH/AquLEICsSQS
         +vUX8JSULlt20QwLnGLsF5hvW+vohuE7teM7lUu1v2SpGJHpqAK8mYN+UvWgytylc+j9
         9LbRRcM4b8gZvvZltmqR4uaGNYGv1i+aLk5v/Epzu9qLnkfmRTwC2AR1yAVCPnUIqCj/
         B3wA==
X-Gm-Message-State: APjAAAXLPpEi2lrR8+mAttis8j5rFN0ilhTj0prZBWuyyZkRYSNWRNJY
        mMZtxPIBU8BhFC9aAxGLIqzYgXCSnpoxgg==
X-Google-Smtp-Source: APXvYqzBdDEAun4ddraXDH0JmE0NfN2/8fkMmcoEXyWovIsWmBQVZxrDAu7ZlvMN7cusyuebhAeBJg==
X-Received: by 2002:a50:a547:: with SMTP id z7mr42996078edb.58.1554144738172;
        Mon, 01 Apr 2019 11:52:18 -0700 (PDT)
Received: from localhost.localdomain (83-84-17-34.cable.dynamic.v4.ziggo.nl. [83.84.17.34])
        by smtp.gmail.com with ESMTPSA id y2sm3422574eda.11.2019.04.01.11.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 11:52:17 -0700 (PDT)
From:   Jelle van der Waa <jelle@vdwaa.nl>
X-Google-Original-From: Jelle van der Waa
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Todd Zullinger <tmz@pobox.com>
Subject: [PATCH 0/3] Make hg-to-git contrib script Python 3 compatible
Date:   Mon,  1 Apr 2019 20:52:05 +0200
Message-Id: <20190401185208.17031-1-jelle@vdwaa.nl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series makes hg-to-git Python 3 compatible and was tested
that it still works with Python 2.7. I'm not sure which Python version
in minimally supported for these Git contrib scripts.


