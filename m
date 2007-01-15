From: Jeff King <peff@peff.net>
Subject: Re: Commit signing
Date: Mon, 15 Jan 2007 16:11:20 -0500
Message-ID: <20070115211120.GA1987@coredump.intra.peff.net>
References: <200701151000.58609.andyparkins@gmail.com> <eognu3$tje$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 22:36:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6ZVV-0008P6-AS
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 22:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbXAOVgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 16:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbXAOVgl
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 16:36:41 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4481 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932066AbXAOVgk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 16:36:40 -0500
Received: (qmail 28410 invoked from network); 15 Jan 2007 16:11:37 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 15 Jan 2007 16:11:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Jan 2007 16:11:20 -0500
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eognu3$tje$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36884>

On Mon, Jan 15, 2007 at 09:24:55PM +0100, Jakub Narebski wrote:

> By the way, how to make tag pointing to a out-of-tree blob, like
> junio-gpg-pub tag in git.git?

git-tag will accept the usual object syntax:
  git-tag magic HEAD:foo
  git-tag magic e69de29bb2d1d6434b8b29ae775ad8c2e48c5391

So you just need to create the blob:
  git-hash-object -w foo

If you make an annotated tag, git-show will give you the actual tag;
looks like it doesn't peel away unless it's a commit.

-Peff
