From: Yann Dirson <ydirson@altern.org>
Subject: Re: Some ideas for StGIT
Date: Sat, 4 Aug 2007 10:08:01 +0200
Message-ID: <20070804080801.GD30277@nan92-1-81-57-214-146.fbx.proxad.net>
References: <1186163410.26110.55.camel@dv> <200708031914.04344.andyparkins@gmail.com> <1186206085.28481.33.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Catalin Marinas <catalin.marinas@gmail.com>
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 10:09:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHEhG-0000Eh-Ij
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 10:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756441AbXHDIJL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 04:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756104AbXHDIJL
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 04:09:11 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:56514 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756173AbXHDIJI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 04:09:08 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 01FEB73AA;
	Sat,  4 Aug 2007 10:09:07 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id D078038A4;
	Sat,  4 Aug 2007 10:09:06 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 53A9E1F070; Sat,  4 Aug 2007 10:08:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1186206085.28481.33.camel@dv>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54813>

On Sat, Aug 04, 2007 at 01:41:25AM -0400, Pavel Roskin wrote:
> [quote]
> Sometimes, I just make patches in quilt, then I do "quilt 
> refresh", "quilt pop -a", "cd patches" and modify the patches 
> and series file manually, e.g. by moving one patch from one file 
> into the other.
> [end of quote]

FWIW, I have written a couple of scripts to help moving stuff around
between patches.  Those are not yet integrated in stgit proper, and it
happens that the 0.13 tarball does not contain them, they are only
available from the git tree (better use my tree[1], since I updated them
recently).

Most notably relevant to this use are stg-fold-files-from and
stg-dispatch, to move diff hunks between patches.  They only cases
(off the top of my hand) where they do not fit my needs are:
 - when I need to move a part of a diff hunk that is not possible to
 isolate using -U<n> (but I have read interesting things about git-gui
 for such functionnality, so that will surely come one day)
 - when I need to move git-specific diff hunks (moves, permissions,
 etc.), since it uses filterdiff, which is not git-aware (yet ?)

(in short, there are lots of dev to do in/around stgit, but there are
not as many contributors as there is for git - hint, hint ;)

If there are other typical situations where they need to edit patches,
I'd be interested to hear about them.  Not to avoid implementing patch
edition in stgit, since it is occasionally useful to fix a typo when
reviewing at refresh time, but to see what higher-level tools we could
provide.

Best regards,
-- 
Yann

[1] gitweb at http://repo.or.cz/w/stgit/ydirson.git
