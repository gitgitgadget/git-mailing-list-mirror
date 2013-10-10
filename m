From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: fix signed commit parsing
Date: Thu, 10 Oct 2013 06:57:55 +0000
Message-ID: <20131010065755.GA2413@dcvr.yhbt.net>
References: <1380552374-26103-1-git-send-email-boklm@mars-attacks.org>
 <20130930190404.GU9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Vigier <boklm@mars-attacks.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 10 08:58:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUAC8-0003KO-KU
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 08:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289Ab3JJG54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 02:57:56 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37044 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751647Ab3JJG54 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 02:57:56 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7F8C1F728;
	Thu, 10 Oct 2013 06:57:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20130930190404.GU9464@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235852>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Nicolas Vigier wrote:
> 
> > When parsing a commit object, git-svn wrongly think that a line
> > containing spaces means the end of headers and the start of the commit
> > message. In case of signed commit, the gpgsig entry contains a line with
> > one space, so "git svn dcommit" will include part of the signature in
> > the commit message.
> >
> > An example of such problem :
> > http://svnweb.mageia.org/treasurer?view=revision&revision=86
> >
> > This commit changes the regex to only match an empty line as separator
> > between the headers and the commit message.
> >
> > Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
> 
> Good catch.  For what it's worth,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks both.  I've signed-off, added Jonathan's reviewed-by and
queued this up in my master.  Currently at:

The following changes since commit 128a96c98442524c7f2eeef4757b1e48445f24ce:

  Update draft release notes to 1.8.5 for the fifth batch of topics (2013-09-20 12:42:02 -0700)

are available in the git repository at:

  git://git.bogomips.org/git-svn.git master

for you to fetch changes up to 945b9c14ffd3e11c916ee2b2428a0b2be9645829:

  git-svn.txt: elaborate on rev_map files (2013-10-10 06:56:12 +0000)

----------------------------------------------------------------
Keshav Kini (4):
      git-svn.txt: fix AsciiDoc formatting error
      git-svn.txt: reword description of gc command
      git-svn.txt: replace .git with $GIT_DIR
      git-svn.txt: elaborate on rev_map files

Nicolas Vigier (1):
      git-svn: fix signed commit parsing

 Documentation/git-svn.txt | 46 +++++++++++++++++++++++++++++++++-------------
 git-svn.perl              |  2 +-
 2 files changed, 34 insertions(+), 14 deletions(-)
-- 
Eric Wong
