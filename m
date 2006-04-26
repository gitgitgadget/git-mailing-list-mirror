From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links
Date: Wed, 26 Apr 2006 11:28:21 +0200
Organization: At home
Message-ID: <e2neen$4mp$1@sea.gmane.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain> <7vwtde2q1z.fsf@assigned-by-dhcp.cox.net> <444EAE7C.5010402@vilain.net> <e2mv30$k08$1@sea.gmane.org> <e2n01t$m8j$1@sea.gmane.org> <7vzmi8sxt1.fsf_-_@assigned-by-dhcp.cox.net> <e2n4am$1vn$1@sea.gmane.org> <7vlktssudl.fsf_-_@assigned-by-dhcp.cox.net> <e2n72h$aqe$1@sea.gmane.org> <7virowrd1y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Apr 26 11:28:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYgJo-0002eX-EC
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 11:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWDZJ2H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 05:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWDZJ2H
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 05:28:07 -0400
Received: from main.gmane.org ([80.91.229.2]:32396 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751260AbWDZJ2G (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Apr 2006 05:28:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FYgJU-0002am-6k
	for git@vger.kernel.org; Wed, 26 Apr 2006 11:28:00 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Apr 2006 11:28:00 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Apr 2006 11:28:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19195>

Junio C Hamano wrote:

> And a subproject commit, unless it contains subsubproject, would
> look like just an ordinary commit.  Its tree would match the
> entry in the tree the toplevel commit at the path in "bind" line
> of the top-level commit.
> 
> Some reading material, from newer to older:
> 
>   * http://www.kernel.org/git/?p=git/git.git;a=blob;hb=todo;f=Subpro.txt
> 
>   This talks about the overall "vision" on how the user-level
>   interaction might look like, with a sketch on how the core-level
>   would help Porcelain to implement that interaction.  Most of the
>   core-level support described there is in the "bind commit"
>   changes, except "update-index --bind/-unbind" to record the
>   information on bound subprojects in the index file.

By the way, this file talks about (1) "using"/"userspace"/"embedder"
subproject holding 'appliance/', and toplevel (master) holding toplevel
Makefile, or (2) 'using' subproject holding both 'appliance/' and toplevel
Makefile with the help of --exclude. 

Another option would be to have only "embedded"/"used"/"requirement" be
subproject holding 'kernel-2.6', and 'appliance/' hold by toplevel (master)
commit.  Perhaps not the best solution for 'kernel + userspace tools'
example, but might be better workflow for 'application + library' or
'application + engine' example. 

-- 
Jakub Narebski
Warsaw, Poland
