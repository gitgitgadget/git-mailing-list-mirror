From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] fetch-pack: fix object_id of exact sha1
Date: Thu, 3 Mar 2016 19:50:00 -0500
Message-ID: <20160304005000.GA1074@sigill.intra.peff.net>
References: <CABaesJK+zuuYAJ6YaEugLMFywMqE8V0W1=_4mJPGDAnfT9yXJg@mail.gmail.com>
 <1456798376-29904-1-git-send-email-gabrielfrancosouza@gmail.com>
 <20160301045453.GB19272@sigill.intra.peff.net>
 <CABaesJ+5B9WEqJQsK5s+WFczWMfvBgTx6UmVwjAL-WAf55zJUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 01:50:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abdwZ-00086i-HE
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 01:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756888AbcCDAuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 19:50:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:54520 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756793AbcCDAuE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 19:50:04 -0500
Received: (qmail 27317 invoked by uid 102); 4 Mar 2016 00:50:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Mar 2016 19:50:03 -0500
Received: (qmail 11385 invoked by uid 107); 4 Mar 2016 00:50:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Mar 2016 19:50:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Mar 2016 19:50:00 -0500
Content-Disposition: inline
In-Reply-To: <CABaesJ+5B9WEqJQsK5s+WFczWMfvBgTx6UmVwjAL-WAf55zJUw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288226>

On Thu, Mar 03, 2016 at 08:35:54PM -0300, Gabriel Souza Franco wrote:

> > The code looks good to me. Do we need documentation or test updates?
> >
> > Here's a test that can be squashed in. For documentation, it looks like
> > we don't cover the "<sha1> <ref>" form at all. That's maybe OK, as it's
> > mostly for internal use by remote-http (though fetch-pack _is_ plumbing,
> > so perhaps some other remote-* could make use of it). But perhaps we
> > should document that "<sha1>" should work.
> 
> Thanks for providing a test, I hadn't looked up those yet. For
> documentation, should
> it be on the same patch or a new one? Also, I'm not exactly sure how
> to word that <refs>...
> can also contain a hash instead of a ref.

I think it make sense as part of the same patch. I guess you could still
call the argument "<refs>" even though it takes more now, and just
explain the new feature in the appropriate section. I can't think of a
better word to use (somehow "<objects>" feels too broad, and the primary
use would still be a list of refs).

-Peff
