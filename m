From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Wed, 12 Nov 2008 14:37:47 -0500
Message-ID: <20081112193747.GA21567@coredump.intra.peff.net>
References: <20081102123519.GA21251@atjola.homenet> <7vljw2yo93.fsf@gitster.siamese.dyndns.org> <20081103071420.GD10772@coredump.intra.peff.net> <32541b130811102004n54a47331v48ba8d299039897f@mail.gmail.com> <20081112083353.GB3817@coredump.intra.peff.net> <alpine.DEB.1.00.0811121205100.30769@pacific.mpi-cbg.de> <20081112110629.GA20473@coredump.intra.peff.net> <32541b130811120739t95455d8n9b8056a8033491c3@mail.gmail.com> <20081112191512.GA21401@coredump.intra.peff.net> <7vljvooi8w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 20:39:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0LYQ-0000t6-2T
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 20:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbYKLThv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 14:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbYKLThu
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 14:37:50 -0500
Received: from peff.net ([208.65.91.99]:4426 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726AbYKLThu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 14:37:50 -0500
Received: (qmail 21670 invoked by uid 111); 12 Nov 2008 19:37:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Nov 2008 14:37:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Nov 2008 14:37:47 -0500
Content-Disposition: inline
In-Reply-To: <7vljvooi8w.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100808>

On Wed, Nov 12, 2008 at 11:29:35AM -0800, Junio C Hamano wrote:

> I think you guys are barking up a wrong tree.
> 
> The staged state, the work tree state and the committed states are three
> conceptually different things.  Making them stand out as distinct entities
> at the UI level is a _good thing_.

I'm not sure I agree. They _are_ different things, but in the case of
diff, you are really treating each of them like a tree (which makes
range operators a little silly, but then that is a silliness already
present in "git diff tree1..tree2").

But again, I would not be convinced this is a good direction until I
saw:

 - the actual design, especially to what degree any ugliness is exposed
   when we realize that they _aren't_ trees. IOW, how badly does this
   abstraction leak?

 - numbers showing that it isn't going to perform significantly worse

And I'm still not volunteering to work on it, so somebody else will have
to come up with those things. ;)

-Peff
