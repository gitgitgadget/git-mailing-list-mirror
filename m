From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] verify-tag: add --check-name flag
Date: Tue, 7 Jun 2016 18:13:25 -0400
Message-ID: <20160607221325.GA21166@sigill.intra.peff.net>
References: <20160607195608.16643-1-santiago@nyu.edu>
 <xmqq7fe0pv5b.fsf@gitster.mtv.corp.google.com>
 <20160607211707.GA7981@sigill.intra.peff.net>
 <xmqq37oopt28.fsf@gitster.mtv.corp.google.com>
 <20160607215536.GA20768@sigill.intra.peff.net>
 <xmqqy46gods1.fsf@gitster.mtv.corp.google.com>
 <20160607220743.GA21043@sigill.intra.peff.net>
 <CAPc5daV=gqDLeFLB2csJDvNo4fpSKW_FjoB10TyroapQiHFq=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: santiago@nyu.edu, Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Colin Walters <walters@verbum.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 00:15:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAPFi-0001Er-A8
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 00:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755522AbcFGWN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 18:13:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:50875 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755488AbcFGWN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 18:13:28 -0400
Received: (qmail 11066 invoked by uid 102); 7 Jun 2016 22:13:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jun 2016 18:13:28 -0400
Received: (qmail 2401 invoked by uid 107); 7 Jun 2016 22:13:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jun 2016 18:13:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2016 18:13:25 -0400
Content-Disposition: inline
In-Reply-To: <CAPc5daV=gqDLeFLB2csJDvNo4fpSKW_FjoB10TyroapQiHFq=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296736>

On Tue, Jun 07, 2016 at 03:11:47PM -0700, Junio C Hamano wrote:

> On Tue, Jun 7, 2016 at 3:07 PM, Jeff King <peff@peff.net> wrote:
> >>
> >> Puzzled.  I didn't even use --format=%(tagname) in the above.
> >
> > No, but you used --show-tagname, which does not exist today (and which
> > IMHO should be implemented as --format). Would --show-tagname take
> > either a tagname _or_ a sha1? I assume it would not be calling
> > get_sha1(), as having it find refs/heads/$tag would be silly.
> 
> And you do not even want to rely on where refs/tags/* it lives.
> show-tagname, as I hinted in the first response, was meant to be
> a short-hand for
> 
>        git cat-file tag $tag_object_name | sed -e '/^$/q' -e 's/^tag //p'
> 
> so I am still puzzled.

If you are suggesting that you can do the whole thing today by parsing
the tag object yourself, then sure, I agree. I thought the point of the
exercise was to make that less painful for the callers.

-Peff
