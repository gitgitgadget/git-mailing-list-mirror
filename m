From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Makefile: introduce NO_PTHREADS
Date: Mon, 17 Nov 2008 08:47:19 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811170846390.3468@nehalem.linux-foundation.org>
References: <200811121029.34841.thomas@koch.ro> <20081112173651.GA9127@linode.davidb.org> <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org> <loom.20081113T174625-994@post.gmane.org> <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811131518070.3468@nehalem.linux-foundation.org> <371xaQfxsMMQ-9LK24q-nhcS4loEggn8Cj3J1IzfMbzzYDGE6HKbQQ@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0811131630470.3468@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0811131707090.3468@nehalem.linux-foundation.org> <vzAozXmaOLEpyz-7DHx4nMusAdaTsFp7iZ8xfFsgAIraex6_wfvyuw@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0811141109580.3468@nehalem.linux-foundation.org> <7vtza95h01.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0811150915240.3468@nehalem.linux-foundation.org> <7vvdumwbnn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 17:48:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L27HC-0004yr-Fv
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 17:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494AbYKQQr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 11:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751974AbYKQQr0
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 11:47:26 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58622 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752480AbYKQQrZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Nov 2008 11:47:25 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAHGlJv9010825
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Nov 2008 08:47:20 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAHGlJKT008716;
	Mon, 17 Nov 2008 08:47:19 -0800
In-Reply-To: <7vvdumwbnn.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.434 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101233>



On Mon, 17 Nov 2008, Junio C Hamano wrote:
> 
> I suspect that the callpath around ce_modified_check_fs() uses a buffer
> obtained from path.c:get_pathname() and parallel threads stomp on each
> other, but I do not have time to debug this right now (I will be on a
> 14-hour flight in a few hours).

Oh, damn. I had forgotten that check_fs() doesn't just do a "lstat()" any 
more. You're right.

Let me look at it. 

		Linus
