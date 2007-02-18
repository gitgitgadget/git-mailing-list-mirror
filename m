From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Sun, 18 Feb 2007 01:06:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702180105000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net> <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
 <20070217232603.GB30839@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 01:06:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIZZm-0005JV-F2
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 01:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965421AbXBRAGn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 19:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965424AbXBRAGn
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 19:06:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:55156 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965421AbXBRAGn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 19:06:43 -0500
Received: (qmail invoked by alias); 18 Feb 2007 00:06:41 -0000
X-Provags-ID: V01U2FsdGVkX19KS+NmZIJKW2hwNd2jnWccln5l9Fz8sEQPn1aXjG
	hhrw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070217232603.GB30839@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40034>

Hi,

On Sat, 17 Feb 2007, Jeff King wrote:

> On Sat, Feb 17, 2007 at 01:12:52PM -0800, Junio C Hamano wrote:
> 
> > +	prefix = setup_git_directory_gently(&is_not_gitdir);
> > +	prefix_length = prefix ? strlen(prefix) : 0;
> > +	if (!is_not_gitdir) {
> > +		git_config(git_apply_config);
> > +		if (apply_default_whitespace)
> > +			parse_whitespace_option(apply_default_whitespace);
> > +	}
> > +
> 
> If I read this correctly, running 'git apply' inside a git repository
> will parse $GIT_DIR/config and $HOME/.gitconfig. However, outside of a
> repository it will parse neither. It would make more sense to me to
> still parse $HOME/.gitconfig to pick up the user's global options.

In git-config we solve the problem by running git_config regardless of 
is_not_gitdir. However, I suspect you have to 'cd' back to prefix, or else 
the patch gets applied in the repo root, right? (Disclaimer: I did not 
read the patch.)

Ciao,
Dscho
