From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Heads up: rebase -i -p will be made sane again
Date: Wed, 28 Jan 2009 05:01:56 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901280458590.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901271012550.14855@racer> <20090127085418.e113ad5a.stephen@exigencecorp.com> <alpine.DEB.1.00.0901280225240.3586@pacific.mpi-cbg.de> <20090127213950.3596ecf9.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 05:03:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS1dt-0006u8-N9
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 05:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbZA1EBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 23:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752436AbZA1EBi
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 23:01:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:57374 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752269AbZA1EBh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 23:01:37 -0500
Received: (qmail invoked by alias); 28 Jan 2009 04:01:36 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp062) with SMTP; 28 Jan 2009 05:01:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+dcwsz/9CdRxdEijz7D3OpCNXTdLNYIHum8jcjq7
	heQPpom7H1kwHa
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090127213950.3596ecf9.stephen@exigencecorp.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107468>

Hi,

On Tue, 27 Jan 2009, Stephen Haberman wrote:

> > So I adapted my code to find the "dropped" merges in 
> > git-rebase--interactive, too, for now, but I guess the proper fix is 
> > something like this:
> 
> So, if C, as a merge commit, doesn't get a patch id anymore (right?),
> does that mean that C is included with A and D in the cherry-picking
> on top of UPSTREAM (because with no patch id it cannot be recognized
> as a duplicate)?

Yep, it gets into the list.  But not with a "pick" command, as a merge it 
will get a "merge" command.

> So then C' is an empty-commit? This would be fine, I think, or can you 
> detect that C is a noop somehow without patch ids?

Actually, there are three possible outcomes:

- it tries to merge an ancestor of HEAD or HEAD itself -> noop

- it tries to merge which results in a fast-forward -> fine

- it tries to merge and a proper merge is necessary -> may conflict

Ciao,
Dscho
