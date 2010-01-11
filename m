From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Mon, 11 Jan 2010 07:43:51 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001110739280.13040@localhost.localdomain>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org> <87ljgfgbl0.fsf@catnip.gol.com> <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com> <877hrzga16.fsf@catnip.gol.com> <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
 <7v3a2mzzg4.fsf@alter.siamese.dyndns.org> <20100104053125.GA5083@coredump.intra.peff.net> <7vbphaquwl.fsf@alter.siamese.dyndns.org> <20100104064408.GA7785@coredump.intra.peff.net> <alpine.LFD.2.00.1001040659150.3630@localhost.localdomain>
 <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com> <alpine.LFD.2.00.1001040801290.3630@localhost.localdomain> <7vvdf9402f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miles Bader <miles@gnu.org>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 16:44:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUMRB-0005VL-4q
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 16:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374Ab0AKPoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 10:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753250Ab0AKPoL
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 10:44:11 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:32906 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752382Ab0AKPoK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jan 2010 10:44:10 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0BFhpZ6023005
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Jan 2010 07:43:53 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0BFhpIw012826;
	Mon, 11 Jan 2010 07:43:51 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vvdf9402f.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.449 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136632>



On Sun, 10 Jan 2010, Junio C Hamano wrote:
> 
> Here is an experimental patch; first, some numbers (hot cache best of 5 runs).

Without testing it, I can already ACK it. It looks like the 
ObviouslyRightThing(tm) to do. But I'll run some numbers too.

One thing that worries me - but that is independent of this patch - is 
that I don't think our 'grep' function works correctly (neither the 
'fixmatch()' one or the 'regexec()' one) when there are NUL characters in 
a file. Maybe I shouldn't care, but it worries me a bit.

		Linus
