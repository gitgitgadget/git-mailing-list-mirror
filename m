From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: hosting git on a nfs
Date: Thu, 13 Nov 2008 16:38:15 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811131630470.3468@nehalem.linux-foundation.org>
References: <200811121029.34841.thomas@koch.ro> <20081112173651.GA9127@linode.davidb.org> <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org> <loom.20081113T174625-994@post.gmane.org> <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811131518070.3468@nehalem.linux-foundation.org> <371xaQfxsMMQ-9LK24q-nhcS4loEggn8Cj3J1IzfMbzzYDGE6HKbQQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: James Pickens <jepicken@gmail.com>,
	Bruce Fields <bfields@fieldses.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Nov 14 01:39:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0mix-0004J6-DR
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 01:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbYKNAic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 19:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbYKNAic
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 19:38:32 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52479 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751946AbYKNAib (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2008 19:38:31 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAE0cHki026692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Nov 2008 16:38:18 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAE0cFis026170;
	Thu, 13 Nov 2008 16:38:16 -0800
In-Reply-To: <371xaQfxsMMQ-9LK24q-nhcS4loEggn8Cj3J1IzfMbzzYDGE6HKbQQ@cipher.nrlssc.navy.mil>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.432 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100937>



On Thu, 13 Nov 2008, Brandon Casey wrote:
>
> Cold cache* (over NFS):
> 
> Before:
> 
> 0.01user 0.31system 0:04.40elapsed 7%CPU
> 0.01user 0.31system 0:06.47elapsed 5%CPU
> 0.01user 0.26system 0:04.19elapsed 6%CPU
> 0.01user 0.30system 0:04.99elapsed 6%CPU
> 
> After:
> 
> 0.01user 0.46system 0:01.39elapsed 34%CPU
> 0.01user 0.41system 0:00.88elapsed 47%CPU
> 0.01user 0.45system 0:01.16elapsed 40%CPU
> 0.01user 0.45system 0:00.99elapsed 47%CPU
> 0.01user 0.45system 0:01.02elapsed 45%CPU

Ok, both you and Julian do seem to be getting a nice speedup from this.

I'll clean it up a bit and make a less hacky version. And I'll try to make 
it work for "git status" and friends too.

		Linus
