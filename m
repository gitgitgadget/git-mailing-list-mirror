From: Jeff King <peff@peff.net>
Subject: Re: cloning a tree which has detached branch checked out
Date: Tue, 7 Feb 2012 12:16:04 -0500
Message-ID: <20120207171604.GA26614@sigill.intra.peff.net>
References: <20120207070628.GA24698@redhat.com>
 <m362fjklb7.fsf@localhost.localdomain>
 <20120207104100.GA24828@redhat.com>
 <CACsJy8DtmQLX+Lfng-QRzVg9sfo8gQMXB-xTtPYpt+R2gModTg@mail.gmail.com>
 <20120207153225.GA14773@sigill.intra.peff.net>
 <7v4nv236xn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 18:16:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuoeL-0003ZE-RP
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 18:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544Ab2BGRQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 12:16:08 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59314
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754178Ab2BGRQH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 12:16:07 -0500
Received: (qmail 9003 invoked by uid 107); 7 Feb 2012 17:23:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Feb 2012 12:23:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Feb 2012 12:16:04 -0500
Content-Disposition: inline
In-Reply-To: <7v4nv236xn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190185>

On Tue, Feb 07, 2012 at 09:11:00AM -0800, Junio C Hamano wrote:

> > This particular bug should have been fixed before that, even, with my
> > c1921c1 (clone: always fetch remote HEAD, 2011-06-07). And it is tested
> > explicitly in t5707,...
> [...]
> What is funny is "error: Trying to write ref HEAD with nonexistant object".
> "git grep -e nonexistant f3fb0" does not register any hit.

That misspelling of "nonexistent" was fixed by 7be8b3b (Fix typo:
existant->existent, 2011-06-16), around the same time as my clone patch.
Which really makes me wonder if the OP is accidentally running an old
version of git during the tests.

> >> On Tue, Feb 7, 2012 at 5:41 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> >> > #git clone -n lab:/home/mst/scm/linux
> [...]
> Could it be that mysterious "lab:" protocol handler that is misbehaving?

I think you are misreading. It would be "lab::" in that case, no? The
command above should do ssh transport to the machine "lab".

-Peff
