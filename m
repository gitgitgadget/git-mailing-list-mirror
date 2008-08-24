From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2008, #07; Sat, 23)
Date: Sun, 24 Aug 2008 12:16:12 -0700
Message-ID: <7vd4jymdfn.fsf@gitster.siamese.dyndns.org>
References: <7v1w0ft750.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0808241955550.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 24 21:17:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXL5c-0008HN-5m
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 21:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995AbYHXTQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 15:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752914AbYHXTQX
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 15:16:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbYHXTQW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 15:16:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0AFED6DC67;
	Sun, 24 Aug 2008 15:16:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 39B466DC65; Sun, 24 Aug 2008 15:16:15 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0808241955550.24820@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Sun, 24 Aug 2008 20:12:43 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 22878AC8-7211-11DD-A15F-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93551>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> * sb/daemon (Thu Aug 14 20:02:20 2008 +0200) 4 commits
>>  - git-daemon: rewrite kindergarden, new option --max-connections
>>  - git-daemon: Simplify dead-children reaping logic
>>  - git-daemon: use LOG_PID, simplify logging code
>>  - git-daemon: call logerror() instead of error()
>> 
>> Can somebody who actually runs the daemon standalone comment on this 
>> one?
>
> I am somewhat uneasy about running my production machine with these 
> changes, since the last commit (the one introducing a kindergarden with 
> cradles) is too unobvious for me.

Well, I didn't ask anybody to _run_ it.

I asked people who care about their daemons to comment on the change, so
that if there are any issues in the code that I didn't see, the breakage
gets caught before it propagates to their daemons they build from 'next'
or 'master'.

Having said that, I do agree that the kindergarden change is very involved
(it removes more code than it adds --- the reduction of lines is somewhat
inflated because quite a lot of comments that have become stale gets
removed by the patch).
