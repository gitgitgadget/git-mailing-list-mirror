From: Jeff King <peff@peff.net>
Subject: Re: Make author and committer available to pre-commit hook
Date: Mon, 5 Jul 2010 07:46:19 -0400
Message-ID: <20100705114619.GA21146@sigill.intra.peff.net>
References: <AANLkTinpCDRf_Yhuj2-tdZwmvHk8yna1Xjdtbrmx35CB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Gisle Aas <gisle@aas.no>
X-From: git-owner@vger.kernel.org Mon Jul 05 13:46:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVk84-0005eY-6G
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 13:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415Ab0GELqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 07:46:23 -0400
Received: from peff.net ([208.65.91.99]:49138 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831Ab0GELqX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 07:46:23 -0400
Received: (qmail 11877 invoked by uid 107); 5 Jul 2010 11:47:18 -0000
Received: from c-67-172-213-4.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.213.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 05 Jul 2010 07:47:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Jul 2010 07:46:19 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinpCDRf_Yhuj2-tdZwmvHk8yna1Xjdtbrmx35CB@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150258>

On Mon, Jul 05, 2010 at 01:30:46PM +0200, Gisle Aas wrote:

> I would like to implement a pre-commit hook that validates the
> --author set for the commit.  Our use case is a shared repository of
> configuration info where different persons all commit as root; but we
> want to make sure they override the --author to something sensible.
> 
> What would be the preferred mechanism to pass on this information?  It
> could for instance be arguments to the hook script or via environment
> variables.

It would make sense to me for it to be passed in through the environment
using GIT_{AUTHOR,COMMITTER}_{NAME,EMAIL}. You could even pass
GIT_AUTHOR_DATE to detect if somebody is using "git commit -c" to get
the date from a previous commit.

-Peff
