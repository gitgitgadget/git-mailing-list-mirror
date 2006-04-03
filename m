From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Use sigaction and SA_RESTART in read-tree.c; add option
 in Makefile.
Date: Sun, 2 Apr 2006 21:40:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604022139100.3781@g5.osdl.org>
References: <17063.1144016974@lotus.CS.Berkeley.EDU> <7v7j67i93f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jason Riedy <ejr@EECS.Berkeley.EDU>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 06:40:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQGrW-0001rR-AW
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 06:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWDCEkQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 00:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWDCEkQ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 00:40:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33442 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750930AbWDCEkO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 00:40:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k334eAEX004958
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 2 Apr 2006 21:40:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k334e984002965;
	Sun, 2 Apr 2006 21:40:10 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j67i93f.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18315>



On Sun, 2 Apr 2006, Junio C Hamano wrote:

> Jason Riedy <ejr@EECS.Berkeley.EDU> writes:
> 
> > Also add a NO_SA_RESTART option in the Makefile in case someone
> > doesn't have SA_RESTART but does restart (maybe older HP/UX?).
> > We want the builder to chose this specifically in case the
> > system both lacks SA_RESTART and does not restart stdio calls;
> > a compat #define in git-compat-utils.h would silently allow
> > broken systems.
> 
> What am I missing...?

I don't think this part is worth it at least for now.

If there really are systems without SA_RESTART, they probably don't have 
sigaction() either, so #defining SA_RESTART to zero likely won't help.

But somebody can prove me wrong..

		Linus
