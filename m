From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Use a *real* built-in diff generator
Date: Sun, 26 Mar 2006 12:09:35 +0100
Message-ID: <20060326110934.GA3774@linux-mips.org>
References: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org> <118833cc0603250544h289f385fo683ec7b40cdb0ed@mail.gmail.com> <Pine.LNX.4.64.0603250734130.15714@g5.osdl.org> <Pine.LNX.4.64.0603250742340.15714@g5.osdl.org> <Pine.LNX.4.64.0603251009500.11968@alien.or.mcafeemobile.com> <Pine.LNX.4.64.0603251030340.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Davide Libenzi <davidel@xmailserver.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 26 13:10:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNT8H-0000rg-1C
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 13:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWCZLJx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 06:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWCZLJx
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 06:09:53 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:44778 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1750720AbWCZLJx
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Mar 2006 06:09:53 -0500
Received: from localhost.localdomain ([127.0.0.1]:52448 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133444AbWCZK7f (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 11:59:35 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k2QB9leP005107;
	Sun, 26 Mar 2006 12:09:47 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k2QB9ZdR005105;
	Sun, 26 Mar 2006 12:09:35 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603251030340.15714@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18037>

On Sat, Mar 25, 2006 at 10:39:03AM -0800, Linus Torvalds wrote:

> Besides, I hate how GNU patch bends over backwards in applying crap that 
> isn't a proper patch at all (whitespace-corruption, you name it: GNU patch 
> will accept it). Also, I made "git-apply" be all-or-nothing: either it 
> applies the _whole_ patch (across many different files) or it applies none 
> of it. With GNU patch, if you get an error on the fifth file, the four 
> first files have been modified already - aarrgghhh..

Which is apply's greatest strength - and weakness.  GNU diff doesn't
understand the file renamings bits of git diffs, so they they need to be
used with apply.  So if a patch doesn't apply?  Apply doesn't even have
an option to apply things as good as it can and leave the rest in
reject files.  Yuck.

  Ralf
