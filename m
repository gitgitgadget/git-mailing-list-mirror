From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Soem core git optimizations
Date: Sat, 10 May 2008 19:36:46 -0700
Message-ID: <7v4p958t35.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0805090856350.3142@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 11 04:37:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv1Rj-0003G9-K2
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 04:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191AbYEKChE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 22:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754166AbYEKChD
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 22:37:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43472 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140AbYEKChA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 22:37:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4D4454084;
	Sat, 10 May 2008 22:36:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 82F984080; Sat, 10 May 2008 22:36:53 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 212E8E94-1F03-11DD-A2B9-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81728>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I notice that Junio merged my fnmatch-avoidance patch, but I have a few 
> other optimizations that I track in my private tree that I have sent out 
> but probably didn't get much attention. They do matter from a performance 
> angle, even if not as much as avoiding fnmatch did.
> ...
> and while this probably doesn't matter on most loads, the reason I'm 
> re-sending is that I think it's pretty solid and core code. I've been 
> running with both of these patches (and some others) rebased on top of 
> Junio's tree for the last few weeks.

Unfortunately this seems to depend on stuff still in 'next', and a trivial
rebasing seems to break switching branches with "git checkout" in t4122
(switching from 'master' to 'test' will lose arch/i386/boot/Makefile).

I'll take a hint and merge the "case insensitive" and "diff-submodule"
series to 'master' and then apply these two --- the result does not have
the git-checkout breakage.
