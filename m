From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Dangerous "git am --abort" behavior
Date: Wed, 22 Dec 2010 10:49:19 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1012221046100.24315@ds9.cixit.se>
References: <AANLkTinP4SArMkjvTXOEG=tf=8EcEdP9fPAB7F=iitSc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Dec 22 11:00:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVLV3-0007bi-0m
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 11:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411Ab0LVKAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 05:00:40 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:38884 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751992Ab0LVKAh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 05:00:37 -0500
X-Greylist: delayed 634 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Dec 2010 05:00:36 EST
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id oBM9nKif030539
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 22 Dec 2010 10:49:20 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id oBM9nJ0r030536;
	Wed, 22 Dec 2010 10:49:20 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <AANLkTinP4SArMkjvTXOEG=tf=8EcEdP9fPAB7F=iitSc@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Wed, 22 Dec 2010 10:49:20 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164075>

Linus Torvalds:

> I just noticed this, and I wonder if it has bitten me before without
> me noticing: "git am --abort" can be really dangerous.

Indeed, I have been bitten by that several times, having worked heavily on 
applying patches at $dayjob for a while now. I have taken to habit to always 
do the same "rm -rf .git/rebase-apply" that you mention before doing anything 
involving am or rebase...

> Or maybe we could just introduce a new "git am --clean" that just flushes 
> any old pending state (ie does that "clean_abort" thing, which is 
> basically just the "rm -rf" I've done by hand).

That would be very helpful, as manually doing a "rm -rf" inside the .git 
directory does make me nervous each time I do it...

-- 
\\// Peter - http://www.softwolves.pp.se/
