From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 1 Nov 2007 11:33:13 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org>
 <7vmytycykt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 19:34:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inerm-0007AY-Vc
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 19:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463AbXKASdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 14:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753340AbXKASdn
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 14:33:43 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36706 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752824AbXKASdn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Nov 2007 14:33:43 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA1IXEMi016993
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 Nov 2007 11:33:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA1IXDCB009756;
	Thu, 1 Nov 2007 11:33:14 -0700
In-Reply-To: <7vmytycykt.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-2.393 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_33,TW_QD
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62982>



On Wed, 31 Oct 2007, Junio C Hamano wrote:
> 
> * ph/parseopt (Tue Oct 30 14:15:21 2007 -0500) 23 commits
>  + ...
> 
> It appears 1.5.4 will be, to a certain extent, a "Let's clean up
> the internal implementation" release.  This series should become
> part of it.  Hopefully will merge to 'master' soon, but I
> haven't looked this series very closely yet.

I certainly think this should go in, but it does make one deficiency 
painfully clear: the remaining shell scripts end up having all the old 
flags behaviour.

So while you can combine flags for *most* programs, you still won't 
be able to say things like

	git clean -qdx

just because that's still a shellscript, and doing any fancy argument 
parsing in shell is just painful.

Is somebody still working on doing the shell->C conversion?

		Linus
