From: Jeff King <peff@peff.net>
Subject: Re: push race
Date: Tue, 16 Oct 2012 00:51:18 -0400
Message-ID: <20121016045118.GA21359@sigill.intra.peff.net>
References: <CAB9Jk9Be4gGaBXixWN7Xju7N6RGKH+FonhaTbZFJ6uYsJDk8dg@mail.gmail.com>
 <CACBZZX5keWVDZ-rvQfHFChKRC1YwXcUvfiqzgeMjVTydnQCdmg@mail.gmail.com>
 <507C1DB4.2010000@xiplink.com>
 <20121015185608.GC31658@sigill.intra.peff.net>
 <CAJo=hJu=eqgUhJvvpMLJ05AT6o+nVUDcm+tHV8en8OCX2-2qgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: marcnarc@xiplink.com,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 06:51:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNz7t-0003ra-6c
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 06:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755684Ab2JPEvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 00:51:22 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53600 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755652Ab2JPEvV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 00:51:21 -0400
Received: (qmail 11845 invoked by uid 107); 16 Oct 2012 04:51:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Oct 2012 00:51:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Oct 2012 00:51:18 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJu=eqgUhJvvpMLJ05AT6o+nVUDcm+tHV8en8OCX2-2qgA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207800>

On Mon, Oct 15, 2012 at 07:09:52PM -0700, Shawn O. Pearce wrote:

> On Mon, Oct 15, 2012 at 11:56 AM, Jeff King <peff@peff.net> wrote:
> > Right. The only thing that needs locking is the refs, because the object
> > database is add-only for normal operations, and by definition collisions
> > mean you have the same content (or are astronomically unlucky, but your
> > consolation prize is that you can write a paper on how you found a sha1
> > collision).
> 
> Its worth nothing that a SHA-1 collision can be identified at the
> server because the server performs a byte-for-byte compare of both
> copies of the object to make sure they match exactly in every way. Its
> not fast, but its safe. :-)

Do we? I thought early versions of git did that, but we did not
double-check collisions any more for performance reasons. You don't
happen to remember where that code is, do you (not that it really
matters, but I am just curious)?

-Peff
