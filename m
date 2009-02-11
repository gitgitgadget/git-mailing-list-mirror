From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git push failure in the case of SSH to localhost
Date: Wed, 11 Feb 2009 11:14:45 -0800
Message-ID: <20090211191445.GU30949@spearce.org>
References: <8e04b5820902110824u1ab99cc1r4df6349b20d62f84@mail.gmail.com> <20090211180559.GC19749@coredump.intra.peff.net> <8e04b5820902111042q138a2e79vc97c533007482e5c@mail.gmail.com> <20090211184429.GA27896@coredump.intra.peff.net> <8e04b5820902111103n69cde3e1le5781fb1818b622c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 20:16:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXKZB-0002ZL-HS
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 20:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755016AbZBKTOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 14:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754846AbZBKTOq
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 14:14:46 -0500
Received: from george.spearce.org ([209.20.77.23]:36633 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbZBKTOp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 14:14:45 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 72B6B38210; Wed, 11 Feb 2009 19:14:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <8e04b5820902111103n69cde3e1le5781fb1818b622c@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109507>

"Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com> wrote:
> 
>     Here is what I'm trying to accomplish: I want to add to the git
> search path also the folder ${GIT_DIR}/bin if this already exists...
> (This allows me to have repository specific commands...)

for f in `cd $(git rev-parse --git-dir)/bin && ls *`; do
  git config alias.$f '!$(git rev-parse --git-dir)/bin/'$f
done

No need to patch git.
 
-- 
Shawn.
