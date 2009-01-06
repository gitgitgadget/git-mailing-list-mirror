From: Jeff King <peff@peff.net>
Subject: Re: gitweb: removal of old style blobdiff support breaks ikiwiki
Date: Mon, 5 Jan 2009 19:25:20 -0500
Message-ID: <20090106002520.GA29000@coredump.intra.peff.net>
References: <20090105235418.GA9373@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
To: Joey Hess <joeyh@debian.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 01:26:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJzmX-0004p9-SO
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 01:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbZAFAZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 19:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbZAFAZY
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 19:25:24 -0500
Received: from peff.net ([208.65.91.99]:49632 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742AbZAFAZY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 19:25:24 -0500
Received: (qmail 30316 invoked by uid 107); 6 Jan 2009 00:25:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 05 Jan 2009 19:25:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Jan 2009 19:25:20 -0500
Content-Disposition: inline
In-Reply-To: <20090105235418.GA9373@gnu.kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104607>

On Mon, Jan 05, 2009 at 06:54:18PM -0500, Joey Hess wrote:

> I wonder if it wouldn't be better to make gitweb continue to support the
> old urls, using diff-tree instead of the porcelain?

It can't; there is currently no interface for diffing two arbitrary
blobs except "git diff". The simplest fix to retain functionality but
plug the hole is to pass --no-ext-diff to all versions, and
--no-textconv to versions which have textconv (i.e., 1.6.1 and later).
IIRC, there is a problem with --no-ext-diff in some versions, so that
fix might have to be backported, too.

-Peff
