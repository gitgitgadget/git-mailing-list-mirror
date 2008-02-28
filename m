From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: warning: no common commits - slow pull
Date: Thu, 28 Feb 2008 13:36:56 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802281331220.19665@iabervon.org>
References: <200802102007.38838.lenb@kernel.org> <20080211035501.GB26205@mit.edu> <200802151643.30232.lenb@kernel.org> <200802261438.17014.lenb@kernel.org> <7vir0byoc2.fsf@gitster.siamese.dyndns.org> <7voda2yksf.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802271411280.19665@iabervon.org> <7vskzeruit.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802271605540.19665@iabervon.org> <7voda1nbzc.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802281026030.19665@iabervon.org>
 <7vy795j7d2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Len Brown <lenb@kernel.org>,
	Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 19:38:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUndQ-0004gT-KS
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 19:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbYB1ShA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 13:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbYB1Sg7
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 13:36:59 -0500
Received: from iabervon.org ([66.92.72.58]:46370 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915AbYB1Sg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 13:36:59 -0500
Received: (qmail 15755 invoked by uid 1000); 28 Feb 2008 18:36:56 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Feb 2008 18:36:56 -0000
In-Reply-To: <7vy795j7d2.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75432>

On Thu, 28 Feb 2008, Junio C Hamano wrote:

> Another potential problem area is if find_common() does the
> right thing when it is called for the second time.  I did not
> check if you clear COMMON, SEEN, COMPLETE etc. bits from the
> object database before initiating the second round, but if you
> didn't, I am afraid these bits left over from the primary
> transfer might interfere the common ancestor discovery during
> the second round.

Absolutely; that was actually my first guess at why it was failing, and I 
think it's a necessary aspect to the failure. Let me see if I can get your 
test case to exhibit the problem for me and look into it further.

	-Daniel
*This .sig left intentionally blank*
