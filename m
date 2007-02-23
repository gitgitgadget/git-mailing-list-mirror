From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-push hook to update remote working copy safely
Date: Fri, 23 Feb 2007 19:13:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702231910270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1172220709.10221.1176113191@webmail.messagingengine.com>     
 <7v649t5ebq.fsf@assigned-by-dhcp.cox.net>     
 <1172248500.32514.1176151445@webmail.messagingengine.com>     
 <Pine.LNX.4.63.0702231737300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <1172250283.5505.1176180417@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sam Watkins <swatkins@fastmail.fm>
X-From: git-owner@vger.kernel.org Fri Feb 23 19:14:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKew5-0007HO-3w
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 19:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933158AbXBWSNi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 13:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933131AbXBWSNi
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 13:13:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:58211 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933158AbXBWSNh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 13:13:37 -0500
Received: (qmail invoked by alias); 23 Feb 2007 18:13:35 -0000
X-Provags-ID: V01U2FsdGVkX19DM042OkRDT8ef+dYkPd1bZTPGgV3+3s2bKrTrYJ
	FN7g==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <1172250283.5505.1176180417@webmail.messagingengine.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40457>

Hi,

On Sat, 24 Feb 2007, Sam Watkins wrote:

> On Fri, 23 Feb 2007 17:40:02 +0100 (CET), "Johannes Schindelin"
> <Johannes.Schindelin@gmx.de> said:
> >
> > On Sat, 24 Feb 2007, Sam Watkins wrote:
> >
> > > it should merge the changes as if I'd run git-pull on the remote
> > > box, and handle conflicts in the same way.
> >
> > But that leaves conflicts in the working directory! You _have_ to
> > resolve them (or reset) before proceding.
> 
> I think it's ok for our application if the push+hook leaves conflicts in 
> the working directory, I just want to replicate the effect of running 
> git-pull remotely without actually having to go through ssh contortions 
> to achieve that.

I don't really see what you want to do there (and you don't want to tell 
me:-)). Nevertheless, it seems that Junio's script would help you. You 
cannot run a pull sanely when the working directory is dirty, and 
therefore the hook does not allow that.

BTW the easiest way to do what you apparently want is to push to a 
"remotely tracking" branch, i.e. a branch in the remotes/ hierarchy, and 
_then_ make an update hook which says "git merge remotes/<uploadbranch>".

Ciao,
Dscho
