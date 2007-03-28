From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: fix pretty-printing of messages with "\nencoding "
Date: Wed, 28 Mar 2007 18:15:17 -0400
Message-ID: <20070328221517.GA25430@coredump.intra.peff.net>
References: <20070328215209.GA13672@coredump.intra.peff.net> <7v7it1f29s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 00:15:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWgQN-0004Ex-Om
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 00:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933762AbXC1WPV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 18:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933822AbXC1WPV
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 18:15:21 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2093 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933762AbXC1WPU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 18:15:20 -0400
Received: (qmail 14888 invoked from network); 28 Mar 2007 22:15:50 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 28 Mar 2007 22:15:50 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2007 18:15:17 -0400
Content-Disposition: inline
In-Reply-To: <7v7it1f29s.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43396>

On Wed, Mar 28, 2007 at 03:10:07PM -0700, Junio C Hamano wrote:

> The function is correct; the only reason it may recode to
> non-utf8 is the user (or Porcelain such as qgit or gitk)
> explicitly asked to do so -- from the final output they will get
> the message in user-native encoding and without the extra
> encoding header, thus we retain the backward compatible
> behaviour before the re-encoding feature was introduced.

I see. But then why do we not simply strip the encoding header entirely,
and return in native format? Why do we insert a new encoding header
_only_ when there was one previously?

-Peff
