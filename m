From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Make cvs2git support remote CVS repos
Date: Wed, 25 May 2005 19:42:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505251938580.2307@ppc970.osdl.org>
References: <20050525181132.75705.qmail@web41204.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 04:38:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db8GO-0006wq-TE
	for gcvg-git@gmane.org; Thu, 26 May 2005 04:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVEZCkI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 22:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVEZCkI
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 22:40:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:6095 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261151AbVEZCkD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2005 22:40:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4Q2e2jA017021
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 25 May 2005 19:40:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4Q2e1Pu030458;
	Wed, 25 May 2005 19:40:01 -0700
To: Mark Allen <mrallen1@yahoo.com>
In-Reply-To: <20050525181132.75705.qmail@web41204.mail.yahoo.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 25 May 2005, Mark Allen wrote:
>
> Added a "--module=cvsmodule" command line option and (since we're going to process argv
> anyway) made "-v" for verbose mode a command line option too, instead of a compile time
> option.

Ahh.. You found out how to get CVS to check out individual files. 

The reason I use RCS "co" directly is because I couldn't figure out how
CVS can be made to do it. Of course, the raw RCS possibly also performs
better, but somebody should check that. If the overhead of using CVS to do
this is low enough, we should drop the raw RCS access, which should
simplify your patch and get rid of the need for "RCSDIR".

Anybody up for some performance testing?

			Linus
