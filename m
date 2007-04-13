From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: cvsserver and wincvs (cvsgui)
Date: Fri, 13 Apr 2007 02:11:07 +0200
Organization: At home
Message-ID: <evmhk0$p0l$1@sea.gmane.org>
References: <Pine.LNX.4.64.0704121821150.27922@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 02:08:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc9Kx-0001gs-Cg
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 02:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbXDMAIT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 20:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753930AbXDMAIT
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 20:08:19 -0400
Received: from main.gmane.org ([80.91.229.2]:48673 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753925AbXDMAIS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 20:08:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hc9Kd-0003zX-CJ
	for git@vger.kernel.org; Fri, 13 Apr 2007 02:08:03 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Apr 2007 02:08:03 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Apr 2007 02:08:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44371>

[Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org]

Daniel Barkalow wrote:

> I'm having problems using git-cvsserver to support a wincvs user. It seems 
> to be truncating binary files in both directions (e.g., we have a PNG that 
> starts, in hex, 89 50 4e 47 0d 0a ..., and it gets truncated between the 
> 0d and 0a), and it seems to fail up-to-date checks when checking in files 
> that are, in fact, up-to-date (and, so far as I can see, haven't been 
> modified anywhere else).

Which version of git do you use?


In git-cvsserner(1) (but not in git-config(1)) we have:

  The server should set the '-k' mode to binary when relevant, however,
  this is not really implemented yet. For now, you can force the server
  to set '-kb' for all files by setting the `gitcvs.allbinary` config
  variable. In proper GIT tradition, the contents of the files are
  always respected. No keyword expansion or newline munging is supported.

Do you have gitcvs.allbinary set?


By the way, gitweb used to have the same problem. It was fixed by using
:raw mode for outputting binary files, instead of set by default :utf8
(see commit f5aa79d909f8c4838bf5).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
