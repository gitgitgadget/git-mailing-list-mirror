From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: fsck-cache problem
Date: Sun, 24 Apr 2005 14:24:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504241418270.15879@ppc970.osdl.org>
References: <118833cc0504231855145c10a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 23:17:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPoTg-0000Ly-NT
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 23:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbVDXVWQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 17:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbVDXVWQ
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 17:22:16 -0400
Received: from fire.osdl.org ([65.172.181.4]:42942 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262432AbVDXVWL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 17:22:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3OLM7s4020003
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 24 Apr 2005 14:22:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3OLM6ka019481;
	Sun, 24 Apr 2005 14:22:07 -0700
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc0504231855145c10a5@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 23 Apr 2005, Morten Welinder wrote:
>
> That "(null)" is not from git, but from glibc in response to NULL
> passed for %s. 

Fixed. 

The object library set the types for tree/commit objects only when they
_parsed_ them, resulting in objects that were never parsed (because they
weren't found - because you hadn't gotten them downloaded yet) never
having their type set.

		Linus
