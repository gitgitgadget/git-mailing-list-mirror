From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] Add password parameter to git svn commands and use
 it when provided instead of defaulting to end-user prompt
Date: Mon, 14 Oct 2013 23:35:56 +0000
Message-ID: <20131014233556.GA31230@dcvr.yhbt.net>
References: <1381569810-2167-1-git-send-email-arnaud.brejeon@gmail.com>
 <20131014141127.GA21200@google.com>
 <20131014184005.GA3352@dcvr.yhbt.net>
 <20131014223602.GB12116@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, arnaud.brejeon@gmail.com,
	git@vger.kernel.org, matthijs@stdin.nl
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 15 01:36:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVrg9-0000qr-6Q
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 01:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757792Ab3JNXf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 19:35:57 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59072 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757774Ab3JNXf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 19:35:57 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id B689244C004;
	Mon, 14 Oct 2013 23:35:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20131014223602.GB12116@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236150>

Jeff King <peff@peff.net> wrote:
> On Mon, Oct 14, 2013 at 06:40:05PM +0000, Eric Wong wrote:
> 
> > > arnaud.brejeon@gmail.com wrote:
> > > 
> > > > Signed-off-by: Arnaud Brejeon <arnaud.brejeon <at> gmail.com>
> > > 
> > > Thanks.
> > > 
> > > Can you say a little more about the context?  Do you run a script that
> > > wants to pass a password to 'git svn', do you type it each time on the
> > > command line, or something else?  Is it ok that the password would
> > > show up in "ps" output?  Would the platform's keyring or netrc be
> > > usable here, or is there something in the context that avoids that?
> > 
> > I think using keyring or netrc is more appropriate.  Having a password
> > on the command-line and visible to all via ps doesn't seem like
> > something git should support.
> 
> Agreed. We have ready-made git-credential helpers to handle this exact
> problem. We would need to convert SVN::Prompt to use git-credential
> rather than prompting itself, though. One of the things that held me
> back from writing such a patch is that I thought libsvn already handled
> things like keychain integration, and it was better for git-svn to be
> more svn-like than git-like in its access of SVN repos.
> 
> Are those already supported out of the box by libsvn? If git's
> credential helpers are significantly more featureful, it might be worth
> converting, but if not, I think it makes sense to stay with svn's
> existing code.

I looks like this patch was forgotten once again:

http://mid.gmane.org/1371573490-21973-1-git-send-email-matthijs@stdin.nl

Matthijs: can you add a Signed-off-by for your patch?  I'm inclined to
push it to Junio as-is since it looks reasonable.
I admit I don't know SVN callbacks anymore well enough and don't have
time to test with GNOME.
