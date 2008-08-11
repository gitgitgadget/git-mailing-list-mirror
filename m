From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git gc does not discard objects found in alternate unless the
	alternate storage is packed
Date: Sun, 10 Aug 2008 19:54:38 -0700
Message-ID: <20080811025438.GB27195@spearce.org>
References: <loom.20080810T210546-549@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sergio <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 04:56:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSNaD-0000OH-1q
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 04:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684AbYHKCyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 22:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753800AbYHKCyj
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 22:54:39 -0400
Received: from george.spearce.org ([209.20.77.23]:49415 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619AbYHKCyi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 22:54:38 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2CEB338375; Mon, 11 Aug 2008 02:54:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <loom.20080810T210546-549@post.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91911>

Sergio <sergio.callegari@gmail.com> wrote:
> Version 1.5.6.5
> 
> Looks weird
> Is it the intended behaviour?

This is the current (intended) behavior.  We have never pruned an
object from a repository unless the object is packed in the shared
alternate repository.  See git-prune-packed's man page.  The prune
logic for loose objects only deletes objects which are in packs,
and it doesn't care where that pack came from.

-- 
Shawn.
