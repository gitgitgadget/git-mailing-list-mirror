From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-submodule: Make update verbose for up to date path
Date: Tue, 4 Mar 2008 16:08:16 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803041605450.22527@racer.site>
References: <1204642691-3220-1-git-send-email-pkufranky@gmail.com>  <alpine.LSU.1.00.0803041503360.22527@racer.site> <46dff0320803040803v2f93d749t6b45fc8e47e66d21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 17:09:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWZi2-0007QC-MV
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 17:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763287AbYCDQJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 11:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759944AbYCDQJE
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 11:09:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:47411 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763271AbYCDQJD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 11:09:03 -0500
Received: (qmail invoked by alias); 04 Mar 2008 16:09:01 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 04 Mar 2008 17:09:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+1Up10YIy1ftkof1f37xq2lPUEk96edVgrcbkSUT
	vuVVMiUSxU0/cw
X-X-Sender: gene099@racer.site
In-Reply-To: <46dff0320803040803v2f93d749t6b45fc8e47e66d21@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76111>

Hi,

On Wed, 5 Mar 2008, Ping Yin wrote:

> When i run 'git submodule update' in a repository whose submodules are 
> all clean, there is not any output which makes me not know whether this 
> command are successful. I think this is not friendly.

The problem is: people ignore output.  Back when merge-recursive was even 
more chatty than it is now, they happily glanced over the fact that there 
were _conflicts_.

So we reduced the output.  Drastically.

For example, git reset --hard (amongst others) does not output a _thing_ 
if it succeeds.  This is good.  No output means it succeeded.

Now, some other commands take a while to complete, so we have a progress 
which kicks in after a second or so.  Still, this is just to keep the user 
busy when she would otherwise think that Git hangs.

So no, I do not like submodule becoming chattier.  You can add --verbose 
if you want, but the default should be _quiet_.

Ciao,
Dscho

