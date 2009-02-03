From: Jeff King <peff@peff.net>
Subject: Re: how to diff versions of a file
Date: Tue, 3 Feb 2009 02:34:50 -0500
Message-ID: <20090203073450.GE21367@sigill.intra.peff.net>
References: <1c5969370902022100h7c03bbb6h2d9f443f877d89ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matt Graham <mdg149@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 08:36:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUFpU-0007wk-Gj
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 08:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbZBCHey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 02:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbZBCHey
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 02:34:54 -0500
Received: from peff.net ([208.65.91.99]:45748 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751661AbZBCHey (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 02:34:54 -0500
Received: (qmail 17512 invoked by uid 107); 3 Feb 2009 07:35:05 -0000
Received: from c-75-75-4-229.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (75.75.4.229)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 03 Feb 2009 02:35:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Feb 2009 02:34:50 -0500
Content-Disposition: inline
In-Reply-To: <1c5969370902022100h7c03bbb6h2d9f443f877d89ec@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108161>

On Tue, Feb 03, 2009 at 12:00:51AM -0500, Matt Graham wrote:

> I'm curious if there's a way to diff between 2 arbitrary versions of a file.
> 
> For example, how can I see the diff between tree.c on HEAD and from 3
> edits (of tree.c) ago?

Others have suggested diffing between two arbitrary revisions, and
limiting the diff by path. E.g.:

  git diff HEAD~3 HEAD -- tree.c

which works just fine.  But I find it more intuitive to simply specify
the diff between two blobs (or trees, if you want), like:

  git diff HEAD~3:tree.c HEAD:tree.c

The added bonus is that you can also use this syntax to diff two files
with different names.

-Peff
