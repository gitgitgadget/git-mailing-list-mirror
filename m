Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29D5B1F462
	for <e@80x24.org>; Mon, 20 May 2019 21:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfETVxb (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 17:53:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43412 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfETVx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 17:53:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so16198643wro.10
        for <git@vger.kernel.org>; Mon, 20 May 2019 14:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rc6ypPd/1pcy07wnydsn0f/YwNrE/zJObGpMETKsD5c=;
        b=fJQz2eesGvch0GcOFbNN0yLD/IDTEWTPD2vVqNVhSK2gNQtdXJcO0aHNEocnjsncT0
         tqipI/vEFKJjlnqz8F5/IMx5JmgFA2aLbhcJej9tGdRB+XKATxP5BqsbaYN8EbHpR3ip
         r2HZ0ooPE7YJGpkv8o5Wc0/09wv64HlEC5EU65DkvZ6LdS36QAt2wULojilZSEmaKplV
         deBGqN/FMM5r3sN9se2yGE5GDFajWqJMQrewzkXvfB+3eSXIkAoHCVYuWYdBGeXu7jY/
         O2wLqxqMjmLDmnwkZMHiw+moOgkjGVIxQGXC/3dh5V8jTtYUhSEMBlx4rlqR2rlySuTX
         FtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rc6ypPd/1pcy07wnydsn0f/YwNrE/zJObGpMETKsD5c=;
        b=o4OxUqnIrAyG84ONgeyht2/3GA+GA+OXPHLNi3MFHMow7u1d9zZMJwaa3XYc/lB2JR
         zta0tBEMn9MwcTFDN+7pWJkugKc1AhR84Yogn4tkX04Z+fgFmyF1CpRuppZb3yaEY9Fu
         AnWDViLuPTQWZ0dJMm14wbXUgQEjrnxPPbq+QnobqeD+5znqSQDbVMIfddNLNTVLK1qp
         t9xfb9IX4RZPFT3GR7DOqVd6hZIesbp2G2pj1BvtjUBMURPCuZOhWnnIVrO2TwrzEdyd
         0swFHAnbXtXInPLlZxP68YJXjhJ+RrIJcaw4qXaVlvw4cy60mpfpFy4GuAj6B1inU3+5
         gjXQ==
X-Gm-Message-State: APjAAAWEyfbSXmzUmTV6jXgegqn03KymgGBh0ySm3Gu1kk8Tjohpn0HS
        9wn9lrq1RVs3WI1CZr8CbTVl7yzP
X-Google-Smtp-Source: APXvYqwtwBqNhDBYjXC5BblB35MNdv93H9J6D6SXlgIk5x4T8Km/yI1jqAngOYyKnsHRncFcDejErA==
X-Received: by 2002:adf:e74b:: with SMTP id c11mr46209277wrn.172.1558389207614;
        Mon, 20 May 2019 14:53:27 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n63sm600249wmn.38.2019.05.20.14.53.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 14:53:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Adam Roben <aroben@apple.com>,
        Bryan Larsen <bryan.larsen@gmail.com>,
        Matthias Urlichs <smurf@smurf.noris.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] hash-object doc: point to ls-files and rev-parse
Date:   Mon, 20 May 2019 23:53:12 +0200
Message-Id: <20190520215312.10363-4-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <20190520215312.10363-1-avarab@gmail.com>
References: <20190520215312.10363-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the intro to note that it's better to ask the index about files
already tracked by it.

I've seen uses of this in the wild where the use-case was finding
object IDs for files found in a freshly cloned repo, i.e. something
like "git ls-files | git hash-object --stdin-paths".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-hash-object.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index 100630d021..077d83ec65 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -20,6 +20,13 @@ work tree), and optionally writes the resulting object into the
 object database.  Reports its object ID to its standard output.
 When <type> is not specified, it defaults to "blob".
 
+This command won't take the shortcut of seeing if the path(s) to be
+hashed are present in the index, in which case their already computed
+object ID could be retrieved by linkgit:git-ls-files[1] via the
+`--stage` option, or by linkgit:git-rev-parse[1]. Use those instead of
+e.g. `--stdin-paths` if the intent is to say find the blob object IDs
+of checked-out files.
+
 OPTIONS
 -------
 
-- 
2.21.0.1020.gf2820cf01a

