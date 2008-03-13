From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] merge-recursive: handle file mode changes
Date: Fri, 14 Mar 2008 00:40:05 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803140039250.4174@racer.site>
References: <20080308171726.GA16129@localhost> <alpine.LSU.1.00.0803081850470.3975@racer.site> <20080313125229.GA24758@localhost> <alpine.LSU.1.00.0803131607030.1656@racer.site> <20080313192246.GA30361@localhost> <alpine.LSU.1.00.0803132216580.4174@racer.site>
 <20080313224741.GA5000@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Mar 14 00:40:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZx2R-0003bN-94
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 00:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbYCMXkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 19:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752667AbYCMXkD
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 19:40:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:33100 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752636AbYCMXkA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 19:40:00 -0400
Received: (qmail invoked by alias); 13 Mar 2008 23:39:58 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp015) with SMTP; 14 Mar 2008 00:39:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+YyqgxBd6Yzp3dp43x9q4v6gD3ZwulC3etRWg9yh
	PRW9GIb1nt68G9
X-X-Sender: gene099@racer.site
In-Reply-To: <20080313224741.GA5000@localhost>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77150>

Hi,

On Thu, 13 Mar 2008, Clemens Buchacher wrote:

> @@ -1062,6 +1071,8 @@ static struct merge_file_info merge_file(struct diff_filespec *o,
>  		} else {
>  			die("unsupported object type in the tree");
>  		}
> +
> +		result.merge = !result.clean;

That is new.  Doesn't this overwrite what has been set in

        } else {
                if (!sha_eq(a->sha1, o->sha1) && !sha_eq(b->sha1, o->sha1))
                        result.merge = 1;

?

Ciao,
Dscho
