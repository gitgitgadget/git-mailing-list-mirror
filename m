From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in git.git
Date: Sun, 5 Mar 2006 12:04:48 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603051203060.13139@g5.osdl.org>
References: <7vacc5jza6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0603042058250.13139@g5.osdl.org> <7vfylxigxc.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0603050946280.13139@g5.osdl.org> <Pine.LNX.4.64.0603051027400.13139@g5.osdl.org>
 <7vwtf8fzvb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 05 21:05:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFzTw-0000TX-Tv
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 21:05:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbWCEUEy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 15:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbWCEUEy
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 15:04:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33485 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751807AbWCEUEx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Mar 2006 15:04:53 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k25K4nDZ031517
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 5 Mar 2006 12:04:50 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k25K4mmu002965;
	Sun, 5 Mar 2006 12:04:49 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtf8fzvb.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17242>



On Sun, 5 Mar 2006, Junio C Hamano wrote:
> 
> I abused SHOWN when I did --objects-edge with
> mark_edge_parents_uninteresting modification in
> eb38cc689e84a8fd01c1856e889fe8d3b4f1bfb4, but probably it can be
> modified to use SEEN.

Ahh, no. SEEN is different from SHOWN. SHOWN means that we've actually 
shown that commit, while SEEN just means that we've added it to the list 
(but it might be uninteresting, for example). I think you did exactly the 
right thing wrt SHOWN.

That said, the revision list walker should never see a SHOWN commit on the 
list, because it is the thing that sets SHOWN as it removes the entry from 
the list (and it should never get re-added, due to SEEN).

		Linus
