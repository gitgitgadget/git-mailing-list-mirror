From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: Globbing for ignored branches?
Date: Fri, 24 Jan 2014 19:32:22 +0100
Message-ID: <20140124183222.GE396@x4>
References: <20140124090104.GA396@x4>
 <0C723FEB5B4E5642B25B451BA57E273075148284@S1P5DAG3C.EXCHPROD.USA.NET>
 <20140124170739.GC396@x4>
 <20140124170909.GD396@x4>
 <20140124182341.GB8202@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Garrison <jim.garrison@nwea.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 24 19:32:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6lYX-0004wT-BX
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 19:32:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbaAXSc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 13:32:27 -0500
Received: from ud10.udmedia.de ([194.117.254.50]:55857 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbaAXScZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 13:32:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=mail.ud10.udmedia.de; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=beta; bh=mgByxd1glBESMGBkYBNnfFhi4o
	UxiQmdpm0PVqYLN60=; b=I0AqTnjSO8UicLaAYd/05AA56zYxjW7j2vIfZQDo0o
	u8LufBltDRL+xJGnSFt+mVtf8xpKMYBUAxF/aHDFAwAZ6K0Mxaax7ZQNJNdSAWKh
	HD2zVQtwkkpNebvq4795yo83OUtXpPYcamDO9Z0nd59QClen4QhcUmL3J5OeePvi
	w=
Received: (qmail 4163 invoked from network); 24 Jan 2014 19:32:23 +0100
Received: from unknown (HELO x4) (ud10?360p3@91.64.96.185)
  by mail.ud10.udmedia.de with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 24 Jan 2014 19:32:23 +0100
Content-Disposition: inline
In-Reply-To: <20140124182341.GB8202@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241020>

On 2014.01.24 at 13:23 -0500, Jeff King wrote:
> On Fri, Jan 24, 2014 at 06:09:09PM +0100, Markus Trippelsdorf wrote:
> 
> > > > If you mean "ignore" in some other scenario you need to be more
> > > > specific about what you want.
> > > 
> > > I want to them when I run "git pull".
> >            ignore
> 
> I assume you mean that you do not want to fetch them at all, not that
> you want to avoid merging them. The set of branches that git fetches is
> configured by the fetch "refspec" in your config file. It usually looks
> like this:
> 
>   $ git config remote.origin.fetch
>   +refs/heads/*:refs/remotes/origin/*
> 
> But you can specify a specific list of branches you want to fetch
> instead:
> 
>   $ git config --unset remote.origin.fetch
>   $ for i in master other-branch; do
>       git config --add remote.origin.fetch \
>                        +refs/heads/$i:refs/remotes/origin/$i
>     done
> 
> However, you do have to specify each branch individually. You probably
> want to say "all branches except X", and you cannot currently specify
> a negative refspec like that.

Thanks.
Yes, that was the question I wanted to ask (, sorry for not formulating
it more clearly). 
Is this "negative refspec for branches" a feature that is planned for
the future?

-- 
Markus
