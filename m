From: Sverre Hvammen Johansen <hvammen@gmail.com>
Subject: Re: how to backup git
Date: Mon, 12 May 2008 06:40:53 +0000 (UTC)
Message-ID: <loom.20080512T062707-662@post.gmane.org>
References: <4827DEF6.1050005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 08:41:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvRjP-0007FO-UI
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 08:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597AbYELGlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 02:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754581AbYELGlF
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 02:41:05 -0400
Received: from main.gmane.org ([80.91.229.2]:50755 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751581AbYELGlE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 02:41:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JvRiW-0007Ce-3S
	for git@vger.kernel.org; Mon, 12 May 2008 06:41:00 +0000
Received: from c66-235-35-214.sea2.cablespeed.com ([66.235.35.214])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 May 2008 06:41:00 +0000
Received: from hvammen by c66-235-35-214.sea2.cablespeed.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 May 2008 06:41:00 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.235.35.214 (Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8.1.14) Gecko/20080404 Firefox/2.0.0.14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81836>

bill lam <cbill.lam <at> gmail.com> writes:

> Hello, this should be a simple question. How to backup a git repository but 
> excluding files that not under versioned?  If I cp or tar or rsync the 
> directory. All non-versioned files are added.

A repository can be backed up by backing up the .git directory.

If you want to back up the HEAD commit, use git-archive as follows:

  $ git archive --prefix=my-backup/ HEAD | gzip >my-backup.tar.gz

If you want to back up the working directory, commit it to a temporary branch
before you use 'git archive'.

-- 
Sverre Hvammen Johansen
