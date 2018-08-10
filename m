Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBEE31F404
	for <e@80x24.org>; Fri, 10 Aug 2018 15:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeHJSHl (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 14:07:41 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:41781 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeHJSHl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 14:07:41 -0400
Received: by mail-lj1-f179.google.com with SMTP id y17-v6so7491908ljy.8
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 08:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TysihhBhCujnSmGCumAWvbZAXZjEyKIxQjiMC4/hCCc=;
        b=IR3MCEkA3mpCoNp7FzladqSush5pMVHKfJhzS4NczZuXoVmCAucATYTFRRiuTjZwQ7
         hcN4kfFJm84kbwqBOLZZako1XAstJKVtLfyhSGS66xieqLxKCYrUKcX6qBHx1VyGnmLX
         InE9pL3WJjSOhN9AzERqWi4mGDuKIQLHH09zl4Ydi+bsihW+r0Fc5tTf5Gb2pvypXkro
         Jt3/I4Of7iJWKDUvHGgp01ptp6taa9adZdAVnsMqUcitAcP4e10NW3zFKCgnSgh+x2iM
         OkuS81M8HxwRa8ChoInu0lsA2Gt+WzNEabIEW73r6bx+8uAhjKK7EFeMqt2/jwOCGpKJ
         teBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TysihhBhCujnSmGCumAWvbZAXZjEyKIxQjiMC4/hCCc=;
        b=CoZ1RJJINF+lbErKUwBsMQprFG9N/DkpFo8w6EMx3r8ij9BUGqjX+tcgwS0ARapxbJ
         UnI3/Jx6IvdgQsoFWLdT50x+/mVVYE1ScSBYUAs9fi4f/V6N4ZNE/WJjYlKvkeqqa9d6
         qiJ1VsqeUfTSiq6ZZuL6mQjhkGh4i8puGO8IaM+pCsf2ZJDaTLrENt1DMdFM75aS7ode
         xBOYrClxlTqSPYjhJrARgdnHFMlXBrUm2yL1JhOwxhyEXPu9Vg0WCMRL368AaJSkP1No
         +AtpH48QLCc/G2LtPNgoTwkz4IP0eh0XNymdz3G5n+EN4iFM6WXNtvVwGNOgWMV6N/f5
         TOlg==
X-Gm-Message-State: AOUpUlFAy0qyGRp6SGPONfkXwJy4RQCsQa2TPzsHxCCTH6SeEYGiMDfu
        ylqStJZPYZ491MTarwJ9Fvo=
X-Google-Smtp-Source: AA+uWPw7EDVXIBxlx3op6Xm9U2OnZnjeAiHzf9udFJ7DhmpOlV3kv+WT0cKDAM+RqBP3Q5jplXpWQg==
X-Received: by 2002:a2e:4557:: with SMTP id s84-v6mr5021911lja.47.1533915438136;
        Fri, 10 Aug 2018 08:37:18 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f18-v6sm1664680lja.85.2018.08.10.08.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 08:37:17 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com, pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, tboegi@web.de
Subject: [PATCH v3 0/1] clone: warn on colidding entries on checkout
Date:   Fri, 10 Aug 2018 17:36:07 +0200
Message-Id: <20180810153608.30051-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.915.gd571298aae
In-Reply-To: <20180807190110.16216-1-pclouds@gmail.com>
References: <20180807190110.16216-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are lots of suggestions on optimizing this stuff, but since this
problem does not affect me to begin with,  I'm reluctant to make more
changes and going to stay simple, stupid and slow. I could continue to
do small updates if needed. But for bigger changes, consider this
patch dropped by me.

v3 now uses inode on UNIXy platforms for checking colliding items. I
still don't try to separate colliding groups because it should be
quite obvious once you look at the colliding list (and most of the
time I suspect we only have one or two groups).

Since on Windows we can't really have colliding groups (no inode to
check) so the warning message is to me a bit misleading. But I frankly
don't want to put more effort in this.

Nguyễn Thái Ngọc Duy (1):
  clone: report duplicate entries on case-insensitive filesystems

 builtin/clone.c |  1 +
 cache.h         |  2 ++
 entry.c         | 32 ++++++++++++++++++++++++++++++++
 unpack-trees.c  | 22 ++++++++++++++++++++++
 unpack-trees.h  |  1 +
 5 files changed, 58 insertions(+)

-- 
2.18.0.915.gd571298aae

