From: Rafael Kitover <rkitover@io.com>
Subject: ignoring file modes completely
Date: Sat, 05 Feb 2011 10:24:50 -0500
Organization: CPAN
Message-ID: <4D4D6BC2.90101@io.com>
Reply-To: rkitover@io.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 05 16:57:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlkVg-00083q-IG
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 16:57:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055Ab1BEP5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 10:57:06 -0500
Received: from smtp.prismnet.com ([209.198.128.91]:53813 "EHLO
	smtp.prismnet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907Ab1BEP5E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 10:57:04 -0500
X-Greylist: delayed 1909 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Feb 2011 10:57:04 EST
Received: from [127.0.0.1] (c-76-98-235-160.hsd1.pa.comcast.net [76.98.235.160])
	(authenticated bits=0)
	by smtp.prismnet.com (8.14.4/8.14.4) with ESMTP id p15FPCaa004548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sat, 5 Feb 2011 09:25:13 -0600 (CST)
	(envelope-from rkitover@io.com)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
X-Spam-Status: No, score=0.0 required=10.0 tests=RDNS_DYNAMIC
	autolearn=disabled version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on smtp.prismnet.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166098>

Hello,

I found the core.filemode option, which ignores executable bits, but I 
need an option to ignore all mode differences, and such an option does 
not seem to exist.

The reason for this is that I'm trying to use msysGit with Cygwin git, 
sometimes to work with an msysGit clone in cygwin or to work with a 
Cygwin git clone in msysGit. For example, I would like to use "git 
cpan-init" under Cygwin, then use msysGit to work with the repository, 
this is currently impossible.

Here is "git status" on a repo made with Cygwin git under msysGit:

$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working 
directory)
#
#       modified:   Makefile.PL
#       modified:   t/02ads.t
#       modified:   t/02cxn.t
#       modified:   t/04os.t
...
...

Every file is modified because the modes do not match :(

Would it be possible to add some sort of option to ignore all file mode 
changes?
