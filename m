From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What to do if git-cvsimport/cvsps hangs?
Date: Thu, 13 Dec 2007 17:56:02 -0800 (PST)
Message-ID: <m3sl26qbth.fsf@roke.D-201>
References: <824peojm4g.fsf@mid.bfk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Florian Weimer <fweimer@bfk.de>
X-From: git-owner@vger.kernel.org Fri Dec 14 02:56:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2zn7-0002iC-QS
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 02:56:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761428AbXLNB4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 20:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761383AbXLNB4J
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 20:56:09 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:58229 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754855AbXLNB4F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 20:56:05 -0500
Received: by nf-out-0910.google.com with SMTP id g13so756819nfb.21
        for <git@vger.kernel.org>; Thu, 13 Dec 2007 17:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=MH4/6aC3fxOl4dNe+odq63o8Vu7ct/WebQ13p3WhY2g=;
        b=jbC7AKeASTJOlrVsASh6Sa7/DOfW8FrkcbjHJtyMhbll2wFgpqGoIM/fNW856fj6HUBHX4xhCI+lmlBWgQrN1n/hQpif26TJQhUgIzf2xwktAn/5Kn5/EU5I0CgWu8fquXvhTnFvyvPt+dm+Mzx665qzY2ChsQgd1Lz50TTMaks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=SEtTHRsdLwFXqnC4Qtsw1rBi3nnVcXqQgskUMZiTRkm/7FCWuqZKsUP0nw427iajMbG4VPQ+kk/sEnmlZAsJHZVavRKIuhiF8xzRk9OiPuJjXJcweyejwkrJn7QycVeMfL62qKk8i3yHcuEiKeQpWCYy5rceMzo5qbpcNOSCR30=
Received: by 10.86.90.2 with SMTP id n2mr2448766fgb.66.1197597363794;
        Thu, 13 Dec 2007 17:56:03 -0800 (PST)
Received: from roke.D-201 ( [83.8.245.165])
        by mx.google.com with ESMTPS id b17sm11461424fka.2007.12.13.17.56.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 13 Dec 2007 17:56:02 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBE1tw2K000741;
	Fri, 14 Dec 2007 02:55:59 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lBE1ttiw000738;
	Fri, 14 Dec 2007 02:55:55 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <824peojm4g.fsf@mid.bfk.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68213>

Florian Weimer <fweimer@bfk.de> writes:

> This is probably more of a cvsps question than a GIT question, but
> AFAICT, the cvsps upstream is mostly inactive these days.
> 
> I tried to import the PostgreSQL repository, using
> 
>   git-cvsimport  -d :pserver:anoncvs@anoncvs.postgresql.org:/projects/cvsroot -k -C pgsql pgsql
> 
> However, after a bit of activity, git-cvsimport hangs at the following
> line
> 
>   cvs rlog: Logging pgsql/src/win32
> 
> strace doesn't show any system call activtiy in the cvsps process
> (which consumes 100% CPU).  cvsps is Debian's 2.1-2 version.
> 
> Is there some kind of replacement for cvsps which works more reliably?

You can try set of patches to cvsps there (see GitLinks at Git Wiki,
or git-cvsimport entry at InterfacesFrontendsAndTools)
  http://ydirson.free.fr/en/software/scm/cvsps.html

Or you can try other CVS importers (see InterfacesForntendsAndTools):
 - parsecvs by Keith Packard, used to import X.Org, seems to be
   unmaintaned, requires access to *,v files (but check out cvssuck)
 - fromcvs by Simon 'corecode' Schubert, uses git-fast-import, 
   IIRC in Ruby
 - cvs2svn has _experimental_ support for git export (git-fast-import?)
   so you can try this as well.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
