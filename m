Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 069901F404
	for <e@80x24.org>; Tue, 13 Mar 2018 20:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753095AbeCMUj4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 16:39:56 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35496 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752740AbeCMUjx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 16:39:53 -0400
Received: by mail-wr0-f194.google.com with SMTP id n12so2297273wra.2
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 13:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=633XID1WlAcHPsfyvEhFqI0gYWjxCgLvRKS0bu1qfJw=;
        b=VZwWhih6Y/vfE0DpKC+Jj3ALiCKRekviD/mg2RTvfYyxvRj113C8cQZjKCGUJCmTWa
         PJSKAOmZB5C7EplJGqnTn7yIrTmTuBpflBc7UomB0cq3CWGm9Q1L5P3khqXNpxJhRcXh
         UCh1k3QJP1FRS3dHpukmLEYY/Ad2jZAsrCUu/QlQ8ngYVrxeN5XZgoGPASNZKbkIuw7F
         3G91gLpcKzsKyiIx4hlEz9v2jFH9Vo44S7KFdO1xUQ3hlgaBhPTm3VWVjBrdUEtMF4A3
         oPlt5IY8Y88Ny2iGFPDVQpyGAzYD5bvQVqjC7jadYRqdjrWjIGwO9tt2Vj1gSbs4FeaK
         Oyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=633XID1WlAcHPsfyvEhFqI0gYWjxCgLvRKS0bu1qfJw=;
        b=qECIj4Zw4pFtN7irSOOEg7F3W7bp03FbcKXnJzU6hjmwXYxevaniXSapVmVhfEFMsS
         T+CxLRosOEDrpoSL604mjAsU8DzoVyeC+l99rMBxMsjbDGb5SxCPs9jeaWFBnMchBUwc
         p2jgWkd4qlk8Q3WAIxsvYQB23oHvSgxTLYssLMyjywA3hQgC7rFB+ssANGZimnb8sXD3
         ziKJpW68j6X+UbyUvuxvJGnj8ptxXAb/tgBvMFMjQdP/bV079okSAw61jaEb5kjILDWF
         hQUDSr4NcYFZWdWwta9DDSVtsWBXb7yu8WF7FiUbCph24TH+Mg3eLz7LDme9RjcDebd0
         wF7w==
X-Gm-Message-State: AElRT7Gy885JgtaCDgfj8J9Qlu9Y1XLq7reABnF+tsbaxlHnaPSgHJWH
        mdZtpzK9JxlHgXCHxI0/QoX/4Ybd
X-Google-Smtp-Source: AG47ELukwGXxLWNKljUAHZQzvEcAT4OvRanbuFhx7jSd6bf3aR801MzTTxZ/t7g4+JUQybbUM2SVIA==
X-Received: by 10.223.151.129 with SMTP id s1mr1735325wrb.206.1520973592105;
        Tue, 13 Mar 2018 13:39:52 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m9sm1424203wrf.13.2018.03.13.13.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Mar 2018 13:39:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Daniel Jacques <dnj@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] Makefile: fix broken bindir_relative variable
Date:   Tue, 13 Mar 2018 20:39:33 +0000
Message-Id: <20180313203935.5084-2-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180313203935.5084-1-avarab@gmail.com>
References: <20180313203935.5084-1-avarab@gmail.com>
In-Reply-To: <xmqqfu533jrk.fsf@gitster-ct.c.googlers.com>
References: <xmqqfu533jrk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the bindir_relative variable to work like the other *_relative
variables, which are computed as a function of the absolute
path. Before this change, supplying e.g. bindir=/tmp/git/binaries to
the Makefile would yield a bindir_relative of just "bin", as opposed
to "binaries".

This logic was originally added back in 026fa0d5ad ("Move computation
of absolute paths from Makefile to runtime (in preparation for
RUNTIME_PREFIX)", 2009-01-18), then later in 971f85388f ("Makefile:
make mandir, htmldir and infodir absolute", 2013-02-24) when
more *_relative variables were added those new variables didn't have
this bug, but bindir_relative was never fixed.

There is a small change in behavior here, which is that setting
bindir_relative as an argument to the Makefile won't work anymore, I
think that's fine, since this was always intended as an internal
variable (e.g. INSTALL documents bindir=*, not bindir_relative=*).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index de4b8f0c02..b2f8f2b171 100644
--- a/Makefile
+++ b/Makefile
@@ -468,8 +468,7 @@ ARFLAGS = rcs
 # This can help installing the suite in a relocatable way.
 
 prefix = $(HOME)
-bindir_relative = bin
-bindir = $(prefix)/$(bindir_relative)
+bindir = $(prefix)/bin
 mandir = $(prefix)/share/man
 infodir = $(prefix)/share/info
 gitexecdir = libexec/git-core
@@ -486,6 +485,7 @@ lib = lib
 # DESTDIR =
 pathsep = :
 
+bindir_relative = $(patsubst $(prefix)/%,%,$(bindir))
 mandir_relative = $(patsubst $(prefix)/%,%,$(mandir))
 infodir_relative = $(patsubst $(prefix)/%,%,$(infodir))
 htmldir_relative = $(patsubst $(prefix)/%,%,$(htmldir))
-- 
2.15.1.424.g9478a66081

