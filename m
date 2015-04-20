From: Jeff King <peff@peff.net>
Subject: Re: [BUG] Performance regression due to #33d4221: write_sha1_file:
 freshen existing objects
Date: Mon, 20 Apr 2015 16:09:56 -0400
Message-ID: <20150420200956.GA16249@peff.net>
References: <CADoxLGPYOkgzb4bkdHq5tK0aJS2M=nWGzO=YYXPDcy-gh45q-g@mail.gmail.com>
 <20150417140315.GA13506@peff.net>
 <CADoxLGOPXDgb0LBcSBm+xRDhbnGV_y-TXENyPV7oK_+KZzPKRQ@mail.gmail.com>
 <20150420195337.GA15447@peff.net>
 <xmqq1tjelg78.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Saasen <ssaasen@atlassian.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 22:10:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkI15-0003Qo-Jl
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 22:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbbDTUJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 16:09:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:47806 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750771AbbDTUJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 16:09:58 -0400
Received: (qmail 9801 invoked by uid 102); 20 Apr 2015 20:09:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Apr 2015 15:09:58 -0500
Received: (qmail 28147 invoked by uid 107); 20 Apr 2015 20:10:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Apr 2015 16:10:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Apr 2015 16:09:56 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1tjelg78.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267497>

On Mon, Apr 20, 2015 at 01:04:11PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... But I don't know
> > if this counts as critical (it is for you, certainly, but I don't think
> > that many people are affected, as the crucial factor here is really the
> > slow NFS filesystem operations).
> 
> If it is critical to some people, they can downmerge to their custom
> old installations of Git they maintain with ease, of course, and
> that "with ease" part is the reason why I try to apply fixes to tip
> of the original topic branch even though they were merged to the
> mainline eons ago ;-).

I think it is a bigger deal for folks who do not ship a custom
installation, but expect to ship a third-party system that interacts
with whatever version of git their customers happen to have (in which
case they can only recommend their customers to upgrade).

I don't know how Stash or GitLab installations work. GitHub ships our
own custom git (which I maintain), though we are already on 2.3.x.

Either way, though, I do not think it is the upstream Git project's
problem.

-Peff
