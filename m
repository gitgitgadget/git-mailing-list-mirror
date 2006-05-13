From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tracking branch history
Date: Sat, 13 May 2006 09:43:40 -0700
Message-ID: <7vbqu1vps3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605121838490.6713@iabervon.org>
	<Pine.LNX.4.64.0605121640210.3866@g5.osdl.org>
	<20060513034051.GA21586@spearce.org>
	<7vody2v7yr.fsf@assigned-by-dhcp.cox.net>
	<20060513071753.GA21998@spearce.org>
	<20060513074328.GB21998@spearce.org>
	<Pine.LNX.4.64.0605130815550.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 13 18:44:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FexDY-0007T9-Ei
	for gcvg-git@gmane.org; Sat, 13 May 2006 18:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWEMQnn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 12:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWEMQnn
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 12:43:43 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:41627 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932479AbWEMQnm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 May 2006 12:43:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060513164341.PTSD18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 13 May 2006 12:43:41 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605130815550.3866@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 13 May 2006 08:20:05 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19939>

Linus Torvalds <torvalds@osdl.org> writes:

> I actually disagree with Junio - I think the logging the name made sense. 
> If you have a shared repo with multiple people pushing to the same branch, 
> it's interesting to see who does the pushing.

Yes, I agree recording that information is interesting.  

My comment was about how it is recorded.  In the local case
GIT_COMMITTER_IDENT is what you want as Shawn did in his
original proposal, but remote "pushing into shared repository"
case I do not think it is available in general.

Well, at least that was what I was thinking when I made that
comment.  However,

If the pushers arrange to have appropriate environment variables
while receive-pack does its work (.git/config in the target
repository is not an appropriate place to get user.* settings
from in a shared setting), what you say makes perfect sense.

Having the usual enviornment available would be handy to make
the hooks on the receiving end to do useful things anyway, so I
retract that suggestion.

> I also think it might be good to save the oldsha1 value. Yes, it _should_ 
> always be the previous sha1 logged, but it's interesting to see in case it 
> isn't (ie the ref was updated some other way), and it's also interesting 
> for the first entry after logging has been enabled.
>
> 		Linue

Yes, and also what user-level command was used to cause update
the ref; was it a merge from remote, own commit, rewind/rebase?

	Junia

;-)
