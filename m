From: Eric Wong <normalperson@yhbt.net>
Subject: Re: svn svn returning 'fatal: Not a valid object name' on
	sourceforge svn repo
Date: Sat, 5 Dec 2009 14:49:50 -0800
Message-ID: <20091205224950.GC2120@dcvr.yhbt.net>
References: <p0624081ac73dd6a1aaff@[63.138.152.192]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Bannasch <stephen.bannasch@deanbrook.org>
X-From: git-owner@vger.kernel.org Sat Dec 05 23:50:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH3S1-00069m-QL
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 23:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756932AbZLEWtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 17:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756427AbZLEWto
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 17:49:44 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:36018 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754728AbZLEWto (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 17:49:44 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id C57B4296845;
	Sat,  5 Dec 2009 22:49:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <p0624081ac73dd6a1aaff@[63.138.152.192]>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134631>

Stephen Bannasch <stephen.bannasch@deanbrook.org> wrote:
> I use git svn often and normally it works fine.
>
> I getting a fatal error trying to clone the asciimathm svn repo at sourceforge:
>
> $ git svn clone --trunk=trunk --branches=branches http://asciimathml.svn.sourceforge.net/svnroot/asciimathml asciimathml-svn-git
> fatal: Not a valid object name
> ls-tree -z  ./: command returned error: 128
>
> Anybody seen this kind of problem before.
>
> A svn co works fine.
>
> I'm using git version 1.6.5.1 on mac os 10.5.8.

Hi Stephen,

Passing the "-r4:HEAD" parameter to "git svn clone" should work.  It
looks like the repository was initially miscreated and "trunk" was a
symlink (and not a directory) in r1.

I have not yet thought of a good solution to this, yet...

-- 
Eric Wong
