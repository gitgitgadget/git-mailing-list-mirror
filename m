From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Invalid refspec?
Date: Thu, 20 Mar 2008 13:12:38 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803201256080.19665@iabervon.org>
References: <2008-03-20-11-53-31+trackit+sam@rfc1149.net> <alpine.LNX.1.00.0803200914420.19665@iabervon.org> <7vy78dwdh2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Samuel Tardieu <sam@rfc1149.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 18:13:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcOKo-00052m-Cd
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 18:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756934AbYCTRNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 13:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755958AbYCTRNE
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 13:13:04 -0400
Received: from iabervon.org ([66.92.72.58]:56618 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756934AbYCTRND (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 13:13:03 -0400
Received: (qmail 30133 invoked by uid 1000); 20 Mar 2008 17:12:38 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Mar 2008 17:12:38 -0000
In-Reply-To: <7vy78dwdh2.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77676>

On Thu, 20 Mar 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > We need a test for the src being an object name around line 443 in 
> > remote.c; I'll have something this evening if nobody beats me to it.
> 
> Careful.  That is ONLY valid for pushes.  For fetches, you are allowed to
> name existing refs and nothing else.

I think it's okay to make "HEAD~1:foo" *valid* a fetch refspec; it'll be 
rejected a bit further along, but there's no particular need to give a 
different error for "HEAD~1:foo" versus 
"e83c5163316f89bfbde7d9ab23ca2e25604af290:foo" based on the presence of a 
~. Sure, we can figure out a little bit earlier that it's not going to 
work, but I don't think that's really enough to make it important that 
parse_ref_spec reject it.

	-Daniel
*This .sig left intentionally blank*
