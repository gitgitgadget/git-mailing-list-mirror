From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Possible regression in git-rev-list --header
Date: Sat, 30 Dec 2006 19:30:48 +0100
Organization: At home
Message-ID: <en6b34$8ni$1@sea.gmane.org>
References: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Dec 30 19:28:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0iwL-0002QC-8d
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 19:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbWL3S2K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 13:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965225AbWL3S2K
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 13:28:10 -0500
Received: from main.gmane.org ([80.91.229.2]:55375 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965116AbWL3S2I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 13:28:08 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H0iw0-0007fV-JC
	for git@vger.kernel.org; Sat, 30 Dec 2006 19:27:56 +0100
Received: from host-81-190-24-56.torun.mm.pl ([81.190.24.56])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Dec 2006 19:27:56 +0100
Received: from jnareb by host-81-190-24-56.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Dec 2006 19:27:56 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-56.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35622>

Marco Costalba wrote:

> When 'commitencoding' variable is set in config file then git-rev-list
> called with --header option sends also the encoding information.
> 
> $ git rev-list --header -n1 HEAD
> 6d751699cb04150abd79a730187d4e2ed6330c05
> tree 70209eebdc59d108948feb15c3c5497f299ef290
> parent 49a8186d7352d0454df79b289fecb18c8e535c32
> author Marco Costalba <mcostalba@gmail.com> 1167500660 +0100
> committer Marco Costalba <mcostalba@gmail.com> 1167500660 +0100
> encoding UTF-8
> 
>     Test commit
> 
>     Let's see what git-rev-list --header spits out.
> 
>     Signed-off-by: Marco Costalba <mcostalba@gmail.com>
> 
> $ git --version
> git version 1.5.0.rc0.g1ed48
> 
> 
> This is very unfortunate because qgit parsing routine it's totally
> broken after this change. Please revert the patch, or at least make
> git-rev-list --header quiet as default, IOW add an option
> --show-encoding that defaults to disabled.

Well, that is incompatibile change, but it also shows design errors
in qgit, as it should ignore unknown headers, and rely on "\n\n" to
separate header from the body. Isn't it?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
