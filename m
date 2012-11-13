From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Mon, 12 Nov 2012 23:01:04 -0500
Message-ID: <20121113040104.GA9361@sigill.intra.peff.net>
References: <1352653610-2090-1-git-send-email-felipe.contreras@gmail.com>
 <20121112233546.GG10531@sigill.intra.peff.net>
 <CAMP44s0emar-C27SX-FDsUVB6Sevuy4fBFHuO2OD6xELCEjmGg@mail.gmail.com>
 <20121113000217.GH10531@sigill.intra.peff.net>
 <CAMP44s16y9WSmnTdb04EMSzXVgzfYP7pSMo6qZi0HY0bjouA0w@mail.gmail.com>
 <20121113032727.GA8387@sigill.intra.peff.net>
 <CAMP44s0SDHVzSd-8Rq7Z1sbiQ6m0pxX+2pgx16_DoWnHeyNsNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 05:01:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY7gi-0001Wd-Dl
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 05:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842Ab2KMEBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 23:01:10 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45479 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752761Ab2KMEBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 23:01:09 -0500
Received: (qmail 18634 invoked by uid 107); 13 Nov 2012 04:01:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 23:01:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 23:01:04 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s0SDHVzSd-8Rq7Z1sbiQ6m0pxX+2pgx16_DoWnHeyNsNQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209568>

On Tue, Nov 13, 2012 at 04:55:25AM +0100, Felipe Contreras wrote:

> > No, it's not. Those broken names do not come from the environment, but
> > from our last-resort guess of the hostname.
> 
> That depends how you define environment, but fine, the point is that
> it happens.

If you have a strawman definition that does not have anything to do with
what I said in my original email, then yes, it could happen. But as I
said already, "git var" uses IDENT_STRICT and will not allow such broken
names.

> > We long ago switched to
> > printing the name as a warning when we have made such a guess (bb1ae3f),
> > then more recently started rejecting them outright (8c5b1ae).
> 
> Right, but these would still happen:
> 
> michael <michael@michael-laptop.michael.org>

Did you read my email? I explicitly proposed that we would _not_ allow
send-email to use implicit email addresses constructed in that way.

> > But in the meantime you are causing a regression for anybody who expects
> > GIT_AUTHOR_NAME to override user.email when running git-send-email (and
> > you have taken away the prompt that they could have used to notice and
> > correct it).
> 
> I think they can survive. If anybody like this exists.

Sorry, but that is not how things work on this project. You do not get
to cause regressions because you are too lazy to implement the feature
_you_ want in a way that does not break other people.

I tried to help you by pointing you in the right direction and even
providing a sample "git var" patch. But it is not my itch to scratch.

-Peff
