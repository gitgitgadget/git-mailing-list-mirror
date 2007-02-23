From: "Sam Watkins" <swatkins@fastmail.fm>
Subject: Re: git-push hook to update remote working copy safely
Date: Sat, 24 Feb 2007 04:04:43 +1100
Message-ID: <1172250283.5505.1176180417@webmail.messagingengine.com>
References: <1172220709.10221.1176113191@webmail.messagingengine.com>   
   <7v649t5ebq.fsf@assigned-by-dhcp.cox.net>   
   <1172248500.32514.1176151445@webmail.messagingengine.com>   
   <Pine.LNX.4.63.0702231737300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 23 18:37:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKeLt-00005Y-0R
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 18:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbXBWRg5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 12:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbXBWRg5
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 12:36:57 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:33110 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932465AbXBWRg5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Feb 2007 12:36:57 -0500
Received: from out1.internal (unknown [10.202.2.149])
	by out1.messagingengine.com (Postfix) with ESMTP id D35D61CF9FC
	for <git@vger.kernel.org>; Fri, 23 Feb 2007 12:04:43 -0500 (EST)
Received: from web4.messagingengine.com ([10.202.2.213])
  by out1.internal (MEProxy); Fri, 23 Feb 2007 12:04:43 -0500
Received: by web4.messagingengine.com (Postfix, from userid 99)
	id 879F115DA73; Fri, 23 Feb 2007 12:04:43 -0500 (EST)
X-Sasl-Enc: u2DpeEgiz7Zf4qcoj+3WtypSmemMeJgp4LS2Tsw0Ice4 1172250283
Content-Disposition: inline
X-Mailer: MessagingEngine.com Webmail Interface
In-Reply-To: <Pine.LNX.4.63.0702231737300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40453>


On Fri, 23 Feb 2007 17:40:02 +0100 (CET), "Johannes Schindelin"
<Johannes.Schindelin@gmx.de> said:
> Hi,
>
> On Sat, 24 Feb 2007, Sam Watkins wrote:
>
> > it should merge the changes as if I'd run git-pull on the remote
> > box, and handle conflicts in the same way.
>
> But that leaves conflicts in the working directory! You _have_ to
> resolve them (or reset) before proceding.

hi Johannes,

I think it's ok for our application if the push+hook leaves conflicts in
the working directory, I just want to replicate the effect of running
git-pull remotely without actually having to go through ssh contortions
to achieve that. It might not be such a good idea to do that in the
normal usage of git, but we are using it in not a normal way, and that
is what I am trying to do, replicate the effect of running git-pull
remotely using git-push plus (unknown attempt-to-merge command or
whatever in the hook).

> Don't you have any user interaction? I.e. if the remote working
> directory is only ever changed by your hook, you can use what Junio
> sent. It is even overkill for that purpose.

no, the remote working directory can be edited just like the local
working directory. there's user interaction in the form of editing on
both ends. otherwise, the committing/syncing process is intended to be
non-interactive.

If we were using a central non-editable repository, we could use
"checkout -f" in the hook we did try that before.

thanks for your help :)


Sam
