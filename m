From: Petr Baudis <pasky@suse.cz>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Sun, 18 Apr 2010 02:59:17 +0200
Message-ID: <20100418005917.GO10939@machine.or.cz>
References: <201004150630.44300.chriscool@tuxfamily.org>
 <201004180246.18263.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Sam Vilain <sam@vilain.net>, catalyst@lists.scsys.co.uk
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 02:59:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3Ir7-0005Km-QS
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 02:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756246Ab0DRA7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 20:59:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60430 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754451Ab0DRA7U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 20:59:20 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 97A6186208F; Sun, 18 Apr 2010 02:59:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201004180246.18263.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145199>

On Sun, Apr 18, 2010 at 02:46:16AM +0200, Jakub Narebski wrote:
> Or is it
> meant as web analogue of git-gui: a committool, with ability to create
> new commits, perhaps to edit files (and add them, delete them, move them
> around), a bit like ikiwiki with Git backend, or other Git based wikis
> and blogs?

Yes. Though it is probably supposed to be real Git frontend with Git
semantics, not something more abstract with Git under the hood.

> 1. Keep "Web Client" separate for gitweb, and make use of gitweb 
>    hooks/plugin system like $feature{'actions'}.  This might require
>    adding new "hooks" to gitweb.
> 
>    The advantage is that "Web Client" can be written in any language,
>    not necessary Perl.  The disadvantage that if it is written in Perl,
>    some code might be duplicated.  It might be hard to write generic
>    hooks - the "Web Client" could be not as well integrated with gitweb.
> 
> 2. Write "Web Client" as a Perl module, like 'gitweb/cache.pm' in the
>    http://repo.or.cz/w/git/jnareb-git.git/log/refs/heads/gitweb/cache-kernel-pu
>    and 'require' this file as needed, guarded by global variable or
>    %feature.
> 
>    The advantage is possible tighter integration.  I am not sure about
>    being able to use code from gitweb in "Web Client".  It also requires
>    using Perl, and might require using some contortions if the problem
>    would be naturally split into multiple modules: there can be multiple
>    modules, but it could be better to have them in one file.

I think (2) is only infinitesimally better than (1) if you can't call
all the gitweb methods from your module anyway. For me, the main worry
is maintaining some consistent UI for the user (graphical and URI-wise)
and (2) can accomplish this really only in a limited way unless you go
much further with the modularization first.

> 3. Split Gitweb, add "Web Client" as one of modules.  Might be best
>    from the purity point of view, but is practical only if it is
>    integrated in gitweb.  That would require getting gitweb maintainer
>    out of GSoC.   Also I am not sure how feaible this approach would be.

Would it be really required to get gitweb maintainer out of GSoC in
order to go this way? Why?

-- 
				Petr "Pasky" Baudis
http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
