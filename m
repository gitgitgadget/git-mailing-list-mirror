From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How to switch kernel customizations from 2.6.15.6 to 2.6.16?
Date: Wed, 29 Mar 2006 11:39:06 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603291136100.15714@g5.osdl.org>
References: <1143596622.2481.10.camel@mattlaptop.metaesthetics.net>
 <Pine.LNX.4.64.0603281749060.15714@g5.osdl.org> <7vlkutc36w.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0603291102440.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 21:39:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOgVf-0008V8-As
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 21:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWC2TjM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 14:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWC2TjM
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 14:39:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45289 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750836AbWC2TjK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Mar 2006 14:39:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2TJd7Co020921
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 29 Mar 2006 11:39:07 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2TJd6IQ011521;
	Wed, 29 Mar 2006 11:39:06 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0603291102440.15714@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18179>



On Wed, 29 Mar 2006, Linus Torvalds wrote:
> 
> Right now, the sequence is:
> 
> 	git checkout mine			# if required
> 	git rebase --onto his origin

vs

> 	git checkout his
> 	git cherry-pick origin..mine

Btw, I realize that the advantage of "git rebase" is that it doesn't 
change somebody elses branch. However, we'd still be a lot better off with 
us simply doing the equivalent of something like

    git checkout -b new-mine his && 
	git cherry-pick origin..mine &&
	git rename-branch -f new-mine mine

instead of what git-rebase does now.

			Linus
