From: Jeff King <peff@peff.net>
Subject: Re: `.git` symlink makes `git submodule add` fail
Date: Fri, 12 Feb 2016 13:27:33 -0500
Message-ID: <20160212182733.GA19973@sigill.intra.peff.net>
References: <20160212164853.GA6888@witiko>
 <xmqqio1tvlzu.fsf@gitster.mtv.corp.google.com>
 <xmqq60xtvlj9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?VsOtdCBOb3ZvdG7DvQ==?= <witiko@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 19:27:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUIRQ-00018A-An
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 19:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbcBLS1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 13:27:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:41121 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751257AbcBLS1g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 13:27:36 -0500
Received: (qmail 12787 invoked by uid 102); 12 Feb 2016 18:27:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Feb 2016 13:27:35 -0500
Received: (qmail 18142 invoked by uid 107); 12 Feb 2016 18:27:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Feb 2016 13:27:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Feb 2016 13:27:33 -0500
Content-Disposition: inline
In-Reply-To: <xmqq60xtvlj9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286063>

On Fri, Feb 12, 2016 at 10:19:38AM -0800, Junio C Hamano wrote:

> >> Is this a bug, or is the ability to symlink `.git` just a happy coincidence?
> >
> > It has never been supported.
> 
> Oops, hit "send" too early.
> 
> We have support for a "gitdir:" facility that would work even on a
> filesystem that cannot do symlinks (see gitrepository-layout(5)),
> and both the higher-level submodule Porcelain and the more recent
> "worktree" experimental code do use it.

And the way to convince git to make the link for you is with clone's
"--separate-git-dir" option.

-Peff
