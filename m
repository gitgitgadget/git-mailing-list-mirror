From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Fri, 8 Feb 2008 02:23:37 +0300
Message-ID: <20080207232337.GR30368@dpotapov.dyndns.org>
References: <pan.2008.02.04.18.25.26@progsoc.org> <20080205050741.GA4624@coredump.intra.peff.net> <pan.2008.02.06.21.56.35@progsoc.org> <20080207042332.GA7632@sigill.intra.peff.net> <pan.2008.02.07.10.15.05@progsoc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anand Kumria <wildfire@progsoc.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 00:24:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNG6M-0000Ls-AQ
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 00:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756605AbYBGXXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 18:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756471AbYBGXXp
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 18:23:45 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:15943 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756356AbYBGXXo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 18:23:44 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1033704nfb.21
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 15:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=HEfX6sGAqYjhRiF4w0e0LAJGtPTMxJy+7OxvTvNncTw=;
        b=nI/hfGk1Cl/EaxX9pWuZLubnVl7YbDL17Sq7DJW4xDe0cuCEla1AlNIetWQd+ZX/SJtFijXVpdAl4gPz9PRwzqWZ8iDW0Q5y0PYCke4+jmC24UbvpDXmvdAzUmk2c0GL+RJscQvpFbKYM8aMXZQWwy8ZQQwUxJYxUknEkgpj/oU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=MPBeUQ5SZA1k30KHMu8423AO2YampWu8OkEpyFIAWqRtbyLDFYijVZPO9FWEEH83BKFc1onKvE7izV6b6KvstqlZqIlgFKKY7nQrqCjBLEStLcJrsagCMDZlLVvYNBII7GXZlCyT9PfE8VMdV7VcQQUrLpVeH/N6i/KFkbmsO9k=
Received: by 10.78.123.4 with SMTP id v4mr21515037huc.18.1202426621797;
        Thu, 07 Feb 2008 15:23:41 -0800 (PST)
Received: from localhost ( [85.141.191.183])
        by mx.google.com with ESMTPS id e9sm2029612muf.0.2008.02.07.15.23.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Feb 2008 15:23:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <pan.2008.02.07.10.15.05@progsoc.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73017>

On Thu, Feb 07, 2008 at 10:15:02AM +0000, Anand Kumria wrote:
> On Wed, 06 Feb 2008 23:23:33 -0500, Jeff King wrote:
> 
> > Googling for your error message turns up only one other instance: a bug
> > in pidgin where the result was "this seems like a bug in gnutls." I hate
> > to say "it's not our bug" without knowing exactly what is causing it,
> > though. And it does seem odd that it works with 1.5.3.8. I wonder if
> > there is some difference in the way we are calling curl that matters.
> 
> It appears that git 1.5.3.8 on Debian links to libcurl3-gnutls whereas, 
> at least for me, git 1.5.4 on Debian links to libcurl4-gnutls 
> (or libcurl4-openssl).

Have you tried Git 1.5.4 with libcurl3-gnutls? It seems the package from
Debian unstable is built with it. I have backported Git 1.5.4 to Etch with
libcurl3-gnutls and I have not noticed any problems with https fetch. So,
I wonder if the problem happens with libcurl4-gnutls only regardless of
your version of Git.

Dmitry
