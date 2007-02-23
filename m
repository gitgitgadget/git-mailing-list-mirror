From: "Sam Watkins" <swatkins@fastmail.fm>
Subject: Re: git-push hook to update remote working copy safely
Date: Sat, 24 Feb 2007 03:35:00 +1100
Message-ID: <1172248500.32514.1176151445@webmail.messagingengine.com>
References: <1172220709.10221.1176113191@webmail.messagingengine.com>
   <7v649t5ebq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 23 17:35:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKdNz-0000fJ-Sv
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 17:35:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933133AbXBWQfE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 11:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933137AbXBWQfE
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 11:35:04 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:57898 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933133AbXBWQfB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Feb 2007 11:35:01 -0500
Received: from out1.internal (unknown [10.202.2.149])
	by out1.messagingengine.com (Postfix) with ESMTP id E9A2A1CF6C2;
	Fri, 23 Feb 2007 11:35:00 -0500 (EST)
Received: from web4.messagingengine.com ([10.202.2.213])
  by out1.internal (MEProxy); Fri, 23 Feb 2007 11:35:00 -0500
Received: by web4.messagingengine.com (Postfix, from userid 99)
	id B15DD188024; Fri, 23 Feb 2007 11:35:00 -0500 (EST)
X-Sasl-Enc: 6AG4kiP99G5mbgxPWRRQDdY8kdf1jBxXWcXF83XBKpOX 1172248500
Content-Disposition: inline
X-Mailer: MessagingEngine.com Webmail Interface
In-Reply-To: <7v649t5ebq.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40449>

On Fri, 23 Feb 2007 03:00:09 -0800, "Junio C Hamano" <junkio@cox.net>
said:
> "Sam Watkins" <swatkins@fastmail.fm> writes:
> 
> > I'm looking for a command that will update the remote working copy after
> > a "git push", without damaging any changes that may have been made to
> > the working copy.
> 
> Define "without damaging".  If there are changes to paths that
> are modified by the pushed commit since the current HEAD, what
> should your "update the remote working copy" procedure would
> do?

hi Junio,

it should merge the changes as if I'd run git-pull on the remote box,
and handle conflicts in the same way.

If possible I want to get exactly the effect of having run on box B
"git-pull A", by running a command like "git-push B" on box A.  I think
maybe that's not possible without commiting all changes to the working
copy on B first, but for our app it's fine to do that it's meant to do
that automatically and frequently anyway.
so I will just do that then run checkout -f from the hook.

I don't understand git very well yet but that will work I think.  I
thought "push" would be symmetrical to "pull" more or less, maybe it is
symmetrical to "fetch" ?

thank-you for your help, I am reading some more of the git manual
because I understand only some of your reply and very little about git
yet!

The app "arcs" we are writing, it is peer to peer, not necessarily using
a central repository, it commits pulls and pushes all changes made to
working copies automatically or when asked to.  currently I'm
implementing push as a remote pull because of this problem, but that
can't connect back through firewalls and suchlike.


Sam
