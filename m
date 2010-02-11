From: Jeff King <peff@peff.net>
Subject: Re: git cherry-pick --continue?
Date: Thu, 11 Feb 2010 14:32:48 -0500
Message-ID: <20100211193248.GA27072@coredump.intra.peff.net>
References: <fabb9a1e1002101237i60a0b2c5j6d1e52b33dacbaa2@mail.gmail.com>
 <20100210210419.GA7728@coredump.intra.peff.net>
 <20100210212408.GB7728@coredump.intra.peff.net>
 <7v63644uoq.fsf@alter.siamese.dyndns.org>
 <7vbpfw3f6t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 20:32:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfemV-0005BY-2t
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 20:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756874Ab0BKTcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 14:32:48 -0500
Received: from peff.net ([208.65.91.99]:54606 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756843Ab0BKTcr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 14:32:47 -0500
Received: (qmail 20462 invoked by uid 107); 11 Feb 2010 19:32:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 11 Feb 2010 14:32:55 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Feb 2010 14:32:48 -0500
Content-Disposition: inline
In-Reply-To: <7vbpfw3f6t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139619>

On Wed, Feb 10, 2010 at 02:21:14PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jeff King <peff@peff.net> writes:
> >
> >> Hmm. I was thinking "am" was the odd man out, but really there are only
> >> two sequencer commands that I noted: rebase and am. So you could perhaps
> >> argue that rebase should also learn "--resolved". Or am I forgetting
> >> one?
> 
> Having said all I did in the previous message, I think "am --continue"
> would be a good addition.

OK. I agree with your philosophical ramblings in the previous message,
but I also think there is some value in making it simple for the user to
remember.

Do you just want to pick up my patch from earlier in the thread, or do
you have further comments? The only thing I could think to change would
be that we may not want to even bother advertising --continue in the
usage message (conversely, we could go a step further and actually
advertise it in the manpage).

> And "rebase --resolved" would not make any sense if the reason the control
> is given back to you was because you ran "rebase -i" and marked a commit
> to be "edit"ed.  Of course, we could add "--resolved" and "--edited" (or
> perhaps "--amended") to "rebase", and have it make sure that the correct
> one is given.  For example, when it stopped for "edit", it would reject
> "rebase --resolved".  But I do not think it is worth the hassle.

Agreed.

-Peff
