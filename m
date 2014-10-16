From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/25] prune-safety
Date: Thu, 16 Oct 2014 17:21:13 -0400
Message-ID: <20141016212112.GA16054@peff.net>
References: <20141015223244.GA25368@peff.net>
 <xmqqsiinsoyk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 23:21:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XesU5-00044L-NX
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 23:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbaJPVVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 17:21:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:59381 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751942AbaJPVVR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 17:21:17 -0400
Received: (qmail 28896 invoked by uid 102); 16 Oct 2014 21:21:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Oct 2014 16:21:16 -0500
Received: (qmail 2687 invoked by uid 107); 16 Oct 2014 21:21:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Oct 2014 17:21:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Oct 2014 17:21:13 -0400
Content-Disposition: inline
In-Reply-To: <xmqqsiinsoyk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 16, 2014 at 02:07:47PM -0700, Junio C Hamano wrote:

> Somewhere in this series the object enumeration seems to get
> broken.  "git clone --no-local" of git.git repository died
> with
> 
>     Cloning into 'victim-7'...
>     remote: Counting objects: 173727, done.
>     remote: Compressing objects: 100% (43697/43697), done.
>     remote: Total 173727 (delta 130908), reused 170009 (delta 128151)
>     Receiving objects: 100% (173727/173727), 33.45 MiB | 13.69 MiB/s,
>     done.
>     Resolving deltas: 100% (130908/130908), done.
>     fatal: did not receive expected object a74380c3117994efba501df1707418eb6feb9284
>     fatal: index-pack failed
> 
> where a74380c... is such an object.
> 
> If you have a clone of https://github.com/git/git.git

Hrm. I cannot reproduce the clone failure...

> $ git rev-list --parents --objects --all | grep  a74380c3117994
> 
> would be an easy way to reproduce.

But this I can. Digging into it...

-Peff
