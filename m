From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH 3/7] gitweb: support filename prefix in git_patchset_body/git_difftree_body
Date: Sat, 28 Apr 2007 10:22:33 +0200
Message-ID: <20070428082233.GA19578@auto.tuwien.ac.at>
References: <11766699702663-git-send-email-mkoegler@auto.tuwien.ac.at> <11766699701308-git-send-email-mkoegler@auto.tuwien.ac.at> <11766699713715-git-send-email-mkoegler@auto.tuwien.ac.at> <200704271255.24200.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 28 10:22:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhiCX-0002YD-IW
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 10:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbXD1IWh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 28 Apr 2007 04:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965536AbXD1IWh
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 04:22:37 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:58997 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbXD1IWg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 04:22:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id B89BF684E788;
	Sat, 28 Apr 2007 10:22:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b6-Mer25Ymr7; Sat, 28 Apr 2007 10:22:33 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 4D77B684E784; Sat, 28 Apr 2007 10:22:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200704271255.24200.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45772>

On Fri, Apr 27, 2007 at 12:55:22PM +0200, Jakub Narebski wrote:
> On Sunday, 15 April 2007, Martin Koegler wrote:
> > git_treediff supports comparing subdirectories. As the output of
> > git-difftree is missing the path to the compared directories,
> > the links in the output would be wrong.
>=20
> You mean that git-diff-tree output for diff between two non-toplevel
> trees lacks the path to compared tree, e.g.
>   $ git diff-tree <commit1>:<path1> <commit2>:<path2>
> lacks <path1> prefix in the from part, and <path2> prefix in to part,
> and the goal is to add those missing prefixes in the links, without
> changing the visible output of git_patchset_body/git_difftree_body.

Yes, as I don't want to rewrite the raw view.

> > The patch adds two new parameters to add the missing path prefix.
>=20
> ...and makes use of them while generating links.
>=20
> Although I'm not sure if it wouldn't be better to put e.g.
> $prefix_from.$diff{'file'} in $diff{'file_from_url'} or something
> like that.

Would this really simplify the code?=20

=46iguring out, what is stored in $diff and how its elements are used,
requries more time. Adding a prefix is easier to understand.

> Looks nice, although I think this patch is needed only when we have
> "treediff" (and "treediff_plain") views, i.e. when we are able to
> compare not only top level trees (like in "commitdiff" view),
> or individual files (in "blobdiff" view), but also arbitrary trees.

My git_treediff patch supports this. My JavaScript prototyp can be used=
 to
select such a comparison.

mfg Martin K=F6gler
