Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BD5320248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfCEMam (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:30:42 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181]:47048 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbfCEMam (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:30:42 -0500
Received: by mail-pg1-f181.google.com with SMTP id 196so5542670pgf.13
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FQX8vk3t7xAq+4JpiDyYxpV4tiit/QCBlqPlkD7RE8E=;
        b=F3lNBCA/AFhVjlr1kmkM40nR6yC0S5GUkxf+vpRmvLLimAwydPxYw/5G3NVwQvzQyE
         cR+7MYo2iM+sMMTFFrMUaVeewxIn6WUZ222MhWp6+YDuKKWn+iGoH5oRpK9ooC4Jmnpn
         LbcxxnRowLiD0txhwFJxDrdsBn+yOl1RVZ1/vL3qu8skShG2YzxgNnJFCGbHK+TEC7Mf
         n6Mkt9sZ7JNPru/ZOOx8AgylegX7f7LL9GuJNXSkOXBFYeHYPd18gJKWX2cTNFjmE5M8
         DYH7THzgW4Dks9XX4mHXCR1nfex7SFLtkMpee8GWhVU/6uWP3PU94ivWAPaRsDcrGouh
         Wp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FQX8vk3t7xAq+4JpiDyYxpV4tiit/QCBlqPlkD7RE8E=;
        b=WE9Nid8IommIq42jsRk8NKzRC4CDn8vnMZrvdpn1pW3tAXm54OdtFkiyAby21Ag/Rs
         nmYjc0T8Z0c5qU244rrBjBlEG+WuNLqR6QAZi9N1VTJ3wzGevb3I2yrrVkDKZOaCgZVL
         Ff/eh4M/mZRZCwZvfD63mehjMnv8WTvK9GOfOXORD5emwSmdoDF6vMiqA7oL/3Hm2DEt
         XpRmfb+kawg0Q5E/qxGb0p22bumwP6ziPmVCTp7mn7wDRghhJOF68tmoW/12I1D0lfR3
         0UzRHWdvVa5xo66Fwp1xk76UvE5YsNzKBgw36rdqNvEaXt8Or3qt3jCLfj8NsuXixiv8
         1zeQ==
X-Gm-Message-State: APjAAAVj97MLFLiNkLjpCAT67IuSRCZUfV4jZIguKDu5p7awYZ1XL47t
        /4bZfGl796FkWJ0Kkk6vKdetrQ2A
X-Google-Smtp-Source: APXvYqxJlSZjKLVRlIHPGqKc3hSnEpxTrAFULC8XqRobqY4ZyuWBFjdmkpZYh0F5ujF01UuWjZ+6rw==
X-Received: by 2002:a17:902:e789:: with SMTP id cp9mr985505plb.127.1551789041524;
        Tue, 05 Mar 2019 04:30:41 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id p14sm21177194pgn.34.2019.03.05.04.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:30:40 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:30:36 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/20] nd/diff-parseopt part 3
Date:   Tue,  5 Mar 2019 19:30:06 +0700
Message-Id: <20190305123026.7266-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The next part of nd/diff-parseopt to continue converting more diff
options to parseopt. Based on nd/diff-parseopt-2.

Part 4 will hopefully finish the diff.c part and we'll move on to 4-5
more parts on revision.c.

Nguyễn Thái Ngọc Duy (20):
  diff-parseopt: convert --[no-]indent-heuristic
  diff-parseopt: convert --patience
  diff-parseopt: convert --histogram
  diff-parseopt: convert --diff-algorithm
  diff-parseopt: convert --anchored
  diff-parseopt: convert --binary
  diff-parseopt: convert --full-index
  diff-parseopt: convert -a|--text
  diff-parseopt: convert -R
  diff-parseopt: convert --[no-]follow
  diff-parseopt: convert --[no-]color
  diff-parseopt: convert --word-diff
  diff-parseopt: convert --word-diff-regex
  diff-parseopt: convert --color-words
  diff-parseopt: convert --exit-code
  diff-parseopt: convert --quiet
  diff-parseopt: convert --ext-diff
  diff-parseopt: convert --textconv
  diff-parseopt: convert --ignore-submodules
  diff-parseopt: convert --submodule

 Documentation/diff-options.txt |   2 +-
 diff.c                         | 342 ++++++++++++++++++++++-----------
 2 files changed, 229 insertions(+), 115 deletions(-)

-- 
2.21.0.rc1.337.gdf7f8d0522

