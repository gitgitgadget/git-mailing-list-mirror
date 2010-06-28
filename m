From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: [OT?] Executing Git from bash script invoked by cron
Date: Mon, 28 Jun 2010 23:17:17 +0200
Message-ID: <1277759597-sup-9397@nixos>
References: <4C290D88.80306@cedarsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 28 23:17:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTLhr-0002Wc-Ra
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 23:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999Ab0F1VRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 17:17:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:33918 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754926Ab0F1VRV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 17:17:21 -0400
Received: (qmail invoked by alias); 28 Jun 2010 21:17:18 -0000
Received: from mawercer.at.xencon.net (EHLO mail.gmx.net) [83.246.111.127]
  by mail.gmx.net (mp068) with SMTP; 28 Jun 2010 23:17:18 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1+0i7pXVXe0IzJLovXQG+6abVMEWBbMsgie/mXMu4
	L4XlcdVCFvKXK4
Received: by mail.gmx.net (sSMTP sendmail emulation); Mon, 28 Jun 2010 23:17:17 +0200
In-reply-to: <4C290D88.80306@cedarsoft.com>
User-Agent: Sup/git
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149862>

Excerpts from Johannes Schneider's message of Mon Jun 28 23:00:56 +0200 2010:
> Hash: SHA1
> 
> Hi,
> 
> I try to mirror my local git repository.
> Therefore I created a bash script. This script, executed form the
> command line, works fine.
> 
> But the same script executed by cron, does not work. Git push does
> simply nothing. No output, no push, nothing.
> But git log and git --version works...
> 
> I tried to google the problem, but couldn't not find anything useful.
> Any hints are welcome.

What do you do in such cases? Make sure you log both: stdout and stderr.

a)
sh -c 'your quoted command &> /tmp/logfile'

b) if this still does not work use strace:

sh -c 'strace -f-o /tmp/strace.log your quoted command &> /tmp/logfile'

Then you know how much is happening.

You may also want to check that the environment is the same. Eg
export > file to create a file containing your environment.
Then source it in the cron job line somehow.

I'm not using cron that often so the solution could be simpler.

Marc Weber
