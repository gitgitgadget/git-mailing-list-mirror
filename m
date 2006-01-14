From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] rpmbuild doesn't like '-' in version strings
Date: Sat, 14 Jan 2006 09:53:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601140951230.13339@g5.osdl.org>
References: <dp3qpb$7uk$1@sea.gmane.org> <7voe2prniw.fsf@assigned-by-dhcp.cox.net>
 <43C91B25.9030707@research.att.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 14 18:54:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExpbO-0002yg-1A
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 18:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWANRyH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 12:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWANRyH
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 12:54:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19399 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750735AbWANRyG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jan 2006 12:54:06 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0EHrKDZ008959
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 14 Jan 2006 09:53:21 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0EHrJZm009131;
	Sat, 14 Jan 2006 09:53:20 -0800
To: John Ellson <ellson@research.att.com>
In-Reply-To: <43C91B25.9030707@research.att.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.65__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14671>



On Sat, 14 Jan 2006, John Ellson wrote:
> 
> What happened to this?   I don't particularly like my fix either, but
> some kind of fix is needed for the "make rpm" target to work.  Its still
> broken because of the '-' in the version string.

Do a "sed" for rpmbuild.

There's absolutely no point in trying to make git-describe use "_" instead 
of "-", since having a "-" in a tag-name is very common ("my-version"), 
and it would be a horrible mistake to munge the tag-names. So even if we 
changed "-g" into "_g" it wouldn't help anything, and just make things 
uglier.

This is an RPM versioning problem, and nothing more. So it should be 
handled by rpmbuild.

		Linus
