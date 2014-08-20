From: Jeff King <peff@peff.net>
Subject: Re: Issuing warning when hook does not have execution permission
Date: Wed, 20 Aug 2014 06:19:22 -0400
Message-ID: <20140820101921.GA21527@peff.net>
References: <CAPyMVO+a+R-+UDVuNSfhyB=PX-NUZbt6VGXfOv19-mDKTqfj6g@mail.gmail.com>
 <20140819080002.GB7712@peff.net>
 <xmqqegwcwhfc.fsf@gitster.dls.corp.google.com>
 <CAFOYHZCGQj1vaZfOpFXHpuf-OjTB5RXRN_37O2EkQFRvow-RfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Babak M <babak@melon.com.au>,
	git <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 12:19:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XK2zL-0000Lh-DW
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 12:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbaHTKT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 06:19:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:55466 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750861AbaHTKT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 06:19:26 -0400
Received: (qmail 4548 invoked by uid 102); 20 Aug 2014 10:19:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Aug 2014 05:19:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Aug 2014 06:19:22 -0400
Content-Disposition: inline
In-Reply-To: <CAFOYHZCGQj1vaZfOpFXHpuf-OjTB5RXRN_37O2EkQFRvow-RfA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255563>

On Wed, Aug 20, 2014 at 08:55:52PM +1200, Chris Packham wrote:

> I actually find the existing behaviour useful. If I want to disable a
> hook to I can just chmod -x .git/hook/... and I then chmod +x it when
> I want to re-enable it. I guess I could live with an extra warning as
> long as the command still succeeds.

You could do the same thing "mv $hook $hook.disabled" but it involves
retraining your fingers. I kind of agree that the existing system of
respecting the executable bit is nice, though: it does what you told it
to do, and a misconfiguration is your problem, not the system's. It's
perhaps worth changing if people frequently get the executable-bit thing
wrong, but I don't know whether they do or not.

I kind of feel like we had a similar discussion around items in PATH,
but I don't remember how it resolved.

-Peff
