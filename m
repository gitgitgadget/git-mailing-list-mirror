From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "make test" fails with current HEAD
Date: Fri, 18 Nov 2005 08:14:01 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511180812200.13959@g5.osdl.org>
References: <pan.2005.11.17.15.31.56.755022@smurf.noris.de>
 <7v7jb6o1kl.fsf@assigned-by-dhcp.cox.net> <20051118075117.GK31613@kiste.smurf.noris.de>
 <7vbr0imlha.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 17:15:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed8so-0002YX-8q
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 17:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVKRQOf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 11:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVKRQOf
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 11:14:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37322 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932353AbVKRQOe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 11:14:34 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAIGE5nO015412
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 18 Nov 2005 08:14:06 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAIGE2vV017044;
	Fri, 18 Nov 2005 08:14:04 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr0imlha.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12237>



On Fri, 18 Nov 2005, Junio C Hamano wrote:
> 
> And at this point it becomes more and more tempting to have our
> own internal diff generator, without relying on external diff.
> 
> A midway compromise solution would be to detect if either file
> is binary ourselves and not to call diff but always say "Binary
> files difer".

Umm.. Why not just say "if the line after the 'diff' line doesn't start 
with '@@ ', then it's a binary diff"?

And not care at _all_ about what it says.

We require unified diffs, and they _always_ start with '@@ ' after the 
header. No need to check anything else.

		Linus
