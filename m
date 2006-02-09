From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb using "--cc"?
Date: Thu, 9 Feb 2006 08:42:39 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602090838460.2458@g5.osdl.org>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org> <43EAA560.8030504@didntduck.org>
 <Pine.LNX.4.64.0602081817040.2458@g5.osdl.org> <7vu0b9jkad.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602090822100.2458@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 17:45:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7Esf-0003Pb-IE
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 17:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160996AbWBIQmv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 11:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161061AbWBIQmv
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 11:42:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52377 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1160996AbWBIQmu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 11:42:50 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k19GgkDZ003560
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 9 Feb 2006 08:42:46 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k19Ggef6032166;
	Thu, 9 Feb 2006 08:42:43 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0602090822100.2458@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15815>



On Thu, 9 Feb 2006, Linus Torvalds wrote:
> 
> This is a first try at it.

Btw, if it wasn't clear, this patch _does_ fix the fact that 
"git-whatchanged" didn't show merges even if they have conflicts.

Of course, since the raw format is equivalent to "-c" and only bases its 
"should I show" logic on whether the file has changed at all, it very 
fundamentally will never be able to tell the difference between a real 
content conflict and something that just had file-level automatic merging. 

So "git-whatchanged" will now show a lot of merges that didn't really 
change anything, but that just merged on a file level (ie the whole merge 
just goes away when you specify "--cc").

Still, that's actually interesting information too, so you can consider 
this a feature.

		Linus
