From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: file rename causes history to disappear
Date: Wed, 6 Sep 2006 11:34:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609061131100.27779@g5.osdl.org>
References: <44FEE0BB.2060601@garzik.org> <Pine.LNX.4.64.0609060834520.27779@g5.osdl.org>
 <44FEED4B.30909@garzik.org> <Pine.LNX.4.64.0609060858050.27779@g5.osdl.org>
 <edmvfv$lt7$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 20:35:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL2EZ-00026J-Py
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 20:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWIFSep (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 14:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWIFSep
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 14:34:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9646 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751134AbWIFSen (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 14:34:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k86IYcnW015594
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 6 Sep 2006 11:34:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k86IYbHg019719;
	Wed, 6 Sep 2006 11:34:37 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <edmvfv$lt7$2@sea.gmane.org>
X-Spam-Status: No, hits=-0.495 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26548>



On Wed, 6 Sep 2006, Jakub Narebski wrote:
> 
> So if/when git would have --follow option to git-log and git-diff-*, it
> would be rather --follow=<filename>, rather than --follow -- <paths>?

That would probably be sensible, yes. Especially since "--follow" is 
fundamentally different from the "<paths>" thing in that you really should 
be able to only follow a single file.

(Following multiple files causes huge amounts of pain - it might be 
possible, but I don't think it's worth it).

> git-rev-list could then output hash with current set of <filenames>, which
> were given <filename> at the beginning, i.e.
>   <hash> -- <filename> [<filename>...]

I would argue that "--follow" would be incompatible with having other 
<paths> listed. But maybe there is some sensible rule for what the 
combination means (show the listed paths _and_ the file we're following?) 
I dunno.

		Linus
