Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419C7C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 22:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D5C206DB
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 22:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfLFWUr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 17:20:47 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:58977 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfLFWUr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 17:20:47 -0500
X-Originating-IP: 157.36.241.251
Received: from localhost (unknown [157.36.241.251])
        (Authenticated sender: me@yadavpratyush.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 46A94240006
        for <git@vger.kernel.org>; Fri,  6 Dec 2019 22:20:44 +0000 (UTC)
Date:   Sat, 7 Dec 2019 03:50:40 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     git@vger.kernel.org
Subject: [PATCH] git-gui: allow closing console window with Escape
Message-ID: <20191206222040.toj4enbbbbamnrww@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is often expected that popup windows like the console window be
close-able with Esc.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
This was requested by https://github.com/prati0100/git-gui/issues/17

 lib/console.tcl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/console.tcl b/lib/console.tcl
index 1f3248f..8828f6f 100644
--- a/lib/console.tcl
+++ b/lib/console.tcl
@@ -88,6 +88,7 @@ method _init {} {
 	bind_button3 $w_t "tk_popup $w.ctxm %X %Y"
 	bind $w_t <$M1B-Key-a> "$w_t tag add sel 0.0 end;break"
 	bind $w_t <$M1B-Key-A> "$w_t tag add sel 0.0 end;break"
+	bind $w <Key-Escape> [list destroy $w]
 }

 method exec {cmd {after {}}} {
--
2.24.0

