From: Jeff King <peff@peff.net>
Subject: Re: [QUESTION] or [BUG] Could not stash new bin files
Date: Mon, 19 Apr 2010 08:41:17 -0400
Message-ID: <20100419124117.GA20184@coredump.intra.peff.net>
References: <p2rc8485ef11004190119q590aea5dy516bdc3d222ebb51@mail.gmail.com>
 <20100419093523.GA26342@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Arnauld Van Muysewinkel <arnauldvm@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 14:41:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3qIU-0004v8-UF
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 14:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589Ab0DSMlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 08:41:49 -0400
Received: from peff.net ([208.65.91.99]:59307 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754165Ab0DSMlt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 08:41:49 -0400
Received: (qmail 17646 invoked by uid 107); 19 Apr 2010 12:41:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 19 Apr 2010 08:41:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Apr 2010 08:41:17 -0400
Content-Disposition: inline
In-Reply-To: <20100419093523.GA26342@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145293>

On Mon, Apr 19, 2010 at 04:35:23AM -0500, Jonathan Nieder wrote:

> >     $ git add -N XXX/src/jrxml/*.xls
> >     $ git stash save --keep-index "Improving performance of views"
> >     XXX/src/jrxml/SubCellMatrixCompared-EXPLAIN-new.xls: not added yet
> >     XXX/src/jrxml/SubCellMatrixCompared-EXPLAIN-old.xls: not added yet
> >     fatal: git-write-tree: error building trees
> 
> Yes, this is a known problem [1].

Thanks for the pointer.

Re-reading that thread, and considering the fact that this comes up so
rarely, I think leaving it as an error is fine. We could possibly give a
bit more advice on how to proceed, though.

> > Specificities:
> > 
> > * I have a file in the index that I do not want to stash
> 
> Could you explain this further?  The stash currently saves everything
> about the current state (except files not in the index nor HEAD).

Yeah, I'm not really sure why intent-to-add is being used here at all,
instead of regular "git add".

But if the real problem is wanting to stash part of your changes, then
the best thing is probably to use the interactive "git stash -p".

> > * The two new files are binary files

I don't think that is relevant here. The intent-to-add bit is the
problem.

-Peff
