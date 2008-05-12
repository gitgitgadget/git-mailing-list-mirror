From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git-svn blame change- doc confusion
Date: Sun, 11 May 2008 23:33:29 -0700
Message-ID: <906678E9-D203-484B-8416-1C6079C74B2D@midwinter.com>
References: <449c10960805112105w2e362ea7l9b11c53c47952501@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 08:34:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvRc5-0005R1-GH
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 08:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547AbYELGdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 02:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754528AbYELGdb
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 02:33:31 -0400
Received: from tater.midwinter.com ([216.32.86.90]:46293 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753949AbYELGda (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 02:33:30 -0400
Received: (qmail 2550 invoked from network); 12 May 2008 06:33:30 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=qlstsqLx0eZZzXOrVwTjg5+u7VkYw8UyQ6tXquKL/N4VXaaqdYpdHVl48o/CZkYK  ;
Received: from localhost (HELO ?IPv6:::1?) (127.0.0.1)
  by localhost with SMTP; 12 May 2008 06:33:30 -0000
In-Reply-To: <449c10960805112105w2e362ea7l9b11c53c47952501@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81835>

On May 11, 2008, at 9:05 PM, Dan McGee wrote:
> Here is the commit snippet. Reading the commit message, I would assume
> the default format with no options is SVN, and you need to use the
> --git-format arg to get the GIT format.

Yes, that's right. But note that "git format" does not mean "identical  
to the output of git blame" -- it means "lines are formatted the same  
way they are in git blame," meaning the revision ID (which in this  
case is an svn version number or 0 for any lines for which there isn't  
history in svn) then the committer name and commit timestamp enclosed  
in parentheses, then the line number with a trailing closing paren,  
then the contents of the line.

The svn format, by contrast, is the svn commit number, then the  
committer name, then the contents of the line.

> However, reading the --git-format description tells me something real
> weird- that using --git-format will give me SVN revision numbers and
> not git hashes, and something about revision 0?

Yes, that's also right. If you want git hashes, just run "git blame",  
which will work exactly the same as in a non-svn-linked git repository  
-- the whole point of having "git svn blame" is to view changes in  
terms of svn revisions rather than git hashes.

-Steve
