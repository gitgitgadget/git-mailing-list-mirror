From: Jeff King <peff@peff.net>
Subject: Re: multiple source file extensions
Date: Fri, 1 May 2015 22:33:21 -0400
Message-ID: <20150502023320.GB587@peff.net>
References: <CACnwZYed_aHzLsbkJVm=OnydXw-CPi-Zm9V7928rzvpaFMNENw@mail.gmail.com>
 <CANuW5x3OBWNDnHeVbH7ZQaj5AUAingea6crJ0cF9AHFjcJE_bQ@mail.gmail.com>
 <20150502011100.GB5634@peff.net>
 <20150502020431.GA15775@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Josh Hagins <hagins.josh@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 02 04:33:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoNFB-0005gK-8H
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 04:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbbEBCdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 22:33:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:53191 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750839AbbEBCdX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 22:33:23 -0400
Received: (qmail 6908 invoked by uid 102); 2 May 2015 02:33:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 21:33:23 -0500
Received: (qmail 3240 invoked by uid 107); 2 May 2015 02:33:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 22:33:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 May 2015 22:33:21 -0400
Content-Disposition: inline
In-Reply-To: <20150502020431.GA15775@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268210>

On Sat, May 02, 2015 at 09:04:32AM +0700, Duy Nguyen wrote:

> Subject: [PATCH] Avoid the need of "--" when wildcard pathspec is used
> [..]
> This patch modifies the rules a bit by considering any valid (*)
> wildcard pathspec "exist in worktree". The rules become:
> 
>  (1) if an arg is a rev, then it must either exist in worktree or not
>      be a valid wildcard pathspec.
> 
>  (2) else, it either exists in worktree or is a wildcard pathspec
> 
>  (3) else, "--" is required.
> 
> With the new rules, "--" is not needed most of the time when wildcard
> pathspec is involved.

I like it. Since this is a DWIM code path anyway, I don't think it
should be a problem in practice (i.e., if you are trying to do something
crazy like match a literal path that has a '*' in it, you really should
be using "--" in the first place).

-Peff
