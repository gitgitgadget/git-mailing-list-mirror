From: Yann Dirson <ydirson@altern.org>
Subject: Re: git-kill: rewrite history removing a commit
Date: Wed, 31 Jan 2007 21:22:04 +0100
Message-ID: <20070131202204.GB5362@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070131195533.GE21097@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Wed Jan 31 21:23:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCLzE-0007d9-JH
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 21:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbXAaUWy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 15:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161028AbXAaUWy
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 15:22:54 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:46984 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161027AbXAaUWx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 15:22:53 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp8-g19.free.fr (Postfix) with ESMTP id CC39855FA;
	Wed, 31 Jan 2007 21:22:51 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 7B32C2004; Wed, 31 Jan 2007 21:22:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20070131195533.GE21097@mellanox.co.il>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38292>

On Wed, Jan 31, 2007 at 09:55:33PM +0200, Michael S. Tsirkin wrote:
> Below is a simple script that rewrites history reverting a single commit.
> This differs from git-revert in that a commit is completely removed,
> and is especially useful before one has published a series of
> commits.
> 
> Do you find this useful? Comments?

That may be well when no patch depends on the one you kill.  In that
case, it surely requires some work to handfix things.

I'd suggest to use stgit to prepare commits before publication.  Even
if you don't feel the need for it in everyday life, you can have a
one-shot use for this particular problem, by turning your latest
commits into an stgit stack, use stgit facilities to handle posible
conflicts, and turn them into commits again:

The nominal case goes:

  stg init
  stg uncommit -n <ncommits>
  stg float <patch-to-kill>
  stg delete <patch-to-kill>

And if there is any conflict, you can still solve them, decide to
change your plans, get diffs from gitk, etc.

Best regards,
-- 
Yann.
