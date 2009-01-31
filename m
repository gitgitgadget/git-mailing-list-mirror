From: Jeff King <peff@peff.net>
Subject: Re: Git log can not show history before rename
Date: Sat, 31 Jan 2009 02:04:18 -0500
Message-ID: <20090131070418.GB3033@coredump.intra.peff.net>
References: <1976ea660901300323n384d3650s3bb5a575accb65d1@mail.gmail.com> <1976ea660901300429i6d9b3594m91222314c284d184@mail.gmail.com> <adf1fd3d0901300449x7f6a2f5bq920068b46994c92e@mail.gmail.com> <200901302252.18051.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>,
	Frank Li <lznuaa@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jan 31 08:06:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT9vH-0001Ft-QR
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 08:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbZAaHEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 02:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbZAaHEW
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 02:04:22 -0500
Received: from peff.net ([208.65.91.99]:35152 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392AbZAaHEV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 02:04:21 -0500
Received: (qmail 10400 invoked by uid 107); 31 Jan 2009 07:04:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 31 Jan 2009 02:04:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Jan 2009 02:04:18 -0500
Content-Disposition: inline
In-Reply-To: <200901302252.18051.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107908>

On Fri, Jan 30, 2009 at 10:52:13PM +0100, Thomas Rast wrote:

> You might find this useful:
> 
>   $ git config alias.renames
>   !GIT_PAGER="grep -v '^$' | sort -u" git --paginate log --follow --name-only --pretty=format:"" --
> 
> Slow and hacky, but works nice enough in practice.  The intended use
> case is like
> 
>   $ gitk --complicated-rev-options $(git renames git-svn.perl)

Related (but also slow and hacky :) ), it is sometimes nice to see not
the whole history of a file, but all of the commits, in the usual log
order, that ended up affecting the outcome of a set of content (so not
any commits whose work was later overwritten). I posted a short script
for it a while back:

  http://article.gmane.org/gmane.comp.version-control.git/99278

-Peff
