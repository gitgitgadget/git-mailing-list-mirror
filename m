From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-add--interactive: manual hunk editing mode
Date: Wed, 2 Jul 2008 04:02:01 -0400
Message-ID: <20080702080200.GA21367@sigill.intra.peff.net>
References: <20080701101114.GA6379@sigill.intra.peff.net> <1214912674-9443-1-git-send-email-trast@student.ethz.ch> <7v7ic4hmj5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 10:03:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDxIt-00086D-IR
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 10:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbYGBICG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 04:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752079AbYGBICF
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 04:02:05 -0400
Received: from peff.net ([208.65.91.99]:4198 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751889AbYGBICD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 04:02:03 -0400
Received: (qmail 1690 invoked by uid 111); 2 Jul 2008 08:02:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 02 Jul 2008 04:02:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Jul 2008 04:02:01 -0400
Content-Disposition: inline
In-Reply-To: <7v7ic4hmj5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87098>

On Tue, Jul 01, 2008 at 10:39:58PM -0700, Junio C Hamano wrote:

> > +use File::Temp;
> 
> People with minimum Perl installation should still be able to use "add -i"
> as long as they do not use 'e' subcommand, shouldn't they?  Shouldn't we
> do something like:
> 
> 	my $can_use_temp = eval {
>         	require File::Temp;
>                 1;
> 	};
> 
> and disable 'e' subcommand unless $can_use_temp?

According to Module::CoreList, File::Temp has shipped as part of core
perl since 5.006001. "add -i" doesn't work with perl < 5.6 already due to
things like 3-argument open.

So if the problem is "old perl", I don't think it is an issue. Are there
modern perl installations in the wild that don't have File::Temp?

-Peff
