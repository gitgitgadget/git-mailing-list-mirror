From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: old but persistent problem: bad line length character
Date: Wed, 08 Jun 2011 10:33:20 -0700 (PDT)
Message-ID: <m3d3iodya5.fsf@localhost.localdomain>
References: <alpine.DEB.1.10.1106071832470.4175@localhost>
	<20110607180624.GA23752@sigill.intra.peff.net>
	<alpine.DEB.1.10.1106072337500.11389@localhost>
	<7vpqmo2wy7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Kleiweg <pkleiweg@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 19:33:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUMdE-0004cF-TS
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 19:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334Ab1FHRdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 13:33:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55579 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab1FHRdX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 13:33:23 -0400
Received: by fxm17 with SMTP id 17so477589fxm.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 10:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=31mSa0iqUmNxqy92veIjEcGlntIIrk7imU2qiVz/tHA=;
        b=tCUU2UDgYAWFSiN3KnqKg70wMqHLGphZ5x4v1q5gavkA6cMQoiQo/GvPhXv67oHnuJ
         Betob8UR00KSBu0AxVHz8ro4tQTt75fFV2YHijqM5eyokz7Dl9F33FwdINkrntl2/C68
         gU9PBjjLzCOerTbW7ENGivrmK2Vv8N7gt3vpg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=L1JlpmgPYB1yvuZa5URwWzLZ9YUfSJmQyMtA6OOcYcapwvvXSSpkX4Tei/Kez57wce
         wgd8ib+pecwXWD9fUaqwGd7OsSTZFWQzIDl+ciW6Nq5jmopA4UuvSwBPXs4JL8BAtg+q
         1nKQOTCAmFpV06H5cWWYRRhzmeXXUpL0jQow8=
Received: by 10.223.145.24 with SMTP id b24mr1978332fav.89.1307554401592;
        Wed, 08 Jun 2011 10:33:21 -0700 (PDT)
Received: from localhost.localdomain (abvo166.neoplus.adsl.tpnet.pl [83.8.212.166])
        by mx.google.com with ESMTPS id n15sm324811fag.42.2011.06.08.10.33.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 10:33:20 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p58HWo6O020430;
	Wed, 8 Jun 2011 19:32:55 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p58HWYnd020420;
	Wed, 8 Jun 2011 19:32:34 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vpqmo2wy7.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175411>

Junio C Hamano <gitster@pobox.com> writes:

> Peter Kleiweg <pkleiweg@xs4all.nl> writes:
> 
> > I made it read some more than 4 bytes. And this is what I get:
> >
> > {27}]0;github git-receive-pack 'pebbe/Gabmap.git'{7}
> >
> > Ah, I see! I have a wrapper set-up around ssh that sets the 
> > window title of the shell to the ssh command argument. That is 
> > what messes things up!
> >
> > OK. Fixed now.
> 
> That does not explain why you earlier said 1.4.4.4 works and more recent
> versions do not, though.


>From my #git channel logs:

Jun 03 19:09:42 <ShadeHawk>     Hmmm... for a while I had transient (i.e. fixed now) error
                                when fetching from git.kernel.org repositories
Jun 03 19:09:50 <ShadeHawk>     $ git fetch origin
Jun 03 19:09:59 <ShadeHawk>     fatal: protocol error: bad line length character: git:
Jun 03 19:10:24 <ShadeHawk>     but when I wanted to debug it (with GIT_TRACE_PACKET=2),
                                it was already fixed ;-P

$ git version
git version 1.7.5


It might be not related with issue that Peter encountered, though.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
