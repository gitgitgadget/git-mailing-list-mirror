From: Jan Hudec <bulb@ucw.cz>
Subject: Does it make sense to pull from mirror? (Re: [BUG?] push to
 mirrior interferes with parallel operations)
Date: Thu, 18 Nov 2010 19:49:04 +0100
Message-ID: <20101118184904.GO3693@efreet.light.src>
References: <e355bb33c6192a6a29de56c7be93278e.squirrel@artax.karlin.mff.cuni.cz>
 <20101118175007.GA26505@sigill.intra.peff.net>
 <20101118175810.GB26505@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 18 19:49:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ9Xk-00009r-Km
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 19:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760127Ab0KRStG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 13:49:06 -0500
Received: from cuda1.bluetone.cz ([212.158.128.5]:40752 "EHLO
	cuda1.bluetone.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887Ab0KRStF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 13:49:05 -0500
X-ASG-Debug-ID: 1290106144-0703ee710001-QuoKaX
Received: from efreet.light.src (152-31-80-78.tmcz.cz [78.80.31.152]) by cuda1.bluetone.cz with ESMTP id JkNYgGwCzZb6aWoo; Thu, 18 Nov 2010 19:49:04 +0100 (CET)
X-Barracuda-Envelope-From: bulb@ucw.cz
X-Barracuda-Apparent-Source-IP: 78.80.31.152
Received: from bulb by efreet.light.src with local (Exim 4.72)
	(envelope-from <bulb@ucw.cz>)
	id 1PJ9Xc-00048Z-6F; Thu, 18 Nov 2010 19:49:04 +0100
X-ASG-Orig-Subj: Does it make sense to pull from mirror? (Re: [BUG?] push to
 mirrior interferes with parallel operations)
Content-Disposition: inline
In-Reply-To: <20101118175810.GB26505@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Barracuda-Connect: 152-31-80-78.tmcz.cz[78.80.31.152]
X-Barracuda-Start-Time: 1290106144
X-Barracuda-URL: http://212.158.128.5:8000/cgi-mod/mark.cgi
X-Barracuda-Bayes: INNOCENT GLOBAL 0.8082 1.0000 2.2984
X-Barracuda-Spam-Score: 2.30
X-Barracuda-Spam-Status: No, SCORE=2.30 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=4.5 KILL_LEVEL=4.8 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.47003
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161704>

On Thu, Nov 18, 2010 at 12:58:11 -0500, Jeff King wrote:
> It seems to me there are really two kinds of mirrors: one where you will
> fetch everything from the remote, and one where you will push everything
> to the remote.
> 
> You have the latter kind, and the fetch refspec is just causing
> problems. Removing it would solve not only this issue, but also the fact
> that you would never want to run "git fetch backup", even accidentally,
> in your repo, as it would overwrite your local work.

Accidentally did it already. Fortunately it just died with something like
    "refusing to pull to checked out branch of non-bare repository"
and did nothing at all.
 
> So I think we need --mirror=push, or something similar.

Does it *ever* make sense to have a non-bare pull mirror. I think it does
not.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
