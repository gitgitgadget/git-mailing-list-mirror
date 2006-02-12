From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] binary-tree-based objects.
Date: Sat, 11 Feb 2006 21:22:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602112117560.3691@g5.osdl.org>
References: <87slqpg11q.fsf@wine.dyndns.org> <Pine.LNX.4.64.0602111803350.3691@g5.osdl.org>
 <7vslqpi9mg.fsf@assigned-by-dhcp.cox.net> <7vhd75fc6y.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602112045340.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 06:22:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F89h4-0001eU-K0
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 06:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWBLFWk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 00:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWBLFWk
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 00:22:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30943 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932246AbWBLFWj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 00:22:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1C5MZDZ005031
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 11 Feb 2006 21:22:36 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1C5MZWl026857;
	Sat, 11 Feb 2006 21:22:35 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0602112045340.3691@g5.osdl.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15982>



On Sat, 11 Feb 2006, Linus Torvalds wrote:
> 
> Before:
> 	real    0m41.322s	user    0m40.612s	sys     0m0.492s
> 	real    0m40.797s	user    0m40.140s	sys     0m0.468s
> 	real    0m40.433s	user    0m40.016s	sys     0m0.412s
> 
> After:
> 	real    0m22.542s	user    0m22.080s	sys     0m0.448s
> 	real    0m22.660s	user    0m22.336s	sys     0m0.312s
> 	real    0m22.671s	user    0m22.236s	sys     0m0.292s

And just so you wouldn't think that all my machines are slow..

Before:
	real    0m28.645s	user    0m28.366s	sys     0m0.280s
	real    0m28.700s	user    0m28.486s	sys     0m0.212s

After:
	real    0m16.566s	user    0m16.373s	sys     0m0.196s
	real    0m16.512s	user    0m16.277s	sys     0m0.236s

so there (that's all with current kernel HEAD, mostly packed).

Now, I haven't compared it to the other suggested fixes (hashing, and the 
256-way bucket-sorting), but I obviously prefer the tree approach because 
it's my idea (and my ideas are _always_ superior) and because it's so dang 
simple.

If somebody shows that the other approaches are faster, then I guess I'll 
just have to sulk in a corner and grown quietly at people.

		Linus
