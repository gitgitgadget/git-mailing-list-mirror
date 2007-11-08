From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH 0/5] some shell portability fixes
Date: Thu, 8 Nov 2007 07:14:56 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071108061456.GA28509@ins.uni-bonn.de>
References: <20071106201518.GA6361@ins.uni-bonn.de> <7v8x5bgl04.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0711070758w5832ab83ic16e8fb4edb80972@mail.gmail.com> <fcaeb9bf0711070805x49228d8dq7e8e6f26060c47ab@mail.gmail.com> <7v3avhbxdq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 07:15:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq0fc-0000I8-5o
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 07:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbXKHGPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 01:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbXKHGPA
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 01:15:00 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:42659 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbXKHGO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 01:14:59 -0500
Received: from localhost.localdomain (xdsl-87-78-134-79.netcologne.de [87.78.134.79])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id D3C7A400002BE;
	Thu,  8 Nov 2007 07:14:57 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1Iq0fI-0007QF-PC; Thu, 08 Nov 2007 07:14:56 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v3avhbxdq.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63936>

* Junio C Hamano wrote on Wed, Nov 07, 2007 at 09:42:41PM CET:
> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
> >
> > Argh, should have made it clear, busybox sed is good enough.
> 
> Thanks.  And you can also happy grok Ralf's rewritten construct,
> right?
> 
> That is, existing
> 
>         $ sed -e 's/foo/\n/' file
> 
> will be rewritten by the patch [2/5] to
> 
>         $ sed -e 's/foo/\
>         /' file

The original was something like
  sed 's/[|]/\n/g'

Using instead
  tr '|' '\n'

should work for the original construct, and AFAIK only /usr/ucb/tr on
Solaris fails to understand \n correctly.  Would that be better for you?
Or even
  tr '|' '\012'

which fails only on EBCDIC, which I don't think git targets.

I'll resend the patches tonight.

Cheers,
Ralf
