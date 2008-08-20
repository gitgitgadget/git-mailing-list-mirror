From: Johan Herland <johan@herland.net>
Subject: [PATCH v2] Teach "git diff" HTML funcname patterns
Date: Wed, 20 Aug 2008 19:49:15 +0200
Message-ID: <200808201949.15450.johan@herland.net>
References: <200808201927.47099.johan@herland.net> <20080820172940.GA26411@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Mike Hommey <mh@glandium.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 19:51:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVrpe-0000yY-VG
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 19:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbYHTRtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 13:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbYHTRtv
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 13:49:51 -0400
Received: from sam.opera.com ([213.236.208.81]:53277 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880AbYHTRtu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 13:49:50 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m7KHnFb8007347
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 20 Aug 2008 17:49:20 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <20080820172940.GA26411@glandium.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93001>

Finds lines with <h1>..<h6> tags. The pattern is adapted from the ruby one.

Signed-off-by: Johan Herland <johan@herland.net>
---

On Wednesday 20 August 2008, Mike Hommey wrote:
> On Wed, Aug 20, 2008 at 07:27:46PM +0200, Johan Herland wrote:
> > Finds lines with <h1>..<h6> tags. The pattern is adapted from the
> > ruby one.
> Don't you want to catch <H1>...<H6> too ?

Yes. Thanks.


Have fun!

...Johan


 Documentation/gitattributes.txt |    2 ++
 diff.c                          |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index db16b0c..8bb05e6 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -320,6 +320,8 @@ patterns are available:
 
 - `tex` suitable for source code for LaTeX documents.
 
+- `html` suitable for HTML/XHTML documents.
+
 
 Performing a three-way merge
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/diff.c b/diff.c
index a6c1432..9d4b961 100644
--- a/diff.c
+++ b/diff.c
@@ -1382,6 +1382,7 @@ static struct builtin_funcname_pattern {
 	{ "bibtex", "\\(@[a-zA-Z]\\{1,\\}[ \t]*{\\{0,1\\}[ \t]*[^ \t\"@',\\#}{~%]*\\).*$" },
 	{ "tex", "^\\(\\\\\\(\\(sub\\)*section\\|chapter\\|part\\)\\*\\{0,1\\}{.*\\)$" },
 	{ "ruby", "^\\s*\\(\\(class\\|module\\|def\\)\\s.*\\)$" },
+	{ "html", "^\\s*\\(<[Hh][1-6]\\s.*>.*\\)$" },
 };
 
 static const char *diff_funcname_pattern(struct diff_filespec *one)
-- 
1.6.0.96.g2fad1
