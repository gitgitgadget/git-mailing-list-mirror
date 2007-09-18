From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: git-svn error when cloning apache repo
Date: Tue, 18 Sep 2007 08:53:52 -0400
Message-ID: <20070918125352.GA19524@falcon.digizenstudio.com>
References: <20070915230833.GA8525@falcon.digizenstudio.com> <46ED17A9.2010603@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 14:54:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXcae-0006DH-CM
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 14:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbXIRMyC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 08:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbXIRMyB
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 08:54:01 -0400
Received: from k2smtpout03-01.prod.mesa1.secureserver.net ([64.202.189.171]:34096
	"HELO k2smtpout03-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751538AbXIRMyA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 08:54:00 -0400
Received: (qmail 20768 invoked from network); 18 Sep 2007 12:53:59 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout03-01.prod.mesa1.secureserver.net (64.202.189.171) with ESMTP; 18 Sep 2007 12:53:59 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 7CF3D100A1A;
	Tue, 18 Sep 2007 12:53:59 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KTSxbON7VOxO; Tue, 18 Sep 2007 08:53:53 -0400 (EDT)
Received: from falcon (ip70-187-196-88.dc.dc.cox.net [70.187.196.88])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id AFA86100A0E;
	Tue, 18 Sep 2007 08:53:53 -0400 (EDT)
Received: by falcon (Postfix, from userid 1000)
	id CB0327B520; Tue, 18 Sep 2007 08:53:52 -0400 (EDT)
Mail-Followup-To: Sam Vilain <sam@vilain.net>, git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46ED17A9.2010603@vilain.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58599>

On Sun, Sep 16, 2007 at 11:46:49PM +1200, Sam Vilain wrote:
> Jing Xue wrote:
> > $ git svn clone https://svn.apache.org/repos/asf/incubator/ivy/core/ ivy-core -T trunk -b branches -t tags
> > Initialized empty Git repository in .git/
> > Using higher level of URL: https://svn.apache.org/repos/asf/incubator/ivy/core => https://svn.apache.org/repos/asf
> >   
> 
> I'm fairly sure this is where it went wrong. Try editing .git/config and
> putting your original URL in the source URL, and re-try the fetch.

Hmm... thanks, but didn't work. The repo didn't look right to begin
with. The HEAD pointed to refs/heads/master as usual, but there was
nothing in refs/heads at all.

I also tried:
git svn clone https://svn.apache.org/repos/asf/ ivy-core -s --prefix=incubator/ivy/core/

And got no errors, but there wasn't any working tree in ivy-core
afterwards. Then I tried 'git svn rebase':

fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
fatal: Needed a single revision
invalid upstream

Due to the same "nothing in refs/heads" situation. Also there is this
23M file .git/svn/incubator/ivy/core/trunk/.rev_db.13f79535-47bb-0310-9956-ffa450edef6
that contains all 0's.

The part before "I also tried..." was with git 1.5.3.  "I also tried..."
was with git 1.5.3.1.112.gb7a2 as of last night.

Cheers.
-- 
Jing Xue
