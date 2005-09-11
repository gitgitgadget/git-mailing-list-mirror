From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix pulling into the same branch.
Date: Sun, 11 Sep 2005 10:58:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509111054590.3242@g5.osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F043BA469@scsmsx401.amr.corp.intel.com>
 <7vzmr43vix.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0509111153380.32555@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vk6hntslb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 19:58:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEW5k-0001FE-T9
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 19:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbVIKR6J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 13:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbVIKR6J
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 13:58:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61675 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964995AbVIKR6I (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 13:58:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8BHw1Bo014571
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Sep 2005 10:58:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8BHw0Zo014680;
	Sun, 11 Sep 2005 10:58:01 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6hntslb.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8308>



On Sun, 11 Sep 2005, Junio C Hamano wrote:
> 
> Yes, but the issue becomes how we can reliably tell if a
> repository is naked or has an associated working tree.

You can't "git pull" into a naked thing anyway. And

	git-read-tree -m -u <old-head> <new-head>

should always do the right thing (ie if there is dirty state that would be
updated, it will fail gracefully).

Or did I miss something?

		Linus
