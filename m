From: Alexander Strasser <eclipse7@gmx.net>
Subject: Re: [PATCH 6/6] t4012: Make --shortstat more robust
Date: Thu, 12 Jul 2012 06:44:51 +0200
Message-ID: <20120712044451.GA23758@akuma>
References: <20120711221327.GA21382@akuma>
 <7vr4sic4e7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 06:45:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpBHB-0001f0-LP
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 06:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914Ab2GLEo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 00:44:59 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:42216 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750949Ab2GLEo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 00:44:58 -0400
Received: (qmail invoked by alias); 12 Jul 2012 04:44:55 -0000
Received: from p5B06F836.dip.t-dialin.net (EHLO gmx.net) [91.6.248.54]
  by mail.gmx.net (mp034) with SMTP; 12 Jul 2012 06:44:55 +0200
X-Authenticated: #8251126
X-Provags-ID: V01U2FsdGVkX1/eCeh3EkzenUBhM1Q2YCfBqSWtZrZCs/uNkmSawN
	Lazq+aFuMs+20T
Received: by gmx.net (sSMTP sendmail emulation); Thu, 12 Jul 2012 06:44:51 +0200
Content-Disposition: inline
In-Reply-To: <7vr4sic4e7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201347>

Hi,

  seems I managed to omit a word in the short log message:
  t4012: Make --shortstat *test* more robust

Junio C Hamano wrote:
> Alexander Strasser <eclipse7@gmx.net> writes:
> 
> > The --shortstat test depends on the same scenario as the --stat
> > test. Use the part of the same expected result for the --stat test
> > to avoid duplicating it manually.
> 
> > diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
> > index 81a9e8c..a3f6030 100755
> > --- a/t/t4012-diff-binary.sh
> > +++ b/t/t4012-diff-binary.sh
> > @@ -38,9 +38,9 @@ test_expect_success 'apply --stat output for binary file change' '
> >  '
> >  
> >  test_expect_success 'diff --shortstat output for binary file change' '
> > -	echo " 4 files changed, 2 insertions(+), 2 deletions(-)" >expected &&
> > +	tail -1 expected >expect &&
> 
> "(tail|head) -n 1" is preferred.  There are the same POSIX.1
> violations in a handful of other scripts, 5526, 7502, 7800 and
> 9146.

  OK, got it.

> >  	git diff --shortstat >current &&
> > -	test_i18ncmp expected current
> > +	test_i18ncmp expect current
> >  '
> >  
> >  test_expect_success 'diff --shortstat output for binary file change only' '
> 
> Other than that, the series looked good.  Thanks.

  I will wait a bit longer for comments and then resend a corrected
version. Thanks for the quick reply.

  Alexander
