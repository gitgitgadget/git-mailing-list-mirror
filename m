From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/1] Diff-helper update
Date: Wed, 18 May 2005 11:38:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505181134470.18337@ppc970.osdl.org>
References: <7v3bslqc94.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505180821470.18337@ppc970.osdl.org> <7v64xgpgb0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505181110480.18337@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, pasky@ucw.cz
X-From: git-owner@vger.kernel.org Wed May 18 20:43:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYTU5-0002kh-5g
	for gcvg-git@gmane.org; Wed, 18 May 2005 20:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbVERSlW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 14:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVERShp
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 14:37:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:20688 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262285AbVERSgy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2005 14:36:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4IIahU3030788
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 May 2005 11:36:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4IIag84011969;
	Wed, 18 May 2005 11:36:42 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0505181110480.18337@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 18 May 2005, Linus Torvalds wrote:
> 
> If diff-helper just passes the lines it doesn't understand through
> unmodified (_after_ having handled any pending rename logic), it will 
> automatically do the right thing.

I took the liberty of doing just that. The only subtle issue was that 
the strbuf functions would consider an empty line to be EOF, which looked 
wrong and unintentional. Fixing that made the actual diff-helper changes 
totally trivial, and I can now do

	git-rev-list HEAD | git-diff-tree -r -v --stdin | ./git-diff-helper -r | less -S

and it does the right thing for me.

		Linus
