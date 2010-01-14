From: Jeff King <peff@peff.net>
Subject: Re: Gitignore matching "git add" wildcard prevents operation
Date: Thu, 14 Jan 2010 15:39:28 -0500
Message-ID: <20100114203928.GA26883@coredump.intra.peff.net>
References: <4B4F6000.4070005@sofistes.net>
 <20100114195234.GA26684@coredump.intra.peff.net>
 <7vljg0bfox.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marko Poutiainen <regs@sofistes.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 21:39:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVWTf-00062n-Da
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 21:39:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159Ab0ANUjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 15:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755739Ab0ANUjb
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 15:39:31 -0500
Received: from peff.net ([208.65.91.99]:57887 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754938Ab0ANUja (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 15:39:30 -0500
Received: (qmail 14824 invoked by uid 107); 14 Jan 2010 20:44:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 14 Jan 2010 15:44:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jan 2010 15:39:28 -0500
Content-Disposition: inline
In-Reply-To: <7vljg0bfox.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137021>

On Thu, Jan 14, 2010 at 12:21:34PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... But there is no way to
> > use the shell wildcard and get the behavior you want (not even a "git
> > add --really-ignore-my-ignores a.*").
> 
> Perhaps you want to run
> 
> 	$ git add 'a.*'
> 
> Notice that the wildcard is protected from the shell.

Ugh. You're right that it does work, but I don't expect users to make
the intuitive jump from the OP's problem to this solution (I certainly
didn't). In particular:

  1. Most programs don't take their own globs. Without knowing that git
     can do so, there is no reason to discover it in this instance. I
     can see searching the manpage for options, but not for a discussion
     of globbing behavior.

  2. They would have to know that using a git-glob will magically change
     the error-checking behavior.

-Peff
