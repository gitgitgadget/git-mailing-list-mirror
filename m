From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Document --ignore-if-in-upstream in git-format-patch
Date: Thu, 18 Jan 2007 14:40:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701181437200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <8764b4fuc8.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1141177238-1169127647=:22628"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 14:41:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7XVb-0006oL-6X
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 14:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbXARNkt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 08:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbXARNkt
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 08:40:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:42781 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932423AbXARNks (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 08:40:48 -0500
Received: (qmail invoked by alias); 18 Jan 2007 13:40:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 18 Jan 2007 14:40:47 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
In-Reply-To: <8764b4fuc8.fsf@morpheus.local>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37087>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1141177238-1169127647=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 18 Jan 2007, David Kågedal wrote:

> Someone who knows how it *actually* works is encouraged to send a
> better explanation.

Nice try... Unfortunately, I don't have time to do it.

> +--ignore-if-in-upstream::
> +	Do not include the same patch twice.  If there are two commits
> +	that would produce identical patches, the second one is
> +	excluded from the output.

This is not what it does, though. (If in doubt, use the source, Luke).

Given a range upstream..localbranch, --ignore-if-in-upstream looks at all 
diffs associated with commits in localbranch..upstream (i.e. all commits 
upstream has, but not localbranch), and when traversing 
upstream..localbranch to output the commits with diffs, drops those at the 
floor which were already seen in localbranch..upstream.

The way it does this is by hashing the diffs, and check only the hashes.

Ciao,
Dscho

---1148973799-1141177238-1169127647=:22628--
