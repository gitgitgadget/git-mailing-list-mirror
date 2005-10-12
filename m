From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-mv
Date: Wed, 12 Oct 2005 12:07:57 +0200
Message-ID: <20051012100757.GM30889@pasky.or.cz>
References: <20051007143333.GA18843@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 12 12:09:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPdX6-0005mT-Ki
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 12:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbVJLKIB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 06:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbVJLKIB
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 06:08:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:6542 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751380AbVJLKIB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Oct 2005 06:08:01 -0400
Received: (qmail 22374 invoked by uid 2001); 12 Oct 2005 12:07:57 +0200
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20051007143333.GA18843@tumblerings.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10016>

Dear diary, on Fri, Oct 07, 2005 at 04:33:33PM CEST, I got a letter
where Zack Brown <zbrown@tumblerings.org> told me that...
> Hi,

Hello,

> IIRC, file renaming is something we only care about at read time, we don't
> actually need to track it while making the change, because git allows us to
> track data from file to file without having to tell it that the data is moving.
> 
> So, just to keep certain people happy, why not have the cg-mv command defined to
> something like this:
> 
> #!/bin/bash
> cp $1 $2
> cg-rm $1
> cg-add $2

so it should keep the file under the original name as well, but
untraced? That's weird. What about

	#!/usr/bin/env bash

	if [ -e $2 ]; then
		! got_parameter -f && die "dest exists"
		[ -e $1 ] || die "no source nor destination"
	fi
	( [ -e $1 ] && mv $1 $2 ) && cg-add $2 && cg-rm $1

plus quoting and stuff?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
