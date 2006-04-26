From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and other commit links ideas)
Date: Wed, 26 Apr 2006 14:42:51 +0200
Organization: At home
Message-ID: <e2nprc$cie$1@sea.gmane.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain> <e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604250811230.3701@g5.osdl.org> <Pine.LNX.4.64.0604250833540.3701@g5.osdl.org> <e2lijt$aco$1@sea.gmane.org> <Pine.LNX.4.64.0604251004410.3701@g5.osdl.org> <BAYC1-PASMTP091348C4C33C5A0E83C012AEBF0@CEZ.ICE> <Pine.LNX.4.64.0604251106400.3701@g5.osdl.org> <BAYC1-PASMTP04D82622D9D5DA7E352079AEBF0@CEZ.ICE> <Pine.LNX.4.64.0604251125010.3701@g5.osdl.org> <BAYC1-PASMTP03E0B5376ACFF165B29ED1AEBF0@CEZ.ICE> <Pine.LNX.4.64.0604251155530.3701@g5.osdl.org> <7vslo1v4zw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Apr 26 14:44:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYjMw-0002l1-Hm
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 14:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWDZMn2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 08:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWDZMn2
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 08:43:28 -0400
Received: from main.gmane.org ([80.91.229.2]:42155 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932135AbWDZMn2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Apr 2006 08:43:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FYjM5-0002av-LH
	for git@vger.kernel.org; Wed, 26 Apr 2006 14:42:53 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Apr 2006 14:42:53 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Apr 2006 14:42:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19203>

Junio C Hamano wrote:

> My initial 'related' without 'note' was flawed - it used
> cherry-pick as an example of 'related' when it clearly should
> have been 'note' (no connectivitiy required).
[...]
> There definitely needs to be an ability to specify a list of
> "nature of links this repository accepts", if we were to do
> 'link'.  It probably should default to an empty set.  rev-list
> --objects would include objects pointed by 'link' only when the
> repository wants such links to be honored.  fsck-objects will
> declare an object that is reachable only by a 'link' that is not
> accepted by the repository "uninteresting" and let git-prune
> remove it.

I think that perhaps connectivity should be more fine-grained than this.
Namely we might want links which are not fsck-able nor pulled (and can be
dangling), but will prevent object pointed from being pruned. The
"original" (or "cherrypick") relation comes to mind.

Of course that can be configured per repository...

-- 
Jakub Narebski
Warsaw, Poland
