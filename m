From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bundle, fast-import: detect write failure
Date: Thu, 10 Jan 2008 12:05:50 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801101204120.31053@racer.site>
References: <874pdmhxha.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Thu Jan 10 13:06:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCwAy-0008Tc-K9
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 13:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504AbYAJMF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 07:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754078AbYAJMF4
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 07:05:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:38215 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753907AbYAJMFz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 07:05:55 -0500
Received: (qmail invoked by alias); 10 Jan 2008 12:05:53 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp011) with SMTP; 10 Jan 2008 13:05:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19WQusaNI1WGpMdu/bpWRElvQFmMnGdJqnChfq9zl
	sk7jotm4HMM3OO
X-X-Sender: gene099@racer.site
In-Reply-To: <874pdmhxha.fsf@rho.meyering.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70062>

Hi,

On Thu, 10 Jan 2008, Jim Meyering wrote:

> I noticed some unchecked writes.  This fixes them.

Thank you.

However, you also have this:

> -	close(keep_fd);
> +	if (close(keep_fd))
> +		die("failed to write keep file");

I recently read an article which got me thinking about close().  The 
author maintained that many mistakes are done by being overzealously 
defensive; die()ing in case of a close() failure (when open() succeeded!) 
might be just wrong.

Ciao,
Dscho
