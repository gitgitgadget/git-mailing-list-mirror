From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC/PATCH] t9159-*.sh: Don't use the svn '@<rev>' syntax
Date: Wed, 20 Jul 2011 17:59:55 +0100
Message-ID: <4E27098B.906@vilain.net>
References: <4E21D295.7020600@ramsay1.demon.co.uk> <7vvcuy82kn.fsf@alter.siamese.dyndns.org> <4E269AB6.8070207@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>, mhagger@alum.mit.edu
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jul 20 19:08:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjaFh-0004cy-Jp
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 19:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844Ab1GTRH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 13:07:58 -0400
Received: from uk.vilain.net ([92.48.122.123]:37539 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613Ab1GTRH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 13:07:58 -0400
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jul 2011 13:07:57 EDT
Received: by uk.vilain.net (Postfix, from userid 1001)
	id EEBE9824E; Wed, 20 Jul 2011 17:59:56 +0100 (BST)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [IPv6:::1] (localhost [127.0.0.1])
	by uk.vilain.net (Postfix) with ESMTP id 64B3A81C3;
	Wed, 20 Jul 2011 17:59:55 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
In-Reply-To: <4E269AB6.8070207@drmicha.warpmail.net>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177543>

On 20/07/11 10:07, Michael J Gruber wrote:
> path@REV are so-called peg revisions, introduced in svn 1.1, and denote
> "I mean the file named path in REV" (as opposed to "the file named path
> now and maybe differently back then"). It (now) defaults to BASE (for
> worktree) resp. HEAD (for URLs). A bit like our rename detection.
>
> -r REV specifies the operative revision. After resolving the
> name/location using the pegrev, the version at the resolved path at the
> oprative version is operated on.
>
> svn 1.5.0 (June 2008) introduced peg revisions to "svn copy", so I
> assume our people were following svn trunk and adjusting in 2007 already
> (to r22964). There were some fixes to "svn copy" with peg later on.
>
> I do not understand the above commit message at all; and I did not find
> anything about how "svn copy -r REV" acted in svn 1.4. I would assume
> "operative revision", and the above commit message seems to imply that
> peg defaulted to REV here (not HEAD) and that that changed in 1.5.0, but
> that is a wild guess (svnbook 1.4 does not so anything).

What happened is that I noticed that the code stopped working after svn
1.5 was released.  Previously I wrote it to detect the merge properties
as left by SVK and the experimental/contrib python script for merging. 
I was testing at times using trunk SVN versions.  You could probably
figure it out by running ffab6268^ with svn 1.4.x vs svn 1.5.x if you
cared.  My comment tries to explain what you describe above, but without
the correct terms.  I could see via experimentation what the difference
was between "-r N" and '/path@N', and that the behaviour changed in svn
1.5.  Apologies for not explaining this thoroughly enough in the
submitted description!

HTH,
Sam
