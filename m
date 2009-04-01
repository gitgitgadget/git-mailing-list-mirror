From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: On git 1.6 (novice's opinion)
Date: Wed, 01 Apr 2009 09:35:17 +0200
Organization: Universitaetsklinikum Regensburg
Message-ID: <49D33556.24356.5A16ED@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <7veiwi5t8j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 09:37:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lov0c-00052n-Ts
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 09:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760425AbZDAHfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 03:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759775AbZDAHfj
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 03:35:39 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([194.94.155.53]:28356 "EHLO
	rrzmta2.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760128AbZDAHfi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2009 03:35:38 -0400
Received: from rrzmta2.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id D1A99C4607;
	Wed,  1 Apr 2009 09:35:38 +0200 (CEST)
Received: from kgate1.dvm.klinik.uni-regensburg.de (kgate1.klinik.uni-regensburg.de [132.199.176.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by rrzmta2.rz.uni-regensburg.de (Postfix) with ESMTP id A5E5BC4554;
	Wed,  1 Apr 2009 09:35:37 +0200 (CEST)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by kgate1.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20070831MT-1) with ESMTP id n317ZUPn000519;
	Wed, 1 Apr 2009 09:35:30 +0200
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    1 Apr 09 09:35:29 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 1 Apr 09 09:35:23 +0100
In-reply-to: <7veiwi5t8j.fsf@gitster.siamese.dyndns.org>
X-mailer: Pegasus Mail for Windows (4.41)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.29/Sophos-P=4.37.0+V=4.37+U=2.07.219+R=05 January 2009+T=589357@20090401.072036Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115345>

On 27 Mar 2009 at 18:30, Junio C Hamano wrote:

> "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:
> 
> > ... Also some seemingly dangerous commands that cannot easily be undone
> > should ask safety questions ("cvs merge (-j)" would also fall into that
> > category.
> 
> This is slightly an interesting point.
> 
> In CVS and Subversion, "merge" (rather "update") can be a dangerous
> operation.  You start working, you keep building, and you eventually
> accumulate quite a lot of changes but you still cannot see the end of the
> tunnel.  Your changes are incomplete and you will upset others if you
> commit.  Your changes are extensive enough that it can conflict heavily
> with what others have done already, and there is a high chance that you
> can screw up the merging but there is no easy way (unless you tar-up the
> whole work tree before attempting to update) to get back to the state
> before your merge.  Damned if you commit, damned if you don't.  You lose
> either way.
> 
> This is because you cannot have a local commit.  The problem is inherent
> to the centralized nature of these systems.
> 
> Distributed systems are different.  Unlike CVS/Subversion's
> 
> 	work work work; then
> 
>         update to merge, risk screwing up the work in progress (or almost
> 	finished work); then
> 
>         commit
> 
> workflow, in a distributed system, you first commit and then merge,
> preferably from a clean slate.  You will not have to worry about screwing
> up the conflict resolution, because both states (what the other guy did,
> and what you did) are committed safely away and you can reset back to the
> state before you start your merge.

Hi!

OK, that example is not that dangerous in git, but git also has commands a 
beginner could make some undesired damage ("git rebase", maybe).

Regards,
Ulrich
