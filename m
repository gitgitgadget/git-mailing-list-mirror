From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree -M performance regression in 'next'
Date: Sun, 12 Mar 2006 09:00:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603120858230.3618@g5.osdl.org>
References: <20060311172818.GB32609@c165.ib.student.liu.se>
 <7voe0bdeyr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 12 18:00:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FITvf-0004P2-QA
	for gcvg-git@gmane.org; Sun, 12 Mar 2006 18:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbWCLRAZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 12:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbWCLRAZ
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 12:00:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17051 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751560AbWCLRAY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Mar 2006 12:00:24 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2CH0EDZ017284
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Mar 2006 09:00:14 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2CH0Dok008376;
	Sun, 12 Mar 2006 09:00:13 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe0bdeyr.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17519>



On Sun, 12 Mar 2006, Junio C Hamano wrote:
> 
> On my otherwise idle Duron 750 with slow disks, I am getting
> something like these:
> 
> 0.99.9m : 130m virtual, 40m resident, (0major+14205minor)
>           67.62user 0.08system 1:15.95elapsed
> master  : 130m virtual, 40m resident, (0major+12510minor)
>           66.06user 0.07system 1:10.95elapsed
> "next"  : 150m virtual, 65m resident, (0major+49858minor)
>           51.41user 0.45system 0.57.55elapsed

Any way to fix that "4 times as many page misses, and 70% bigger rss?" 
thing? It looks like you're not very careful about your memory use.

I realize that git in general wants a lot of memory, but I see that as a 
failure most of the time. I've got 2GB in most of my machines, but I 
shouldn't _need_ to have it..

			Linus
