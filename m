From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add .git/version
Date: Thu, 17 Nov 2005 11:35:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511171131260.13959@g5.osdl.org>
References: <11322339372137-git-send-email-matlads@dsmagic.com>
 <200511171644.48438.Josef.Weidendorfer@gmx.de> <7v7jb7uler.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org, Martin Atukunda <matlads@dsmagic.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 20:41:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcpbN-0001j6-AT
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 20:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbVKQTi7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 14:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbVKQTi6
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 14:38:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30097 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964818AbVKQTi5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 14:38:57 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAHJZCnO029476
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 17 Nov 2005 11:35:12 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAHJZBGO005329;
	Thu, 17 Nov 2005 11:35:11 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jb7uler.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12148>



On Thu, 17 Nov 2005, Junio C Hamano wrote:
> 
>  - We want repository-format-version but that may be too
>    long. Just saying version is a bit confusing.  Abbreviating
>    it to repository-version makes it sound as if somebody took a
>    snapshot (i.e. tar-tree $commit).  Whatever name we choose,
>    let's pick a one not so confusing.

My one argument against this is that I don't see why we have to have a 
separate file for this.

Why not just add a "core.version" flag to the config file? If no version 
exists, assume it's version 1. And then, if we ever start using some other 
version, make git-init-db always create the config file (the way we 
already do for "core.filemode")

Sure, people can edit the version flag by hand, but hey, that's true even 
if it's in a separate .git/version file.

		Linus
