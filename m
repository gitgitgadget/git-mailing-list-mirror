From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: name pack files after trailer hash
Date: Mon, 16 Dec 2013 14:35:33 -0500
Message-ID: <20131216193533.GA3488@sigill.intra.peff.net>
References: <CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com>
 <20131128092935.GC11444@sigill.intra.peff.net>
 <CAJo=hJuBTjGfF2PvaCn_v4hy4qDfFyB=FXbY0=Oz3hcE0L=L4Q@mail.gmail.com>
 <20131204200850.GB16603@sigill.intra.peff.net>
 <CAJo=hJuRz9Qc8ztQATkEs8huDfiANMA6gZEOapoofVdoY82k4g@mail.gmail.com>
 <20131205160418.GA27869@sigill.intra.peff.net>
 <20131205202807.GA19042@sigill.intra.peff.net>
 <52AEAEB2.6060203@alum.mit.edu>
 <20131216190445.GB29324@sigill.intra.peff.net>
 <xmqqzjo0oako.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 16 20:35:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vsdx8-0003Yc-BM
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 20:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467Ab3LPTfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 14:35:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:45721 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755228Ab3LPTfg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 14:35:36 -0500
Received: (qmail 25729 invoked by uid 102); 16 Dec 2013 19:35:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Dec 2013 13:35:35 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Dec 2013 14:35:33 -0500
Content-Disposition: inline
In-Reply-To: <xmqqzjo0oako.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239355>

On Mon, Dec 16, 2013 at 11:33:11AM -0800, Junio C Hamano wrote:

> >  	<base-name> to determine the name of the created file.
> >  	When this option is used, the two files are written in
> >  	<base-name>-<SHA-1>.{pack,idx} files.  <SHA-1> is a hash
> > +	of the bytes of the packfile, and is written to the standard
> 
> "hash of the bytes of the packfile" tempts one to do
> 
>     $ sha1sum .git/objects/pack/pack-*.pack
> 
> but that is not what we expect. I wonder if there are better ways to
> phrase it (or alternatively perhaps we want to make that expectation
> hold by updating our code to hash)?

Yeah, I wondered about that, but didn't think it was worth the verbosity
to explain that the true derivation. I think Jonathan's suggestion takes
care of it, though.

-Peff
