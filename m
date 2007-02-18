From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Sun, 18 Feb 2007 01:08:03 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702180107250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net> <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
 <20070217232603.GB30839@coredump.intra.peff.net> <7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 01:08:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIZb7-0005uo-SW
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 01:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965425AbXBRAIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 19:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965430AbXBRAIG
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 19:08:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:57863 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965425AbXBRAIF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 19:08:05 -0500
Received: (qmail invoked by alias); 18 Feb 2007 00:08:03 -0000
X-Provags-ID: V01U2FsdGVkX1+QozN/XvSQg3aIj/CuDvLdar1VSR5oKkMMMStR9z
	2RiQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40035>

Hi,

On Sat, 17 Feb 2007, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Sat, Feb 17, 2007 at 01:12:52PM -0800, Junio C Hamano wrote:
> >
> >> +	prefix = setup_git_directory_gently(&is_not_gitdir);
> >> +	prefix_length = prefix ? strlen(prefix) : 0;
> >> +	if (!is_not_gitdir) {
> >> +		git_config(git_apply_config);
> >> +		if (apply_default_whitespace)
> >> +			parse_whitespace_option(apply_default_whitespace);
> >> +	}
> >> +
> >
> > If I read this correctly, running 'git apply' inside a git repository
> > will parse $GIT_DIR/config and $HOME/.gitconfig. However, outside of a
> > repository it will parse neither. It would make more sense to me to
> > still parse $HOME/.gitconfig to pick up the user's global options.
> 
> I thought about that, but decided against it.  If you are truly
> operating outside a git managed repository, it does not feel
> right to apply configuration user has for git.

That is a good point. But in the same vein, why not have a flag to 
git-apply, and let it ignore the configuration altogether?

Ciao,
Dscho
