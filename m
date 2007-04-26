From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-fetch and unannotated tags
Date: Thu, 26 Apr 2007 17:21:27 +0200
Message-ID: <4630C377.8000602@op5.se>
References: <200704252004.45112.andyparkins@gmail.com> <200704252142.33756.andyparkins@gmail.com> <7vfy6ow4my.fsf@assigned-by-dhcp.cox.net> <200704260904.08447.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 17:21:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hh5ms-0005qJ-Ep
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 17:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031266AbXDZPVc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 11:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031268AbXDZPVc
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 11:21:32 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:42151 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031275AbXDZPVb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 11:21:31 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 72E1F6BCBF; Thu, 26 Apr 2007 17:21:29 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.4
Received: from [192.168.1.179] (unknown [192.168.1.179])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 152E16BCBE; Thu, 26 Apr 2007 17:21:28 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
In-Reply-To: <200704260904.08447.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45638>

Andy Parkins wrote:
> 
> I'd be arguing for making not following unannotated tags the default, and then 
> supply a switch to make them followed.  Is that too painful?  I think that's 
> in keeping with the tradition that unannotated tags are, typically, not 
> wanted in a central repository - the default update hook prevents it for 
> example.
> 

Yup. I share your feelings about simple tags. However, unless the repo owner
has decided to explicitly push the simple tag to the repo, or fscked up by
doing "git push --all" when he had cruft in his own repo, those tags are
in fact part of the repo.

In the "oops" case, I'd point this out to the owner so he/she can delete them
from the central repo (and enable the update-hook that barfs when simple tags
are pushed). If the owner actually wants the tags there, then they're
obviously important for some reason, so keeping them might make sense.

If anything, I'd be more interested in teaching git how to clean up simple
tags. That fix is useful on a wider basis and the "simple vs annotated"
recognition code can be useful for skipping unannotated tags when doing
"git push --all --not-simple" (or some such).

I have no idea where to put it though, as I haven't followed git development
very closely as of late.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
