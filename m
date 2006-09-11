From: Paul Mackerras <paulus@samba.org>
Subject: Re: Change set based shallow clone
Date: Tue, 12 Sep 2006 07:52:27 +1000
Message-ID: <17669.55963.930152.564529@cargo.ozlabs.ibm.com>
References: <17669.8191.778645.311304@cargo.ozlabs.ibm.com>
	<20060911142644.32313.qmail@science.horizon.com>
	<7vy7sqic4e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux@horizon.com, git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue Sep 12 00:13:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMu1h-0008Oc-Oy
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 00:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbWIKWNJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 18:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbWIKWNI
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 18:13:08 -0400
Received: from ozlabs.org ([203.10.76.45]:61828 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965068AbWIKWNF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Sep 2006 18:13:05 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 7B65B67B57; Tue, 12 Sep 2006 08:13:04 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7sqic4e.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26862>

Junio C Hamano writes:

> That's a dubious idea.
> 
>  - Why assume a tag points directly at a commit, or if it is
>    not, why assume "foo^{}" (dereferencing repeatedly until we
>    get a non-tag) is special?

Umm, I'm not sure what you're getting at here - if one shouldn't make
those assumptions, why does git ls-remote output both the tag and
tag^{} lines?

>  - Why assume the user wants access to only the object name of
>    what the tag points at?  Perhaps most users would want to
>    have its type, dates (committer and author), and probably the
>    first line of the commit message if it is (and most likely it
>    is) a commit?  -- at least gitweb and gitk would want these.

There are two things here.  Gitk needs to know which IDs have tags
when displaying the graph, and their names.  It doesn't need to know
the other details until someone clicks on the commit or the tag.  Thus
the information that needs to be collected for every tag at startup is
just the name and the sha1 id of the commit it eventually points to
(if it doesn't eventually point to a commit it's basically not
interesting).

Paul.
