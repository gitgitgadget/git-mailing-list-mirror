From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: Pushing into a repository with working directory?
Date: Fri, 05 Jan 2007 08:51:14 +0000
Message-ID: <459E1182.201@shadowen.org>
References: <20070102045108.GC27690@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 09:51:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2knL-0001k0-SZ
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 09:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbXAEIvR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 03:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161030AbXAEIvR
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 03:51:17 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:2484 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161027AbXAEIvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 03:51:16 -0500
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1H2kmL-0007jf-H5; Fri, 05 Jan 2007 08:50:21 +0000
User-Agent: Icedove 1.5.0.9 (X11/20061220)
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070102045108.GC27690@spearce.org>
X-Enigmail-Version: 0.94.1.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35980>

Shawn O. Pearce wrote:
> So tonight on #git I think I answered for the 10th time why the
> working directory doesn't update after a push to its associated
> repository.
> 
> We all know its somewhat dangerous to push into the current branch
> of a working directory, especially if that working directory contains
> uncommitted changes, as HEAD no longer matches the index.
> 
> But we all also know its incredibly useful to be able to push into
> a repository with a working directory, so we certainly don't want
> to disallow it entirely.
> 
> What about refusing a push to the current branch (branch listed in
> $GIT_DIR/HEAD) and the repository appears to have a working directory
> (is_bare_git_dir is false)?

Special casing the 'current' branch makes any sort of automated push
setup unreliable.  Indeed the special case preventing a fetch into the
current branch is pretty annoying for the same reason.  I would almost
prefer to relax that than add the same for push.

-apw
