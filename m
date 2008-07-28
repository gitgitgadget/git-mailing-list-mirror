From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Adding custom hooks to a bare repository.
Date: Mon, 28 Jul 2008 14:40:19 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807281438220.2725@eeepc-johanness>
References: <18071eea0807280404w3365748cjcd11f536bf5d27eb@mail.gmail.com>  <alpine.DEB.1.00.0807281324350.2725@eeepc-johanness> <18071eea0807280532l69d12e3ehb8377da9d24e035@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git mailing list <git@vger.kernel.org>
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 14:40:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNS1O-0001hG-V5
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 14:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbYG1MjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 08:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752284AbYG1MjO
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 08:39:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:52431 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751816AbYG1MjN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 08:39:13 -0400
Received: (qmail invoked by alias); 28 Jul 2008 12:39:11 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp057) with SMTP; 28 Jul 2008 14:39:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19p+CUh2vVpSJXsbcFVlfU1S687I0MkZpb4L+JZCI
	+280zDPlxCUXeZ
X-X-Sender: user@eeepc-johanness
In-Reply-To: <18071eea0807280532l69d12e3ehb8377da9d24e035@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90452>

Hi,

On Mon, 28 Jul 2008, Thomas Adam wrote:

> 2008/7/28 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>
> > Yes.  Hooks, just as the config and reflogs, are supposed to be local 
> > things.  Rationale being: it is rude, and also insecure, to install 
> > something that potentially calls other programs without the user 
> > saying so.
> 
> Oh absolutely, I agree with that.
> 
> > All you can do is checking in a copy of the hook, and ask your 
> > users/check in your build system that it is installed.
> 
> Hmm -- perhaps I am being unintentionally dense, but I am assuming
> that when you say "checking in a copy" you mean anywhere other than
> .git/hooks/ since that isn't tracked by git.  I have no problem with
> the rationale you've just described -- but it would be handy to add
> this post-merge hook script into hooks/ (exec bit removed) such that
> on a clone, all one would need to do is chmod +x it.   If that's
> possible, I'm clearly missing the steps to enable this.

No, as you said, anything in .git/ is not meant to be tracked.  Besides, 
if a user would change the executable bit (as advised), Git would always 
show this file as modified, making the tree permanently dirty (or worse, 
it could be accidentally be committed as executable).

For all those reasons, it is better to just commit an executable script in 
your <toplevel>/githooks/post-merge and ask your users to copy it to 
.git/hooks/.

Hth,
Dscho
