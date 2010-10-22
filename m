From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git Attribute: File Text Encoding {WAS: Re: [RFC] Print diffs of UTF-16 to console / patches to email as UTF-8...?}
Date: Fri, 22 Oct 2010 14:49:20 -0700 (PDT)
Message-ID: <m3sjzxkifz.fsf@localhost.localdomain>
References: <1287763608.31218.63.camel@drew-northup.unet.maine.edu>
	<20101022161851.GH9224@burratino>
	<E7645863-A3AD-4EE1-AF6B-71C50A859619@gmail.com>
	<20101022195331.GA12014@burratino>
	<1287778695.819.17.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Joshua Juran <jjuran@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Fri Oct 22 23:49:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9PUO-00067j-Cd
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 23:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122Ab0JVVtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 17:49:23 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58129 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530Ab0JVVtW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 17:49:22 -0400
Received: by bwz11 with SMTP id 11so980419bwz.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 14:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ZkVy9psiS9oeZPyPq7CC+sH7tUI7ssYdV0mQ+mlNY70=;
        b=rQbPdvmiU7Zyzembv/TigpFnFgkA9COvKwy+VeSTOfcaTrq2G9mVmFTr2Hs/TUx2hR
         P8Zerv3w8RGJU8pGJEg9SXEpDj86ipUS/t2DjrPmvrw03Y+7roi6k33sisKGXmLieRlW
         wxhdtUD1De3lwH71AML0X1UJMlSfEqEFXrweU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=iLREfPSMbuia9uOWMIccX80FSix1sJXBqAOxpq2Hvjl0YqVok8nz/9z3wgM6cbP9q5
         ecyCo0vSre7bavI6BO78buuuCQqjDEvy2vxwStHkNfkg8Ew4NOQmBZOFWGwRJvmRbmMc
         KLmDvtgT1++AF/svFlifijYEQSwBgoxj+Aais=
Received: by 10.204.123.132 with SMTP id p4mr2645400bkr.67.1287784161385;
        Fri, 22 Oct 2010 14:49:21 -0700 (PDT)
Received: from localhost.localdomain (abvu212.neoplus.adsl.tpnet.pl [83.8.218.212])
        by mx.google.com with ESMTPS id r21sm2473726bkj.10.2010.10.22.14.49.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 14:49:20 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9MLmdH6007857;
	Fri, 22 Oct 2010 23:48:44 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9MLmHGc007852;
	Fri, 22 Oct 2010 23:48:17 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1287778695.819.17.camel@drew-northup.unet.maine.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159756>

Drew Northup <drew.northup@maine.edu> writes:
> On Fri, 2010-10-22 at 14:53 -0500, Jonathan Nieder wrote:
> > Joshua Juran wrote:
> 
> > >                                                      But a more
> > > complete and robust solution would be to store the encoding
> > > somewhere, possibly in the blob itself, or in the tree storing the
> > > filename.
> > 
> > How about Jakub's idea of keeping it in .gitattributes (or some
> > similarly visible key/value store)?  Two reasons:
> > 
> >  1. When asked to declare encoding, half the time people will be
> >     wrong.  So it seems worthwhile to make the declared encoding
> >     visible enough to fix.
> > 
> >  2. Two ASCII files identical except that one is declared as
> >     latin1 and the other utf8 should be considered identical.
> > 
> > Thanks for some food for thought.
> 
> I think that's a fine place to start. Shall I start a branch for it when
> I get home (where the code I'm working on is located)? It would be good
> practice if nothing else...

Just for clarification: Git supports and uses `encoding` gitattribute,
but it is used currently _only_ bu git-gui (by converting from `encoding`
gitattribute to `git.encoding` given by config).

The places that are missing:

1. A way to check attribute of a file in given tree.  Currently 
   git-check-attr checks for .gitattributes _only_ from working
   area (in addition to unversioned .git/info/attributes, and perhaps
   in the future core.attributesFile a la core.excludesFile).

2. A consensus where conversion should take place: at which level
   in stack, for what output destination, etc.

3. Support for i18n.blobOutputEncoding, which would convert (unless
   overriden) e.g. in 'git show <blob>', and perhaps also in diff.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
