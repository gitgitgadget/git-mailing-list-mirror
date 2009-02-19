From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] Introduce the function strip_path_suffix()
Date: Thu, 19 Feb 2009 21:12:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902192110290.6223@intel-tinevez-2-302>
References: <499C63E7.5040306@kdbg.org> <f6344cbba22e049806796f4920e229fb2e539d5c.1235070304u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>, Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 19 21:13:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaFHD-00057H-Gh
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 21:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757412AbZBSUMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 15:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757385AbZBSUMR
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 15:12:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:47758 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756454AbZBSUMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 15:12:16 -0500
Received: (qmail invoked by alias); 19 Feb 2009 20:12:14 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp018) with SMTP; 19 Feb 2009 21:12:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18SOskvFeYS4ppDBGU6aA2O+tYKJhaMB5ZafLY5n4
	d+hfigrWWPriI7
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <f6344cbba22e049806796f4920e229fb2e539d5c.1235070304u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110742>

Hi,

On Thu, 19 Feb 2009, Johannes Schindelin wrote:

> The function strip_path_suffix() will try to strip a given suffix from 
> a given path.  The suffix must start at a directory boundary (i.e. "core" 
> is not a path suffix of "libexec/git-core", but "git-core" is).
> 
> Arbitrary runs of directory separators ("slashes") are assumed identical.
> 
> Example:
> 
> 	strip_path_suffix("C:\\msysgit/\\libexec\\git-core",
> 		"libexec///git-core", &prefix)
> 
> will set prefix to "C:\\msysgit" and return 0.

Aargh, of course I managed to forget to adjust the example.  Here it goes:

	prefix = strip_path_suffix("C:\\msysgit/\\libexec\\git-core",
			"libexec///git-core");

will set prefix to "C:\\msysgit".

Ciao,
Dscho
