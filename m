From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: file rename causes history to disappear
Date: Wed, 06 Sep 2006 19:11:48 +0200
Organization: At home
Message-ID: <edmvfv$lt7$2@sea.gmane.org>
References: <44FEE0BB.2060601@garzik.org> <Pine.LNX.4.64.0609060834520.27779@g5.osdl.org> <44FEED4B.30909@garzik.org> <Pine.LNX.4.64.0609060858050.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 06 19:13:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL0xK-0003vb-Hs
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 19:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbWIFRMw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 13:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbWIFRMw
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 13:12:52 -0400
Received: from main.gmane.org ([80.91.229.2]:58311 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751743AbWIFRMv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 13:12:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GL0wi-0003kx-Fg
	for git@vger.kernel.org; Wed, 06 Sep 2006 19:12:16 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 19:12:16 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 19:12:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26542>

Linus Torvalds wrote:

> There's a huge difference between "pathname" and "inode". And git operates 
> on _pathnames_, not on inodes. So when you give a pathname specifier, 
> that's _exactly_ what it is. It's a pathname specifier, _not_ an "inode" 
> specifier.
> 
> And pathnames don't change. They're just names for paths to possibly 
> _find_ a file/inode. They can't be "renamed". The data that is found 
> behind a pathname may be moved to _another_ pathname (and we call that a 
> rename), but that doesn't change the original pathname in any way, shape, 
> or form.

So if/when git would have --follow option to git-log and git-diff-*, it
would be rather --follow=<filename>, rather than --follow -- <paths>?

git-rev-list could then output hash with current set of <filenames>, which
were given <filename> at the beginning, i.e.
  <hash> -- <filename> [<filename>...]
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
