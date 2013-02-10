From: Jeff King <peff@peff.net>
Subject: Re: Git prompt
Date: Sun, 10 Feb 2013 17:43:45 -0500
Message-ID: <20130210224345.GA32318@sigill.intra.peff.net>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130210212538.GA11720@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@MIT.EDU>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:44:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4fdE-0005f4-HV
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 23:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756912Ab3BJWn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 17:43:57 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43807 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756854Ab3BJWn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 17:43:56 -0500
Received: (qmail 15873 invoked by uid 107); 10 Feb 2013 22:45:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 10 Feb 2013 17:45:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Feb 2013 17:43:45 -0500
Content-Disposition: inline
In-Reply-To: <20130210212538.GA11720@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215961>

On Sun, Feb 10, 2013 at 01:25:38PM -0800, Jonathan Nieder wrote:

> Ethan Reesor wrote:
> 
> > I have a git user set up on my server. It's prompt is set to
> > git-prompt and it's git-shell-commands is empty.
> [...]
> > How do I make the git user work like github where, upon attempting to
> > get a prompt, the connection is closed?
> 
> I assume you mean that the user's login shell is git-shell.
> 
> You can disable interactive logins by removing the
> ~/git-shell-commands/ directory.  Unfortunately that doesn't let you
> customize the message.  Perhaps it would make sense to teach shell.c
> to look for a
> 
> 	[shell]
> 		greeting = 'Hi %(username)! You've successfully authenticated, but I do not provide interactive shell access.'
> 
> setting in git's config file.  What do you think?

I think something like that makes sense. To my knowledge there is no way
with stock git to customize git-shell's output (at GitHub, that message
comes from our front-end routing process before you even hit git-shell
on our backend machines).

The "username" in our version of the message comes from a database
mapping public keys to GitHub users, not the Unix username.  But I
suspect sites running stock Git would be happy enough to have
%(username) map to the actual Unix username.

-Peff
