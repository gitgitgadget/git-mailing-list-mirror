From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] shortstatus v1
Date: Tue, 10 Feb 2009 13:36:56 +0100
Message-ID: <499174E8.3030207@drmicha.warpmail.net>
References: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com> <20090210110330.GB12089@coredump.intra.peff.net> <49916524.4000400@drmicha.warpmail.net> <20090210114506.GF12089@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 10 13:38:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWrsm-0003vR-Cp
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 13:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbZBJMhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 07:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbZBJMhF
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 07:37:05 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39716 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751920AbZBJMhE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Feb 2009 07:37:04 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 6D7A828F3A7;
	Tue, 10 Feb 2009 07:37:02 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 10 Feb 2009 07:37:02 -0500
X-Sasl-enc: 16J34RbXpW9p5pI4QkU0n/lnb8fxzJsna9Bf8nIFtf1P 1234269421
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6132D27474;
	Tue, 10 Feb 2009 07:37:01 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090209 Shredder/3.0b2pre
In-Reply-To: <20090210114506.GF12089@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109224>

Jeff King venit, vidit, dixit 10.02.2009 12:45:
...
>> Right now, "git status" is basically "git commit --dry-run", which may
>> or may not be good, but certainly is not what people coming from other
>> vcs expect. I would suggest having "git commit -n" replace "git status"
>> if I hadn't done so already or if I dared to (I can't remember ;) ).
> 
> I would much prefer that, if it had been done that way from the
> beginning. But I think we are stuck with "git status" due to hysterical
> raisins.

ROTFTCOOTF!

Now I know why I never liked those caricatures of grapes...

>> "git ls-files" may do but has a different set of mode characters. I
>> think that sums up what preceeded Junio's patch from October.
> 
> But you only need to use it here to get the untracked files, so it
> doesn't matter what it says about modified files.
> 
> The big downside with the snippet I posted above is that it runs three
> separate commands that go through the index. In theory, you could do it
> in one pass. But wt-status _doesn't_ do that, since the diff
> infrastructure isn't there (a long time ago, Junio had an experimental
> parallel diff walker patch, but it never made it out of next).

We completely agree. How do you suggest to progress? Go for the diff
walker? For a (porc.) command like shortstatus I think going through the
index 3 times isn't that bad, all disk access should be cached after the
first run.

Michael
