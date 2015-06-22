From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add list-all-objects command
Date: Mon, 22 Jun 2015 06:24:34 -0400
Message-ID: <20150622102433.GA12584@peff.net>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
 <1434914431-7745-1-git-send-email-charles@hashpling.org>
 <1434914431-7745-2-git-send-email-charles@hashpling.org>
 <CACsJy8DGD6PLVJMFQGKyk9YGUn16G8+dLx2bMBn8fyjuXvfbBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Charles Bailey <charles@hashpling.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 12:24:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6yu9-00058P-OE
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 12:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756188AbbFVKYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 06:24:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:49741 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756099AbbFVKYg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 06:24:36 -0400
Received: (qmail 16458 invoked by uid 102); 22 Jun 2015 10:24:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 05:24:37 -0500
Received: (qmail 7151 invoked by uid 107); 22 Jun 2015 10:24:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 06:24:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jun 2015 06:24:34 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8DGD6PLVJMFQGKyk9YGUn16G8+dLx2bMBn8fyjuXvfbBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272322>

On Mon, Jun 22, 2015 at 04:57:28PM +0700, Duy Nguyen wrote:

> On Mon, Jun 22, 2015 at 2:20 AM, Charles Bailey <charles@hashpling.org> wrote:
> > From: Charles Bailey <cbailey32@bloomberg.net>
> >
> > list-all-objects is a command to print the ids of all objects in the
> > object database of a repository. It is designed as a low overhead
> > interface for scripts that want to analyse all objects but don't require
> > the ordering implied by a revision walk.
> >
> > It will list all objects, loose and packed, and will include unreachable
> > objects.
> 
> Nit picking, but perhaps we should allow to select object source:
> loose, packed, alternates.. These info are available now and cheap to
> get. It's ok not to do it now though.

There is already plumbing to do those individual operations if you want.
Although some of the plumbing involves "for i in objects/pack/*.pack",
which is perhaps a little less abstract than we'd like. :)

> Personally I would name this command "find-objects" (after unix
> command "find") where we could still filter objects _not_ based on
> object content.

I like that better than "ls", too, but I propose that we actually add
this as a feature to cat-file. I'll send patches in a moment.

-Peff
