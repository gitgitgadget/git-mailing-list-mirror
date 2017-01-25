Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D35DB1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 16:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbdAYQ7G (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 11:59:06 -0500
Received: from mout.gmx.net ([212.227.17.20]:59662 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751787AbdAYQ7E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 11:59:04 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Le69A-1c9D7F40SK-00ptmk; Wed, 25
 Jan 2017 17:58:58 +0100
Date:   Wed, 25 Jan 2017 17:58:57 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Retire the `relink` command
Message-ID: <10319c47ff3f7222c3a601827ebd9398861d509d.1485363528.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:u+uRtkahJ7MOaBEoXHtoy7+QjszO3D4BZ1GBtuQQ5NsByDv6DKm
 eepd2ZsDhlI7z0rBPcUm8LylTSH97SvYr1PqrWSXANeDvs8txrI7qnxspvI/bgyXnU4dQJK
 b+68j1tAuRGgF1qYufAl12T7xSdCExAN2HherM/7I30Y9Jpb4KxRmVnCXH5vrNhpbBoOH6I
 iLnKfuGQ3xWbEWGQZxjfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f6Q2rUarzL0=:r4V2ScrlHZj8hUcw+Tk8e4
 ddlS5oaTJLW01foqC2K6BplGm6EBq+HlVZujcmYp+oL+BmJffGBIaH6bgrdItxnsToOaK4afA
 vlwI/+rHxM+xleeaAN3LPK57+D/pGqrx2TSrH5CSNWqgNg1B3+/dovnFFXtUWdxb/UbNf99mv
 kfjCTZ014PhIwGDzZ2yjnfwfGzgsPWoyBwJX2/gzDY1uExAu658dqyQo4iAqeTAviDT9SsL2D
 8Jv7VJbFaSioh5BVG+YxNRtaMK8hdac2MpXsy6RMnu0pqgpu7ITJYy2nNUHsBceQq74XAE3qp
 FpJyjZj5sSBacIPuAKIWFKJ1nxKm8squ7teCzyo1JOdgQed1rdO38x9BrMtu0/lvpZjmXJCkY
 TODCv/Hp1rT5U0sXVztRif8ebpY6bhOG28bQlp/t0oIZPVJtGL3Vl1XQWBs80+POjHj9DIkm1
 lvtPTdWzQwNtrAb2DyTBoulYEnAtzp2tCudR6xLFxsqoF9epDLJGHjMnD9KO+JZ4YBkFCftJH
 0i14ugmSLCfFS66z9//hixb0Bj09wlibOdGmUzsqf2wz9V8rJi567L5Gqpvh0HB7LC+Fz4826
 b7P0V14GgY4ty+VGU0Bn8FnheD3xMkVqu5RjwhmHoYE+9xjqwm8mBE25E+5zv347XHYggciVn
 htLWGwDc0dttZiIpdqajDlmcgnTvB0f59KZn9AG74fyby9C2Wl8jNrpLhgkndNYS/Ba+N19UQ
 IvJuyEvoY2BAKjr7+Xm+bj0UX0OzfwqdNlpYw5OJRYvum40KRO1VIS7UGuXBOLoz7Gg7d/wt9
 wN4/3jn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Back in the olden days, when all objects were loose and rubber boots were
made out of wood, it made sense to try to share (immutable) objects
between repositories.

Ever since the arrival of pack files, it is but an anachronism.

Let's move the script to the contrib/examples/ directory and no longer
offer it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/retire-relink-v1
Fetch-It-Via: git fetch https://github.com/dscho/git retire-relink-v1

 .gitignore                                          | 1 -
 Makefile                                            | 1 -
 command-list.txt                                    | 1 -
 git-relink.perl => contrib/examples/git-relink.perl | 0
 {Documentation => contrib/examples}/git-relink.txt  | 0
 5 files changed, 3 deletions(-)
 rename git-relink.perl => contrib/examples/git-relink.perl (100%)
 rename {Documentation => contrib/examples}/git-relink.txt (100%)

diff --git a/.gitignore b/.gitignore
index 6722f78f9a..b1020b875f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -118,7 +118,6 @@
 /git-rebase--merge
 /git-receive-pack
 /git-reflog
-/git-relink
 /git-remote
 /git-remote-http
 /git-remote-https
diff --git a/Makefile b/Makefile
index 27afd0f378..658ac19247 100644
--- a/Makefile
+++ b/Makefile
@@ -527,7 +527,6 @@ SCRIPT_PERL += git-archimport.perl
 SCRIPT_PERL += git-cvsexportcommit.perl
 SCRIPT_PERL += git-cvsimport.perl
 SCRIPT_PERL += git-cvsserver.perl
-SCRIPT_PERL += git-relink.perl
 SCRIPT_PERL += git-send-email.perl
 SCRIPT_PERL += git-svn.perl
 
diff --git a/command-list.txt b/command-list.txt
index 2a94137bbb..a1fad28fd8 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -107,7 +107,6 @@ git-read-tree                           plumbingmanipulators
 git-rebase                              mainporcelain           history
 git-receive-pack                        synchelpers
 git-reflog                              ancillarymanipulators
-git-relink                              ancillarymanipulators
 git-remote                              ancillarymanipulators
 git-repack                              ancillarymanipulators
 git-replace                             ancillarymanipulators
diff --git a/git-relink.perl b/contrib/examples/git-relink.perl
similarity index 100%
rename from git-relink.perl
rename to contrib/examples/git-relink.perl
diff --git a/Documentation/git-relink.txt b/contrib/examples/git-relink.txt
similarity index 100%
rename from Documentation/git-relink.txt
rename to contrib/examples/git-relink.txt

base-commit: 4e59582ff70d299f5a88449891e78d15b4b3fabe
-- 
2.11.1.windows.prerelease.2.3.g7f3eb74
