From: Jeff King <peff@peff.net>
Subject: Re: Parallel checkout (Was Re: 0 bot for Git)
Date: Fri, 15 Apr 2016 12:52:08 -0400
Message-ID: <20160415165208.GA17928@sigill.intra.peff.net>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
 <CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
 <CACsJy8DiCw_yZNp7st-qVA7zYEHww=ae5Q=uKVzBhAfU8akR7Q@mail.gmail.com>
 <CAGZ79kZzdioQRFEmgTGOOdLQ-Ov-tWmgi1dLhHPDVzDb+Py2RQ@mail.gmail.com>
 <CAP8UFD3xWUkCFZMN1N6t36KKwcfnkLsFznAc7j7yF89PbYaqfg@mail.gmail.com>
 <20160415095139.GA3985@lanh>
 <CAP8UFD0WZHriY340eh3K6ygzb0tXnoT+XaY8+c2k+N2x9UBYxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 18:52:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar6ye-0004Q0-Aq
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 18:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbcDOQwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 12:52:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:50188 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752091AbcDOQwL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 12:52:11 -0400
Received: (qmail 29380 invoked by uid 102); 15 Apr 2016 16:52:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Apr 2016 12:52:10 -0400
Received: (qmail 11526 invoked by uid 107); 15 Apr 2016 16:52:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Apr 2016 12:52:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Apr 2016 12:52:08 -0400
Content-Disposition: inline
In-Reply-To: <CAP8UFD0WZHriY340eh3K6ygzb0tXnoT+XaY8+c2k+N2x9UBYxA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291617>

On Fri, Apr 15, 2016 at 01:18:46PM +0200, Christian Couder wrote:

> On Fri, Apr 15, 2016 at 11:51 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Fri, Apr 15, 2016 at 12:04:49AM +0200, Christian Couder wrote:
> >>
> >> There is a draft of an article about the first part of the Contributor
> >> Summit in the draft of the next Git Rev News edition:
> >>
> >> https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-14.md
> >
> > Thanks. I read the sentence "This made people mention potential
> > problems with parallelizing git checkout" and wondered what these
> > problems were.
> 
> It may have been Michael or Peff (CC'ed) saying that it could break
> some builds as the timestamps on the files might not always be ordered
> in the same way.

I don't think it was me. I'm also not sure how it would break a build.
Git does not promise a particular timing or order for updating files as
it is. So if we are checking out two files "a" and "b", and your build
process depends on the timestamp between them, I think all bets are
already off.

-Peff
