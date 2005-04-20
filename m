From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] write-tree performance problems
Date: Wed, 20 Apr 2005 09:21:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504200910000.6467@ppc970.osdl.org>
References: <200504191250.10286.mason@suse.com> <200504192049.21947.mason@suse.com>
 <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org> <200504201122.35448.mason@suse.com>
 <Pine.LNX.4.61.0504201128550.2630@cag.csail.mit.edu>
 <Pine.LNX.4.58.0504200840240.6467@ppc970.osdl.org>
 <Pine.LNX.4.61.0504201147280.2630@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 18:15:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOHr8-00015c-6b
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 18:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVDTQTS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 12:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVDTQTS
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 12:19:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:12202 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261709AbVDTQTP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 12:19:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3KGJAs4007881
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 09:19:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3KGJ9IA011618;
	Wed, 20 Apr 2005 09:19:10 -0700
To: "C. Scott Ananian" <cscott@cscott.net>
In-Reply-To: <Pine.LNX.4.61.0504201147280.2630@cag.csail.mit.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 20 Apr 2005, C. Scott Ananian wrote:
> 
> OK, sure.  But how 'bout chunking trees?  Are you grown happy with the new 
> trees-reference-other-trees paradigm, or is there a deep longing in your 
> heart for the simplicity of 'trees-reference-blobs-period'?

I'm pretty sure we do better chunking on a subdirectory basis, especially 
as it allows us to do various optimizations (avoid diffing common parts).

Yes, you could try to do the same optimizations with chunking, but then 
you'd need to make sure that the chunking was always on a full tree entry 
boundary etc - ie much harder than blob chunking. 

But hey, numbers talk, bullshit walks. 

		Linus
