From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] Remove the suggestion to use parsecvs, which is
 currently broken.
Date: Sun, 6 Jan 2013 17:34:20 +0100
Message-ID: <20130106163420.GA3378@book-mint>
References: <20121228162025.8565E4413A@snark.thyrsus.com>
 <20121228230149.GA3575@book-mint>
 <20121229044200.GA16086@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 17:36:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrtCn-0000Mo-6r
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 17:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051Ab3AFQfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 11:35:54 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:40510 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756034Ab3AFQfx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 11:35:53 -0500
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1TrtAy-0001QA-NC; Sun, 06 Jan 2013 17:34:20 +0100
Content-Disposition: inline
In-Reply-To: <20121229044200.GA16086@thyrsus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212812>

Hi,

On Fri, Dec 28, 2012 at 11:42:00PM -0500, Eric S. Raymond wrote:
> Heiko Voigt <hvoigt@hvoigt.net>:
> > Maybe you could add that information to the parsecvs compile
> > instructions? I think just because it takes some effort to compile does
> > not justify to remove this useful pointer here. When I was converting a
> > legacy cvs repository this pointer would have helped me a lot.
> 
> I'm parsecvs's maintainer now.  It's not in good shape; there is at
> least one other known showstopper besides the build issue.  I would
> strongly prefer to direct peoples' attention away from it until I
> have time to fix it and cut a release.  This is not a distant 
> prospect - two or three weeks out, maybe.

So for this short amount of time you want to change gits documentation?
Is this hint causing you trouble? Are there many people asking for
support because of that?

Even if it takes some effort to get parsecvs running I would like to
keep the hint to a good and proven cvs importer.

> The priority that is between me and fixing parsecvs is getting (a)
> cvsps and git-cvsimport to a non-broken state, and (b) having a sound
> test suite in place so I *know* it's in a non-broken state. As previously
> discussed, I will then apply that test suite to parsecvs.
> 
> Heiko, you can speed up the process by (a) adapting your tests for
> the new cvsps test code,

I had a quick glance at your testsuite. After building cvsps with
	make
and cd'ing into test I got a lot of error messages some saying that
cvsps was not found when issuing
	make
there. It would be great if do not need to install cvsps into my path
just for running the testsuite. 

There is no README so I am not sure how the tests are supposed to be
build in general. Due to the lack of documentation its probably easier
for you Eric to port my tests.

The structure of my tests is quite simple:

	t/  - All the tests
	t/cvsroot - A cvs module per test
	t/t[0-9]{4}*/expect - The expected cvsps output

You can copy the cvs repository modules and convert the expected cvsps
output to whatever output you want to test against. It the found
changeset ordering that is interesting.

> and (b) merging the fix you wrote so cvsps
> would pass the t9603 test.  

The fix was never clean and AFAIR the reason behind that was that the
breakage in commit ordering is not easy to fix in cvsps. That and
because there are other working tools out there was the reason why I
stopped working on fixing cvsps.

Cheers Heiko
