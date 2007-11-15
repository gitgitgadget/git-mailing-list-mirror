From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problem in our test setup
Date: Thu, 15 Nov 2007 12:40:30 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711151237400.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0711150618300.4362@racer.site>
 <7vzlxg6kzt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 12:41:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isd5q-0003gU-Bs
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 12:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765424AbXKOLkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 06:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765375AbXKOLkd
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 06:40:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:56567 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765154AbXKOLkc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 06:40:32 -0500
Received: (qmail invoked by alias); 15 Nov 2007 11:40:30 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp048) with SMTP; 15 Nov 2007 12:40:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qjiZOZQBqvjzuZWwSMr6HOtyShrCbOm0LpIyT2L
	nwjpy8wyKQvryl
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vzlxg6kzt.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65110>

Hi,

On Wed, 14 Nov 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Because my prefix is the default prefix, which is $HOME/bin, and which 
> > is not turned off in the tests.  So git finds "runstatus", because it 
> > is still installed.
> 
> Yes, we have a problem.
> 
> We could solve this for commands issued in "git foo" form by not looking 
> for "git-foo" anywhere other than in git_exec_path.  The scripts and 
> tests only prepend GIT_EXEC_PATH to their PATH and run "git foo" or 
> "git-foo", but if we replace all of them to the non-dash form, wouldn't 
> that solve the issue as well?

Funnily enough, it _is_ the non-dash form that I replaced.  What happens 
is this: the git wrapper looks for a builtin named 'runstatus', does not 
find it, then calls out for something like 'git-runstatus', which is found 
in my $HOME/bin.

Sorry,
Dscho
