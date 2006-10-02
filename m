From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: Escape ESCAPE (\e) character
Date: Mon, 2 Oct 2006 14:54:53 -0700 (PDT)
Message-ID: <20061002215453.45092.qmail@web31814.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1836624930-1159826093=:44740"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Oct 02 23:55:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUVkb-0002uf-Gp
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 23:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965439AbWJBVyz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 17:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965441AbWJBVyz
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 17:54:55 -0400
Received: from web31814.mail.mud.yahoo.com ([68.142.206.167]:23904 "HELO
	web31814.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965439AbWJBVyy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Oct 2006 17:54:54 -0400
Received: (qmail 45094 invoked by uid 60001); 2 Oct 2006 21:54:53 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=NoCX/ccaURjOgOUHDiPq992aNRj3ClKA6XHNqvUGaK1T0q2q7YhHT57sbsYkjskvnllCv0zJ8KnXi0fwBI1mQAsSb2hHZO4BPRgNFr17KvX9H7cFIwdTvuMFafOTf53LSXpcxCN4wmRHKMQL2Dnz/RlE3L2WlT4O1bzI9p58ZXE=  ;
Received: from [64.215.88.90] by web31814.mail.mud.yahoo.com via HTTP; Mon, 02 Oct 2006 14:54:53 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28238>

--0-1836624930-1159826093=:44740
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Take a look at commit 20a3847d8a5032ce41f90dcc68abfb36e6fee9b1
using gitweb before this patch.  This patch fixes this.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

--0-1836624930-1159826093=:44740
Content-Type: text/plain; name="pe.txt"
Content-Description: 497324604-pe.txt
Content-Disposition: inline; filename="pe.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 10e803a..a9e95c9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -485,6 +485,7 @@ sub esc_html {
 	$str = decode("utf8", $str, Encode::FB_DEFAULT);
 	$str = escapeHTML($str);
 	$str =~ s/\014/^L/g; # escape FORM FEED (FF) character (e.g. in COPYING file)
+	$str =~ s/\033/^[/g; # "escape" ESCAPE (\e) character (e.g. commit 20a3847d8a5032ce41f90dcc68abfb36e6fee9b1)
 	return $str;
 }
 
-- 
1.4.2.3.gc269

--0-1836624930-1159826093=:44740--
