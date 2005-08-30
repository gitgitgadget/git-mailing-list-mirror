From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/9] Fix git patch header processing in git-apply.
Date: Mon, 29 Aug 2005 17:47:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508291744400.3243@g5.osdl.org>
References: <11252426672473-git-send-email-robfitz@273k.net>
 <7vslwtein3.fsf@assigned-by-dhcp.cox.net> <20050829235823.GA19351@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 30 02:48:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9uHR-0007PM-Sc
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 02:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbVH3ArL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 20:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbVH3ArL
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 20:47:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49887 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751376AbVH3ArK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 20:47:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7U0l2jA009957
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 Aug 2005 17:47:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7U0l0TV001931;
	Mon, 29 Aug 2005 17:47:01 -0700
To: Robert Fitzsimons <robfitz@273k.net>
In-Reply-To: <20050829235823.GA19351@localhost>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7933>



On Mon, 29 Aug 2005, Robert Fitzsimons wrote:
>
> I should have mentioned before, these changes are being used in a
> SourcePuller dump file to git import script I've been working on.

Hmm. Anything that depends on "--ignore-applied" is fundamentally broken
as an import tool. There's no way something like that can be valid, since
it inhently means that somebody is trying to apply a patch that simple
isn't applicable.

So it seems like you're trying to work around some other serious problems 
in the import, and as a result the import is clearly not trustworthy. 

Don't do this.

			Linus
