From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-cget: prints elements of C code in the git
	repository
Date: Tue, 24 Mar 2009 09:59:07 -0400
Message-ID: <20090324135906.GA10644@coredump.intra.peff.net>
References: <49C8B159.2040600@gmail.com> <alpine.DEB.1.00.0903241257430.7493@intel-tinevez-2-302> <49C8E074.4030808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 15:01:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm7Bs-0005Fn-S5
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 15:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755109AbZCXN7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 09:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756409AbZCXN7R
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 09:59:17 -0400
Received: from peff.net ([208.65.91.99]:59001 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755706AbZCXN7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 09:59:16 -0400
Received: (qmail 29702 invoked by uid 107); 24 Mar 2009 13:59:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 24 Mar 2009 09:59:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Mar 2009 09:59:07 -0400
Content-Disposition: inline
In-Reply-To: <49C8E074.4030808@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114460>

On Tue, Mar 24, 2009 at 02:30:28PM +0100, Roel Kluin wrote:

> > - the commit message is severely lacking (I had to apply it and run it to 
> >   find out what problem it tries to solve),
> 
> This is probably better:
> 
> This script shows where elements of C code are defined in the git-repository.
> It is still experimental, although it should work in most cases.

Wouldn't it be a lot easier to base this on something like ctags, which
already knows how to do all the parsing of C quirky C?

I.e.:

  git ls-files | xargs ctags
  vi -t get_sha1

Where you can replace "vi" with your editor of choice. And if you really
like getting the definition dumped to stdout, writing a command-line
viewer for the ctags format would be quite simple (and I would be
surprised if one hasn't been written already).

-Peff
