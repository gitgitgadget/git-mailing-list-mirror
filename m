From: Jeff King <peff@peff.net>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Mon, 20 Feb 2012 09:39:52 -0500
Message-ID: <20120220143952.GA8387@sigill.intra.peff.net>
References: <CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
 <20120216192001.GB4348@sigill.intra.peff.net>
 <CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
 <20120217203755.GA30114@sigill.intra.peff.net>
 <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
 <20120217222912.GC31830@sigill.intra.peff.net>
 <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
 <20120220140653.GC5131@sigill.intra.peff.net>
 <87ty2l38ay.fsf@thomas.inf.ethz.ch>
 <20120220143644.GA13938@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 15:40:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzUPI-0007p6-7V
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 15:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057Ab2BTOjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 09:39:55 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43840
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205Ab2BTOjz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 09:39:55 -0500
Received: (qmail 1592 invoked by uid 107); 20 Feb 2012 14:39:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Feb 2012 09:39:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2012 09:39:52 -0500
Content-Disposition: inline
In-Reply-To: <20120220143644.GA13938@do>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191076>

On Mon, Feb 20, 2012 at 09:36:44PM +0700, Nguyen Thai Ngoc Duy wrote:

> > test_expect_failure 'checkout gives cache-tree' '
> > 	git checkout HEAD^ &&
> > 	test_shallow_cache_tree
> > '
> > 
> > ;-)
> 
> Quick and dirty that passes that test. I think we could do better if
> we analyse two way merge rules carefully and avoid this diff, but
> that's too much for me right now.

Unpack trees is already sprinkled with cache_tree_invalidate_path. But
something seems to throw away the cache tree entirely (I think it may be
that the extension simply isn't copied over to the destination index).
I'm walking through it right now.

-Peff
