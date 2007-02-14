From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [ANNOUNCE] GIT 1.5.0
Date: Wed, 14 Feb 2007 08:45:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702140839560.3604@woody.linux-foundation.org>
References: <7vlkj1v3av.fsf@assigned-by-dhcp.cox.net> <17875.9043.217255.863200@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 17:47:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHNHy-00035Z-1n
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 17:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbXBNQpy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 11:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbXBNQpx
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 11:45:53 -0500
Received: from smtp.osdl.org ([65.172.181.24]:35046 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932380AbXBNQps (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 11:45:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1EGjjhB007901
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Feb 2007 08:45:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1EGjiHX002937;
	Wed, 14 Feb 2007 08:45:44 -0800
In-Reply-To: <17875.9043.217255.863200@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.909 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39676>



On Wed, 14 Feb 2007, Bill Lear wrote:
> 
> This is enabled by passing the --enable=receive-pack to the
> git-daemon (usually in the [x]?inetd configuration).
> 
> This has the benefit of:

Before you list the benefits, you should always talk about the lack of 
security! Let nobody enable it without realizing the dangers! Tell people 
to _only_ do this inside a company firewall, and even then, only if you 
trust everybody.

>   2) A less ugly URL to use: git://server/repo, instead of, say,
>      ssh+git://server/path/to/repos/repo.

Why do people use that silly "ssh+git://" format?

It's a cogito thing. Native git has never done it, and only supports it 
because cogito thought it must make sense.

The native git ssh URL is exactly the normal ssh URL:

	server:/path/to/repos/repo

and if you really want to use the "xxx://" format, you might as well just 
use

	ssh://server/path/to/repos/repo

which should also work fine. 

		Linus

PS. This is the commit message that  added "git+ssh://":

	Author: Linus Torvalds <torvalds@osdl.org>
	Date:   Fri Oct 14 17:14:56 2005 -0700
	
	    Support git+ssh:// and ssh+git:// URL
	
	    It seemed to be such a stupid syntax. It's both what "ssh://" means,
	    and it's what not specifying a protocol at _all_ means.
	
	    But hey, since we already have two ways of saying "use ssh with
	    pack-files", here's two more.

so it was deemed stupid from the get-go, and isn't even some "legacy" 
thing. It's purely a "cogito people thought it makes sense to point out 
that it's _both_ native git _and_ ssh protocol".
