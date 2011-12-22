From: Jehan Bing <jehan@orb.com>
Subject: "Nested quantifiers" error in gitweb with "++" in the filename
Date: Thu, 22 Dec 2011 12:37:52 -0800
Message-ID: <jd04eq$9m0$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 21:40:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdpR0-0006NA-3M
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 21:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755838Ab1LVUkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Dec 2011 15:40:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:42968 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755831Ab1LVUkH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2011 15:40:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RdpQs-0006Ic-Ml
	for git@vger.kernel.org; Thu, 22 Dec 2011 21:40:06 +0100
Received: from 173-167-111-189-sfba.hfc.comcastbusiness.net ([173.167.111.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Dec 2011 21:40:06 +0100
Received: from jehan by 173-167-111-189-sfba.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Dec 2011 21:40:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 173-167-111-189-sfba.hfc.comcastbusiness.net
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187615>

Hi,

I'm getting an error when trying to look at a blob when the filename has 
"++" in it:

http://.../blob/13ec1624fefc23d20d0407aac3337b35844a2ceb:/foo-++.txt

And I get the following error page:
	gitprojects /


	500 - Internal Server Error
	Nested quantifiers in regex; marked by <-- HERE in 
m//test.git/blob/13ec1624fefc23d20d0407aac3337b35844a2ceb:/foo-++ <-- 
HERE .txt$/ at (eval 10) line 7.
	OPML TXT


The Apache log show the same thing:
  gitweb.cgi: Nested quantifiers in regex; marked by <-- HERE in 
m//test.git/blob/13ec1624fefc23d20d0407aac3337b35844a2ceb:/foo-++ <-- 
HERE .txt$/ at (eval 10) line 7.


It works fine if the filename has a single '+' sign (tried "foo-+.txt").
There is a same error when browsing a tree and clicking a directory with 
the "++"

We notice the error when looking at the Qt source code. They have a 
bunch of "*g++*" files and directories.

We use git-1.7.6 but updating to gitweb.cgi from 1.7.8.1 didn't fix it.


Regards,
	Jehan
