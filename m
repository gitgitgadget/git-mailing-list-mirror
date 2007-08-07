From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when
 contents are unchanged
Date: Tue, 07 Aug 2007 14:39:28 +0800
Message-ID: <46B813A0.4040305@midwinter.com>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net> <vpqhcni47ek.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021050500.14781@racer.site> <vpqbqdq45ua.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021147110.14781@racer.site> <AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca> <Pine.LNX.4.64.0708021541520.14781@racer.site> <46B1F3F4.5030504@midwinter.com> <Pine.LNX.4.64.0708021614420.14781@racer.site> <20070803053717.GA16379@midwinter.com> <alpine.LFD.0.999.0708062118190.5037@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jean-Fran?ois Veillette <jean_francois_veillette@yahoo.ca>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 07 08:39:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIIjB-0007s1-M8
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 08:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbXHGGjd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 02:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbXHGGjd
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 02:39:33 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:46284 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752954AbXHGGjd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 02:39:33 -0400
Received: (qmail 30356 invoked from network); 7 Aug 2007 06:39:32 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=rOIRYdu1pwB57xbh8PCrTXB9P35BJ3Y822XJ9013AkFhbUsrdHAiH3umT3EmqQWG  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 7 Aug 2007 06:39:32 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <alpine.LFD.0.999.0708062118190.5037@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55225>

Linus Torvalds wrote:
> Doing a "git diff" cannot actually update the index (since it very much 
> has to work on a read-only setup too), which is why the index _stays_ 
> stale unless something is done (eg "git status") to refresh it. 

Another thought: How about if git-diff *tries* to update the index if 
needed, but failure to do so is not treated as an error condition? That 
seems like the best of both worlds to me: git would self-correct a 
potential performance problem without user intervention, while still 
working properly in a read-only environment.

-Steve
