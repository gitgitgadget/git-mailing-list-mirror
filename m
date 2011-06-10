From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: diff'ing files ...
Date: Fri, 10 Jun 2011 06:12:29 -0700 (PDT)
Message-ID: <m34o3xesqn.fsf@localhost.localdomain>
References: <BANLkTi=1vaoLVmhyahDttmUmqw7RTp=8-A@mail.gmail.com>
	<20110606224356.GC13697@sigill.intra.peff.net>
	<BANLkTinwSembzVk4gSYSvsRdHhDfqizkyg@mail.gmail.com>
	<20110607221948.GA10104@sigill.intra.peff.net>
	<alpine.LFD.2.00.1106092145390.2142@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Albretch Mueller <lbrtchx@gmail.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jun 10 15:12:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV1Vy-0005Kj-Tw
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 15:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125Ab1FJNMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 09:12:35 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41376 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932116Ab1FJNMc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 09:12:32 -0400
Received: by bwz15 with SMTP id 15so2168121bwz.19
        for <git@vger.kernel.org>; Fri, 10 Jun 2011 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=Fo8kJ726NOLEaxl+HTJNCP9Oj71kWJXL0CLx0ZxIOco=;
        b=MLCThiS3kVtFqF/g2QxTTa0626uOOwrtxNM8T4nJORryP0oV7k4ijuYIDXjG2lolwz
         qak6uPA3cbeCcOrbOaVHbwUohJRlOAIW8lb8c/fI6NgoPe8YG8AFPD7OI7dFtzK7zoV6
         dm56iJ0wVrbuynSHKEDdQtlzmuCf+PW3aPpLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=OcFlesl0sJMn/o1z39xf6TG8EjFKyAF8vfC5+D0/ceWT9MWFIJb6JopDYgdNVnfwKc
         zUkfCs/+K3zNps3n+CaWJdDJBMOFZeqKS9tkjJocqaw9MYQfehqV1DCQR75nhRI0Kjjz
         JL/CGPk1p+TkaKHxzrj/qyMSfTHZVrRxMBeXQ=
Received: by 10.204.141.15 with SMTP id k15mr1799774bku.50.1307711550857;
        Fri, 10 Jun 2011 06:12:30 -0700 (PDT)
Received: from localhost.localdomain (abvz126.neoplus.adsl.tpnet.pl [83.8.223.126])
        by mx.google.com with ESMTPS id k10sm2560332bkq.22.2011.06.10.06.12.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Jun 2011 06:12:29 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p5ADBovE017917;
	Fri, 10 Jun 2011 15:12:01 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p5ADBTcD017906;
	Fri, 10 Jun 2011 15:11:29 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LFD.2.00.1106092145390.2142@xanadu.home>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175608>

Nicolas Pitre <nico@fluxnic.net> writes:
> On Tue, 7 Jun 2011, Jeff King wrote:
> > On Tue, Jun 07, 2011 at 10:12:35PM +0000, Albretch Mueller wrote:
> > 
> > > > ... binary diffs, though I don't know offhand the details of the algorithm.
> > > ~
> > >  this is the part that I need ;-)

[...]

> > According to the xdiff page linked:
> > 
> >   For binary files, LibXDiff implements both (with some modification)
> >   the algorithm described in File System Support for Delta Compression
> >   by Joshua P.  MacDonald, and the algorithm described in Fingerprinting
> >   By Random Polynomials by Michael O. Rabin.
> > 
> > Nicolas (cc'd) might be able to say what, if any, substantive changes
> > were made from those works.
> 
> The libxdiff code was pretty generic so to be highly portable and usable 
> for many application types.  What I did is to get rid of everything that 
> git strictly didn't need in order to make the code as simple as 
> possible, and most importantly as fast as possible. [...]
> 
> And then further modifications were made to avoid pathological corner 
> cases which were taking too much time for little gain in the Git 
> context.
> 
> I also changed the output encoding to make it tighter.

Nicolas, do you know how binary diff used by git compares with respect
to performance and compression with other binary diff algorithms:

  * original LibXDiff
  * bsdiff
  * xdelta (vcdif algorithm)
  * vbindiff

-- 
Jakub Narebski
Poland
ShadeHawk on #git
