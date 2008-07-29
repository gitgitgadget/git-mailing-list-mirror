From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Make use of stat.ctime configurable
Date: Mon, 28 Jul 2008 19:01:40 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807281857140.3486@nehalem.linux-foundation.org>
References: <7vr69lihkt.fsf@gitster.siamese.dyndns.org> <20080723164614.GB5283@blimp.local> <alpine.DEB.1.00.0807231757550.8986@racer> <20080723191647.GF5283@blimp.local> <alpine.LFD.1.10.0807241854580.5249@nehalem.linux-foundation.org> <20080725055547.GA3699@blimp.local>
 <alpine.DEB.1.00.0807260256030.11976@eeepc-johanness> <20080726153802.GA16868@blimp.local> <7v1w1f155p.fsf@gitster.siamese.dyndns.org> <20080728063128.GA4234@blimp.local> <20080728160446.GA16351@old.davidb.org> <alpine.LFD.1.10.0807280906530.3486@nehalem.linux-foundation.org>
 <7vbq0ho5g7.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807281817230.3486@nehalem.linux-foundation.org> <7v3alto4r7.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807281853520.3486@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Brown <git@davidb.org>, Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 04:06:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNeb9-0005Yq-Eq
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 04:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459AbYG2CFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 22:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756379AbYG2CE7
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 22:04:59 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36315 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756355AbYG2CE6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jul 2008 22:04:58 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6T24dns001153
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Jul 2008 19:04:40 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6T24cRu008347;
	Mon, 28 Jul 2008 19:04:38 -0700
In-Reply-To: <alpine.LFD.1.10.0807281853520.3486@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-5.41 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90550>



On Mon, 28 Jul 2008, Linus Torvalds wrote:
> 
> Hmm. I think that's just a plain POSIX oddity. There's no real "reason" 
> for it, except the historical one: in really old UNIX terms, rename used 
> to be a "link+unlink".

Side note: a lot of the mtime/ctime/atime rules are really pretty 
arbitrary. They've grown over time, and have various historic reasons.
'ctime' in particular is more arbitrary than most, and I don't at all 
guarantee that all Unixes will work exactly the same wrt ctime and rename. 

In fact, I -can- guarantee that some older versions of Linux haven't 
always updated ctime on renames, for example, and it's probably still 
per-filesystem.

			Linus
