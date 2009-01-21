From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Rename detection: Avoid repeated filespec population
Date: Wed, 21 Jan 2009 13:56:19 +0100
Message-ID: <20090121125619.GA523@atjola.homenet>
References: <20090120155957.GA23237@atjola.homenet> <20090120212723.GA10967@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 13:58:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPced-0005m0-8G
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 13:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbZAUM4f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2009 07:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbZAUM4f
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 07:56:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:40293 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751499AbZAUM4e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 07:56:34 -0500
Received: (qmail invoked by alias); 21 Jan 2009 12:56:32 -0000
Received: from i577B870E.versanet.de (EHLO atjola.local) [87.123.135.14]
  by mail.gmx.net (mp010) with SMTP; 21 Jan 2009 13:56:32 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/sBX1xX5nsfdavKv1LwhfezpPf0VQJvu/LriDB6j
	PnVeKyIYA6E7Ve
Content-Disposition: inline
In-Reply-To: <20090120212723.GA10967@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106602>

On 2009.01.20 16:27:23 -0500, Jeff King wrote:
> So I think your patch is absolutely the right thing to do. But I thin=
k
> from the commit message it isn't clear that it would not be equally
> correct to follow through on generating cnt_data instead of an early
> return (which _isn't_ right, because you might not need to generate
> cnt_data at all).

Yeah, the commit message wasn't exactly great, but after the fifth
attempt I decided to just sent the damn thing, to see whether at least
the patch itself makes sense.

Another possible solution would be to free the blob data only after the
loop in diffcore_rename has finished, but that's obviously quite bad WR=
T
memory consumption.  :-)

Anyway, too late, yesterday's attempts 6 to 10 at writing a better
commit message didn't work out either, and Junio has applied the patch
by now.

Bj=F6rn
