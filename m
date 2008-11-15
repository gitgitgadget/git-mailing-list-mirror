From: Jeff King <peff@peff.net>
Subject: Re: "secret key not available". "unable to sign the tag".
Date: Fri, 14 Nov 2008 22:57:43 -0500
Message-ID: <20081115035743.GA19633@coredump.intra.peff.net>
References: <823128.71540.qm@web37902.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Gary Yang <garyyang6@yahoo.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 04:59:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1CJP-0007sn-AD
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 04:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbYKOD5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 22:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbYKOD5r
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 22:57:47 -0500
Received: from peff.net ([208.65.91.99]:3614 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854AbYKOD5q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 22:57:46 -0500
Received: (qmail 3564 invoked by uid 111); 15 Nov 2008 03:57:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 14 Nov 2008 22:57:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Nov 2008 22:57:43 -0500
Content-Disposition: inline
In-Reply-To: <823128.71540.qm@web37902.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101043>

On Fri, Nov 14, 2008 at 03:28:44PM -0800, Gary Yang wrote:

> I got errors and warnings when I used "git tag -s my-tag". It says,
> "secret key not available". "unable to sign the tag". 

Probably because it can't find your secret key, like it says.

> gpg: please see http://www.gnupg.org/faq.html for more information
> gpg: skipped `Gary Yang <gyang@linux123.(none)>': secret key not available
> gpg: signing failed: secret key not available
> error: gpg failed to sign the tag
> fatal: unable to sign the tag
> 
> I ran "gpg --gen-key" and generated keypair. But, still got the same
> error. Please help.

Did the key you generated have the email address
"gyang@linux123.(none)"? If not, then that is your problem.

You need to tell git who you are, since it is unable to deduce it from
doing host lookups. Try:

  git config --global user.email garyyang6@yahoo.com

or whatever email address you used when you created the key, and then
gpg should find it appropriately.

-Peff
