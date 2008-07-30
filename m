From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: cvs diff -l equivalent?
Date: Wed, 30 Jul 2008 18:17:14 +0200
Message-ID: <20080730161714.GC27166@cuci.nl>
References: <20080730082030.GA12555@cuci.nl> <200807301600.44205.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jul 30 18:18:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOENT-0001pn-5J
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 18:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbYG3QRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 12:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752356AbYG3QRP
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 12:17:15 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:44409 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbYG3QRO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 12:17:14 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 0B22E5466; Wed, 30 Jul 2008 18:17:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200807301600.44205.trast@student.ethz.ch>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90815>

Thomas Rast wrote:
>Stephen R. van den Berg wrote:
>> Someone popped this question on me.  The closest I got was:

>>    git diff .

>> But that still recurses.  Any solutions without patching?

>Maybe a scripted version?  For just 'git diff .', this should work:

>  git diff $(git ls-files . | grep -v /)

git diff $(git ls-files --exclude-standard . | fgrep -v /)

comes the closest, so it seems.

>That will still do the wrong thing if you diff against an older commit
>with a different list of files.  In that case you need the list of
>files in the other side of the diff too:

>  git diff HEAD^..  -- $(git ls-files . | grep -v /; git ls-tree HEAD^ | cut -f2)

This doesn't seem to do the right thing, it messes up with which commit we
diff.
-- 
Sincerely,
           Stephen R. van den Berg.

How many weeks are there in a lightyear?
