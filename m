From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] sha1_name: don't resolve refs when
 core.warnambiguousrefs is false
Date: Tue, 7 Jan 2014 12:52:42 -0500
Message-ID: <20140107175241.GA20415@sigill.intra.peff.net>
References: <1389065521-46331-1-git-send-email-brodie@sf.io>
 <CAEfQM484kqLSVeyjhYtg7GfXOQkQNjaO1FV2_U3uAqO=Nargdg@mail.gmail.com>
 <20140107171307.GA19482@sigill.intra.peff.net>
 <xmqqzjn7el4k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brodie Rao <brodie@sf.io>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 18:53:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0apc-0006mQ-Dc
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 18:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbaAGRwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 12:52:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:56576 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753030AbaAGRwo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 12:52:44 -0500
Received: (qmail 13383 invoked by uid 102); 7 Jan 2014 17:52:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jan 2014 11:52:43 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jan 2014 12:52:42 -0500
Content-Disposition: inline
In-Reply-To: <xmqqzjn7el4k.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240120>

On Tue, Jan 07, 2014 at 09:51:07AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Alternatively, I guess "cat-file
> > --batch" could just turn off warn_ambiguous_refs itself.
> 
> Sounds like a sensible way to go, perhaps on top of this change?

The downside is that we would not warn about ambiguous refs anymore,
even if the user was expecting it to. I don't know if that matters much.
I kind of feel in the --batch situation that it is somewhat useless (I
wonder if "rev-list --stdin" should turn it off, too).

-Peff
