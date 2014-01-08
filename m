From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 0/5] <branch>@{publish} shorthand
Date: Wed, 8 Jan 2014 04:33:38 -0500
Message-ID: <20140108093338.GA15659@sigill.intra.peff.net>
References: <1389126588-3663-1-git-send-email-artagnon@gmail.com>
 <CALkWK0=g5-9r05vTkys8Tk7iv7PqPZJvMvkYsAOnN_F90Mtgxg@mail.gmail.com>
 <20140107204035.GA27932@sigill.intra.peff.net>
 <CALkWK0mGPhU-8vVg+xY-MGWNstxoXSU9MGQiNzyFN+-Q6Bw28A@mail.gmail.com>
 <20140107211645.GC28102@sigill.intra.peff.net>
 <CALkWK0=UkWEGhU6D8CQctdgTvZUUj276LSuNhSmRUMZ5mwZTeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 10:33:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0pWF-0003l5-SF
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 10:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755067AbaAHJdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 04:33:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:57080 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751456AbaAHJdk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 04:33:40 -0500
Received: (qmail 29415 invoked by uid 102); 8 Jan 2014 09:33:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jan 2014 03:33:40 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jan 2014 04:33:38 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0=UkWEGhU6D8CQctdgTvZUUj276LSuNhSmRUMZ5mwZTeA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240198>

On Wed, Jan 08, 2014 at 03:05:48AM +0530, Ramkumar Ramachandra wrote:

> Agreed. I'll start working on @{publish}. It's going to take quite a
> bit of effort, because I won't actually start using it until my prompt
> is @{publish}-aware.

There's a fair bit of refactoring involved. I took a stab at it and came
up with the series below. No docs or tests, and some of the refactoring
in remote.c feels a little weird. I can't help but feel more of the
logic from "git push" should be shared here.

But it at least works with my rudimentary examples. I'm hoping it will
make a good starting point for you to build on. Otherwise, I may get to
it eventually, but it's not a high priority for me right now.

> Actually, I'm not sure I'd use "git rebase @{pu}"; for me @{pu} is
> mainly a source of information for taking apart to build a new series.

Ah, that's how I'd probably use it, too. :)

  [1/5]: sha1_name: refactor upstream_mark
  [2/5]: interpret_branch_name: factor out upstream handling
  [3/5]: branch_get: return early on error
  [4/5]: branch_get: provide per-branch pushremote pointers
  [5/5]: implement @{publish} shorthand

-Peff
