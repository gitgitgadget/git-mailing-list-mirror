From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: merging problems with Linus' kernel tree.
Date: Tue, 21 Feb 2006 10:55:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602211052360.30245@g5.osdl.org>
References: <20060221183306.GC22988@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 19:55:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBcfn-0007ns-6Z
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 19:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWBUSzk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 13:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWBUSzk
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 13:55:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5017 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750860AbWBUSzj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 13:55:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1LItKDZ002406
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 21 Feb 2006 10:55:20 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1LItFPc030474;
	Tue, 21 Feb 2006 10:55:18 -0800
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20060221183306.GC22988@redhat.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16542>



On Tue, 21 Feb 2006, Dave Jones wrote:
>
> Documentation/cpu-hotplug.txt: needs update
> fatal: Entry 'Documentation/cpu-hotplug.txt' would be overwritten by merge. Cannot merge.

This means that it's dirty in the index, not that you've committed any 
changes.

Do a "git diff".

(It may also be that the diff is empty, and only shows the filename. That 
means that you've changed the mtime - for example edited it, and then 
undone the edit - so that the file is dirty in the index, even if the 
_contents_ are the same. If so, do a "git-update-index --refresh" or 
similar, or just ask for "git status", which will do it for you as part of 
checking the status of all your files).

		Linus
