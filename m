From: Jeff King <peff@peff.net>
Subject: Re: Git v1.8.4.2 test failure in ./t5570-git-daemon.sh
Date: Mon, 28 Oct 2013 21:30:24 -0400
Message-ID: <20131029013024.GA11861@sigill.intra.peff.net>
References: <20131029005430.GA23920@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	git@vger.kernel.org
To: Simon Ruderich <simon@ruderich.org>
X-From: git-owner@vger.kernel.org Tue Oct 29 02:30:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vay8d-0008RB-U4
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 02:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757519Ab3J2Ba2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 21:30:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:57417 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755810Ab3J2Ba1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 21:30:27 -0400
Received: (qmail 29395 invoked by uid 102); 29 Oct 2013 01:30:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Oct 2013 20:30:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Oct 2013 21:30:24 -0400
Content-Disposition: inline
In-Reply-To: <20131029005430.GA23920@ruderich.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236884>

On Tue, Oct 29, 2013 at 01:54:31AM +0100, Simon Ruderich wrote:

> I just compiled Git v1.8.4.2 on Debian Wheezy amd64 and test
> t5570 fails (with GIT_TEST_GIT_DAEMON=1):
> [...]
> Bisecting leads to this commit:
> 
>     commit 68b939b2f097b6675c4aaa178655559aa81b25cb
>     Author: Jeff King <peff@peff.net>
>     Date:   Wed Sep 18 16:05:13 2013 -0400
> 
>         clone: send diagnostic messages to stderr

This is already fixed by Brian Gernhardt's 360a326 (t5570: Update for
clone-progress-to-stderr branch, 2013-10-21).

Junio, that patch seems to have gone onto jc/upload-pack-send-symref,
but should have gone onto jk/clone-progress-to-stderr. The latter made
it into maint for v1.8.4.2, but the former did not.

I think it was just a simple mixup caused by Brian sending two fixups to
t5570 as series, when they are really fixups for two different topics.
Not worth an immediate v1.8.4.3, I think, but you may want to
cherry-pick 360a326 onto maint if there is another release before
v1.8.5.

-Peff
