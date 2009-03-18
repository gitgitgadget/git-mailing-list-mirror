From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Define a version of lstat(2) specially for copy operation
Date: Tue, 17 Mar 2009 23:17:25 -0400
Message-ID: <gppp48$5sc$1@ger.gmane.org>
References: <81b0412b0903170926p4f2d536el2b96a71c79c0159e@mail.gmail.com> <7vprggqeh2.fsf@gitster.siamese.dyndns.org> <49BFD6DD.1010800@viscovery.net> <20090317202818.GA13458@blimp.localdomain> <7v63i7ridk.fsf@gitster.siamese.dyndns.org> <20090317213820.GC13458@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 04:19:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjmJE-0000nk-Us
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 04:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755318AbZCRDRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 23:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755051AbZCRDRo
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 23:17:44 -0400
Received: from main.gmane.org ([80.91.229.2]:47989 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754861AbZCRDRn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 23:17:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LjmHk-00015J-PL
	for git@vger.kernel.org; Wed, 18 Mar 2009 03:17:40 +0000
Received: from pool-173-79-116-31.washdc.fios.verizon.net ([173.79.116.31])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Mar 2009 03:17:40 +0000
Received: from mlevedahl by pool-173-79-116-31.washdc.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Mar 2009 03:17:40 +0000
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pool-173-79-116-31.washdc.fios.verizon.net
User-Agent: KNode/0.99.01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113569>

Alex Riesen wrote:

> So that Cygwin port can continue work around its supporting
> library and get access to its faked file attributes.
> 
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
> Junio C Hamano, Tue, Mar 17, 2009 21:42:31 +0100:
>> But isn't this something shops that do deploy Cygwin version of git want
>> to see fixed, so that they can have a site-wide policy implemented in the
> 
> Frankly, I doubt they know or care.

Please don't presume to speak for the world here. I have a not insignificant 
group of users, many on Cygwin, and we depend upon identical behavior 
between Linux and Cygwin versions of git. I maintain my own local build of 
git for my group, among other reasons is to disable the non-Posix lstat 
hack.  Using the Win32 lstat does not speed up git that much (maybe 20-30% 
in my experience) and this trade-off of compatibility vs being not quite so 
dreadfully slow is certainly not worth it for me. (Obviously, others have a 
different view, or this feature would not exist).

So, I strongly urge keeping the differences between POSIX/Linux git and 
Cygwin git as minimal as possible.

Mark Levedahl
