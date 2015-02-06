From: Jeff King <peff@peff.net>
Subject: Re: BUG: 'error: invalid key: pager.show_ref' on 'git show_ref'
Date: Fri, 6 Feb 2015 15:39:03 -0500
Message-ID: <20150206203902.GB10857@peff.net>
References: <20150206124528.GA18859@inner.h.apk.li>
 <20150206193313.GA4220@peff.net>
 <xmqqbnl6hljt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Krey <a.krey@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 21:39:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJpgF-0002lg-PW
	for gcvg-git-2@plane.gmane.org; Fri, 06 Feb 2015 21:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755257AbbBFUjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2015 15:39:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:46112 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754459AbbBFUjG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2015 15:39:06 -0500
Received: (qmail 6450 invoked by uid 102); 6 Feb 2015 20:39:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Feb 2015 14:39:05 -0600
Received: (qmail 11612 invoked by uid 107); 6 Feb 2015 20:39:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Feb 2015 15:39:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Feb 2015 15:39:03 -0500
Content-Disposition: inline
In-Reply-To: <xmqqbnl6hljt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263426>

On Fri, Feb 06, 2015 at 11:44:38AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Feb 06, 2015 at 01:45:28PM +0100, Andreas Krey wrote:
> >
> >>   $ git show_ref
> >>   error: invalid key: pager.show_ref
> >>   error: invalid key: alias.show_ref
> >>   git: 'show_ref' is not a git command. See 'git --help'.
> >> 
> >> Apparently we need to squelch this message from
> >> within git_config_get_* in this case?
> > ...
> > So it is not a new problem, but it is a bug that you
> > cannot set pager config for such a command or alias.
> 
> Hmm, I think these are two separate issues.

Yeah, sorry, if I wasn't clear. The error messages are definitely a
separate and newer issue, and need to be silenced one way or the other.
It is just that they are notifying us of a deeper problem that has
existed for a long time, and it probably makes sense to deal with both.

-Peff
