From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH 1/1] pretty: note that %cd respects the --date= option
Date: Wed, 20 Aug 2014 14:27:10 +0200
Message-ID: <53F4941E.2060201@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 14:29:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XK50b-0008Ho-F8
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 14:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbaHTM1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 08:27:17 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:44644 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752315AbaHTM1P (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Aug 2014 08:27:15 -0400
Received: from p5ddc26b6.dip0.t-ipconnect.de ([93.220.38.182] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1XK4yv-0001Rv-3P; Wed, 20 Aug 2014 14:27:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1408537635;656442f1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255569>

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
---

Today I found out that both %cd and %ad pretty print format
specifications honour the --date option as shown in:

$ git log --abbrev=8 --date=short --pretty="%h (%s, %cd)" -n1
5bdb1c4e (Merge pull request #245 from
kblees/kb/master/fix-libsvn-address-conflict, 2014-08-16)
$ git log --abbrev=8 --date=short --pretty="%h (%s, %ad)" -n1
5bdb1c4e (Merge pull request #245 from
kblees/kb/master/fix-libsvn-address-conflict, 2014-08-16)

But the documentation did not mention that.

 Documentation/pretty-formats.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt
b/Documentation/pretty-formats.txt
index 85d6353..eac7909 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -122,7 +122,7 @@ The placeholders are:
 - '%ce': committer email
 - '%cE': committer email (respecting .mailmap, see
   linkgit:git-shortlog[1] or linkgit:git-blame[1])
-- '%cd': committer date
+- '%cd': committer date (format respects --date= option)
 - '%cD': committer date, RFC2822 style
 - '%cr': committer date, relative
 - '%ct': committer date, UNIX timestamp
-- 
2.1.0.msysgit.0
