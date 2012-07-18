From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Extract Git classes from git-svn (2/10) (was Re: Fix git-svn
 tests for SVN 1.7.5.)
Date: Wed, 18 Jul 2012 10:58:35 +0000
Message-ID: <20120718105835.GA32215@dcvr.yhbt.net>
References: <5004B772.3090806@pobox.com>
 <20120717174446.GA14244@burratino>
 <5005F164.3060300@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 12:58:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrRxp-0001n6-Az
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 12:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670Ab2GRK6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 06:58:37 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60617 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753278Ab2GRK6f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 06:58:35 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 502A71F42A;
	Wed, 18 Jul 2012 10:58:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <5005F164.3060300@pobox.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201674>

Michael G Schwern <schwern@pobox.com> wrote:

Hi Michael, thanks for taking your time to help with this.

I agree with everything Jonathan said (and thank him for taking
the time to point you in the right direction).

I too (very strongly) prefer email for code review.  I doubt I would've
ever gotten involved if git were run differently.  I'm actually
disappointed the mailing list culture that built git hasn't rubbed off
to other projects that adopt git.

> +++ b/t/Git-SVN/00compile.t

> +use Test::More tests => 2;

I prefer not declaring test counts and using done_testing() instead.
done_testing() is favorable to me in at least 2 ways:

* done_testing() closely matches the behavior of the existing
  sh-based test suite in git (which calls test_done)

* maintaining test counts leads to unnecessary merge conflicts

Skipping the tests on old versions of Test::More (< 0.88) is acceptable
to me (especially since integration tests provide the real coverage
already).

> +++ b/t/Git-SVN/Utils/can_compress.t

> +use Test::More 'no_plan';

no_plan is the worst way to use Test::More, I think.
