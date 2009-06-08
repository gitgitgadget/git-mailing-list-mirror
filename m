From: Jeff King <peff@peff.net>
Subject: Re: [Patch] Prevent cloning over http from spewing
Date: Mon, 8 Jun 2009 07:54:31 -0400
Message-ID: <20090608115431.GC13775@coredump.intra.peff.net>
References: <20090602174229.GA14455@infidigm.net> <m3vdnda9f7.fsf@localhost.localdomain> <7vmy8p8947.fsf@alter.siamese.dyndns.org> <20090603191050.GB29564@coredump.intra.peff.net> <20090603191555.GL3355@spearce.org> <be6fef0d0906040545j7bd754e0j2c60af833e2ac4a4@mail.gmail.com> <20090604160152.GA13984@sigill.intra.peff.net> <be6fef0d0906070331y5fd596d1k67893a96a4d872ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, sparse@infidigm.net,
	git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 13:54:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDdRA-0001CC-OL
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 13:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754765AbZFHLyk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2009 07:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754748AbZFHLyj
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 07:54:39 -0400
Received: from peff.net ([208.65.91.99]:54799 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754727AbZFHLyi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 07:54:38 -0400
Received: (qmail 21219 invoked by uid 107); 8 Jun 2009 11:54:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 08 Jun 2009 07:54:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Jun 2009 07:54:31 -0400
Content-Disposition: inline
In-Reply-To: <be6fef0d0906070331y5fd596d1k67893a96a4d872ac@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121065>

On Sun, Jun 07, 2009 at 06:31:38PM +0800, Tay Ray Chuan wrote:

> > =C2=A0 =C2=A0 something like
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0Fetching %s (got %d packs, %d loose): (%=
d/%d)
> [...]
> Hmm, just wondering, is this is the intended display for "-q" or "-v"=
?
> Or should I do isatty(), like builtin-pack-objects.c does for the
> "Writing objects" progress indicator?

I was imagining:

  - without "-q", show progress if isatty(1).

  - with "-q", never show progress

  - with "-v", show the "getting pack" and "walk" output we show now;
    without "-v", don't show it. "-v" has no impact on the progress
    indicator.=20

-Peff
