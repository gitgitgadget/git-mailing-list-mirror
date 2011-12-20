From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCHv3 02/11] git-p4: test debug macro
Date: Mon, 19 Dec 2011 17:35:17 -0800
Message-ID: <20111220013517.GB20591@padd.com>
References: <1324147942-21558-1-git-send-email-pw@padd.com>
 <1324147942-21558-3-git-send-email-pw@padd.com>
 <4EED1B06.80007@diamand.org>
 <20111218013651.GA18735@padd.com>
 <20111218032238.GA6368@elie.hsd1.il.comcast.net>
 <20111218140633.GB16487@padd.com>
 <7vwr9to8kk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 20 02:35:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcoc4-0007tn-RK
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 02:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420Ab1LTBfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 20:35:24 -0500
Received: from honk.padd.com ([74.3.171.149]:38783 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753220Ab1LTBfW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 20:35:22 -0500
Received: from tic.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id D233720C8;
	Mon, 19 Dec 2011 17:35:21 -0800 (PST)
Received: by tic.padd.com (Postfix, from userid 1000)
	id D5E9C10006A; Mon, 19 Dec 2011 20:35:17 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vwr9to8kk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187492>

gitster@pobox.com wrote on Sun, 18 Dec 2011 13:48 -0800:
> You may have found this handy yourself, but I would rather not to see it
> here in the current form for multiple reasons.
> 
>  - Why "ctrl-c"? You are not even spawning shell from here but are having
>    the user interact with this state in the middle of a test from another
>    shell, no?
> 
>    Why not "When done, type <RET>" and have a "read junk" or something
>    instead? That would be a lot simpler and you do not have to worry about
>    portability with many lines of comments.
> 
>    An alternative is to spawn an interactive shell here, and change the
>    "Debug me" comment to say "ctrl-d when done".

Good point.  I'll get rid of all that trap business.

>  - This is not linked to the generic "debug" option "txxxx-name.sh -d".
>    Shouldn't you be extending test_debug so that it can go interactive,
>    give customized comments&insns (i.e. "cd $here" may be useful for test
>    scripts outside testing p4, but "P4PORT=..." would not be, so the user
>    of test_debug in t9800-git-p4.* needs customizability of the message).

That's good advice; each (set of) script(s) could customize as
needed.

The pain of having to track down the P4PORT, which varies with
each test script, was my main motivation for trying to automate
this.

I'll not resubmit this one until coming up with something
prettier.

> Also could we please rename p4 related tests in t/t98* series so that it
> is clear that they are about git-p4 from "ls t/" output (i.e. have them
> all have "git-p4" in their names)?

Sure.  That was a mistake.  We'll fix it up.

		-- Pete
