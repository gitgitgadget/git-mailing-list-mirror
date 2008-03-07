From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] More test cases for sanitized path names
Date: Fri, 7 Mar 2008 16:24:34 +0100
Message-ID: <200803071624.35369.robin.rosenberg@dewire.com>
References: <47975FE6.4050709@viscovery.net> <200802010534.55925.robin.rosenberg.lists@dewire.com> <7vwsof2b8l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 16:25:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXeRj-0002BW-NA
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 16:25:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755667AbYCGPYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 10:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755930AbYCGPYj
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 10:24:39 -0500
Received: from [83.140.172.130] ([83.140.172.130]:17971 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754393AbYCGPYj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 10:24:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 890608026D6;
	Fri,  7 Mar 2008 16:24:36 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SDEyo3g49sdi; Fri,  7 Mar 2008 16:24:36 +0100 (CET)
Received: from [10.9.0.7] (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id E9BC88026D5;
	Fri,  7 Mar 2008 16:24:35 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vwsof2b8l.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76496>

Den Friday 07 March 2008 09.23.54 skrev Junio C Hamano:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:
> > Verify a few more commands and pathname variants.
> >
> > Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> > ---
> >  t/t7010-setup.sh |   39 +++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 39 insertions(+), 0 deletions(-)
> >
> > These are a few testcases from my earlier attempt at this. The
> > log and commit cases succeeded with Junios version, but not
> > blame and some of the nastier versions for git add (same
> > principle for all commands, just that I use add as an example)
>
> I am very sorry about replying to an ancient topic, but I think I misread
> your patch.
>
> > +test_expect_failure 'add a directory outside the work tree' '
> > +	d1="$(cd .. ; pwd)" &&
> > +	git add "$d1"
> > +	echo $?
> > +'
>
> What I think I misunderstood was that you _wanted_ this (after removing
> the "echo", which was a mistake, which we already talked about) to fail.
> Somehow I ended up committing test_expect_success, which I think was a
> mistake, and I am asking for a sanity-check.
Yes, it should fail, so according to your filosophy, the test should be 
reverted, i.e. ! git add "$d1 and that negated test should pass.

> Likewise for the other two tests.  These "add outside" should fail, right?
>
> > +test_expect_failure 'add a file outside the work tree, nasty case 1' '(
> > +	f="$(pwd)x" &&
> > +	touch "$f" &&
> > +	git add "$f"
> > +)'
> > +
> > +test_expect_failure 'add a file outside the work tree, nasty case 2' '(
> > +	f="$(pwd|sed "s/.$//")x" &&
> > +	touch "$f" &&
> > +	git add "$f"
> > +)'
> > +
> >  test_done

Yes.

-- robin
