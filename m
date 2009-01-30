From: Jeff King <peff@peff.net>
Subject: Re: diff-index --cached on bare repository
Date: Fri, 30 Jan 2009 15:06:25 -0500
Message-ID: <20090130200625.GB3054@coredump.intra.peff.net>
References: <glv901$c5v$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Fri Jan 30 21:07:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSzeb-0002jM-7a
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 21:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbZA3UG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 15:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbZA3UG2
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 15:06:28 -0500
Received: from peff.net ([208.65.91.99]:38195 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752989AbZA3UG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 15:06:27 -0500
Received: (qmail 4215 invoked by uid 107); 30 Jan 2009 20:06:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Jan 2009 15:06:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jan 2009 15:06:25 -0500
Content-Disposition: inline
In-Reply-To: <glv901$c5v$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107868>

On Fri, Jan 30, 2009 at 04:13:53PM +0000, Johannes Gilger wrote:

> today I stumbled over the output of "git diff-index --cached HEAD" in a 
> bare repository. While diff-index HEAD just reminds me that I got to 
> have a work-tree, --cached outputs all the files in HEAD as deleted. The 
> question is if this is intended behaviour? Or is it irrelevant because 
> diff-index is only plumbing? I found a mail of the gitk-team working 
> around this, which is funny because I discovered this while working on 
> GitX.

Generally commands which don't make sense in a bare repository are
forbidden. But diff-index _can_ work in a bare repository, since there
is no reason you can't do index-only operations. However, a bare repo
has no index by default, in which case diff-index shows the results you
saw.

So no, it's not a bug, but it is potentially confusing. I think nobody
ever worried about it because diff-index is plumbing, so users are
unlikely to stumble into it.

-Peff
