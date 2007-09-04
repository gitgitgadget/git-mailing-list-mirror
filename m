From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Calculating tree nodes
Date: Tue, 4 Sep 2007 01:52:05 -0400
Message-ID: <9e4733910709032252x1fe6f436wdd13bcb1a6f76636@mail.gmail.com>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com>
	 <20070904025153.GS18160@spearce.org>
	 <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>
	 <e1dab3980709032119r381f7a91ia84ba09039c21be1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "David Tweed" <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 07:52:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISRKg-0002qW-Pi
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 07:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbXIDFwK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 01:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbXIDFwJ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 01:52:09 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:19872 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbXIDFwF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 01:52:05 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1092657rvb
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 22:52:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=etX91nYY5RK7wILCzd0gdzAI7f2q0+MwRLJIJ+qXt2py587AOsRUfQD1VR2+I/ITTGRS1r+ik8iRNxhj+Y0li1hlTLq4KHu87uFSdBFH++ma7qb2Km9iHwOVqtZG5ggrbFnKyUTWGXqra/CCcN9B7caO9zRmoTBsDxe106NIoOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JcJc7JBIMaIJzeGonA/hEP7GNLNOfBJJ2xSPRjOP3wiCWQHx7dqNm3ive1tsBwFukfnc9rJXDr5gKaWXs+X9e/DBhqay/mRywNX3ergA8z9fbB0zbeWUsfxpSdfI589TPfb9kvlG1BJ6evxzyVU3r124pqgVcV8GHv2k6DzsJX0=
Received: by 10.140.192.9 with SMTP id p9mr2271661rvf.1188885125106;
        Mon, 03 Sep 2007 22:52:05 -0700 (PDT)
Received: by 10.141.44.16 with HTTP; Mon, 3 Sep 2007 22:52:05 -0700 (PDT)
In-Reply-To: <e1dab3980709032119r381f7a91ia84ba09039c21be1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57528>

On 9/4/07, David Tweed <david.tweed@gmail.com> wrote:
> On 9/4/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > Git has picked up the hierarchical storage scheme since it was built
> > on a hierarchical file system.
>
> FWIW my memory is that initial git used path-to-blob lists (as you're
> describing but without delta-ing) and tree nodes were added after a
> couple of weeks, the motivation _at the time_ being they were a
> natural way to dramatically reduce the size of repos.
>
> One of the nice things about tree nodes is that for doing a diff
> between versions you can, to overwhelming probability, decide
> equality/inequality of two arbitrarily deep and complicated subtrees
> by comparing 40 characters, regardless of how remote and convoluted
> their common ancestry. With delta chains don't you end up having to
> trace back to a common "entry" in the history? (Of course, I don't
> know how packs affect this - presumably there's some delta chasing to
> get to the bare objects as well.)

While it is a 40 character compare, how many disk accesses were needed
to get those two SHAs into memory?

>
> --
> cheers, dave tweed__________________________
> david.tweed@gmail.com
> Rm 124, School of Systems Engineering, University of Reading.
> "we had no idea that when we added templates we were adding a Turing-
> complete compile-time language." -- C++ standardisation committee
>


-- 
Jon Smirl
jonsmirl@gmail.com
