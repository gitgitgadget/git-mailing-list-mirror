From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: name pack files after trailer hash
Date: Mon, 16 Dec 2013 14:28:30 -0500
Message-ID: <20131216192830.GA30238@sigill.intra.peff.net>
References: <CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com>
 <20131128092935.GC11444@sigill.intra.peff.net>
 <CAJo=hJuBTjGfF2PvaCn_v4hy4qDfFyB=FXbY0=Oz3hcE0L=L4Q@mail.gmail.com>
 <20131204200850.GB16603@sigill.intra.peff.net>
 <CAJo=hJuRz9Qc8ztQATkEs8huDfiANMA6gZEOapoofVdoY82k4g@mail.gmail.com>
 <20131205160418.GA27869@sigill.intra.peff.net>
 <20131205202807.GA19042@sigill.intra.peff.net>
 <52AEAEB2.6060203@alum.mit.edu>
 <20131216190445.GB29324@sigill.intra.peff.net>
 <20131216191933.GE2311@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 16 20:28:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsdqG-0006eh-PP
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 20:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153Ab3LPT2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 14:28:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:45709 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754466Ab3LPT2c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 14:28:32 -0500
Received: (qmail 25257 invoked by uid 102); 16 Dec 2013 19:28:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Dec 2013 13:28:32 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Dec 2013 14:28:30 -0500
Content-Disposition: inline
In-Reply-To: <20131216191933.GE2311@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239353>

On Mon, Dec 16, 2013 at 11:19:33AM -0800, Jonathan Nieder wrote:

> >              I was tempted to explicitly say something like "this is
> > opaque and meaningless to you, don't rely on it", but I don't know that
> > there is any need.
> [...]
> > On top of jk/name-pack-after-byte-representations, naturally.
> 
> I think there is --- if someone starts caring about the SHA-1 used,
> they won't be able to act on old packfiles that were created before
> this change.  How about something like the following instead?

Right, my point was that I do not think anybody has ever cared, and I do
not see them starting now. But that is just my intuition.

> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
> index d94edcd..cdab9ed 100644
> --- a/Documentation/git-pack-objects.txt
> +++ b/Documentation/git-pack-objects.txt
> @@ -51,8 +51,7 @@ base-name::
>  	<base-name> to determine the name of the created file.
>  	When this option is used, the two files are written in
>  	<base-name>-<SHA-1>.{pack,idx} files.  <SHA-1> is a hash
> -	of the sorted object names to make the resulting filename
> -	based on the pack content, and written to the standard
> +	based on the pack content and is written to the standard

I'm fine with that. I was worried it would get clunky, but the way you
have worded it is good.

-Peff
