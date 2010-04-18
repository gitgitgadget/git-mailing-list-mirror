From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Sun, 18 Apr 2010 03:24:53 +0200
Message-ID: <201004180324.54722.jnareb@gmail.com>
References: <201004150630.44300.chriscool@tuxfamily.org> <201004180246.18263.jnareb@gmail.com> <20100418005917.GO10939@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Sam Vilain <sam@vilain.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Apr 18 03:25:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3JGE-0005Nq-2u
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 03:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756322Ab0DRBY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 21:24:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:31643 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756017Ab0DRBYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 21:24:55 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1148315fga.1
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 18:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=leKxgb/kDOm40DPUlSfGisFvMleiqoj2dScUFef9ANQ=;
        b=neLMkpJRk0AZ72Da800fn/yAOpkg5ziLwI2eaTBnLb2WoU29DDdl/h0AcphbM5vH7e
         e7Pj3pNaiPR3UfV9h0JrP8hs+47L6EMJTvr2+AjWBpObm5L8+qSNSH/TrVz1bKFD1kdR
         nbjbYEf7a0eCSQeDrrJdgPQVMXjUoxr5oWzvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=grFZKeq2nfkf+dpRpfJuAXpL0kIIGocc3lSzW00RootAhGP+ohBAFFNDpghNUh1o2V
         6olbNWH1dKqa8XRybVChEvO2zxvchQ0pFPu6+Ig/A7tLGMyfNozhDznpc7AkY5JRx6Ew
         nZKiE44WNV2ghaKe9AJUfi4RCIGzH5A3EIGns=
Received: by 10.87.48.34 with SMTP id a34mr2755867fgk.2.1271553893308;
        Sat, 17 Apr 2010 18:24:53 -0700 (PDT)
Received: from [192.168.1.13] (abvc197.neoplus.adsl.tpnet.pl [83.8.200.197])
        by mx.google.com with ESMTPS id d4sm6143980fga.15.2010.04.17.18.24.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 18:24:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100418005917.GO10939@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145201>

On Sun, Apr 18, Petr Baudis wrote:
> On Sun, Apr 18, 2010 at 02:46:16AM +0200, Jakub Narebski wrote:

> > Or is it
> > meant as web analogue of git-gui: a committool, with ability to create
> > new commits, perhaps to edit files (and add them, delete them, move them
> > around), a bit like ikiwiki with Git backend, or other Git based wikis
> > and blogs?
> 
> Yes. Though it is probably supposed to be real Git frontend with Git
> semantics, not something more abstract with Git under the hood.

Hmmm... doesn't look so easy.  What to do about simultaneous access
(what webmin does?), and working directory (what ikiwiki does?)?
 
> > 1. Keep "Web Client" separate for gitweb, and make use of gitweb 
> >    hooks/plugin system like $feature{'actions'}.  This might require
> >    adding new "hooks" to gitweb.
> > 
> >    The advantage is that "Web Client" can be written in any language,
> >    not necessary Perl.  The disadvantage that if it is written in Perl,
> >    some code might be duplicated.  It might be hard to write generic
> >    hooks - the "Web Client" could be not as well integrated with gitweb.
> > 
> > 2. Write "Web Client" as a Perl module, like 'gitweb/cache.pm' in the
> >    http://repo.or.cz/w/git/jnareb-git.git/log/refs/heads/gitweb/cache-kernel-pu
> >    and 'require' this file as needed, guarded by global variable or
> >    %feature.
> > 
> >    The advantage is possible tighter integration.  I am not sure about
> >    being able to use code from gitweb in "Web Client".  It also requires
> >    using Perl, and might require using some contortions if the problem
> >    would be naturally split into multiple modules: there can be multiple
> >    modules, but it could be better to have them in one file.
> 
> I think (2) is only infinitesimally better than (1) if you can't call
> all the gitweb methods from your module anyway. For me, the main worry
> is maintaining some consistent UI for the user (graphical and URI-wise)
> and (2) can accomplish this really only in a limited way unless you go
> much further with the modularization first.

Well, you can always add some of "Web Client" functionality directly
to gitweb (for example dispatch must be, I think, in gitweb).  Or you
can (ab)use "do $gitwebgui_pm;" instead of "require $gitwebgui_pm;",
like in http://repo.or.cz/w/git/jnareb-git.git/commitdiff/261b99e3#patch3
(second chunk).

OTOH we can always make gitweb "use Git;" and move some of its routines,
to it after generalization (e.g. config management using single run of
"git config -l -z", unquoting paths, parsing commit/tag/ls-tree/difftree
etc., date parsing and conversion).


BTW. the major thing that prevented me from using Git.pm was the few
places that gitweb uses pipeline, or needs to redirect STDERR to 
/dev/null.  Also t9700-perl-git.sh test doesn't test command_output_pipe
and the like. 

> > 3. Split Gitweb, add "Web Client" as one of modules.  Might be best
> >    from the purity point of view, but is practical only if it is
> >    integrated in gitweb.  That would require getting gitweb maintainer
> >    out of GSoC.   Also I am not sure how feaible this approach would be.
> 
> Would it be really required to get gitweb maintainer out of GSoC in
> order to go this way? Why?

Well, at least someone who would be able to manage integrating split
gitweb.  I think that splitting gitweb, and doing it well, is quite
outside this GSoC 2010 proposal: it would be too much. 

-- 
Jakub Narebski
Poland
