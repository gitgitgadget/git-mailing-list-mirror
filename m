From: Jeff King <peff@peff.net>
Subject: Re: Re: [PATCH] Docs: git checkout --orphan: `root commit' and
 `branch head'
Date: Tue, 27 Sep 2011 19:35:49 -0400
Message-ID: <20110927233549.GA10434@sigill.intra.peff.net>
References: <7vaa9r2jii.fsf@alter.siamese.dyndns.org>
 <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com>
 <4E81F080.7010905@drmicha.warpmail.net>
 <CAMOZ1BsvnZ7PyfjOJURX+B7vCZcYheLS4pissGvPNjEivbYXtw@mail.gmail.com>
 <7v39fhyk21.fsf@alter.siamese.dyndns.org>
 <4E823359.7080602@nextest.com>
 <DBCBE20265964ECCA5B9724DAC74D83B@PhilipOakley>
 <20110927214213.GC5176@sigill.intra.peff.net>
 <CAMOZ1BvzWDPQ_e3Y5H8CX4wQwL5xf3xVvZvRL3gQPcB_kCGBbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Eric Raible <raible@nextest.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 01:35:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8hBs-00015H-Ce
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 01:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013Ab1I0Xfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 19:35:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45600
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172Ab1I0Xfv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 19:35:51 -0400
Received: (qmail 29540 invoked by uid 107); 27 Sep 2011 23:40:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Sep 2011 19:40:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2011 19:35:49 -0400
Content-Disposition: inline
In-Reply-To: <CAMOZ1BvzWDPQ_e3Y5H8CX4wQwL5xf3xVvZvRL3gQPcB_kCGBbw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182275>

On Tue, Sep 27, 2011 at 11:28:14PM +0000, Michael Witten wrote:

>   With "git commit --no-parent", you would be altering the current
>   branch head, which means you are potentially leaving as a dangling
>   commit the commit to which that branch head originally pointed.
>   I.e., it is about as dangerous as "git reset --hard <new_root_commit>",
>   something for which we do NOT provide any protection.

Didn't I already mention that example? And then say that I think the
lack of protection there has been the source of a lot of confusion and
hardship?

Repeating the problems of "git reset" does not seem like a good idea to
me. Especially not with a command like "commit", which is usually very
safe.

That being said, I did say in my last email that one option would be for
the documentation to be very clear about leaving the old history
dangling. That at least keeps clueless people from stumbling into using
the option accidentally.

So I'm not saying "we can't do this". I'm saying "this is dangerous, so
let's think for a minute about what safety mechanisms we can have".

> For instance, what if I want the current branch head to point to that
> new root commit? The existing solution requires juggling branch names;
> why can't git just do what I tell it to do (as with "git reset")?
> After all, "git commit --no-parent" is pretty name explicit.

It's explicit if you understand how git works, or what "parent" means.
I'm not sure every git user does, these days.

-Peff
