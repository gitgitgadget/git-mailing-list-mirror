From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/4] git-credential-store: support multiple credential
 files
Date: Sat, 14 Mar 2015 13:42:04 -0400
Message-ID: <20150314174204.GA32706@peff.net>
References: <1426056553-9364-1-git-send-email-pyokagan@gmail.com>
 <1426056553-9364-2-git-send-email-pyokagan@gmail.com>
 <20150313061530.GA24588@peff.net>
 <CACRoPnR9pTc2LC87Vf0bMAgTj-FnbsRBpjn+3RCxCP6yrzsCkw@mail.gmail.com>
 <20150314173328.GA32599@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 18:44:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWq6l-0005ch-W6
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 18:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbbCNRmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 13:42:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:33080 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751055AbbCNRmH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 13:42:07 -0400
Received: (qmail 27162 invoked by uid 102); 14 Mar 2015 17:42:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 14 Mar 2015 12:42:06 -0500
Received: (qmail 2636 invoked by uid 107); 14 Mar 2015 17:42:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 14 Mar 2015 13:42:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Mar 2015 13:42:04 -0400
Content-Disposition: inline
In-Reply-To: <20150314173328.GA32599@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265454>

On Sat, Mar 14, 2015 at 01:33:28PM -0400, Jeff King wrote:

> On Sat, Mar 14, 2015 at 04:15:53PM +0800, Paul Tan wrote:
> 
> > Even though in this case the store_credential() function is not used
> > anywhere else, from my personal API design experience I think that
> > cementing the rule of "the first file in the list is the default" in
> > the behavior of the function is not a good thing. For example, in the
> > future, we may wish to keep the precedence ordering the same, but if
> > none of the credential files exist, we create the XDG file by default
> > instead. It's a balance of flexibility, but in this case I think
> > putting the default filename in a separate argument is a good thing.
> 
> Yeah, I see your line of reasoning. I think this is probably a case of
> YAGNI, but it is really a matter of personal preference. It's not a big
> deal either way.

By the way, I hope this (and the other comment) do not come off as "you
are wrong, but I do not feel like arguing with you". I really do think
these are a matter of taste, and while we often express issues of taste
in reviews, it is ultimately up to the patch submitter (who is, after
all, doing most of the work) to have the final say on minor issues like
this.  Sometimes the response to taste issue is "oh, I didn't think to
do that, thanks for the suggestion" and sometimes it is "nah, I like it
better my way". And both are OK.

Of course there are also taste issues where we insist (e.g., consistent
whitespace), but I do not think this is one of them.  :)

Maybe that was all obvious, but since you are new to the list, I wanted
to make sure I was clear.

-Peff
