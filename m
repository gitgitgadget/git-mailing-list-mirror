From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 31 Dec 2006 14:38:45 +0100
Message-ID: <17815.48485.178000.90522@lapjr.intranet.kiel.bmiag.de>
References: <7vhcvcfpze.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 14:39:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H10uF-0005iN-U5
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 14:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933174AbWLaNjG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 08:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933175AbWLaNjF
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 08:39:05 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:34246 "EHLO
	meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933173AbWLaNjE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 08:39:04 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id 495C03AECC;
	Sun, 31 Dec 2006 14:39:00 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 06178-05; Sun, 31 Dec 2006 14:39:00 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de (eotheod.intranet.kiel.bmiag.de [10.130.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id 6BE633AECB;
	Sun, 31 Dec 2006 14:38:58 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 2B90F3ADC8;
	Sun, 31 Dec 2006 14:38:58 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eotheod [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 03316-09; Sun, 31 Dec 2006 14:38:55 +0100 (CET)
Received: from LAPJR (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id B182F3ADC6;
	Sun, 31 Dec 2006 14:38:49 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhcvcfpze.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eotheod.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35697>

Junio C Hamano writes:
 > * jc/3way (Wed Nov 29 18:53:13 2006 -0800) 1 commit
 >  + git-merge: preserve and merge local changes when doing fast
 >    forward
 > 
 > A few people wanted to have this in v1.5.0, but I am a bit
 > reluctant to do so --- I think the behaviour of its failure mode
 > is rather nasty, even though it tries to help the user by
 > dropping the local diff in .git/LOCAL_DIFF file.

It happened to me (not really an experienced user) for the first time
on the last pull. Though unexpected it wasn't an unpleasant
experience. The failure mode doesn't feel smooth, but after thinking
about possible improvements I couldn't come up with anything better.
It already states explicitly what it's doing including telling the
user about LOCAL_DIFF. The only thing I wasn't sure about was how to
get rid of the unmerged index entries after I fixed the conflicts
without adding the local change to the index. In the end I did an
update-index/reset combination, but perhaps repeating the list of
files with conflicting local changes after the merge and cleaning the
index instead of leaving unmerged entries in the index would be
better.

I think (because of LOCAL_DIFF) it is safe to have this in 1.5 even in
its current incarnation.
