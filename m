From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git-log to go forward instead of reverse?
Date: 10 Jul 2006 12:25:33 -0700
Message-ID: <86mzbhntxu.fsf@blue.stonehenge.com>
References: <86bqrxpai1.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0607101151470.5623@g5.osdl.org>
	<863bd9p9en.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0607101212410.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 21:26:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G01Ny-0007c8-FJ
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 21:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422794AbWGJTZf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 15:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422795AbWGJTZf
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 15:25:35 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:19276 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1422794AbWGJTZe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 15:25:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 275838F36C;
	Mon, 10 Jul 2006 12:25:34 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 30449-01-9; Mon, 10 Jul 2006 12:25:33 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 874438F36E; Mon, 10 Jul 2006 12:25:33 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
x-mayan-date: Long count = 12.19.13.8.4; tzolkin = 1 Kan; haab = 17 Tzec
In-Reply-To: <Pine.LNX.4.64.0607101212410.5623@g5.osdl.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23642>

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

>> Wow.  Yes, I think I can live with that for the application.

Linus> It's a big deal for me, I often end up doing things like

Linus> 	git log -p some-random-file

Linus> to see what has happened, and getting the most recent changes basically 
Linus> instantaneously (rather than waiting for the thing to traverse all of the 
Linus> history) is a big deal.

Well, this is for a "I'm connected to the net right now: please
refresh all of my git mirrors" script:

        ## (code here to cd to the right dir omitted)
                git-fetch
                if git-status | grep -v 'nothing to commit'
                then echo UPDATE SKIPPED
                else
                    if git-pull . origin | egrep -v 'up-to-date'
                    then git-log --pretty=short ORIG_HEAD..HEAD | cat
                    fi
                fi

The log is just so I can quickly eyeball the interesting changes.  The "cat"
is to keep git-log from starting a pager.  (If there's a switch that does
*that* that I've overlooked, that'd be good too.)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
