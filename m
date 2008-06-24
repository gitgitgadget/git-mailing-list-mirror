From: Ian Hilt <Ian.Hilt@gmx.com>
Subject: Re: [PATCH] pre-commit hook should ignore carriage returns at EOL
Date: Tue, 24 Jun 2008 15:54:49 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806241548140.32759@sys-0.hiltweb.site>
References: <53A5AFCF-94C7-465E-A181-1DA69F251F5B@gmail.com> <alpine.LFD.1.10.0806241418360.32759@sys-0.hiltweb.site> <m363rylknc.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ian Hilt <Ian.Hilt@gmx.com>, Christian Holtje <docwhat@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 21:55:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBEc8-0002Xa-Ia
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 21:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbYFXTyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 15:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752586AbYFXTyp
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 15:54:45 -0400
Received: from mail.gmx.com ([74.208.5.67]:48372 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752222AbYFXTyo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 15:54:44 -0400
Received: (qmail invoked by alias); 24 Jun 2008 19:54:43 -0000
Received: from cpe-75-185-208-72.woh.res.rr.com (EHLO [192.168.1.1]) [75.185.208.72]
  by mail.gmx.com (mp-us001) with SMTP; 24 Jun 2008 15:54:43 -0400
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX1/HoQE3/qLHWeOzk0zOxWS1iu/8IFlzXdSqSE1/e5
	K/Et7W+iCJYJeO
In-Reply-To: <m363rylknc.fsf@localhost.localdomain>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86130>

On Tue, 24 Jun 2008 at 12:05pm -0700, Jakub Narebski wrote:

> I don't think so, because you want next to test for whitespace
> where it _doesn't_ end in \r, i.e. this condition is here
> because of the 'else' clause.  IIRC.

What I'm suggesting is this,

	if (/\s\r$/) {
		bad_line("trailing whitespace", $_);
	} else {
		if (/\s$/) {
			bad_line("trailing whitespace", $_);
		}
	}

Why only test for \r when all you want to know is whether there is
whitespace before \r ?  If there isn't whitespace and \r at the end of a
line, then only test for whitespace at the end of a line.


-- 
Ian Hilt
Ian.Hilt (at) gmx.com
GnuPG key: 0x4AFC1EE3
