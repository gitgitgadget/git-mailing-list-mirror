From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Symbolic link documentation
Date: Thu, 20 Sep 2007 13:25:12 -0400
Message-ID: <20070920172512.GT3099@spearce.org>
References: <70952A932255A2489522275A628B97C3052E98EB@xmb-sjc-233.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Matt Seitz (matseitz)" <matseitz@cisco.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 19:25:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYPmG-0001hT-Hr
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 19:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbXITRZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 13:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbXITRZR
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 13:25:17 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50026 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbXITRZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 13:25:16 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IYPly-0007ni-UT; Thu, 20 Sep 2007 13:25:07 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7793520FBAE; Thu, 20 Sep 2007 13:25:12 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <70952A932255A2489522275A628B97C3052E98EB@xmb-sjc-233.amer.cisco.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58789>

"Matt Seitz (matseitz)" <matseitz@cisco.com> wrote:
> Where does the git user documentation discuss how git handles symbolic
> links?

About the only mention I can find appears to be in git-config where
it talks a little bit about the core.symlinks configuration option.

But in general Git treats symlinks as though they were plain text
files.  The content of the "file" is the target of the symlink.
Use `git-add link` to stage the symlink for the next commit (just
like a file), `git-mv` to rename a symlink (just like a file), etc.
Editing a symlink to point to a new target is just a matter of
using the OS' tools (e.g. `ln -sf newdst link`).

So long as core.symlinks isn't set or is set to true Git will
recreate the symlink upon checkout of the revision, just like it
recreates plain text files.

-- 
Shawn.
