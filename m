From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Tags
Date: Fri, 1 Jul 2005 23:42:30 +0200
Message-ID: <20050701214230.GA22003@pasky.ji.cz>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org> <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org> <42C454B2.6090307@zytor.com> <Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org> <42C462CD.9010909@zytor.com> <Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org> <42C46B86.8070006@zytor.com> <m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com> <20050701180944.GA14375@pasky.ji.cz> <42C58D83.9060107@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 23:36:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoTAi-0002p8-T1
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 23:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVGAVnD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 17:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVGAVnD
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 17:43:03 -0400
Received: from w241.dkm.cz ([62.24.88.241]:18665 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261597AbVGAVmj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2005 17:42:39 -0400
Received: (qmail 24010 invoked by uid 2001); 1 Jul 2005 21:42:30 -0000
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <42C58D83.9060107@zytor.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jul 01, 2005 at 08:37:55PM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> told me that...
> Petr Baudis wrote:
> >Dear diary, on Fri, Jul 01, 2005 at 03:56:06PM CEST, I got a letter
> >where "Eric W. Biederman" <ebiederm@xmission.com> told me that...
> >
> >>"H. Peter Anvin" <hpa@zytor.com> writes:
> >>
> >>
> >>>In the end, it might be that the right thing to do for git on kernel.org 
> >>>is to
> >>>have a single, unified object store which isn't accessible by anything 
> >>>other
> >>>than git-specific protocols.  There would have to be some way of dealing 
> >>>with,
> >>>for example, conflicting tags that apply to different repositories, 
> >>>though.
> >>
> >>As far as I can tell public distributed tags are not that hard and if
> >>you are going to be synching them it is probably worth working on.
> >>
> >>The basic idea is that instead of having one global tag of
> >>'linux-2.6.13-rc1' you have a global tag of
> >>'torvalds@osdl.org/linux-2.6.13-rc1'.
> >>
> >>The important part is that the tag namespace is made hierarchical
> >>with at least 2 levels.  Where the top level is a globally
> >>unique tag owner id and the bottom level is the actual tag.  This
> >>prevents collisions when merging trees because two peoples
> >>tags are never in the same namespace, as least when
> >>people are not actively hostile :)
> >
> >
> >I don't know, I don't consider this very appealing myself. I'd rather
> >prefer the private tags to be per-repository rather than per-user, since
> >those ugly "merged-here", "broken" etc. tags aren't very useful on
> >larger scope than of a repository. OTOH, what tags would be per-user,
> >not per-repository and not global?
> >
> 
> He's talking about global tags, just using a "globally unique" 
> namespace.  Which of course only works right if only genuinely can't 
> create tags outside your assigned namespace.

I doubt that's really useful either. Rather artificial mechanisms for
protection of the namespace would have to be deployed, and again, what
would it be good for anyway? If you are tagging linux-2.m.n, you are
probably whoever you should be - David, Alan, Marcelo, Linus, or whoever
else, while if you are tagging linux-2.m.n-cki, you are likely Con
Kolivas. I don't believe there is any (or much) potential for "natural"
conflicts and if you are malicious, you will just fake the namespace;
but frequently what's interesting about the tags is not the author at
all - I would consider it confusing to have to suddenly dive to another
namespace when Linus hands maintenance of linux-2.m to someone else.

The only significant value I can therefore see in the namespaces is
prevention of user mistakes, but I think the successful strategy here
would be just "upstream will notice", and make sure the upstream will be
noticed properly (perhaps even interactively) about any new tags it
gets.

Ok, I admit that it boils down to me being lazy and that "it'd be more
typing!"... ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
