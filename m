From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] send-email: do not load Data::Dumper
Date: Wed, 6 Apr 2016 20:25:38 +0000
Message-ID: <20160406202538.GA27651@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 22:25:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anu1K-0003nb-TM
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 22:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbcDFUZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 16:25:39 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42201 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776AbcDFUZi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 16:25:38 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF5522044E;
	Wed,  6 Apr 2016 20:25:37 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290867>

We never used Data::Dumper in this script.  The only reference
of it was always commented out and removed over a decade ago in
commit 4bc87a28be020a6bf7387161c65ea3d8e4a0228b
("send-email: Change from Mail::Sendmail to Net::SMTP")

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 While I'm in the area...

 git-send-email.perl | 1 -
 1 file changed, 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 52cf828..38f0a7e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -23,7 +23,6 @@ use POSIX qw/strftime/;
 use Term::ReadLine;
 use Getopt::Long;
 use Text::ParseWords;
-use Data::Dumper;
 use Term::ANSIColor;
 use File::Temp qw/ tempdir tempfile /;
 use File::Spec::Functions qw(catfile);
-- 
EW
