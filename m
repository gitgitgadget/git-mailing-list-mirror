From: Mike <ipso@snappymail.ca>
Subject: git svn import failure : write .git/Git_svn_hash_BmjclS: Bad file
 descriptor
Date: Fri, 16 Jan 2015 09:13:17 -0800
Message-ID: <54B946AD.5050701@snappymail.ca>
Reply-To: ipso@snappymail.ca
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 18:23:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCAc6-0001sC-LO
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 18:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbbAPRXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 12:23:09 -0500
Received: from mail.timetrex.com ([50.97.106.214]:34283 "EHLO
	mail.timetrex.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbbAPRXI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 12:23:08 -0500
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Jan 2015 12:23:08 EST
Received: from mail.office.timetrex.com (unknown [184.68.39.238])
	by mail.timetrex.com (Postfix) with ESMTP id D23CB20059
	for <git@vger.kernel.org>; Fri, 16 Jan 2015 09:13:36 -0800 (PST)
Received: by mail.office.timetrex.com (Postfix, from userid 108)
	id 83A168148C; Fri, 16 Jan 2015 09:13:36 -0800 (PST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	mail.office.timetrex.com
X-Spam-Level: 
X-Spam-Status: No, score=-111.9 required=4.5 tests=ALL_TRUSTED,BAYES_00,
	USER_IN_WHITELIST autolearn=disabled version=3.3.2
Received: from [10.7.5.9] (mikeb.office.timetrex.com [10.7.5.9])
	by mail.office.timetrex.com (Postfix) with ESMTPSA id C86CA812D0
	for <git@vger.kernel.org>; Fri, 16 Jan 2015 09:13:35 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262552>

Similar to the issue mintywalker originally mentioned on Jan 8th 2015, 
during a "git svn clone" I get a Bad File Descriptor error using:

git-svn version 2.2.2 (svn 1.8.8) on Ubuntu 14.04.

<snip>
r460 = 456377de3906d689c56e51af842e18abe086a980 (refs/remotes/origin/trunk)
         A       client/binary/App_Client_v2.1.2.exe
r461 = 36848dbb7f417da2e381b61b68ff7b0d22a5bf7f (refs/remotes/origin/trunk)
write .git/Git_svn_hash_0WWL4a: Bad file descriptor
  at /usr/lib/perl5/SVN/Ra.pm line 623.


$ svn diff --diff-cmd diff -c 461
Index: client/binary/App_Client_v2.1.2.exe
===================================================================
Cannot display: file marked as a binary type.
svn:mime-type = application/octet-stream
Index: client/binary/App_Client_v2.1.2.exe
===================================================================
--- client/binary/App_Client_v2.1.2.exe    (revision 0)
+++ client/binary/App_Client_v2.1.2.exe    (revision 461)

Property changes on: client/binary/App_Client_v2.1.2.exe
___________________________________________________________________
Added: svn:mime-type
## -0,0 +1 ##
+application/octet-stream
\ No newline at end of property


Not sure if it helps or not, but here is the commit immediately after 
that one:

$ svn diff --diff-cmd diff -c 462
Index: interface/help/App_Client.exe
===================================================================
--- interface/help/App_Client.exe  (revision 0)
+++ interface/help/App_Client.exe  (revision 462)
@@ -0,0 +1 @@
+link ../../client/binary/App_Client_v2.1.2.exe
\ No newline at end of file

Property changes on: interface/help/App_Client.exe
___________________________________________________________________
Added: svn:special
## -0,0 +1 ##
+*
\ No newline at end of property

Unfortunately the repository is private, but it seems like a pretty 
simple commit that is causing the problem?

If you need more information please let me know.

Thanks.


-- 
Mike
