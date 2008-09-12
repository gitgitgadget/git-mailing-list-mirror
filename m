From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 02:13:23 +0200
Message-ID: <20080912001323.GG29559@cuci.nl>
References: <20080909235848.GE7459@cuci.nl> <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org> <20080910054244.GB15715@cuci.nl> <alpine.LFD.1.10.0809100828360.3384@nehalem.linux-foundation.org> <20080910230906.GD22739@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <48C90F06.4000309@gmail.com> <20080911123902.GB2056@cuci.nl> <48C9B1C8.9070007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 02:14:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdwIy-0007se-OK
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 02:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962AbYILANZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 20:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752535AbYILANZ
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 20:13:25 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:53236 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbYILANY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 20:13:24 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id C1A965465; Fri, 12 Sep 2008 02:13:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48C9B1C8.9070007@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95675>

A Large Angry SCM wrote:
>Stephen R. van den Berg wrote:
>>No it does not.
>>The cryptographic seal is calculated over the content of the commit,
>>which includes the hashes of all referenced objects, but doesn't include
>>the objects themselves.
>>The content of the commit is not violated.

>The fetch MUST gather the referenced objects ALWAYS or I can't verify 
>the history. To do otherwise means that ID strings on the origin lines 
>are nothing more than an arbitrary text tag and not pointer to a 
>specific history.

To fetch, by default, the origin lines *are* nothing more than arbitrary
text and not a pointer to a specific history.

>How do I verify (think git-fsck) that what the origin lines refer to 
>are, in fact, commits with the proper relationships? Either they HAVE to 
>be in the repository or the references do not belong in the header.

If the origin hashes are not reachable, then fsck is required to silently
skip them, according to spec.
If the origin hashes *are* reachable, then fsck is required to verify
that they refer to proper commits with a normal history.
-- 
Sincerely,
           Stephen R. van den Berg.
"There are three types of people in the world;
 those who can count, and those who can't."
