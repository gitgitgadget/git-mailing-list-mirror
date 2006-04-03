From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: HTTP repo referencing stale heads (can't clone)
Date: Mon, 3 Apr 2006 11:09:30 -0700
Message-ID: <20060403180929.GA14967@reactrix.com>
References: <443146EC.7060704@gentoo.org> <7virpqefp1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Drake <dsd@gentoo.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 20:09:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQTUq-0002J3-2d
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 20:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWDCSJm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 14:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWDCSJm
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 14:09:42 -0400
Received: from 241.37.26.69.virtela.com ([69.26.37.241]:12624 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S964830AbWDCSJl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Apr 2006 14:09:41 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k33I9Ucj019455;
	Mon, 3 Apr 2006 11:09:30 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k33I9UB1019453;
	Mon, 3 Apr 2006 11:09:30 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virpqefp1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18345>

On Mon, Apr 03, 2006 at 10:23:22AM -0700, Junio C Hamano wrote:

> My standard answer would be
> 
> http-server$ cd /var/www/git/zd1211.git/ ;# or whereever
> http-server$ GIT_DIR=. git-update-server-info

Is there any interest in making the HTTP transport slighly less dumb by
using DAV?

I have a working patch to http-fetch that tries to use PROPFIND to get a
remote pack list and falls back to using objects/info/packs.  It's
feasible to do something similar to get a remote ref list when cloning,
although that's a bit more work as all refs would have to be fetched
into a local repo and parsed to determine the object type.

Long term, this could give a repo admin the choice of either making sure
git-update-server-info has been run after every ref/pack change or
enabling DAV once.  Assuming they need to use HTTP.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
