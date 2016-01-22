From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] resolve_gitlink_ref: ignore non-repository paths
Date: Fri, 22 Jan 2016 17:40:56 -0500
Message-ID: <20160122224056.GA15965@sigill.intra.peff.net>
References: <20160122222650.GA14772@sigill.intra.peff.net>
 <20160122222930.GB15560@sigill.intra.peff.net>
 <20160122223154.GA15635@sigill.intra.peff.net>
 <CAGZ79kYU_=w0VWFRNGamP_nnnjyF6AcOj+A8r8GfhyrJMQzi9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Andreas Krey <a.krey@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 23:41:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMkO7-00061t-7o
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 23:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274AbcAVWlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 17:41:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:58985 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754870AbcAVWk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 17:40:58 -0500
Received: (qmail 18297 invoked by uid 102); 22 Jan 2016 22:40:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jan 2016 17:40:58 -0500
Received: (qmail 6798 invoked by uid 107); 22 Jan 2016 22:41:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jan 2016 17:41:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jan 2016 17:40:56 -0500
Content-Disposition: inline
In-Reply-To: <CAGZ79kYU_=w0VWFRNGamP_nnnjyF6AcOj+A8r8GfhyrJMQzi9w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284603>

On Fri, Jan 22, 2016 at 02:36:54PM -0800, Stefan Beller wrote:

> Impressive performance improvements. :)

"Accidentally quadratic" bugs are some of my favorites, because it's
usually easy to show off the results. Of course, the repo in p7300 is
pretty ridiculous, and most people won't see any speedup. I'll be
curious to hear about Andreas's case, as it is a real-world one which
may see some improvement.

> > BTW, what if you have
> > precious content in a ".git" file?
> 
> I'd kindly ask to use a different version control in that case.
> 
> Q: What can you use Git for?
> A: Everything including version control, backup, deploying software,
>     except when there is a file named .git with precious content.
> 
> ;)

Yeah, I think that is my attitude as well. Just because your ".git" file
is not actually a real gitfile does not make it a good idea. We do not
list it in "ls-files -o", but it is not like you could commit it,
either; we explicitly prevent it from being added to the index.

-Peff
