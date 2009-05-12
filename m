From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git fails with control characters in trunk directory name
Date: Tue, 12 May 2009 19:41:22 +0200
Message-ID: <20090512174122.GB32594@blimp.localdomain>
References: <200905112208.21017.Hugo.Mildenberger@namir.de> <200905121557.18542.Hugo.Mildenberger@namir.de> <81b0412b0905120759u15f1ec73k73625a7904515792@mail.gmail.com> <200905121900.00625.Hugo.Mildenberger@namir.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Hugo Mildenberger <Hugo.Mildenberger@namir.de>
X-From: git-owner@vger.kernel.org Tue May 12 19:41:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3vyv-000597-3v
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 19:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134AbZELRlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 13:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbZELRlY
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 13:41:24 -0400
Received: from mout0.freenet.de ([195.4.92.90]:43129 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652AbZELRlX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 13:41:23 -0400
Received: from [195.4.92.22] (helo=12.mx.freenet.de)
	by mout0.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #88)
	id 1M3vyl-0002z5-PK; Tue, 12 May 2009 19:41:23 +0200
Received: from x6446.x.pppool.de ([89.59.100.70]:44203 helo=tigra.home)
	by 12.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #79)
	id 1M3vyl-0006QK-Jf; Tue, 12 May 2009 19:41:23 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id C23D6277D8;
	Tue, 12 May 2009 19:41:22 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 6667436D28; Tue, 12 May 2009 19:41:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200905121900.00625.Hugo.Mildenberger@namir.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118934>

Hugo Mildenberger, Tue, May 12, 2009 18:59:58 +0200:
> > > I looked into guess_dir_name().
> > 
> > That's not the right place. The place I meant is right below the call
> > to this function (you have to parse the names given in the command-line
> > too).
> > 
> > The automatically generated (that's the case with guess_dir_name)
> > directory name certainly shouldn't contain any unexpected characters.
> > 
> > > A regex call would be easy to fit, but
> > > currently the git binary does not depend on libpcre. Is it generally
> > > considered to be acceptable to add such a dependency?
> > 
> > No. And pcre is not the only regex lib in the world. And we prefer
> > shell patterns, if any at all.
> 
> You really want to use shell patterns to match against a string from within a binary?

Is that a problem? Especially if the matching expression is just
something like a character class?

> Although git already makes use of regexec from glibc or compat/regex
> directory in numerous places? 

You said pcre, and I wasn't able to look at the source at the time I
answered your mail to check if git relies on POSIX regexp. I did
(and remembered git grep), so no need for pcre and regular exceptions
are just a line away.


P.S. Could you please quote more appropriately? Your discussion is a
little hard to follow.
