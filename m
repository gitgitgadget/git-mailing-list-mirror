From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] read-tree -m -u: do not overwrite or remove untracked working tree files.
Date: Wed, 17 May 2006 10:24:30 +0200
Organization: At home
Message-ID: <e4emjq$73g$1@sea.gmane.org>
References: <8aa486160605161500m1dd8428cj@mail.gmail.com> <7v1wut61aj.fsf@assigned-by-dhcp.cox.net> <8aa486160605161611p4c9ddbc0v@mail.gmail.com> <7v8xp1jc9h.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed May 17 10:25:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgHLC-0006Ms-AC
	for gcvg-git@gmane.org; Wed, 17 May 2006 10:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWEQIZG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 04:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWEQIZG
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 04:25:06 -0400
Received: from main.gmane.org ([80.91.229.2]:16835 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932482AbWEQIZE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 04:25:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FgHKz-0006Kx-Mm
	for git@vger.kernel.org; Wed, 17 May 2006 10:24:57 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 May 2006 10:24:57 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 May 2006 10:24:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20170>

Junio C Hamano wrote:

>   This is an RFC patch that I consider of somewhat dubious value.
>   Not the implementation quality, but the semantic change it
>   implies.  Before, we could freely work in a working tree, which
>   is just a scratch area to build the index, littered with
>   throw-away files, knowing they would not prevent merge between
>   our HEAD and other branch from happenning even if a merge needs
>   to blow them away.  With this change, it is not a case anymore.
>   Your merge will fail to proceed and you have to remove those
>   throw-away files yourself and retry the merge.  The extent of
>   the damage can be seen by the change to t1002 test this commit
>   contains.  It arguably is making things much safer by refusing to
>   proceed, so this might be a desirable change.  I am still
>   undecided.

Perhaps the behavior should be decided by the config option, e.g.
core.preserveWorkingTree; of course that leave us with the problem what
value should be the default: the one preserving backward compatibility, or
the more safe one.

And of course --force to blow away changes anyway...

-- 
Jakub Narebski
Warsaw, Poland
