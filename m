From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Why doesn't git-apply remove empty file
Date: Thu, 14 Aug 2008 13:02:40 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808141258180.3324@nehalem.linux-foundation.org>
References: <38b2ab8a0808120917h10f15c81v4d1f04c0174dc994@mail.gmail.com>  <7vod3xpxq2.fsf@gitster.siamese.dyndns.org>  <38b2ab8a0808130048t506dbb7ah1d6fcd6bd4f3c90c@mail.gmail.com>  <48A357BA.8060003@lsrfire.ath.cx>  <alpine.LFD.1.10.0808131602200.3462@nehalem.linux-foundation.org>
 <38b2ab8a0808141242k4bd6867dt8ef54f160713061f@mail.gmail.com> <alpine.LFD.1.10.0808141246190.3324@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 22:04:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTj3j-0003Qx-6R
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 22:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508AbYHNUDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 16:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754227AbYHNUDY
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 16:03:24 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51099 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753993AbYHNUDX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2008 16:03:23 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7EK2f15012186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Aug 2008 13:02:42 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7EK2ecd026932;
	Thu, 14 Aug 2008 13:02:41 -0700
In-Reply-To: <alpine.LFD.1.10.0808141246190.3324@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.413 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92393>



On Thu, 14 Aug 2008, Linus Torvalds wrote:
>
>   There's no way to do an all-or-nothing patch, which is often 
>    a huge requirement.

Side note: there's a way to do a "nothing or nothing" thing, and then test 
the return value of whether the do-nothing was successful or not.

So a reasonably common operation thing for scripting GNU patch is to 
literally do

	patch --dry-run

first to see if the patch will succeed.

..or to play games with backup and reject files after-the-fact, of course.

			Linus
