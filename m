From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] fetch: make --prune configurable
Date: Mon, 8 Jul 2013 23:50:08 -0400
Message-ID: <20130709035008.GA27903@sigill.intra.peff.net>
References: <1373288217-20580-1-git-send-email-mschub@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 05:50:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwOwn-0007kc-P1
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 05:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845Ab3GIDuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 23:50:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:35024 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026Ab3GIDuM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 23:50:12 -0400
Received: (qmail 32361 invoked by uid 102); 9 Jul 2013 03:51:27 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Jul 2013 22:51:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Jul 2013 23:50:08 -0400
Content-Disposition: inline
In-Reply-To: <1373288217-20580-1-git-send-email-mschub@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229903>

On Mon, Jul 08, 2013 at 02:56:57PM +0200, Michael Schubert wrote:

> $gmane/201715 brought up the idea to fetch --prune by default.
> Since --prune is a "potentially destructive operation" (Git doesn't
> keep reflogs for deleted references yet), we don't want to prune
> without users consent.
> 
> To accommodate users who want to either prune always or when fetching
> from a particular remote, add two new configuration variables
> "fetch.prune" and "remote.<name>.prune":
> 
>  - "fetch.prune" allows to enable prune for all fetch operations.
> 
>  - "remote.<name>.prune" allows to change the behaviour per remote.

Thanks. As the person who brought up the destructive nature of --prune
in the thread you mentioned, I have no problem at all with doing
something like this, where the user gets to make the choice. And it is
even a good building block if we later do have deleted-branch reflogs;
we can just flip the default from "off" to "on".

In the meantime, I don't know if it is worth mentioning in the
documentation that the remote branches are hard to get back. On the one
hand, it is the (or at least a) reason why the default is not "on". But
it is also far from the only place refs get deleted, so I don't know if
it is worth calling attention to it specifically.

-Peff
