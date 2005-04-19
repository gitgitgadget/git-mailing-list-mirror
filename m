From: Kevin Smith <yarcs@qualitycode.com>
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: Mon, 18 Apr 2005 21:05:45 -0400
Message-ID: <42645969.2090609@qualitycode.com>
References: <20050418210436.23935.qmail@science.horizon.com> <1113869248.23938.94.camel@orca.madrabbit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, darcs-devel@darcs.net
X-From: git-owner@vger.kernel.org Tue Apr 19 03:03:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNh8A-0006cI-0p
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 03:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVDSBGO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 21:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVDSBGO
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 21:06:14 -0400
Received: from deuterium.rootr.net ([203.194.209.160]:25937 "EHLO
	vulcan.rootr.net") by vger.kernel.org with ESMTP id S261242AbVDSBF4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 21:05:56 -0400
Received: from [10.10.10.20] (147-49.35-65.tampabay.res.rr.com [65.35.49.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vulcan.rootr.net (Postfix) with ESMTP id 431C03C0A;
	Tue, 19 Apr 2005 01:05:46 +0000 (UTC)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
To: Ray Lee <ray-lk@madrabbit.org>
In-Reply-To: <1113869248.23938.94.camel@orca.madrabbit.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ray Lee wrote:
> On Mon, 2005-04-18 at 21:04 +0000, linux@horizon.com wrote:
> 
>>The other is "replace very instace of identifier `foo` with identifier`bar`".
> 
> 
> That could be derived, however, by a particularly smart parser [1].

No, it can't. Seriously. A darcs replace patch is encoded as rules, not
effects, and it is impossible to derive the rules just by looking at the
results. Not difficult. Impossible. You could guess, but that's not good
enough for darcs to be able to reliably commute the patches later.

I am curious whether Linus's suggestion about including the
corresponding darcs patch id in the git commit comments would be good
enough.

> As for "darcs mv", that can be derived from the before/after pictures of
> the trees.

Perhaps. If a file is moved and edited within the same commit, I'm not
sure that you can be certain whether it was done with d 'darcs mv' or
not. Requiring separate checkins for the rename and the subsequent
modify would make things easier on SCM's, but is impractical in real
life. Automated refactoring tools, for example, perform the
rename+modify as an atomic operation.

Now, git might not need to deal with any of this, because it only needs
to work with the kernel project. But darcs does have to deal with this
wide range of uses, as does just about any other SCM.

I'm *not* advocating cluttering up git with features that are not
directly needed for kernel development. I'm just trying to clarify the
facts so everyone can understand what darcs is trying to do.

Kevin
