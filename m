From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: FFmpeg considering GIT
Date: Fri, 04 May 2007 18:09:31 +0200
Organization: eudaptics software gmbh
Message-ID: <463B5ABB.5D7A3EC4@eudaptics.com>
References: <loom.20070502T111026-882@post.gmane.org> <20070503200013.GG4489@pasky.or.cz> <loom.20070504T143538-533@post.gmane.org> <200705041653.49486.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 18:10:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk0MI-0002RO-C9
	for gcvg-git@gmane.org; Fri, 04 May 2007 18:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031046AbXEDQJx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 12:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031075AbXEDQJx
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 12:09:53 -0400
Received: from main.gmane.org ([80.91.229.2]:45743 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031046AbXEDQJr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 12:09:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hk0Ll-0003N0-I9
	for git@vger.kernel.org; Fri, 04 May 2007 18:09:41 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 May 2007 18:09:41 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 May 2007 18:09:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46186>

Andy Parkins wrote:
> On Friday 2007 May 04, Michael Niedermayer wrote:
> > for these we currently copy the last good version of the affected files
> > over the current one with svn cp and then apply the changes in nicely
> > split manner. (possibly without the reindention if its uneeded ...)
> 
> I might be misunderstanding, but doesn't that leave the "bad" commit in the
> history?

In the history? Yes.
In the blame? No.

> 
>  * -- * -- G -- B -- !B -- 1 -- 2 -- 3
> 
> B is the bad commit; !B would be the result of the svn cp from the previous
> known-good revision, "G"; then 1, 2, and 3 would be the correctly split
> version of "B".

With svn cp you actually create this "blame" history:

* -- * -- G -- B
           \
             ----- G* -- 1 -- 2 -- 3

where G* is a new revision, but since it is otherwise identical to G, it
does not introduce new blame-able lines.

-- Hannes
