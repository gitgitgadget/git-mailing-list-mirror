From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH RFC GSoC] gitweb: Use -M option while using format-patch
Date: Mon, 10 May 2010 21:38:45 +0530
Message-ID: <4BE82F8D.8060205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 18:09:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBVXc-00009s-Ag
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 18:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981Ab0EJQJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 12:09:06 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54935 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab0EJQJE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 12:09:04 -0400
Received: by pvb32 with SMTP id 32so48457pvb.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 09:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=NHkzV/sp8WWT1xCJpiBqSDPUQJHJHKKXAKR2ZbW6LuA=;
        b=VvDjM9ADO9sVx2rHCXqNNNdDyrryu9gm2mOIEEBVh3182H5UjpshjYw7pEyGeOfpOM
         HeCXsq5i9R87lh8Vz/Z6l0kHVhOEbs0BtRG5cb+1fnZmZI02UYYDDEBDOyxyWWTdB6Fi
         zKkSdQZy3mBDBe2j3/WT8mYmRnxWZjnYhquwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=JVBZ3LggQfaFcU0nXqktZb/d6AZZ1vo1G7ypBl1jdtREi+iES3UVl60iYCHllckOen
         DOzh4XBRORB4apGLo+/UyLGTW8mNfIWCnzqVbkVK/W/E3kbVVv/7ErxbCbUuGldgyWLl
         fqv12Zn2XisiBEeSJPbDOGCiL5SSDs+bV3GC0=
Received: by 10.114.87.17 with SMTP id k17mr3296179wab.215.1273507731013;
        Mon, 10 May 2010 09:08:51 -0700 (PDT)
Received: from [172.16.19.166] ([202.63.112.23])
        by mx.google.com with ESMTPS id v13sm27004247wav.14.2010.05.10.09.08.48
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 09:08:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146822>

Add option '-M' to use with format-patch whcih detects
renames in the commit.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---

  gitweb/gitweb.perl |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c356e95..0184de5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6117,7 +6117,7 @@ sub git_commitdiff {
                         }
                         push @commit_spec, '--root', $hash;
                 }
-               open $fd, "-|", git_cmd(), "format-patch", 
'--encoding=utf8',
+               open $fd, "-|", git_cmd(), "format-patch", '-M', 
'--encoding=utf8',
                         '--stdout', @commit_spec
                         or die_error(500, "Open git-format-patch failed");
         } else {
-- 
1.7.0.4
