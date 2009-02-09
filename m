From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Article about "git bisect run" on LWN
Date: Mon, 9 Feb 2009 13:19:43 +0100
Message-ID: <20090209121943.GG17782@elte.hu>
References: <200902050747.50100.chriscool@tuxfamily.org> <20090205141336.GA28443@elte.hu> <200902060623.16046.chriscool@tuxfamily.org> <200902070541.29955.chriscool@tuxfamily.org> <ee77f5c20902070455h360d8476re76294735673b4ca@mail.gmail.com> <7vskmqw1s4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Symonds <dsymonds@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Andreas Ericsson <ae@op5.se>,
	Jeff Garzik <jeff@garzik.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bill Lear <rael@zopyra.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 13:22:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWV98-00010t-VO
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 13:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895AbZBIMUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 07:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755297AbZBIMUH
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 07:20:07 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:41759 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754021AbZBIMUF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 07:20:05 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1LWV75-0007Mg-SL
	from <mingo@elte.hu>; Mon, 09 Feb 2009 13:19:54 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id A6A6B3E21B0; Mon,  9 Feb 2009 13:19:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vskmqw1s4.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109065>


* Junio C Hamano <gitster@pobox.com> wrote:

> David Symonds <dsymonds@gmail.com> writes:
> 
> > On Sat, Feb 7, 2009 at 3:41 PM, Christian Couder
> > <chriscool@tuxfamily.org> wrote:
> >
> >> It might be useful to have a list of always good commits too, and use it
> >> like this:
> >>
> >> $ git bisect start <bad> <good> $(cat always_good.txt)
> >> $ git bisect skip $(cat always_skipped.txt)
> >> $ git bisect run ./my_test_script.sh
> >
> > Your test script could just do this at its start instead:
> >
> >   if cat always_good.txt | grep $(rev-parse HEAD); then
> >     exit 0
> >   elif cat always_skipped.txt | grep $(rev-parse HEAD); then
> >     exit 125
> >   fi
> 
> Don't cat a file into grep, please.

I do it all the time not because i dont know about grep's ability
to take a file parameter, but because this way it's just a
special-case of command piping and i can inject other commands as
i extend/edit the command line interactively, etc.

	Ingo
