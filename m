From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git svn forking an awful lot of "git config"s
Date: Wed, 20 Feb 2008 15:31:28 -0800 (PST)
Message-ID: <m3ejb7tdbo.fsf@localhost.localdomain>
References: <alpine.LSU.1.00.0802201520580.17164@racer.site>
	<20080220223953.GA32663@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Feb 21 00:32:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRyQ4-0000NT-CW
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 00:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825AbYBTXbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 18:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbYBTXbd
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 18:31:33 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:45591 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbYBTXbb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 18:31:31 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2310861fga.17
        for <git@vger.kernel.org>; Wed, 20 Feb 2008 15:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=ayqNpkAY0vM2fGm5+3ABHc2IOFeUcEyE6946SOl8cXo=;
        b=qCvzS0jCZXI5Li9cPqQSiED7h5g/xv1epUvcbEOECa084gA4qZzqCHVF7R/Oq5KQULmbUcoFHVLiyasZqakuXFEjazgmfmcJI1B1rk3JhbJU08KnB++NTxApFGHCMQp+SgLV10kb1uBucjRPni84vfzeZBHIUxO+A8dFAsf3udY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=ChbyycKECi61U16laA7XT5z/P3BffYhMgzCJomIAUvs+Z7jJDy1ZY4eX50MPVxh1b+4ZePs6d0WkT07yaBFP1sgriGYYR0YFsgaavJKFaZXssyA6Mml0aO+xi0yv5lkHBKzvhTBENrL4atuZSY7B08mVeQv8ZV4MqTyJtDKvNl4=
Received: by 10.82.140.20 with SMTP id n20mr17453177bud.24.1203550290108;
        Wed, 20 Feb 2008 15:31:30 -0800 (PST)
Received: from localhost.localdomain ( [83.8.189.142])
        by mx.google.com with ESMTPS id 7sm2606849nfv.35.2008.02.20.15.31.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Feb 2008 15:31:28 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1KNVQdX026312;
	Thu, 21 Feb 2008 00:31:26 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1KNVOca026309;
	Thu, 21 Feb 2008 00:31:24 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080220223953.GA32663@hand.yhbt.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74568>

Eric Wong <normalperson@yhbt.net> writes:

> Many months ago, I thought about implementing a transparent caching layer
> in Git.pm to work with git configs.  Of course, that requires
> cooperation from all readers/writers within the process...  Done
> correctly, it would help more than just git-svn. too.

Take a look how gitweb uses "git config -z -l" to read all config
in one go, and save it to hash for later use, lazily.
 
> I think I had this idea around the time we made git-config output Perl
> hashes and arrays.

This is an alternate solution, better for simple scripts and one-off
scripts (you don't need to write "git config -z -l" parser), but
I think that additional eval might be not good for performance.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
