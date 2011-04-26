From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH] fetch: show remote name instead of URL if available
Date: Tue, 26 Apr 2011 13:36:26 -0400
Message-ID: <1303839386.18603.19.camel@drew-northup.unet.maine.edu>
References: <1303830807-21966-1-git-send-email-dpmcgee@gmail.com>
	 <7v1v0ogbnn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Dan McGee <dpmcgee@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:40:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEmFp-00079K-Jo
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 19:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757856Ab1DZRkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 13:40:49 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:37969 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757829Ab1DZRks (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 13:40:48 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p3QHaWYA001260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 26 Apr 2011 13:36:37 -0400
In-Reply-To: <7v1v0ogbnn.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=3
	Fuz1=3 Fuz2=3
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p3QHaWYA001260
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1304444295.53013@t/1wQB5+8eRIOw2qhSmcKw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172118>


On Tue, 2011-04-26 at 10:33 -0700, Junio C Hamano wrote:
> Dan McGee <dpmcgee@gmail.com> writes:
> 
> >     $ git fetch -v
> >     From git://git.kernel.org/pub/scm/git/git
> >      = [up to date]      html       -> origin/html
> >     ...
> 
> I see this full URL output as a nice reminder of what "origin" refers to,
> especially when you said "git fetch -v origin".  This is especially useful
> when you are fetching from different locations that house repositories of
> the same project (e.g. among my multiple git.git working trees on my
> notebook, some of them fetch from my private, primaty development machine
> and others from public k.org).
> 
> Changing this output ...
> 
> > Versus the new output:
> >
> >     $ ./git fetch -v
> >     From origin
> 
> ... this way feels like a regression to me.
> 
> > Alternatively, we could do something like
> >     From origin (git://git.kernel.org/pub/scm/git/git)
> 
> That is much less problematic.
> 
> But let's step back a bit.  What problem are you trying to solve?
> 
> Are you trying to give a reminder that you are interacting with 'origin'
> when you said "git fetch -v" without saying where you are fetching from?
> I think that is a good thing to aim for (the same reasoning behind the
> comment of mine above).  If so, the ideal change from my gut feeling is to
> add an extra " (origin)" at the end, like so:
> 
> 	From git://git.kernel.org/pub/scm/git/git (origin)
> 
> when and only when the fetch is done without mentioning any remote
> nickname; iow, "git fetch -v origin" or "git fetch -v git://.../git" won't
> get the extra " (origin)" at the end.

I was about to compose mail to the same effect, so I'll just agree
instead.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
