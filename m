From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 14:39:02 +0200
Message-ID: <20080911123902.GB2056@cuci.nl>
References: <20080909194354.GA13634@cuci.nl> <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org> <20080909235848.GE7459@cuci.nl> <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org> <20080910054244.GB15715@cuci.nl> <alpine.LFD.1.10.0809100828360.3384@nehalem.linux-foundation.org> <20080910230906.GD22739@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <48C90F06.4000309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 14:40:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdlT2-0003lT-Ud
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 14:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbYIKMjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 08:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbYIKMjF
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 08:39:05 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:58505 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbYIKMjE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 08:39:04 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 1079F5465; Thu, 11 Sep 2008 14:39:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48C90F06.4000309@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95606>

A Large Angry SCM wrote:
>Stephen R. van den Berg wrote:
>>If you fetch just branches A, B and C, but not D, the origin link from A
>>to D is dangling. 

>I do not understand how this can be considered an acceptable behavior. 
>If an object ID is referenced in an object header, particularly commit 
>objects, fetch must gather those objects also because to do otherwise 
>breaks the cryptographic authentication in git.

No it does not.
The cryptographic seal is calculated over the content of the commit,
which includes the hashes of all referenced objects, but doesn't include
the objects themselves.
The content of the commit is not violated.

Do not forget though:
- origin links are a rare occurrence.
- When they occur, they usually were made to point into other (deemed)
  important public branches.
- Due to the fact that the branches they are pointing into are important
  and public, in most cases the origin links *will* point to objects you
  actually already have (even if you fetched from someone else).
- The only time you're going to have dangling origin links is when
  they were pointing at someone's private branches, in which case it was
  not very prudent of the committer to actually record the link in the
  first place.  But nothing breaks if you don't have his private branch
  locally.
-- 
Sincerely,
           Stephen R. van den Berg.
"There are three types of people in the world;
 those who can count, and those who can't."
