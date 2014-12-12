From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] document string_list_clear
Date: Fri, 12 Dec 2014 14:29:38 -0500
Message-ID: <20141212192938.GB21132@peff.net>
References: <xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
 <CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
 <20141209201713.GY16345@google.com>
 <20141209202738.GC12001@peff.net>
 <20141209222337.GA16345@google.com>
 <20141210084351.GA29776@peff.net>
 <20141210091815.GA18372@google.com>
 <20141212091625.GA9049@peff.net>
 <20141212183114.GA29365@google.com>
 <CAGZ79kbKCRKyugTnnx34AkeqN0NDBL_J2yGky06E+263oQ_6hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 20:29:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzVuK-0007si-FH
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 20:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756471AbaLLT3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 14:29:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:52246 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752179AbaLLT3k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 14:29:40 -0500
Received: (qmail 14965 invoked by uid 102); 12 Dec 2014 19:29:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Dec 2014 13:29:39 -0600
Received: (qmail 13623 invoked by uid 107); 12 Dec 2014 19:29:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Dec 2014 14:29:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Dec 2014 14:29:38 -0500
Content-Disposition: inline
In-Reply-To: <CAGZ79kbKCRKyugTnnx34AkeqN0NDBL_J2yGky06E+263oQ_6hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261363>

On Fri, Dec 12, 2014 at 11:19:23AM -0800, Stefan Beller wrote:

> * Assuming we put everything into headers now, we'd need to discuss
>   -> Do we want to extract it to technical/api-$somedoc later at all?
> (There seems to be some disagreement?)
>   -> How do we extract (plain sed for lines starting with "*", or
> doxygen, or a self cooked script)
>   -> How do we ensure the generated documentation doesn't get stale over time?

I think it would be _nice_ to extract it, and that should be a
consideration when doing the manual work of moving it into headers
(you'll notice I used the "/**" convention to start comments which
should be extractable, but I am happy to use any similar convention[1]).

But unless somebody is excited about working on the extractor
immediately, I think we should punt on it for now. Moving the
documentation is already a big job, and I do not want to add an extra
dependency to the task.

The exact extractor choice might influence formatting decisions (e.g.,
should extracted text stand alone, or must it be viewed in context of the
function it prefaces), but we might be able to do a mechanical
conversion later if those facts change.

-Peff
