From: Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC3.5 05/12] send-email: Improve redability and
	error-handling in send_message's sendmail code
Date: Mon, 20 Apr 2009 22:00:22 -0400
Message-ID: <20090421020021.GA14479@coredump.intra.peff.net>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com> <1240074128-16132-2-git-send-email-mfwitten@gmail.com> <1240074128-16132-3-git-send-email-mfwitten@gmail.com> <1240074128-16132-4-git-send-email-mfwitten@gmail.com> <1240074128-16132-5-git-send-email-mfwitten@gmail.com> <1240074128-16132-6-git-send-email-mfwitten@gmail.com> <7vljpwp0jr.fsf@gitster.siamese.dyndns.org> <7vfxg4nl0e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 04:02:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw5JD-0000tO-5z
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 04:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbZDUCA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 22:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbZDUCA2
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 22:00:28 -0400
Received: from peff.net ([208.65.91.99]:59024 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126AbZDUCA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 22:00:28 -0400
Received: (qmail 5892 invoked by uid 107); 21 Apr 2009 02:00:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 20 Apr 2009 22:00:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Apr 2009 22:00:22 -0400
Content-Disposition: inline
In-Reply-To: <7vfxg4nl0e.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117073>

On Sun, Apr 19, 2009 at 06:58:57PM -0700, Junio C Hamano wrote:

> >> +		(my $pid = open my $pipe, '|-')
> >> +			// die "Could not fork to run '$smtp_server': $!\n";
> >
> > Have I already rejected this "5.10 or later" construct in the previous
> > round?  If I haven't, please consider now I have.
> 
> Sorry, I should have checked myself.  defined-or "//" is 5.8.1 or later.

I don't think that's right. perl581delta lists it in the "Future
Directions" section and says

  A new operator "//" (defined-or) _will_ be available.

(emphasis mine). I don't think it was in a stable version until 5.10
(where it is listed as "now this is available" in perl5100delta.
Which puts it squarely in the "too new to use" list.

-Peff
