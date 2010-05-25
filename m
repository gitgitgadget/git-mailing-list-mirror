From: Gabriel Burca <gburca-gmane@ebixio.com>
Subject: Re: Error when cloning gc'ed repository
Date: Tue, 25 May 2010 21:15:49 +0000 (UTC)
Message-ID: <loom.20100525T230522-721@post.gmane.org>
References: <hj6ms0$vcg$1@ger.gmane.org> <hj9tr4$5vi$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 04:55:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH6m4-0007UR-5K
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 04:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759181Ab0EZCzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 22:55:10 -0400
Received: from lo.gmane.org ([80.91.229.12]:48294 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758814Ab0EZCzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 22:55:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OH6ls-0007RB-EU
	for git@vger.kernel.org; Wed, 26 May 2010 04:55:04 +0200
Received: from il27-ig12.motorola.com ([il27-ig12.motorola.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 May 2010 04:55:04 +0200
Received: from gburca-gmane by il27-ig12.motorola.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 May 2010 04:55:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 136.182.2.26 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3 (.NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147731>

Andre Loker <loker <at> gmx.de> writes:

> 
> Andre Loker wrote:
> > Hi,
> > 
> > $ git clone git <at> theserver:the/repository.git
> > Initialized empty Git repository in /e/Temp/dr/.git/
> > remote: Counting objects: 1396, done.
> > remote: Compressing objects: 100% (654/654), done.
> > fatal: The remote end hung up unexpectedly
> > fatal: early EOFs:  47% (657/1396)
> > fatal: index-pack failed
> 
> To answer the question myself: it seems that it is a problem with 
> openssh under cygwin 1.7.1. I found a similar problem here:
> 
> http://www.mail-archive.com/cygwin <at> cygwin.com/msg103749.html
> 
> The proposed workaround is to use plink instead of openssh. I tried it 
> and so far it seems to work. It's not as nice as openssh, but at least 
> it's a workaround until the issue is solved.


I downgraded just the openssh package in cygwin from 5.5p1-1 to 5.4p1-1 and the
problem went away. This was easier than switching to putty/plink.

Before the downgrade my rate of failure was 100%. I was doing a "git remote
update origin", not a clone, but the symptoms were the same as Andre's.

-- 
Gabriel Burca
