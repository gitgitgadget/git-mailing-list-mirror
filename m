From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] more push progress tests
Date: Wed, 13 Oct 2010 23:02:20 -0400
Message-ID: <20101014030220.GB20685@sigill.intra.peff.net>
References: <AANLkTim6j7cXj2-1JnKdNLb8KFJK86F02tzeByDBskEa@mail.gmail.com>
 <20101012192117.GD16237@burratino>
 <20101012193204.GA8620@sigill.intra.peff.net>
 <20101012193830.GB8620@sigill.intra.peff.net>
 <7vzkuim1zx.fsf@alter.siamese.dyndns.org>
 <20101013174543.GA13752@sigill.intra.peff.net>
 <AANLkTim6j7cXj2-1JnKdNLb8KFJK86F02tzeByDBskEa@mail.gmail.com>
 <AANLkTin9_kofdy49WF4V_JoovVR+G8DN7vn-cz3p84fz@mail.gmail.com>
 <1286998311-5112-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 05:02:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6E50-0005F6-Ji
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 05:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132Ab0JNDCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 23:02:00 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:40228 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754015Ab0JNDB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 23:01:59 -0400
Received: (qmail 4586 invoked by uid 111); 14 Oct 2010 03:01:57 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 14 Oct 2010 03:01:57 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Oct 2010 23:02:20 -0400
Content-Disposition: inline
In-Reply-To: <1286998311-5112-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159015>

On Thu, Oct 14, 2010 at 03:31:48AM +0800, Tay Ray Chuan wrote:

> [PATCH 1/3] t5523-push-upstream: add function to ensure fresh upstream repo
> [PATCH 2/3] t5523-push-upstream: test progress messages
> [PATCH 3/3] push: pass --progress down to git-pack-objects

I had hoped to have a fix for --no-progress, but munging the tests took
so long that now I am sleepy. :) So here are some extra tests on top of
your series. The first two are refactoring, and the third has the new
tests. It checks regular stderr-is-tty progress and that "push -q"
suppresses progress, as Junio asked elsewhere. And it reveals the bug in
--no-progress.

It might make more sense to actually re-roll your series with the
refactoring at the front, and my 3/3 squashed into your 2/3.

Also, these tests feel a bit out of place in t5523, but I don't see a
better place for them to go. Perhaps they should go in their own test
script. I don't feel strongly, though.

  [1/3]: tests: factor out terminal handling from t7006
  [2/3]: tests: test terminal output to both stdout and stderr
  [3/3]: t5523: test push progress output to tty

-Peff
