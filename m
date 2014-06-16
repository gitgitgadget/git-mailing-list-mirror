From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] verify-commit: scriptable commit signature
 verification
Date: Mon, 16 Jun 2014 16:39:56 -0400
Message-ID: <20140616203956.GA3546@sigill.intra.peff.net>
References: <cover.1402063795.git.git@drmicha.warpmail.net>
 <cc5fd1d554e0357dfb514e3f9ad100d98c16d4d5.1402063796.git.git@drmicha.warpmail.net>
 <20140613080229.GJ7908@sigill.intra.peff.net>
 <539ACA8A.90108@drmicha.warpmail.net>
 <20140613110901.GB14066@sigill.intra.peff.net>
 <xmqqbntw4u4d.fsf@gitster.dls.corp.google.com>
 <20140616195428.GB24376@sigill.intra.peff.net>
 <xmqqk38gpp9v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 22:40:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwdhO-000183-B3
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 22:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755587AbaFPUj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 16:39:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:45504 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752310AbaFPUj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 16:39:57 -0400
Received: (qmail 16072 invoked by uid 102); 16 Jun 2014 20:39:57 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Jun 2014 15:39:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jun 2014 16:39:56 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk38gpp9v.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251823>

On Mon, Jun 16, 2014 at 01:34:20PM -0700, Junio C Hamano wrote:

> > Your middle example above did make me think of one other thing, though.
> > As you noted, we actually have _three_ signature types:
> >
> >   1. signed tags
> >
> >   2. signed commits
> >
> >   3. merges with embedded mergetag headers
> >
> > We already have a tool for (1). Michael is adding a tool for (2). How
> > would one check (3) in a similar way?
> 
> Hmph, somehow I misread the patch that it was for both 2 & 3 X-<.

I was just assuming it handles only (2) without checking further, so I
may be wrong. But I do not think it makes sense to conflate (2) and (3).
A merge commit may have both, and they are separate signatures.

For that matter, is there a way to expose (3) currently, besides via
--show-signature? It does not trigger "%GG" and friends (nor should it).
It may make sense to add extra format specifiers for mergetag
signatures. Though I do not use them myself, so I am not clear on what
the use case is besides a manual, human verification of a particular
merge.

-Peff
