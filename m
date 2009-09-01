From: Jeff King <peff@peff.net>
Subject: Re: stash --dwim safety
Date: Tue, 1 Sep 2009 02:57:16 -0400
Message-ID: <20090901065716.GA5575@sigill.intra.peff.net>
References: <7viqg48nxi.fsf@alter.siamese.dyndns.org>
 <7v3a77dx5b.fsf@alter.siamese.dyndns.org>
 <vpqocpv2n93.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Sep 01 08:57:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiNJ0-0006u0-KK
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 08:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbZIAG5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 02:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752013AbZIAG5Q
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 02:57:16 -0400
Received: from peff.net ([208.65.91.99]:52140 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856AbZIAG5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 02:57:16 -0400
Received: (qmail 30698 invoked by uid 107); 1 Sep 2009 06:57:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Sep 2009 02:57:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Sep 2009 02:57:16 -0400
Content-Disposition: inline
In-Reply-To: <vpqocpv2n93.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127526>

On Tue, Sep 01, 2009 at 08:27:20AM +0200, Matthieu Moy wrote:

> I was actually thinking of being a little more paranoid to prevent
> accidental "stash save": we could refuse to create a named stash when
> the "save" command is not given. The case I hadn't thought of was "git
> stash -q apply", which has 99% chances of being a typo for "git stash
> apply -q", and which would mean "create a stash named apply, quietly".

I like that. I think it addresses Dscho's concern with mistakes causing
an unexpected stash, and it is actually more consistent with the current
rule (that named stashes need an explicit 'save'). IOW, it is actually a
bit confusing that "git stash foo" doesn't work, but "git stash -k foo"
does.

-Peff
