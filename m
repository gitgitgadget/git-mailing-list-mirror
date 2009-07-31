From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to embed a hash, tag or branch name?
Date: Fri, 31 Jul 2009 02:27:50 -0700 (PDT)
Message-ID: <m3ljm5ryar.fsf@localhost.localdomain>
References: <20090731081723.GE29909@nalle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mikko Rapeli <mikko.rapeli@iki.fi>
X-From: git-owner@vger.kernel.org Fri Jul 31 11:28:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWoP9-0001R8-R2
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 11:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbZGaJ1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 05:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbZGaJ1w
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 05:27:52 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:50948 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbZGaJ1v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 05:27:51 -0400
Received: by ewy10 with SMTP id 10so1368123ewy.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 02:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=xiz5v70yVL9JtdO5jz8Do5bohpwFqx/5RWjnKdBFGsI=;
        b=f2KioXJfhD85x7vRd5Ani3eppaNcqALEs3lnwWVHW6LWs11gmdSDwIN/fnZIg2uW2E
         dkCcIlzwVqcRVyeYAmWU4f/NsXfIcgcIjSrAbUyMLadGkx1yPonJdpg3Xh7Pc4jK4q0j
         oQrOOxhtoyK7laSI7P1ZTlSWLr1BOyQQIqOmg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Apq3pujx73DGRws4WYcig/wBtJHNsqnicLvm1MlvKoC/DEszXrRCewRCfYFPbyG7Qc
         iR12bMRxC4Ywz/fea9TkIGVoH8FxF9USEU/8n93XR6y5f4677QNad0jCRETdQ1OMnxzz
         H+dyajHeoC2uUaBf4N0pasrLlI3WSaa+ju2N0=
Received: by 10.210.56.7 with SMTP id e7mr597859eba.30.1249032470974;
        Fri, 31 Jul 2009 02:27:50 -0700 (PDT)
Received: from localhost.localdomain (abvk103.neoplus.adsl.tpnet.pl [83.8.208.103])
        by mx.google.com with ESMTPS id 10sm2870587eyd.52.2009.07.31.02.27.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Jul 2009 02:27:50 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6V9YKdb022475;
	Fri, 31 Jul 2009 11:34:20 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6V9YKHr022472;
	Fri, 31 Jul 2009 11:34:20 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090731081723.GE29909@nalle>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124518>

Mikko Rapeli <mikko.rapeli@iki.fi> writes:

> How do I embed a hash, tag or branch name into source code managed by
> git?
> 
> I've tried searching the net, git manuals etc but haven't found a
> replacement for the old '$Id: $' strings from svn. What I need is a way to
> map compiled binaries and flash images to git tree heads, tags and
> branches.

You can embed SHA-1 of a _file contents_ (blob) using '$Id: $' keyword
with `ident` attribute - see gitattributes manpage.

The correct solution of embedding version number is to do it at 
_build time_, using e.g. script similar to GIT-VERSION-GEN used by
Git itself and by Linux kernel.  It helps if you tag your releases.


If you really, really, really need it, you can embed tag or branch
name into source code using `filter` attribute and custom clean/smudge
filters to do keyword un-expansion and keyword expansion.  But please
think twice about what you want to achive with keyword expansion, and
whether keyword expansion is a best solution...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
