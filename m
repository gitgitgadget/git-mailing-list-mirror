From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 05/11] Add a library function to add an alternate to the
 alternates file
Date: Sun, 9 Mar 2008 00:18:16 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803090017150.3975@racer.site>
References: <alpine.LNX.1.00.0803081804090.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 09 00:18:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY8JW-0003k6-N6
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbYCHXSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbYCHXSN
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:18:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:43390 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751057AbYCHXSM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:18:12 -0500
Received: (qmail invoked by alias); 08 Mar 2008 23:18:10 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp028) with SMTP; 09 Mar 2008 00:18:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+9Oqp+uZO9dnR3IETAejIVf+NVFUb/iof7RsL0HK
	I82W4JSBugNHL4
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0803081804090.19665@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76614>

Hi,

On Sat, 8 Mar 2008, Daniel Barkalow wrote:


> +void add_to_alternates_file(const char *reference)
> +{
> +	char *file;
> +	char *alt;
> +	int fd;
> +
> +	file = mkpath("%s/objects/info/alternates", get_git_dir());
> +	fd = open(file, O_CREAT | O_WRONLY | O_APPEND, 0666);
> +	if (fd < 0)
> +		die("failed to create %s", file);

Even with alternates, which are probably written only rarely, I would have 
expected a lockfile procedure (if only to be consistent with the rest).

Ciao,
Dscho

