From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-bitmap: do not use gcc packed attribute
Date: Tue, 5 Aug 2014 14:47:24 -0400
Message-ID: <20140805184724.GA10369@peff.net>
References: <20140728171743.GA1927@peff.net>
 <53D806AC.3070806@gmail.com>
 <20140801223739.GA15649@peff.net>
 <20140801231044.GA17960@peff.net>
 <53DFDCD2.2090803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 20:47:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEjlp-0000Dg-A0
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 20:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994AbaHESrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 14:47:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:46491 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753704AbaHESr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 14:47:28 -0400
Received: (qmail 30199 invoked by uid 102); 5 Aug 2014 18:47:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Aug 2014 13:47:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Aug 2014 14:47:24 -0400
Content-Disposition: inline
In-Reply-To: <53DFDCD2.2090803@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254821>

On Mon, Aug 04, 2014 at 09:19:46PM +0200, Karsten Blees wrote:

> Hmm, I wonder if it wouldn't be simpler to read / write the desired on-disk
> structure directly, without copying to a uchar[6] first.

Probably. My initial attempt was to keep together the read/write logic
about which sizes each item is, but I think the result ended up
unnecessarily verbose and harder to follow.

> Here's what I came up with (just a sketch, commit message is lacky and the
> helper functions deserve a better place / name):

I like it. Want to clean it up and submit in place of mine?

-Peff
