Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93D832070F
	for <e@80x24.org>; Mon, 19 Sep 2016 20:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbcISUbU (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 16:31:20 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32849 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbcISUbT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 16:31:19 -0400
Received: by mail-wm0-f66.google.com with SMTP id w84so9677246wmg.0
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 13:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=qurLuCKqQw3oNICO5hdo/dKyf94HSgPd3Ko3qEPDG9o=;
        b=nBulYe2bYDF3Fk7O/gO7T3Fu//sw56oKsWjc+3FTChg/cmNqJAbm1hmsJrxxNZgvCZ
         bg7Wakl9qbyAec47ogT7AwEimzzE+hj1slI/P2iAWqOVPWysptdiKk0GQPLfV4eX2gc9
         yq5FMe+TqOt8O/iMWMcAUrM+7U51OtFSaUr+h1Yhh8+7PLwu1jk/jW0QvPRabrTkpsQf
         TLLx9IC5YsnkWLrkQjzYaQ/i696TWaC1Ege7svw9sbxgBeRL3Rifh/38F9HBIT1/MGi+
         BHSOteVcQq2NQWOS3cjO2dM1SA8TNG5F3xlKkxQ4+fVgBWsL6nS9VOmC9Zs0czMfXsz8
         7SmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=qurLuCKqQw3oNICO5hdo/dKyf94HSgPd3Ko3qEPDG9o=;
        b=kV7E8mdnpk+y00c0DjiMj0D4f+5t/IyQ7FswczmuaQ7zfrQNqpKCtj2+oQ06ESNK9P
         hHvOVO+MyeIkK1LRtc1OtmTowcHAkZbNWUSSkwC3ESNyKA9chDdxwcyy0rrKdqQ84gaQ
         ChhlE45j3qVfs6jxlcTXvcCi/b5ptZl4XhN4m/v0A6tKpMrZcrF0lmvw0645XS8+6dNo
         h8/dS6NMCtvqz8TUUnUT3B4/b4T4uxrh/ZYd9DL1Idv61VtWaigaHRQDkm68lkJ8IOlx
         tXZx9mOCfg3LwBVTPMwhB5tqCb/qgjry15LpHxT+yuAPKlYoUUAdxpx9NS6BD//UDWau
         kGLw==
X-Gm-Message-State: AE9vXwNBSD5i7pSn8WZNHdmsDpjypdVPDG1KLaou/IMw4wy5n0Zkj3G9tMxbzhxHrwfbrQ==
X-Received: by 10.28.145.65 with SMTP id t62mr30120wmd.49.1474317077928;
        Mon, 19 Sep 2016 13:31:17 -0700 (PDT)
Received: from bender (h081217206156.dyn.cm.kabsi.at. [81.217.206.156])
        by smtp.googlemail.com with ESMTPSA id xb6sm24788565wjb.30.2016.09.19.13.31.16
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Sep 2016 13:31:17 -0700 (PDT)
Message-ID: <1474317076.23916.6.camel@gmail.com>
Subject: .git directory tree as tar-file
From:   Martin Bammer <mrbm74@gmail.com>
To:     git@vger.kernel.org
Date:   Mon, 19 Sep 2016 22:31:16 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

it would be nice to have an option to have a .git.tar instead of the .git
directory tree. This tree quickly gets very big and copy and compare actions
take very long. I've observed that even in small projects with only a few files
the .git tree can contain several thousand entries. Especially when projects are
saved on shares copy and compare actions are getting very slow.
Is such a feature already planned or is there a chance to have such a feature in
the near future?

Best regards,

Martin

