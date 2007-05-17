From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Git.pm: Add remote_refs() git-ls-remote frontend
Date: Thu, 17 May 2007 13:30:28 +0200
Message-ID: <20070517113028.GN4489@pasky.or.cz>
References: <20070517023743.1982.41240.stgit@rover> <7vk5v89ek8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 17 13:30:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoeBl-0007cb-6X
	for gcvg-git@gmane.org; Thu, 17 May 2007 13:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274AbXEQLab (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 07:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755024AbXEQLab
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 07:30:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39146 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755274AbXEQLaa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 07:30:30 -0400
Received: (qmail 30486 invoked by uid 2001); 17 May 2007 13:30:28 +0200
Content-Disposition: inline
In-Reply-To: <7vk5v89ek8.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47513>

On Thu, May 17, 2007 at 07:58:31AM CEST, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > .... Too bad that
> >
> > 	git-ls-remote --heads .
> > 	
> > is subtly different from
> >
> > 	git-ls-remote . refs/heads/
> >
> > so we have to provide the interface for specifying both.
> 
> I've already heard you say the above elsewhere, but I am not
> sure what you exactly mean here.  Mind substantiating it a bit
> more clearly?

Because the arguments are matched like

	case "/$path" in
	*/$pat )

so if you have remote "refs" and refs/remote/refs/heads/x, git-ls-remote
refs/heads/ is ambiguous. OTOH, --heads always match start of the path.

It's somewhat obscure and probably doesn't really matter for user
interface, but API should be free even of obscure misbehaviour, I
believe.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
