From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 08:56:58 +0200
Message-ID: <20080912065658.GA15391@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809100841080.3384@nehalem.linux-foundation.org> <alpine.LFD.1.10.0809100844040.3384@nehalem.linux-foundation.org> <200809101823.22072.jnareb@gmail.com> <48C9A9A4.8090703@vilain.net> <alpine.LFD.1.10.0809111641110.3384@nehalem.linux-foundation.org> <20080912054739.GB22228@cuci.nl> <48CA09E7.8090102@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Fri Sep 12 08:58:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke2bz-0005um-ML
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 08:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbYILG5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 02:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752120AbYILG5A
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 02:57:00 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:42177 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbYILG47 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 02:56:59 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id BC6D45465; Fri, 12 Sep 2008 08:56:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48CA09E7.8090102@dawes.za.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95688>

Rogan Dawes wrote:
>Stephen R. van den Berg wrote:
>>It would probably become computationally prohibitive to use it between
>>long lived permanent branches.  In that case it would need to be
>>augmented by the sha1 of the originating commit.  Which gives you two
>>hashes as reference, and in that case you might as well use the two
>>commit hashes of which the difference yields the patch.

>Pardon my confusion, but why include two commit hashes? Surely the 
>commit already has its parent, so there is no need to include that in 
>your "cherry pick". And if the commit has more than one parent, then I 
>doubt you could/should really cherry-pick it anyway.

Well, actually, sometimes cherry-pick does pick just one of the
(multiple) parents to diff with; also, some people (not I) envisioned
using two commits which were not a direct parent and child of one
another (I'm not quite sure how that would work, but the model would
support it).

>Besides, you could always augment your local repo with a mapping of 
>patch ids to commits/commit pairs to reduce lookup time.

Yes, possible.  But then after cloning, this mapping-cache needs to be
recreated, and that would mean that one would have to walk through all
commits and calculate all patch-id's, of which then only those few which are
referenced need to be stored.
-- 
Sincerely,
           Stephen R. van den Berg.

"Father's Day: Nine months before Mother's Day."
