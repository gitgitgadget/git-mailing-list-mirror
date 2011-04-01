From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] teach wait_or_whine a "quiet" mode
Date: Thu, 31 Mar 2011 21:35:20 -0400
Message-ID: <20110401013519.GB21036@sigill.intra.peff.net>
References: <20110331184243.GA12027@sigill.intra.peff.net>
 <20110331184342.GA16906@sigill.intra.peff.net>
 <201103312256.39317.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Apr 01 03:35:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5TGq-0002Ax-II
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 03:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031Ab1DABfX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 21:35:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46771
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751701Ab1DABfW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 21:35:22 -0400
Received: (qmail 4924 invoked by uid 107); 1 Apr 2011 01:36:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Mar 2011 21:36:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2011 21:35:20 -0400
Content-Disposition: inline
In-Reply-To: <201103312256.39317.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170547>

On Thu, Mar 31, 2011 at 10:56:39PM +0200, Johannes Sixt wrote:

> On Donnerstag, 31. M=C3=A4rz 2011, Jeff King wrote:
> > The wait_or_whine function will complain to stderr in a few
> > cases:
> >
> >   1. We fail to actually waitpid() correctly.
> >
> >   2. The child died of a signal.
> >
> >   3. The child returned exit code 127, indicating a missing
> >      command to exec after forking.
> >
> > We already have a silent_exec_failure flag to silence (3).
> > Let's convert that into a "quiet" flag to also silence (2).
>=20
> I'm rather negative on controlling these two error reports with the s=
ame flag=20
> because...

=46air enough. We can add an extra flag, then, or just drop both patche=
s
entirely. They are just trying to save the "child process killed"
message when we abort a separate-process async.

-Peff
