From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] RFC Allow case insensitive search flag with git-grep
 for fixed-strings
Date: Fri, 6 Nov 2009 03:48:55 -0500
Message-ID: <20091106084855.GA20964@coredump.intra.peff.net>
References: <B7C4E16C-B15D-4A7B-873A-B6BD0FDAD8C8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Collins <bricollins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 09:49:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6KVJ-0007W2-25
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 09:49:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848AbZKFIs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 03:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754474AbZKFIs6
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 03:48:58 -0500
Received: from peff.net ([208.65.91.99]:39550 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753517AbZKFIs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 03:48:57 -0500
Received: (qmail 5609 invoked by uid 107); 6 Nov 2009 08:52:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 06 Nov 2009 03:52:46 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Nov 2009 03:48:55 -0500
Content-Disposition: inline
In-Reply-To: <B7C4E16C-B15D-4A7B-873A-B6BD0FDAD8C8@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132285>

On Thu, Oct 29, 2009 at 06:21:59PM -0700, Brian Collins wrote:

> You will have to excuse me, this is my first patch and I don't know
> if this is the right place to post this. Apologies in advance if I'm
> in the wrong place.

You're in the right place (though judging from the response, nobody
seemed to find your patch all that interesting...).

> git-grep currently throws an error when you combine the -F and -i
> flags. This isn't in line with how GNU grep handles it. This patch
> allows the simultaneous use of those flags.

I don't see a reason not to allow this combination if our grep
implementation supports it. My only reservation would be that we
sometimes call out to an external grep, and non-GNU grep might barf on
this. But I think that is OK, as the user should get a sane error from
the external grep.

>  builtin-grep.c |    8 +++++---
>  grep.c         |   16 ++++++++++++----
>  grep.h         |    2 ++

Tests? They help prove to us that your feature works, and also prevent
us from accidentally breaking your feature in the future.

-Peff
