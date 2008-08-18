From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] On error in DirCache.lock, do not leave the index
	locked.
Date: Sun, 17 Aug 2008 22:46:00 -0700
Message-ID: <20080818054600.GA7376@spearce.org>
References: <1218922587.30527.2.camel@isidore.myhome.westell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: "John J. Franey" <jjfraney@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 07:47:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUxa5-0006GA-LZ
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 07:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbYHRFqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 01:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbYHRFqB
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 01:46:01 -0400
Received: from george.spearce.org ([209.20.77.23]:48468 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbYHRFqB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 01:46:01 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7A91138375; Mon, 18 Aug 2008 05:46:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1218922587.30527.2.camel@isidore.myhome.westell.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92682>

"John J. Franey" <jjfraney@gmail.com> wrote:
> After using C git on the same repository, the jgit cache read
> threw an EOFException, and left the index lock file.
> The repository is still valid according to C git, but
> unreachable by C git because it honors the lock file
> left behind by jgit.

Urgh.  Thanks for the patch.
 
>  The reason for the EOFException is beyond me right now.  It
>  reported "Short read of block."  However, I'm pretty sure
>  leaving the lock file in place is an error.

If you can reproduce it, I'd like to see a copy of the index file
if that is possible.  I was pretty certain DirCache honors the
index file format properly, but a short read of a block suggests
we misread a length field somewhere.
 
-- 
Shawn.
