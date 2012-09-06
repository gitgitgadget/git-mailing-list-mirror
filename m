From: Jeff King <peff@peff.net>
Subject: Re: git blame --follow
Date: Thu, 6 Sep 2012 05:58:04 -0400
Message-ID: <20120906095804.GA15277@sigill.intra.peff.net>
References: <k29hpo$3av$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "norbert.nemec" <norbert.nemec@native-instruments.de>
X-From: git-owner@vger.kernel.org Thu Sep 06 11:58:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9Yqp-0004fw-0a
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 11:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358Ab2IFJ6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 05:58:12 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59624 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398Ab2IFJ6K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 05:58:10 -0400
Received: (qmail 19349 invoked by uid 107); 6 Sep 2012 09:58:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Sep 2012 05:58:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2012 05:58:04 -0400
Content-Disposition: inline
In-Reply-To: <k29hpo$3av$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204872>

On Thu, Sep 06, 2012 at 09:02:17AM +0200, norbert.nemec wrote:

> 'git blame --follow' seems to be undocumented. The exact behavior is
> not clear to me. Perhaps an alias for some combination of '-C' and
> '-M'? It seems not be be fully consistent with 'git log --follow'.
> 
> Could someone clarify? Did I miss something?

I don't think it was ever intended to do anything; the only reason it is
not rejected outright is that "blame" piggy-backs on the regular
revision option parser used by "log" and others.

What would you expect it to do?

I can't think of a sane behavior for "blame --follow". The follow code
is about tweaking path-limiting during traversal, but blame does not use
pathspecs. It tracks content, and the "-C" option already instructs it to
look across file boundaries.

-Peff
