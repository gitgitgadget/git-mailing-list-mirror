From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Tue, 2 Oct 2007 22:58:53 -0400
Message-ID: <20071003025853.GA11440@coredump.intra.peff.net>
References: <20071002155800.GA6828@coredump.intra.peff.net> <200710021916.44388.andyparkins@gmail.com> <20071002191104.GA7901@coredump.intra.peff.net> <7vsl4tjo28.fsf@gitster.siamese.dyndns.org> <20071002204848.GA8284@coredump.intra.peff.net> <7vr6kdhwsg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 04:59:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcuS0-0000eP-QS
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 04:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270AbXJCC64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 22:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753551AbXJCC64
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 22:58:56 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2245 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003AbXJCC64 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 22:58:56 -0400
Received: (qmail 11025 invoked by uid 111); 3 Oct 2007 02:58:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 02 Oct 2007 22:58:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2007 22:58:53 -0400
Content-Disposition: inline
In-Reply-To: <7vr6kdhwsg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59772>

On Tue, Oct 02, 2007 at 05:22:23PM -0700, Junio C Hamano wrote:

> >   strbuf_init(&url);
> >   strbuf_addf(&url, "%s/objects/pack/pack-%s.idx", repo->base, hex);
> 
> Ugh, this typically calls snprintf() twice doesn't it?

Yes, it probably does. However, I think it is considerably easier to
read and more maintainable. Are you "ugh"ing because of the performance
impact (which should be negligible unless this is in a tight loop) or
because of the portability problems associated with va_copy?

-Peff
