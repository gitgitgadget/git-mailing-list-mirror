From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 7/7] Make 'stg pull' use git-fetch and not git-pull.
Date: Thu, 1 Feb 2007 19:47:05 +0100
Message-ID: <20070201184705.GC5362@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070129230117.7102.64322.stgit@gandelf.nowhere.earth> <20070129230555.7102.93948.stgit@gandelf.nowhere.earth> <b0943d9e0701311544k22986545x351c04a8faab8814@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 01 19:48:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCgyn-0001bM-QD
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 19:48:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422932AbXBASsP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 13:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422936AbXBASsO
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 13:48:14 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:40713 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422932AbXBASsO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 13:48:14 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 1514D4352F;
	Thu,  1 Feb 2007 19:48:12 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id DD10F1F080; Thu,  1 Feb 2007 19:47:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <b0943d9e0701311544k22986545x351c04a8faab8814@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38387>

On Wed, Jan 31, 2007 at 11:44:07PM +0000, Catalin Marinas wrote:
> On 29/01/07, Yann Dirson <ydirson@altern.org> wrote:
> >We introduce a new pull-does-rebase setting, as companion to pullcmd.
> >This allows to use both pullcmd's that need a rebase (like git-fetch)
> >and pullcmd's that do not (like git-pull).
> 
> Thanks for the patches. I applied all of them but I have a question on this 
> one:
> 
> >+    if (config.get('stgit.pull-does-rebase')):
> >+        # FIXME!
> >+        reset(tree_id = rev_parse(repository))
> 
> Why the "FIXME" here? The alternative is switch() and it might be safer.

The last 2 patches, including the one with this FIXME, will need some
work.

In this case, we should reset to the parent branch.  It currently just
works because traditionnaly we use refs/heads/origin from remote
"origin", and "rev-parse origin" resolves to that branch.


Best regards,
-- 
Yann
