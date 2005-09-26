From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Add "git-update-ref" to update the HEAD (or other) ref
Date: Sun, 25 Sep 2005 17:50:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509251747290.3308@g5.osdl.org>
References: <Pine.LNX.4.58.0509251134480.3308@g5.osdl.org>
 <7vhdc8n2xb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Mon Sep 26 02:51:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJhD1-0007lh-59
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 02:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbVIZAuj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 20:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbVIZAuj
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 20:50:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40149 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751580AbVIZAui (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Sep 2005 20:50:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8Q0oY4s025738
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 25 Sep 2005 17:50:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8Q0oX9H002808;
	Sun, 25 Sep 2005 17:50:33 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhdc8n2xb.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9297>



On Sun, 25 Sep 2005, Junio C Hamano wrote:
> 
> I'd like to take these patches in two stages (I am not asking
> you for a resend):
> 
>  - Drop the emulated symlink part from the update-ref.c; have it
>    graduate to "master" branch and use it in existing scripts.

Sure.

>  - Take the read_ref() change, along with a patch to re-add the
>    emulated symlink part to update-ref.c (after making its
>    interpretation to match that of read_ref() -- which requires
>    the prefix to be exactly "ref: " five bytes); keep it in "pu"
>    branch a bit longer.

I was actually thinking of maybe entirely replacing "read_ref()" with the
more powerful "resolve_ref()" - moving resolve_ref() into refs.c.

That way there's only one place that knows about the "ref:" thing.

But yes, forcing the format to be "ref: " instead of "ref:<whitespace>*" 
sounds fine.

		Linus
