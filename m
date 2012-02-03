From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] t0300-credentials: Word around a solaris /bin/sh bug
Date: Fri, 03 Feb 2012 17:00:34 -0500
Message-ID: <1328306228-sup-8799@pinkfloyd.chass.utoronto.ca>
References: <1328211135-25217-1-git-send-email-bwalton@artsci.utoronto.ca> <20120202200240.GC9246@sigill.intra.peff.net> <7vr4ycu3ty.fsf@alter.siamese.dyndns.org> <20120203120657.GB31441@sigill.intra.peff.net> <7v7h03odyo.fsf@alter.siamese.dyndns.org> <20120203212604.GA1890@sigill.intra.peff.net> <7vr4ybmvrq.fsf@alter.siamese.dyndns.org> <20120203215507.GB3472@sigill.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 23:00:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtRBQ-0000EG-F4
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 23:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755911Ab2BCWAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 17:00:35 -0500
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:52796 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab2BCWAf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 17:00:35 -0500
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:49990 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RtRBK-0006mV-AS; Fri, 03 Feb 2012 17:00:34 -0500
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RtRBK-0002SN-9S; Fri, 03 Feb 2012 17:00:34 -0500
In-reply-to: <20120203215507.GB3472@sigill.intra.peff.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189813>

Excerpts from Jeff King's message of Fri Feb 03 16:55:07 -0500 2012:

> >     write_script () {
> >         case "$#" in
> >         1)    case "$1" in
> >             *.perl | *.pl) echo "#!$PERL_PATH" ;;
> >             *) echo "#!$SHELL_PATH" ;;
> >             esac
> >                 2)    echo "#!$2" ;;
> >         *)    BUG ;;
> >                 esac >"$1" &&
> >                 cat >>"$1" &&
> >                 chmod +x "$1"
> >     }
> > 
> 
> Nice. I was going to suggest a wrapper like "write_sh_script" so you
> didn't have to spell out $SHELL_PATH, but I think the auto-detection
> makes sense (and falling back to shell makes even more sense, as that
> covers 99% of the cases anyway).

This looks like a very nice, general purpose, solution to the problem.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
