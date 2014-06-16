From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: fix charset detection of extract_content_type()
Date: Mon, 16 Jun 2014 15:20:05 -0400
Message-ID: <20140616192005.GA19322@sigill.intra.peff.net>
References: <539caff7.e7bc420a.76b9.fffff853@mx.google.com>
 <xmqqha3kr9m4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: nori <semtlenori@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 21:20:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwcRy-0007as-6I
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 21:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559AbaFPTUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 15:20:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:45425 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751349AbaFPTUH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 15:20:07 -0400
Received: (qmail 10550 invoked by uid 102); 16 Jun 2014 19:20:06 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Jun 2014 14:20:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jun 2014 15:20:05 -0400
Content-Disposition: inline
In-Reply-To: <xmqqha3kr9m4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251804>

On Mon, Jun 16, 2014 at 11:29:39AM -0700, Junio C Hamano wrote:

> nori <semtlenori@gmail.com> writes:
> 
> > extract_content_type() could not extract a charset parameter if the
> > parameter is not the first one and there is a whitespace and a following
> > semicolon just before the parameter. For example:
> >
> >     text/plain; format=fixed ;charset=utf-8
> >
> > Signed-off-by: Yi EungJun <eungjun.yi@navercorp.com>
> > ---
> 
> Peff, doesn't this look somehow familiar?  Perhaps with e3131626
> (http: optionally extract charset parameter from content-type,
> 2014-05-22), this patch is unnecessary?

No, I think this is built on top of e3131626 to catcha case I mised. It
looks OK at first glance, but I'd really like to add better test
coverage for this parsing.

-Peff
