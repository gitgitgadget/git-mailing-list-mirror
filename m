From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: How has learning the advanced features of git helped you to
	write software more effectively?
Date: Thu, 23 Jul 2009 01:59:07 +0400
Message-ID: <20090722215906.GB25324@dpotapov.dyndns.org>
References: <e1a5e9a00907221421m27f0f836t98d361dffc7bd87f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Harper <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 23:59:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTjqX-0002sl-Vl
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 23:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304AbZGVV70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 17:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754292AbZGVV7Z
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 17:59:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:27851 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222AbZGVV7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 17:59:25 -0400
Received: by fg-out-1718.google.com with SMTP id e12so995813fga.17
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 14:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SGPPLFHWa737Hvwu2x16G3+PtLITsLd4ZsQxhQ2x8f0=;
        b=O3eviRKVH2SSj26ZzaC0b8CE7vhQ/MoIcTv4W9GlwHwWS0pdLXEOY2cn0/2Ndi3zER
         Qc0PRlUcRFTCsuFQcPuaMR8vLtm36CEzZvlAROEJgV/L1BRScaF9y31xnfxU21QhkMbc
         c5dIB4OHGAzagurcMIetejoFyWASmab9d/oSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pga1Y/k/F4ceEg4ECM6BK2w/pQchfRnUAcPKlU7HJgpcfCnQzk9sUbrM6C0gFc7Fv5
         S7DZroOiITPDY9iPqTiupVJPRJqILs+JLt+QWf35c5knDA8lpJF/8SEivfZ00T9+L3GN
         FFxQrd13G02vDXuirZh1GPDdlYOWxsAsmdXl4=
Received: by 10.86.9.10 with SMTP id 10mr1183486fgi.48.1248299964454;
        Wed, 22 Jul 2009 14:59:24 -0700 (PDT)
Received: from localhost (ppp91-77-225-54.pppoe.mtu-net.ru [91.77.225.54])
        by mx.google.com with ESMTPS id d6sm2029473fga.25.2009.07.22.14.59.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Jul 2009 14:59:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <e1a5e9a00907221421m27f0f836t98d361dffc7bd87f@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123793>

On Wed, Jul 22, 2009 at 03:21:26PM -0600, Tim Harper wrote:
> 
> Out of the shoot, you get a lot of value learning the basic features
> of git: easy branching, merging, etc.  How has learning the advanced
> features of git (bisect, rebase, rebase -i, add -p, etc.) helped you
> to write software more effectively?

Now I see what features you consider as "advanced", so I will try to
answer your question more directly this time:

- git bisect was useful for the obvious reason: it has saved time and
  efforts in finding some regression. It is especially true if the bug
  is a tricky one.

- I use 'rebase -i' to clean up patches before publishing. When I work
  on some feature, I can focus on it without being distracted some minor
  unimportant details, but then I can take a second look at what I did
  and clean up things a bit before publishing. So, my code is cleaner
  and easy to review.

- 'add -p' is about splitting changes to meaningful patches. Sometimes,
  when you are working on something, you may want to correct another
  minor problem that you came across, but commiting two completely different
  changes as a single patch is not a very good idea.

- 'rebase' can be *sometimes* useful, but it is not something that I
  will recommend to do often and without thinking. Some people really
  like to have linear story, so they tend to abuse this command, but
  'rebase' is re-writing of history, and it means that the original
  history gets lost. OTOH, if you use git-svn, then you do not have much
  choice but to keep it linear....

In any case, I believe that the basic ideas about Git should be learned
first and some advanced features can be learned later when one needs them.


Dmitry
