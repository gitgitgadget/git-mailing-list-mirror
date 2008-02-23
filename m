From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] t3404: use configured shell instead of /bin/sh
Date: Sat, 23 Feb 2008 17:49:38 -0500
Message-ID: <20080223224938.GA14231@coredump.intra.peff.net>
References: <20080220235944.GA6278@coredump.intra.peff.net> <200802232113.40100.johannes.sixt@telecom.at> <7v63wf2yzt.fsf@gitster.siamese.dyndns.org> <200802232209.41428.johannes.sixt@telecom.at> <20080223211536.GA13280@coredump.intra.peff.net> <7vmypr1gmh.fsf@gitster.siamese.dyndns.org> <20080223223933.GA13683@coredump.intra.peff.net> <7vve4fz3y1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Whit Armstrong <armstrong.whit@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 23:50:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT3CD-0002MH-Bk
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 23:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288AbYBWWtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 17:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754278AbYBWWtl
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 17:49:41 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4875 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754052AbYBWWtl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 17:49:41 -0500
Received: (qmail 11703 invoked by uid 111); 23 Feb 2008 22:49:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 23 Feb 2008 17:49:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Feb 2008 17:49:38 -0500
Content-Disposition: inline
In-Reply-To: <7vve4fz3y1.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74873>

On Sat, Feb 23, 2008 at 02:46:30PM -0800, Junio C Hamano wrote:

> I think our messages are crossing, but (1) currently we do not
> export much from t/Makefile and the only people who can get
> affected are on platforms that do need custom configuration, and
> the difference being subtle and rare makes it more surprising
> and harder to diagnose when the difference does matter, (2) I'd
> like to place some stuff in t/Makefile in such a way that no
> tests that runs a server that listens to a network port is not
> run by default, among other things, which means the difference
> between "sh tXXXX-name.sh" and "make tXXXX-name" will get
> bigger not smaller.

OK, thanks for explaining (point 2 was what I was looking for).
Personally, I think we are better off putting such configuration into a
file that gets sourced by test-lib.sh, but I don't overly care. I _do_
find "sh -x tXXXX-name.sh" useful from time to time, but mainly only
while debugging the test scripts themselves.

-Peff
