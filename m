From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] git-fsck-cache argument processing
Date: Sat, 21 May 2005 12:47:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505211245580.2206@ppc970.osdl.org>
References: <4870.10.10.10.24.1116646732.squirrel@linux1>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 21:45:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZZu5-0002cy-H9
	for gcvg-git@gmane.org; Sat, 21 May 2005 21:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVEUTp7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 15:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVEUTp7
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 15:45:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:37301 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261739AbVEUTpx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2005 15:45:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4LJjojA014176
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 21 May 2005 12:45:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4LJjnLP010952;
	Sat, 21 May 2005 12:45:49 -0700
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <4870.10.10.10.24.1116646732.squirrel@linux1>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 20 May 2005, Sean wrote:
>
>  -u, --unreachable      Show missing objects or deltas

That's the wrong description.

fsck always shows missing objects, but "--unreachable" makes it also show
objects that cannot be reached from any of the references (either passed
in on the command line, or the implicit references we take if no explicit
reference is given).

So in many ways, "--unreachable" is about the _reverse_ of showing missing 
objects: it's about showing _extraneous_ objects that aren't needed by the 
ref that was passed in.

		Linus
