From: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] tar-tree: add the "tar.applyUmask" config option
Date: Thu, 20 Jul 2006 00:50:21 +0200
Message-ID: <20060719225021.GA28591@1wt.eu>
References: <20060719214025.GA10997@1wt.eu> <7vd5c1jkc3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 20 00:50:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3KsF-0006yh-II
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 00:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbWGSWu3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Jul 2006 18:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWGSWu3
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Jul 2006 18:50:29 -0400
Received: from 1wt.eu ([62.212.114.60]:55564 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932552AbWGSWu3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jul 2006 18:50:29 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5c1jkc3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24011>

On Wed, Jul 19, 2006 at 03:33:48PM -0700, Junio C Hamano wrote:
> Willy Tarreau <w@1wt.eu> writes:
> 
> > While I agreed with Linus that the very permissive file modes set in tar
> > archives were not particularly a problem for kernel users, I'm finding
> > that for some other projects it sometimes becomes really annoying, to
> > the point that I finally considered using a plain tar instead. This is a
> > shame because tar-tree is really fast an powerful, and I like its ability
> > to enforce permissions when those of the local dir might be wrong for
> > various reasons.
> 
> I do not have problem with an option to allow a non-default
> behaviour in this area.  Maybe we might want to be able to set
> the mask in the configuration file as well, perhaps like...
> 
> 	tar.umask = user ;# use from the current process'
>         tar.umask = 0    ;# same as default
>         tar.umask = 002  ;# group friendly

This is an excellent idea. I will try to find some spare time tomorrow
to implement it. I've also seen the proposal about the --umask= option.
I don't think it's absolutely necessary since the umask has little reason
to change during the repo's life, but if the implementation is obvious,
I will do it too.

Thanks for your suggestion,
Willy
