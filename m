From: Jeff King <peff@peff.net>
Subject: Re: multiple source file extensions
Date: Fri, 1 May 2015 22:35:04 -0400
Message-ID: <20150502023504.GC587@peff.net>
References: <CACnwZYed_aHzLsbkJVm=OnydXw-CPi-Zm9V7928rzvpaFMNENw@mail.gmail.com>
 <CANuW5x3OBWNDnHeVbH7ZQaj5AUAingea6crJ0cF9AHFjcJE_bQ@mail.gmail.com>
 <20150502011100.GB5634@peff.net>
 <20150502020431.GA15775@lanh>
 <CACsJy8C2aztHWHP0_U8VWJxMrT2HE7aYBxDQTnSWS1TVwCnedw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Josh Hagins <hagins.josh@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 02 04:35:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoNGr-0006y0-6j
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 04:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbbEBCfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 22:35:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:53195 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750845AbbEBCfH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 22:35:07 -0400
Received: (qmail 7018 invoked by uid 102); 2 May 2015 02:35:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 21:35:07 -0500
Received: (qmail 3266 invoked by uid 107); 2 May 2015 02:35:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 22:35:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 May 2015 22:35:04 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8C2aztHWHP0_U8VWJxMrT2HE7aYBxDQTnSWS1TVwCnedw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268211>

On Sat, May 02, 2015 at 09:11:16AM +0700, Duy Nguyen wrote:

> On Sat, May 2, 2015 at 9:04 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Fri, May 01, 2015 at 09:11:01PM -0400, Jeff King wrote:
> >> Unfortunately there is no way to use curly braces with git's pathspec,
> >> so you have to write out three separate `*` arguments rather than using
> >> the shell-style {cc,cpp,h}.
> >
> > Noted. Need to add curly brace support in pathspec :-)
> 
> Naah people can just do
> 
> git grep pattern -- '*'.{cc,cpp,h}
> 
> and bash will take care of expanding it into three separate arguments.
> Obscure, but pathspec is also obscure..

Thanks, I had a vague notion that I should be able to convince the shell
to do it for me, but of course "*.{cc,cpp,h}" doesn't work. I always
forget about breaking up parameters into two parts with different
quoting like this.

I agree we don't really need curly braces in pathspecs. :)

-Peff
