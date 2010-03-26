From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Teach 'git grep' about
 --open-files-in-pager=[<pager>]
Date: Fri, 26 Mar 2010 08:46:50 -0400
Message-ID: <20100326124650.GA12215@coredump.intra.peff.net>
References: <alpine.DEB.1.00.1003261145500.7596@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 26 13:47:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nv8wQ-00063h-2O
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 13:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815Ab0CZMrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 08:47:01 -0400
Received: from peff.net ([208.65.91.99]:37377 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710Ab0CZMrA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 08:47:00 -0400
Received: (qmail 31560 invoked by uid 107); 26 Mar 2010 12:47:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 26 Mar 2010 08:47:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Mar 2010 08:46:50 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1003261145500.7596@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143227>

On Fri, Mar 26, 2010 at 11:48:41AM +0100, Johannes Schindelin wrote:

> This supports opening the results of a 'git grep' directly in a pager 
> (where the pager can be 'vi', too).

This is not an argument against your patch, but you may be interested in
an alternate method:

  git grep -n $pattern >grep.out
  vim -q grep.out

The advantage is that the editor understands the output as a "quickfix"
list and lets you cycle through the hits (just like you might with
compiler errors). The disadvantage is that quickfix is a vim extension,
so "less" and stock "vi" can't do this (I imagine emacs has a similar
feature). It's also obviously a little more typing, but you can hide it
inside an alias quite easily.

I use the same trick to look for "^<<<<<<<", and have vim cycle through
merge conflicts (you can also make it quicker by restricitng the grep
only to unmerged files).

-Peff
