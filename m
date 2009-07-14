From: Nicolas Sebrecht <ni.s@laposte.net>
Subject: [PATCH] git-am: less strong format "mbox" detection
Date: Tue, 14 Jul 2009 08:40:47 +0200
Message-ID: <bb3a84e2b817268a88832dc7043383e4b91a3df3.1247553623.git.ni.s@laposte.net>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Nicolas Sebrecht <ni.s@laposte.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 14 08:41:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQbhJ-0003fp-Gp
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 08:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826AbZGNGk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 02:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753825AbZGNGk6
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 02:40:58 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:34311 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733AbZGNGk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 02:40:58 -0400
Received: by ewy26 with SMTP id 26so3051638ewy.37
        for <git@vger.kernel.org>; Mon, 13 Jul 2009 23:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=6EH4ytAY/ZcNu9a1h5+01S2fzVzgIvu0VFHHAbMeCfs=;
        b=W00ncU8mE5evuIkKHgXX5oR6/PMOp/inPJ7SoHs+Qc5E/tWGG0xudVRG3ixbPtRLkv
         UuRtVhCjBxzUDCa5l0qM4ob9hxupfoDTTE2mTh+A7pJNKSF7QTNDE86VMJSsNJvu6hAT
         dfGQSuFpIzQJxVEOLLc0RKIvsAp7Kx5eL0Z5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=lMKTy2QM7wwIR/qXGX1WjYg7fJPrkq0x4L/R2PXEyw2xMXM33rHbpK8lLBKNoyD0xt
         MqdahOVlVhPa7l+AuvmYJLWc56IXLuJujaXFlT4GQrdRxMpQY4foLTjHxBgPghUyzOas
         n6o6t46E5eX7AvA72sgbhWDNjd0Fz2De9gWUg=
Received: by 10.210.125.7 with SMTP id x7mr6101266ebc.96.1247553656711;
        Mon, 13 Jul 2009 23:40:56 -0700 (PDT)
Received: from localhost (91-165-132-96.rev.libertysurf.net [91.165.132.96])
        by mx.google.com with ESMTPS id 28sm981635eyg.12.2009.07.13.23.40.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Jul 2009 23:40:56 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.rc0.121.g2937a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123222>

Thunderbird (v1.* at least) likes to start e-mails with "X-Account-Key:".
Also, I have some emails starting with "Return-Path:" or ""Delivered-To:".

Signed-off-by: Nicolas Sebrecht <ni.s@laposte.net>
---
 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index d64d997..d10a8e0 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -169,7 +169,7 @@ check_patch_format () {
 		read l2
 		read l3
 		case "$l1" in
-		"From "* | "From: "*)
+		"From "* | "From: "* | "X-Account-Key:"* | "Return-Path:"* | "Delivered-To:"*)
 			patch_format=mbox
 			;;
 		'# This series applies on GIT commit'*)
-- 
1.6.4.rc0.121.g2937a.dirty
