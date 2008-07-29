From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Make use of stat.ctime configurable
Date: Mon, 28 Jul 2008 18:55:47 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807281853520.3486@nehalem.linux-foundation.org>
References: <7vr69lihkt.fsf@gitster.siamese.dyndns.org> <20080723164614.GB5283@blimp.local> <alpine.DEB.1.00.0807231757550.8986@racer> <20080723191647.GF5283@blimp.local> <alpine.LFD.1.10.0807241854580.5249@nehalem.linux-foundation.org> <20080725055547.GA3699@blimp.local>
 <alpine.DEB.1.00.0807260256030.11976@eeepc-johanness> <20080726153802.GA16868@blimp.local> <7v1w1f155p.fsf@gitster.siamese.dyndns.org> <20080728063128.GA4234@blimp.local> <20080728160446.GA16351@old.davidb.org> <alpine.LFD.1.10.0807280906530.3486@nehalem.linux-foundation.org>
 <7vbq0ho5g7.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807281817230.3486@nehalem.linux-foundation.org> <7v3alto4r7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Brown <git@davidb.org>, Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 04:00:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNeVX-0004Ip-2z
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 04:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbYG2B7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 21:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbYG2B7J
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 21:59:09 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40601 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751564AbYG2B7I (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jul 2008 21:59:08 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6T1wlW4000722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Jul 2008 18:58:48 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6T1wjY6008041;
	Mon, 28 Jul 2008 18:58:46 -0700
In-Reply-To: <7v3alto4r7.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-5.409 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90548>



On Mon, 28 Jul 2008, Junio C Hamano wrote:
> 
> Ok.  While I have your attention on st_ctime, let me ask you a stupid
> question.  Why does "rename(old, new)" change st_ctime when you move a
> regular file?

Hmm. I think that's just a plain POSIX oddity. There's no real "reason" 
for it, except the historical one: in really old UNIX terms, rename used 
to be a "link+unlink".

And that "link+unlink" updated ctime because the 'nlink' part of the inode 
changed. Never mind that it got changed right back ;)

			Linus
