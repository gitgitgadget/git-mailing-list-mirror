From: Johan Herland <johan@herland.net>
Subject: Re: git filter-branch --filter-notes/--post-rewrite?
Date: Fri, 18 Mar 2011 01:16:14 +0100
Message-ID: <201103180116.14754.johan@herland.net>
References: <hbf.20110317iwua@bombur.uio.no>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Fri Mar 18 01:16:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0NMf-0007G1-Fw
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 01:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755982Ab1CRAQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 20:16:19 -0400
Received: from smtp.getmail.no ([84.208.15.66]:54382 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754333Ab1CRAQS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 20:16:18 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LI8002RR8R3JP80@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 18 Mar 2011 01:16:15 +0100 (MET)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 72E2B1EEF30C_D82A44FB	for <git@vger.kernel.org>; Fri,
 18 Mar 2011 00:16:15 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 425E81EEF2F6_D82A44FF	for <git@vger.kernel.org>; Fri,
 18 Mar 2011 00:16:15 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LI800KE08R3H920@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 18 Mar 2011 01:16:15 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.1; x86_64; ; )
In-reply-to: <hbf.20110317iwua@bombur.uio.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169288>

On Thursday 17 March 2011, Hallvard B Furuseth wrote:
> Is there a git version where filter-branch can copy notes, or with a
> post-rewrite hook?  I found an old discussion of that on WWW, but
> nothing seems to have come of that yet.  Currently I remove the 'rm
> -rf "$tempdir"' in git-filter-branch.sh so the info is available
> for a separate script.

No, AFAIK notes copying (or post-rewrite hook) has not yet been implemented 
in filter-branch. However, it shouldn't be very difficult to add support for 
this:

Looking at git-rebase.sh (where it _is_ implemented), it seems to be a 
matter of feeding "old_sha1 new_sha1" pairs into a "rewritten" file, and 
then passing that file to the stdin of "git notes copy --for-rewrite=filter-
branch" (followed by passing the same file to the "post-rewrite" hook).


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
