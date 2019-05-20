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
	by dcvr.yhbt.net (Postfix) with ESMTP id E8D521F462
	for <e@80x24.org>; Mon, 20 May 2019 21:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfETVx3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 17:53:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40496 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbfETVx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 17:53:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id 15so786084wmg.5
        for <git@vger.kernel.org>; Mon, 20 May 2019 14:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qfp+25EdtCzAZagRvcYdxv6hoKsRLjQuQA4YfB9EpF0=;
        b=cm4iFseLAhBjPLY14aJBQmKw+7+iZUeLJo7e0YToi2w9b4GSCp0May3y5tmBxgZFja
         zPFVYLRR/1U5hJn2NY8/YL/PkGMfEfeSVfoSFMCczVKCmRPy63SGZZ5SmZwBUuEavU+l
         e9JOBIA1+8+3aUnLGvsko/ygBmxTgWGDA6tzyOQkTgkc1tzWKo7d5G2UMQktPw7PtDtq
         d65KFrYECIuu88LzCiA5IeSSUo6p1yIwOwoD5ZN71DSzZIHTyP84BqUxdsukbYLi2wQu
         O1lN+eQcc8VEOkgyzxM24cmqlDnQdr1J02JwTco/YctVyBbwJoVuIKMwJ2R6ldNQUyRo
         i2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qfp+25EdtCzAZagRvcYdxv6hoKsRLjQuQA4YfB9EpF0=;
        b=gz6XyGlwCc+kUq25pSrLWKIv7ARTj/fQVStCUy2l9vVpCMhPEdYf5WcqqzEIRGN7Le
         4LXSH6Z0Z7WAikILgpbJb+VtRiK7DuSPQpWGruDBTWnFZ4BEgb0UJci+NSoNiGIIG25n
         fQqTq2727kG+ytaCtabeRZiVJFelR5Wz7TKPMiOSUobtaIsp2cTeeBMiEtX5wokZwQsD
         /9qQABh96C0v83No7i/RLI5YyFhdM3Xk6Ib6u82eYqKLYRIN+/+/eAuj4sdTGHso/T0r
         LtF3PxpUOyIspNBekLGG8m/tGjFUyJ1jY78vYnV2VOnQkZlnFv1DmFxUeulQXOmTuxq1
         37pA==
X-Gm-Message-State: APjAAAVezbwGjTjgGSst4xMuMpHq1UWzJ0C+RBiBfML310n/NLQI6/NB
        G0SpzYSIgFBoUcC7a+C6kwkvUZqk
X-Google-Smtp-Source: APXvYqzxYgvO6qNeafn924q9qGOeshQDiv1jG4NKOwuj74nxfjgJx+2ZXgn6fb1i/W4jEVTbKf+teA==
X-Received: by 2002:a1c:f916:: with SMTP id x22mr795139wmh.81.1558389205268;
        Mon, 20 May 2019 14:53:25 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n63sm600249wmn.38.2019.05.20.14.53.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 14:53:24 -0700 (PDT)
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
Subject: [PATCH 2/3] hash-object doc: elaborate on -w and --literally promises
Date:   Mon, 20 May 2019 23:53:11 +0200
Message-Id: <20190520215312.10363-3-avarab@gmail.com>
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

Clarify the hash-object docs to explicitly note that the --literally
option guarantees that a loose object will be written, but that a
normal -w ("write") invocation doesn't.

At first I thought talking about "loose object" in the docs was a
mistake in 83115ac4a8 ("git-hash-object.txt: document --literally
option", 2015-05-04), but as is clear from 5ba9a93b39 ("hash-object:
add --literally option", 2014-09-11) this was intended all along.

As seen in 4dd1fbc7b1 ("Bigfile: teach "git add" to send a large file
straight to a pack", 2011-05-08) we'll otherwise not guarantee that we
write loose objects, so let's explicitly note that, using vague enough
language to leave the door open to any arbitrary future storage
format, not just loose objects and packs.

While I'm at it remove the mention of "--stdin" from the "--literally"
documentation. This wasn't correct, the "--literally" option combines
with any other option (e.g. "--stdin-paths"), not just "--stdin".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-hash-object.txt | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index df9e2c58bd..100630d021 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -28,6 +28,12 @@ OPTIONS
 
 -w::
 	Actually write the object into the object database.
++
+No guarantees are made as to how the object is added to the database
+(e.g. whether as a loose object, or streamed to a pack), except in the
+case of the `--literally` option. How it's written may depend on
+heuristics such as the `core.bigFileThreshold` configuration variable
+(see linkgit:git-config[1]).
 
 --stdin::
 	Read the object from standard input instead of from a file.
@@ -53,10 +59,11 @@ OPTIONS
 	is always implied, unless the `--path` option is given.
 
 --literally::
-	Allow `--stdin` to hash any garbage into a loose object which might not
+	Allow for hashing arbitrary data which might not
 	otherwise pass standard object parsing or git-fsck checks. Useful for
 	stress-testing Git itself or reproducing characteristics of corrupt or
-	bogus objects encountered in the wild.
+	bogus objects encountered in the wild. When writing objects guarantees
+	that the written object will be a loose object, for ease of debugging.
 
 GIT
 ---
-- 
2.21.0.1020.gf2820cf01a

