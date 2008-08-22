From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: [BUG?] ls-files -d does not show files removed using 'git rm'
Date: Fri, 22 Aug 2008 18:49:49 +0200
Message-ID: <g8mqnf$ncv$1@ger.gmane.org>
References: <48AEE261.8070906@forwardbias.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 18:51:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWZrH-0008VO-FA
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 18:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbYHVQuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 12:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbYHVQuG
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 12:50:06 -0400
Received: from main.gmane.org ([80.91.229.2]:40712 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689AbYHVQuF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 12:50:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KWZpn-0006Fd-9Y
	for git@vger.kernel.org; Fri, 22 Aug 2008 16:49:59 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 16:49:59 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 16:49:59 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <48AEE261.8070906@forwardbias.in>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93325>

Girish Ramakrishnan venit, vidit, dixit 22.08.2008 17:59:
> If I remove a file using the shell rm, it is listed by ls-files -d.
> However, it is not listed if I use 'git rm'.
> 
> $ rm foo
> $ git ls-files -t -d
> R foo
> $ git checkout foo
> $ git rm foo
> rm 'foo'
> $ git ls-files -t -d
> $
> 
> Is this a bug? In any case, is there a way to find out what files have
> been removed using git rm using ls-files (git status does show it)?

git ls-files combines the listing from the index with the listing from
the workdir. A git rm'ed file is present in neither.

git diff --cached --name-only --diff-filter=D

would show all files which are staged for deletion (git rm'ed).

Michael
