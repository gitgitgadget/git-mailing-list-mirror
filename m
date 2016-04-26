From: Jeff King <peff@peff.net>
Subject: Re: "gitk --author=foo" shows also parent
Date: Tue, 26 Apr 2016 13:52:44 -0400
Message-ID: <20160426175243.GA18260@sigill.intra.peff.net>
References: <571F6852.1070405@qt.io>
 <CANoM8SXn0CgUqQU3vmH-kwuxiDfC1=4FCh1SUsYuOOv4fQtWpw@mail.gmail.com>
 <571F9380.4070006@qt.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Rappazzo <rappazzo@gmail.com>, Git List <git@vger.kernel.org>,
	paulus@samba.org
To: Nikolai Kosjar <nikolai.kosjar@qt.io>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:53:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av7AP-0006sy-VR
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 19:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbcDZRws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 13:52:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:56677 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752524AbcDZRwr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 13:52:47 -0400
Received: (qmail 7056 invoked by uid 102); 26 Apr 2016 17:52:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Apr 2016 13:52:46 -0400
Received: (qmail 16344 invoked by uid 107); 26 Apr 2016 17:52:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Apr 2016 13:52:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Apr 2016 13:52:44 -0400
Content-Disposition: inline
In-Reply-To: <571F9380.4070006@qt.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292632>

On Tue, Apr 26, 2016 at 06:12:48PM +0200, Nikolai Kosjar wrote:

> >I believe that this is intentional.  Notice that the parent commit's
> >circle is just outlined
> >compared to the selected authored commits are filled.  I consider this
> >the context
> >of the commits you are looking at.
> 
> Hmm, then I'm not interested in the context since it's too noisy. Is there
> any way to suppress this?

I am not a gitk user, but AFAIK, no. Gitk uses "--boundary" to ask git
for the bottom boundary of each string of commits. There is
unfortunately no "--no-boundary" option to override this (and I just
tried adding one, and it doesn't seem to work; gitk is perhaps too
aggressive in the way it passes along --boundary).

So I think it would require a patch to gitk.

-Peff
