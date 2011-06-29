From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] Documentation/i18n: quote double-dash for AsciiDoc
Date: Wed, 29 Jun 2011 00:36:48 -0500
Message-ID: <20110629053648.GD28690@elie>
References: <20110628171748.GA11485@elie>
 <20110629053133.GB28690@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 07:37:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbnSN-0000mL-MT
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 07:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501Ab1F2Fgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 01:36:55 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49486 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310Ab1F2Fgy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 01:36:54 -0400
Received: by iwn6 with SMTP id 6so749820iwn.19
        for <git@vger.kernel.org>; Tue, 28 Jun 2011 22:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FlWk9KDV77ZbAnR3Ez9p5+hoRSW6Fl4/rEajpc8l93E=;
        b=wNPpDHRvVFqKc+3W/7sE9IqG67v3kXvWYRFRcN2cG9JawWMBqe1aBoK+LOQ4UThZAh
         PaDVfQzXAuGs5Y3XXySNFEl4uBKameMSEvrsWIN6iqcCU2G0y3uGasUZHp0Nyj2dOrQ/
         fpwfc7nySgIU7+DYkcCbxHOdLKfmY+y9HtB9U=
Received: by 10.42.157.201 with SMTP id e9mr385661icx.141.1309325813377;
        Tue, 28 Jun 2011 22:36:53 -0700 (PDT)
Received: from elie (adsl-69-209-66-254.dsl.chcgil.sbcglobal.net [69.209.66.254])
        by mx.google.com with ESMTPS id s2sm445660ibe.52.2011.06.28.22.36.51
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Jun 2011 22:36:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110629053133.GB28690@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176436>

As explained in v1.7.3-rc0~13^2 (Work around em-dash handling in newer
AsciiDoc, 2010-08-23), if double dashes in names of commands are not
escaped, AsciiDoc renders them as em dashes.

While fixing that, spell the command name as "git sh-i18n--envsubst"
(2 words) instead of emphasizing the name of the binary (one
hyphenated name) and format it in italics.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.

 Documentation/git-sh-i18n--envsubst.txt |    6 +++---
 Documentation/git-sh-i18n.txt           |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-sh-i18n--envsubst.txt b/Documentation/git-sh-i18n--envsubst.txt
index 61e4c08d..6e3a9539 100644
--- a/Documentation/git-sh-i18n--envsubst.txt
+++ b/Documentation/git-sh-i18n--envsubst.txt
@@ -10,8 +10,8 @@ SYNOPSIS
 [verse]
 eval_gettext () {
 	printf "%s" "$1" | (
-		export PATH $('git sh-i18n--envsubst' --variables "$1");
-		'git sh-i18n--envsubst' "$1"
+		export PATH $('git sh-i18n{litdd}envsubst' --variables "$1");
+		'git sh-i18n{litdd}envsubst' "$1"
 	)
 }
 
@@ -22,7 +22,7 @@ This is not a command the end user would want to run.  Ever.
 This documentation is meant for people who are studying the
 plumbing scripts and/or are writing new ones.
 
-git-sh-i18n--envsubst is Git's stripped-down copy of the GNU
+'git sh-i18n{litdd}envsubst' is Git's stripped-down copy of the GNU
 `envsubst(1)` program that comes with the GNU gettext package. It's
 used internally by linkgit:git-sh-i18n[1] to interpolate the variables
 passed to the the `eval_gettext` function.
diff --git a/Documentation/git-sh-i18n.txt b/Documentation/git-sh-i18n.txt
index 3b1f7ac7..eca69e3d 100644
--- a/Documentation/git-sh-i18n.txt
+++ b/Documentation/git-sh-i18n.txt
@@ -34,7 +34,7 @@ gettext::
 eval_gettext::
 	Currently a dummy fall-through function implemented as a wrapper
 	around `printf(1)` with variables expanded by the
-	linkgit:git-sh-i18n--envsubst[1] helper. Will be replaced by a
+	linkgit:git-sh-i18n{litdd}envsubst[1] helper. Will be replaced by a
 	real gettext implementation in a later version.
 
 GIT
-- 
1.7.6
