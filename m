From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] Use compatibility regex library for OSX/Darwin
Date: Tue, 16 Sep 2008 19:46:24 -0400
Message-ID: <20080916234624.GA14405@coredump.intra.peff.net>
References: <20080907184537.GA4148@regex.yaph.org> <W_emvcr7ijntBMNCDV17_XHXotGkm1Bn-9Bw-ZixcXmFyBWlDj5vYg@cipher.nrlssc.navy.mil> <alpine.LNX.1.10.0809161722580.18110@suse104.zenez.com> <20080916233220.GA14173@coredump.intra.peff.net> <alpine.LNX.1.10.0809161738010.17105@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Arjen Laarhoven <arjen@yaph.org>, git@vger.kernel.org,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 01:47:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfkGd-0006VN-L0
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 01:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbYIPXq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 19:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbYIPXq1
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 19:46:27 -0400
Received: from peff.net ([208.65.91.99]:3105 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329AbYIPXq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 19:46:27 -0400
Received: (qmail 25536 invoked by uid 111); 16 Sep 2008 23:46:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 16 Sep 2008 19:46:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Sep 2008 19:46:24 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0809161738010.17105@suse104.zenez.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96053>

On Tue, Sep 16, 2008 at 05:42:11PM -0600, Boyd Lynn Gerber wrote:

> When I do a gmake test these 4 platforms all fail only these 2 tests.
>
> * FAIL 10: reinit
> [...]
> * FAIL 11: init with --template
> [...]
> gmake[1]: *** [t0001-init.sh] Error 1
>
> I have not had time to look into the failures.  How many tests should I  
> see and pass.  The first 40 all pass.  Then 2 of 12 fail as above.

These failures are unrelated to the described problem, and prevent the
system from continuing on to run other tests.

So if you get a chance, please:

  1. Run t0001 in verbose mode and report the results so we can get a
     better idea of what's failing:

       gmake test GIT_TEST_OPTS=--verbose

  2. Run t4018 individually and report on the results:

       cd t && gmake t4018-diff-funcname.sh

-Peff
