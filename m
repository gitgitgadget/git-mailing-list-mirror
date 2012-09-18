From: Jeff King <peff@peff.net>
Subject: Re: How to create the " [PATCH 0/5]" first email?
Date: Tue, 18 Sep 2012 15:16:53 -0400
Message-ID: <20120918191653.GA21187@sigill.intra.peff.net>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
 <F93DBBE1DDAA44A28C9020F9A58FD825@PhilipOakley>
 <7vzk4rz00y.fsf@alter.siamese.dyndns.org>
 <98180D4AA94C468887029389CC535D4F@PhilipOakley>
 <7vfw6gqkfg.fsf@alter.siamese.dyndns.org>
 <20120918001522.GA10283@sigill.intra.peff.net>
 <7v7grsqi98.fsf@alter.siamese.dyndns.org>
 <20120918185530.GB20498@sigill.intra.peff.net>
 <7vsjafm9hd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 21:17:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE3I8-00074f-6v
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 21:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273Ab2IRTQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 15:16:56 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47470 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754011Ab2IRTQz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 15:16:55 -0400
Received: (qmail 23581 invoked by uid 107); 18 Sep 2012 19:17:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Sep 2012 15:17:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Sep 2012 15:16:53 -0400
Content-Disposition: inline
In-Reply-To: <7vsjafm9hd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205853>

On Tue, Sep 18, 2012 at 12:11:58PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But even without that, I still think format-patch is a reasonable time
> > to do it. It is the time when I proof-read my commit message and patch
> > in its final form, and think "do I really want to send this?".
> 
> But it is not like "I cannot sign off because I think it is still
> iffy".

No, that is not the particular reason in my case, but I think I
explained other reasons why "format-patch -s" is not a wrong workflow.

> >> But your point still stands; "commit -s" will not see through that
> >> official trick either ;-).
> >
> > Yes. :)
> 
> Actually, no.  "commit -s" does not have any need to see through it.
> 
> 	... hack hack hack ...
>         $ git commit -a -s
>         ... editor opens, you see your Sign-off at the end, with
>         ... the cursor sitting on the first line
>         ... edit the title, move to the line below the Sign-off,
>         ... and do the "---\n\n * comment" thing.
> 
> And this survives "rebase -i" (but not "format-patch | am" for
> obvious reasons).

Yes, if your particular workflow is to signoff the very first time you
commit. But it would not work for:

 ... hack hack hack ...
 $ git commit -a
   ... make a note after "---" ...

 ... hack hack hack ...
 ... OK, looks good, ready to signoff ...
 $ git commit --amend -s

So it can work, but it is workflow dependent, and in general is a little
flaky with the automagic signoff. You may want to signoff later for a
variety of reasons, not the least of which is that you forgot to type
"-s" the first time.

> So I take it back.  The time you do the "git commit" for the very
> first time for this change that may need to be rerolled number of
> times is the right time to say "-s".

If you remember to type it. :)

-Peff
