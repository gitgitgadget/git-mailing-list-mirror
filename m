From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3-wip] revision traversal: show full history with merge
 simplification
Date: Thu, 31 Jul 2008 20:48:18 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807312044240.3277@nehalem.linux-foundation.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com> <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain> <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain> <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain> <46a038f90807282015m7ce3da10h71dfee221c960332@mail.gmail.com>
 <Pine.LNX.4.64.0807291433430.6791@localhost.localdomain> <alpine.LFD.1.10.0807291716060.3334@nehalem.linux-foundation.org> <alpine.LFD.1.10.0807291738280.3334@nehalem.linux-foundation.org> <7vej5b3ozz.fsf@gitster.siamese.dyndns.org> <7vhca6zcuy.fsf@gitster.siamese.dyndns.org>
 <7vabfxyacx.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807311513020.3277@nehalem.linux-foundation.org> <7vabfxv3px.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Roman Zippel <zippel@linux-m68k.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 05:49:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOle4-0003z4-EG
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 05:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbYHADse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 23:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753133AbYHADse
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 23:48:34 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43510 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753265AbYHADsd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 23:48:33 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m713mJgX025216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2008 20:48:20 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m713mIuZ027363;
	Thu, 31 Jul 2008 20:48:19 -0700
In-Reply-To: <7vabfxv3px.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.905 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91025>



On Thu, 31 Jul 2008, Junio C Hamano wrote:
>
> It was even worse than that.
> 
> The output from v3 is incorrect

Ok. I'm really not surprised. Incrementally is really hard. I'm reminded 
of all the problems we had with just the "trivial" issue of just knowing 
when to consider something uninteresting or not, that ended up depending 
on commit timestamps etc, and had problems with people having their clocks 
set incorrectly.

Doing the ops once you have the full DAG is usually _trivial_ by 
comparison. 

		Linus
