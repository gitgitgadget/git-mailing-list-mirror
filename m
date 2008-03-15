From: Yann Dirson <ydirson@altern.org>
Subject: Re: Repository corruption
Date: Sat, 15 Mar 2008 14:04:41 +0100
Message-ID: <20080315130441.GF4079@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070903165255.6CEC78B8B2@rover.dkm.cz> <20070903174142.GK10749@pasky.or.cz> <20070910212550.GN1935@nan92-1-81-57-214-146.fbx.proxad.net> <20080315121903.GY10335@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sat Mar 15 14:05:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaW4X-0001s5-Nj
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 14:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbYCONEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 09:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbYCONEL
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 09:04:11 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:53248 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438AbYCONEK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 09:04:10 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 7ECE217B5AE;
	Sat, 15 Mar 2008 14:04:08 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 558B217B5A4;
	Sat, 15 Mar 2008 14:04:08 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id CDBB91F0AB; Sat, 15 Mar 2008 14:04:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080315121903.GY10335@machine.or.cz>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77324>

On Sat, Mar 15, 2008 at 01:19:03PM +0100, Petr Baudis wrote:
>   Hi,
> 
> On Mon, Sep 10, 2007 at 11:25:50PM +0200, Yann Dirson wrote:
> > Not sure if you saw my note in IRC: it looks like tagua/ydirson.git is
> > definitely corrupted - not sure it would be useful to keep a copy
> > around for investigation, but I'd appreciate if you could nuke the
> > contents, so I can push again to it.
> 
>   I have nuked it now. :-)

Thanks :)

Any idea what caused the corruption ?

BTW - although I have not reported it on the list, I recently had a
repo corrupted by a "git gc" with 1.5.4.3.  Not sure there would be a
link between those 2 events, but who knows...

It may not be easy to investigate, since I do not have an exact copy
of it before the corruption (fortunately I was able to salvage most of
the work that had no backup copy), since that repo is a private one
holding source code I am not allowed to publish, and since I will be
leaving in 2 weeks the position that gives me access to that code.

The corruptions were of several kinds:
- commits for unapplied stgit patches were all lost, although they
were reachable from refs/patches/master/*
- seemingly-random objects in the history (commits, trees, probably
blobs as well) were missing

Does anyone have ideas about post-mortem analysis on that repo ?

That tree was managed with stgit, using a rebase/commit workflow, and
accumulated objects reported by git-count-objects over the months kept
growing, even after "git repack -a" and "git prune", which always
looked suspect to me.

Although it is possible that I had already run git-gc on that tree,
that would not be recently - it was basically a "let's try it and see
if we perform better afterwards".

Best regards,
-- 
Yann
