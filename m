From: Petr Baudis <pasky@suse.cz>
Subject: Re: efficient cloning
Date: Tue, 21 Mar 2006 12:29:52 +0100
Message-ID: <20060321112952.GR18185@pasky.or.cz>
References: <7vbqw1nakz.fsf@assigned-by-dhcp.cox.net> <7vu09tjy38.fsf@assigned-by-dhcp.cox.net> <200603201730.19373.Josef.Weidendorfer@gmx.de> <7voe00iupp.fsf@assigned-by-dhcp.cox.net> <20060320232101.GQ18185@pasky.or.cz> <7vfylcismx.fsf@assigned-by-dhcp.cox.net> <441FB715.1000500@op5.se> <7v4q1sgpet.fsf@assigned-by-dhcp.cox.net> <20060321091916.GA17125@coredump.intra.peff.net> <7vy7z4f7x3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 21 12:29:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLf3U-00035q-N5
	for gcvg-git@gmane.org; Tue, 21 Mar 2006 12:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbWCUL3c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 06:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbWCUL3c
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 06:29:32 -0500
Received: from w241.dkm.cz ([62.24.88.241]:9858 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030339AbWCUL3b (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Mar 2006 06:29:31 -0500
Received: (qmail 17501 invoked by uid 2001); 21 Mar 2006 12:29:52 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy7z4f7x3.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17781>

Dear diary, on Tue, Mar 21, 2006 at 10:45:12AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Jeff King <peff@peff.net> writes:
> 
> > Then why not create .git/refs/remotes/$origin/HEAD at the time of clone
> > (or later)? Then the core looks for:
> >   (current order, .git/refs, etc)
> >   .git/refs/remotes/foo
> >   .git/refs/remotes/foo/HEAD
> > The porcelain can take care of managing the contents of HEAD. If there
> > is no HEAD in the directory, then it cannot be looked up by 'foo'
> > ('foo/remote-branch' must be used instead).
> 
> Yup, earlier I mentioned that possibility, and it does not seem
> too painful.  On top of the "next", here is what is needed.
> 
> -- >8 --
> [PATCH] get_sha1_basic(): try refs/... and finally refs/remotes/$foo/HEAD
> 
> This implements the suggestion by Jeff King to use
> refs/remotes/$foo/HEAD to interpret a shorthand "$foo" to mean
> the primary branch head of a tracked remote.  clone needs to be
> told about this convention as well.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

Excellent, yes, that's what I've meant. I'm happy now. :)

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
