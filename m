From: Jeff King <peff@peff.net>
Subject: Re: How to get status-like short format for old commits?
Date: Mon, 26 Mar 2012 16:14:56 -0400
Message-ID: <20120326201456.GC13098@sigill.intra.peff.net>
References: <CAA01CsqM_cmf8A5OjdkX4i-ituCWK95ygEoK_Y0-2LkKo1D7kA@mail.gmail.com>
 <20120326120703.GA5454@ikke-laptop.buyways.nl>
 <CAA01CsppeF8r_hDhuE7snExxJ6zaWdt5Znu82ZzDmyNMzWRDfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin <compufreak@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 22:15:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCGJk-0005b9-PR
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 22:15:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445Ab2CZUO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 16:14:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60187
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752184Ab2CZUO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 16:14:58 -0400
Received: (qmail 17107 invoked by uid 107); 26 Mar 2012 20:15:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Mar 2012 16:15:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2012 16:14:56 -0400
Content-Disposition: inline
In-Reply-To: <CAA01CsppeF8r_hDhuE7snExxJ6zaWdt5Znu82ZzDmyNMzWRDfA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193973>

On Mon, Mar 26, 2012 at 08:53:45PM +0200, Piotr Krukowiecki wrote:

> [log --name-status]
> not so nice as status, but still ok.

Yeah, the code to print the verbose "modified: foo.c" style is specific
to status. We could refactor it to be a new generic diff output type,
which would not be that hard. In practice, though, I think people choose
either "--stat --summary" if they want to show to a person (it's a
superset of what status shows, because it also contains the number of
lines changed for each file), or "--raw" if they need something
machine-readable.

Does one of those work for you? If not, it might be a fun and relatively
simple exercise to create a --verbose-name-status that looks like the
output of "git status" (you could also do it by post-processing
--name-status output, but that is less fun and more hacky :) ).

-Peff
