From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] Offer to print changes while running git-mergetool
Date: Sun, 08 Feb 2009 12:38:55 +0000
Message-ID: <498ED25F.3020401@hashpling.org>
References: <1233930745-77930-1-git-send-email-jon.delStrother@bestbefore.tv>	 <7vr62ay8dh.fsf@gitster.siamese.dyndns.org>	 <57518fd10902070401x14cc7cacrfb8bc88bbf2999cd@mail.gmail.com>	 <498E3456.1080509@hashpling.org> <57518fd10902080343p47e30330ufdf2ece909ea0bd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan del Strother <jon.delStrother@bestbefore.tv>
X-From: git-owner@vger.kernel.org Sun Feb 08 13:40:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW8xW-00056W-1Y
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 13:40:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbZBHMi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 07:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbZBHMi7
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 07:38:59 -0500
Received: from relay.pcl-ipout01.plus.net ([212.159.7.99]:27839 "EHLO
	relay.pcl-ipout01.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751603AbZBHMi6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Feb 2009 07:38:58 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEADNhjknUnw4U/2dsb2JhbADMRIQaBg
Received: from pih-relay08.plus.net ([212.159.14.20])
  by relay.pcl-ipout01.plus.net with ESMTP; 08 Feb 2009 12:38:57 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay08.plus.net with esmtp (Exim) id 1LW8w4-0004Nj-K5; Sun, 08 Feb 2009 12:38:56 +0000
Received: from [192.168.76.29] (heisenberg2.hashpling.org [192.168.76.29])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n18CctWB019126;
	Sun, 8 Feb 2009 12:38:56 GMT
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <57518fd10902080343p47e30330ufdf2ece909ea0bd9@mail.gmail.com>
X-Plusnet-Relay: e917abafffd8d37a0ceebcbb6ffde459
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108970>

Jonathan del Strother wrote:
>> Given that mergetool picks up from where it left off when run a second
>> time, what does this patch offer over Ctrl-c, run log tool of your
>> choice, re-run mergetool? Or just running git log in a different
>> terminal instance?
>>
> 
> A large part of my motivation behind this patch was basically
> education - my team (and myself) have made poor merge decisions in the
> past, largely due to not being aware of a tool like "git log --merge".
> The patch was attempting to get inexperienced users to make better use
> of such tools. I certainly wouldn't be averse to using gitk instead.

My point wasn't that we should use gitk instead, I was just trying to
illustrate that there may be a whole raft of other commands or
activities that a user might want to run to help them with a merge so
why should we hard wire any one of them into mergetool?

The other doubt that I've since had about this patch is this. Is just
before running the merge tool the best place to offer to show the log?

In my usual workflows (not necessarily the best!), I usually want to
fire up the merge tool as quickly as possible to get the merge
resolutions done.

Only once I'm in the mergetool do I realise that this one's a bit
complex and I might need to consult the logs to help me resolve this one.

But now, mergetool is blocked waiting for the merge tool to finish. If I
abort the merge it's going to offer me the option to abort completely or
carry on with the next file. (Perhaps "try again" could be a future
direction that mergetool might offer, but it doesn't at the moment.)

I'm far more likely to want to consult the logs in a different terminal
(or gui) with the merge tool still running, especially if I've already
merged some of the easy chunks and have only hit difficulties later on
in the merge.

Charles.
