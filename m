From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Revert diffstat back to English
Date: Thu, 13 Sep 2012 20:11:17 -0400
Message-ID: <20120914001117.GA31647@sigill.intra.peff.net>
References: <20120913132847.GD4287@sigill.intra.peff.net>
 <1347545786-936-1-git-send-email-pclouds@gmail.com>
 <7vzk4t960y.fsf@alter.siamese.dyndns.org>
 <7va9wt9377.fsf@alter.siamese.dyndns.org>
 <20120913210111.GA16956@sigill.intra.peff.net>
 <7v627h7hny.fsf@alter.siamese.dyndns.org>
 <20120913212043.GB16968@sigill.intra.peff.net>
 <7vr4q562cg.fsf@alter.siamese.dyndns.org>
 <20120913213121.GA31426@sigill.intra.peff.net>
 <7vehm561eq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 02:11:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCJVJ-0007BR-Nj
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 02:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759117Ab2INALV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 20:11:21 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43878 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751333Ab2INALU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 20:11:20 -0400
Received: (qmail 9376 invoked by uid 107); 14 Sep 2012 00:11:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Sep 2012 20:11:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Sep 2012 20:11:17 -0400
Content-Disposition: inline
In-Reply-To: <7vehm561eq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205441>

On Thu, Sep 13, 2012 at 02:47:09PM -0700, Junio C Hamano wrote:

> > I agree that the line is not bright. I do not know if it is worthwhile
> > or not. I think it will solve some practical problems, but it may also
> > introduce others.  But basically having a per-repo LANG setting (which
> > is what the projectlang you are talking about would do) also does not
> > seem like a solution that people will use, because they will not get any
> > localization benefit at all.
> >
> > So again, I'd rather err on the side of pushing those things that are
> > near the line into the "do not translate" side, letting people use LANG
> > to localize the rest, and accepting that occasionally people are going
> > to accidentally show you output in a language you don't understand. But
> > hopefully that keeps it to "occasionally" and not "every time you send
> > out a patch".
> 
> I am confused asto what you really want.  In a Klingon-only project,
> I think it is perfectly fine to localize the diffstat summary line
> to Klingon.  It is not machine readble, and it is not personal, but
> it is to be shared with project members, who all speak Klingon.
> 
> Pushing more things to "do not translate" side of the line means
> robbing the benefit of i18n from people, no?

Yes. But you cannot please both sides without creating a third category,
as you noted. If you do not translate diffstat, then Klingon-only projects are
unhappy. If you do translate, then projects run in LANG=C will either
get public Klingon, or the project members will turn off all translation
and lose all benefit of i18n.

So for the time being, I would rather choose LANG=C as a lingua franca
and err on the side of interoperability with other people and not
translating. And then if and when somebody feels like putting the effort
into doing i18n.projectlang by splitting out a third category, they are
welcome to. I just do not see much point in doing i18n.projectlang any
other way.

But again, please don't take my input with too much force. I am
personally perfectly happy to live in LANG=C the rest of my life. I
really started on this topic just by responding to your "I guess nobody
minds the Klingon..." statement. I do find it a little annoying, but I
can learn to live with it if that is significantly easier.

-Peff
