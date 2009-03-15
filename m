From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: creating tags from a subdirectory of trunk
Date: Sun, 15 Mar 2009 16:21:05 -0700
Message-ID: <20090315232105.GA21667@dcvr.yhbt.net>
References: <632a37a0903151418u483ca6cal1582518b9120da8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tom Huybrechts <tom.huybrechts@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 00:22:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LizfC-0000M7-D2
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 00:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbZCOXVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2009 19:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbZCOXVI
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 19:21:08 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41683 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792AbZCOXVI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 19:21:08 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABB1F1F4E3;
	Sun, 15 Mar 2009 23:21:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <632a37a0903151418u483ca6cal1582518b9120da8e@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113302>

Tom Huybrechts <tom.huybrechts@gmail.com> wrote:
> Hi,
> 
> I'm trying to setup a git mirror of a svn repository.  The tags in
> this repository are not created trunk it self, but from subdirectories
> of trunk. The tags and branches are in the standard places.
> e.g:
> /trunk/main -> tags/main-1
> /trunk/plugins/foo -> tags/foo-1
> /trunk/plugins/bar -> tags/bar-1
> 
> I run 'git svn clone -s svn-url target'. It starts going over the
> history nicely until it reaches the first branch. It calls this branch
> something like tags/tag-name@revision, and starts retrieving the
> entire project history again from r1. This is repeated for every
> branch.

Hi Tom,

This is a known problem with some repositories.  My suggestion is to
use individual "fetch" directives for each of those tags you want to
follow.

The -s/--stdlayout is only for projects that follow the SVN-recommended
repository layout exactly and we haven't thought of a generic way to
handle those non-standard tags in repos...

-- 
Eric Wong
