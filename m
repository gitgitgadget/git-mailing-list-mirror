From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] ignore unknown color configuration
Date: Sat, 12 Dec 2009 17:20:47 -0500
Message-ID: <20091212222046.GA25973@coredump.intra.peff.net>
References: <20091212122524.GA17547@coredump.intra.peff.net>
 <7vzl5nn9x2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 03:21:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJe50-0002gl-0O
	for gcvg-git-2@lo.gmane.org; Sun, 13 Dec 2009 03:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbZLMCUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2009 21:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbZLMCUx
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 21:20:53 -0500
Received: from peff.net ([208.65.91.99]:51776 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932158AbZLMCUw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2009 21:20:52 -0500
Received: (qmail 11246 invoked by uid 107); 12 Dec 2009 22:25:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 12 Dec 2009 17:25:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Dec 2009 17:20:47 -0500
Content-Disposition: inline
In-Reply-To: <7vzl5nn9x2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135148>

On Sat, Dec 12, 2009 at 01:45:45PM -0800, Junio C Hamano wrote:

> This is a sane thing to do, as "slot" is part of the name of the variable,
> and we generally do not warn upon seeing a misspelled variable name (it
> makes it worse that "func" is not even misspelled but merely unknown to
> older version of git in your scenario).
> 
> On the other hand, I suspect that most people would apprecfiate if their
> git pointed out "diff.color.finc?  What do you mean?"  before they waste
> 30 minutes wondering why the new feature in 1.6.6 does not work for them.

I would be more sympathetic to that user if this weren't the _only_ set
of variables with this property. They don't get warned for diff.externel
or color.show-branch.

If we are going to declare subsets of the namespace as "complete" (and
warn about unknown keys in them), then we should probably be more
thorough about it (but I don't personally think that is a good idea, as
version portability is IMHO more useful).

-Peff
