From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: my git problem
Date: Mon, 28 Apr 2008 15:14:20 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804281512110.3119@woody.linux-foundation.org>
References: <20080427112938.4dbe8e2a.akpm@linux-foundation.org> <alpine.LFD.1.10.0804271204510.3119@woody.linux-foundation.org> <20080427124454.6a606305.akpm@linux-foundation.org> <alpine.LFD.1.10.0804271315010.3119@woody.linux-foundation.org>
 <20080428143501.7d6e3ad0.akpm@linux-foundation.org> <alpine.LFD.1.10.0804281437160.3119@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 00:15:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqbd9-0000b5-MT
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 00:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965908AbYD1WOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 18:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763669AbYD1WOi
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 18:14:38 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55754 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965850AbYD1WOi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2008 18:14:38 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3SMEL1x011045
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 28 Apr 2008 15:14:22 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3SMEKWf019413;
	Mon, 28 Apr 2008 15:14:20 -0700
In-Reply-To: <alpine.LFD.1.10.0804281437160.3119@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.475 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80629>



On Mon, 28 Apr 2008, Linus Torvalds wrote:
> 
> I don't actually see what was wrong with the old script.  The merge was
> really oddly done, but apart from that, something like this should work
> (just your old script with some trivial fixes to 'git merge' and using
> somewhat saner arguments):

Side note: you are still going to have *exactly* the same issue if you 
have other git trees (not origin) that contain the same patch. 

The fact is, your model of "merging by applying patches" is the real 
problem here. It's not a model that can work unless all trees are 
independent and they obviously aren't. So trying to merge with "origin" is 
only going to remove _one_ tree from the equation.

			Linus
