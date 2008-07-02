From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH/rfc] gitweb: open files (e.g. indextext.html) in utf8 mode
Date: Wed, 2 Jul 2008 12:13:17 +0000
Message-ID: <20080702121317.10819.qmail@bca5b84cb0e0a0.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 14:14:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE1Dg-000300-0D
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 14:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754453AbYGBMMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 08:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754836AbYGBMMq
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 08:12:46 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:44187 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754453AbYGBMMp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 08:12:45 -0400
Received: (qmail 10820 invoked by uid 1000); 2 Jul 2008 12:13:17 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87129>

From: =?utf-8?q?Recai=20Okta=C5=9F?= <roktas@debian.org>

gitweb used to use utf8 only in stdout.  As a result, included files
like indextext.html appeared garbled if they contain utf8 characters.
Now utf8 is also used when reading files.

The patch was submitted through
 http://bugs.debian.org/487465

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 90cd99b..96cb4e0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -16,7 +16,7 @@ use Encode;
 use Fcntl ':mode';
 use File::Find qw();
 use File::Basename qw(basename);
-binmode STDOUT, ':utf8';
+use open qw(:std :utf8);
 
 BEGIN {
 	CGI->compile() if $ENV{'MOD_PERL'};
-- 
1.5.6
