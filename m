Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1733E20248
	for <e@80x24.org>; Sun,  7 Apr 2019 19:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfDGTww (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 15:52:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45810 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfDGTwu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 15:52:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so13780662wra.12
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 12:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pp4QPzf0VOiKQIkDqRZYZIjgltqozRjq4Vpk/xtCVuA=;
        b=mFFf3kRia3snNVMUokF8discwNd9fDKVQeOOZErgvSRq8o/Q66337pexAMhVE5dh+h
         jxyFbZfK0+y5coE+YZ4jSLspiTPE9re2a0SbMBoPrA7uxZ3oSJr5/jiOJIi2AvtOmFCU
         gneVw8RXkw/ZdWKtKQ01gEbhaY6sys3cigKKETcQB4wX9R/WX6kMEGzMInNNGhFs2XN6
         iwz169Jj0fDgsfj4cfO5mNM2KEXEdDr9P9/l4H4P0EjaqGJF5AaL+loQULV+/6WtXLwr
         AQW/c7ZMC2L2X/Xt0FkcgBLWDaKvpdnued4L36GG7WKVTtP7wCV9hO3Xr1FbuyDs8gFW
         a8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pp4QPzf0VOiKQIkDqRZYZIjgltqozRjq4Vpk/xtCVuA=;
        b=bcaVaE3lCLWY01WPQfnJqT/jvtg0gaKlws/Oq/Fo0Vfqtcq0nuUcnGP+E+93mySfwt
         GIwOk7Sn7H2P+p/Rmb6Mec1azbuWqoXYY81/x9hVpxxGq5oBFJYOOwfv80hxBFvirnL6
         KUu2zGFA/YM/6bSt8XznuE12zJWuKQN6kl4NI9M9ij7/iFrBGa+p19TmNHNu/3iSwrkq
         iOZcivSVGbiKfaZLklEtfzRANYatEx+IdrJGSq71H4XzMvSjyabM0Y4E/PIY8vk158t2
         RZCVZJV5UaxSMIrH1bczf5hdAaKyxiX0f/+JYd9pr1sgeU4j8rbrKKz6VXafXVTGW2Ok
         /hAA==
X-Gm-Message-State: APjAAAXjHsVlSll5ss/LecGv2ibsBJPCPLd2u6b6NBsfgNmfy0vng5mm
        VOgF7IEcxxaOYQtLWqIU3okgMuUmfx4=
X-Google-Smtp-Source: APXvYqwgkrJTLzH1HHs4qR8XpgI4dSQUMs50YC8rtZrEWLqt5hH/yE7dfKv6h+aon5N+TOw7PVAAVQ==
X-Received: by 2002:a5d:5192:: with SMTP id k18mr13343401wrv.171.1554666768919;
        Sun, 07 Apr 2019 12:52:48 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16sm41815402wrs.0.2019.04.07.12.52.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Apr 2019 12:52:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Johannes Sixt <j6t@kdbg.org>, Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 10/11] gc docs: clarify that "gc" doesn't throw away referenced objects
Date:   Sun,  7 Apr 2019 21:52:16 +0200
Message-Id: <20190407195217.3607-11-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e
In-Reply-To: <20190322093242.5508-5-avarab@gmail.com>
References: <20190322093242.5508-5-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the "NOTES" section to fix up wording that's been with us since
3ffb58be0a ("doc/git-gc: add a note about what is collected",
2008-04-23).

I can't remember when/where anymore (I think Freenode #Git), but at
some point I was having a conversation with someone who was convinced
that "gc" would prune things only referenced by e.g. refs/pull/*, and
pointed to this section as proof.

It turned out that they'd read the "branches and tags" wording here
and thought just refs/{heads,tags}/* and refs/remotes/* etc. would be
kept, which is what we enumerate explicitly.

So let's say "other refs", even though just above we say "objects that
are referenced anywhere in your repository".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-gc.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 5e80f306e7..9cdae588fb 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -119,8 +119,8 @@ anywhere in your repository. In
 particular, it will keep not only objects referenced by your current set
 of branches and tags, but also objects referenced by the index,
 remote-tracking branches, refs saved by 'git filter-branch' in
-refs/original/, or reflogs (which may reference commits in branches
-that were later amended or rewound).
+refs/original/, reflogs (which may reference commits in branches
+that were later amended or rewound), and anything else in the refs/* namespace.
 If you are expecting some objects to be deleted and they aren't, check
 all of those locations and decide whether it makes sense in your case to
 remove those references.
-- 
2.21.0.392.gf8f6787159e

