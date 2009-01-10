From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/6] Glean libexec path from argv[0] for git-upload-pack
 and git-receive-pack.
Date: Sat, 10 Jan 2009 15:34:50 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901101532430.30769@pacific.mpi-cbg.de>
References: <1231595452-27698-1-git-send-email-prohaska@zib.de> <1231595452-27698-2-git-send-email-prohaska@zib.de> <1231595452-27698-3-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Steve Haslam <shaslam@lastminute.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Jan 10 15:36:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLewl-0002R7-Pq
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 15:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbZAJOeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 09:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752804AbZAJOeJ
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 09:34:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:40583 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751583AbZAJOeI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 09:34:08 -0500
Received: (qmail invoked by alias); 10 Jan 2009 14:34:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp032) with SMTP; 10 Jan 2009 15:34:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18OIpV31fEOSuVIarcD7Zk5MJCkUHz6MsuunA7tdV
	h2mkuvI1cBdC7s
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1231595452-27698-3-git-send-email-prohaska@zib.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105115>

Hi,

On Sat, 10 Jan 2009, Steffen Prohaska wrote:

> From: Steve Haslam <shaslam@lastminute.com>
> 
> If the user specified the full path to git-upload-pack as the -u option to
> "git clone" when cloning a remote repository, and git was not on the default
> PATH on the remote machine, git-upload-pack was failing to exec
> git-pack-objects.
> 
> By making the argv[0] path (if any) available to setup_path(), this will
> allow finding the "git" executable in the same directory as
> "git-upload-pack". The default built in to exec_cmd.c is to look for "git"
> in the ".../libexec/git-core" directory, but it is not installed there (any
> longer).
> 
> Much the same applies to invoking git-receive-pack from a non-PATH location
> using the "--exec" argument to "git push".
> 
> [ spr: split Steve's original commit into two commits. ]

I think you do not want to have that [ ... ] in the commit message, but 
after the "--".

Further, it would make sense to have these 2 patches independently, 
provided that a test is added with which we could verify that the patches 
are actually necessary for upload-pack/receive-pack.

Logically, and to avoid committing a broken revision, 1/6 should come 
last, methinks.

Ciao,
Dscho
