From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Comments on recursive merge..
Date: Mon, 7 Nov 2005 16:33:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
 <20051107225807.GA10937@c165.ib.student.liu.se> <7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Nov 08 01:35:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZHRF-0008Vq-Q8
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 01:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965637AbVKHAeJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 19:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965636AbVKHAeI
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 19:34:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5331 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965637AbVKHAeH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 19:34:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA80XwnO032656
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 7 Nov 2005 16:33:58 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA80XuJU007491;
	Mon, 7 Nov 2005 16:33:57 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11296>



On Mon, 7 Nov 2005, Junio C Hamano wrote:
> 
> This is the first time I see you pleased by something in git
> that was done without very close supervision from you.

That sounds like a backhanded way of saying that I'm micromanagering, 
picky and difficult to work with ;)

> Another thing to consider is if it is fast enough for everyday
> trivial merges.

Hmm. True. The _really_ trivial in-index case triggers for me pretty 
often, but I haven't done any statistics. It might be only 50% of the 
time.

Is the recursive thing noticeably slower for the "easy" cases (ie things 
that the old regular resolve strategy does well)?

It's certainly an option to just do what I just did, namely use the 
default one until it breaks, and then just do "git reset --hard" and re-do 
the pull with "-s recursive". A bit sad, and it would be good to have 
coverage on the recursive strategy..

		Linus
