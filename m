From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Thu, 14 Feb 2008 12:05:35 -0800 (PST)
Message-ID: <m3y79nb8xk.fsf@localhost.localdomain>
References: <200802081828.43849.kendy@suse.cz>
	<m3ejbngtnn.fsf@localhost.localdomain>
	<200802091627.25913.kendy@suse.cz>
	<alpine.LFD.1.00.0802092200350.2732@xanadu.home>
	<alpine.LSU.1.00.0802101640570.11591@racer.site>
	<alpine.LSU.1.00.0802101845320.11591@racer.site>
	<alpine.LSU.1.00.0802122036150.3870@racer.site>
	<alpine.LSU.1.00.0802141917420.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Jan Holesovsky <kendy@suse.cz>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Feb 14 21:06:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPkLV-0003XY-1g
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 21:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757088AbYBNUFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 15:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756342AbYBNUFj
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 15:05:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:60617 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983AbYBNUFi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 15:05:38 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1129018ugc.16
        for <git@vger.kernel.org>; Thu, 14 Feb 2008 12:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=WGIjc4H2HOBr4ZKI/YrQ0ppeTZ+Z9CAUnfMJ3xlQhq0=;
        b=poaKR+H/ZY92ISgC9rEnTZmYSFNRGeVQHRe01n0wzqbCeFKfJy5eCQmG5NEzEm6f1pblv9BykHXLAKycrHescLmkM5qfZCelIambf5E/7MmvcdHmsZjPLEYrJ3KVGIc1ouek2u05lSXTcrpGelIvEJTQJnaVafZsqd6AE1Fxgf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=Yb6/sT0F9ZBlGqt5SPVHwSve9XCtPla3PWuWmbuJJWOJujBxwfNhjpML5W9a2E7IkOxLKUlRABxvJGtZz08HlOH7WawGK4N3xsYjS7IV3+fds5juc5NBEfrP7vpfT1L4QSyb6NcbDAIvM59RFCpucqHty1//f+TmCvyOxp6+/R4=
Received: by 10.66.249.16 with SMTP id w16mr608779ugh.32.1203019536643;
        Thu, 14 Feb 2008 12:05:36 -0800 (PST)
Received: from localhost.localdomain ( [83.8.219.2])
        by mx.google.com with ESMTPS id b39sm15642963ugf.27.2008.02.14.12.05.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Feb 2008 12:05:35 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1EK5UmS014084;
	Thu, 14 Feb 2008 21:05:30 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1EK5RsX014081;
	Thu, 14 Feb 2008 21:05:27 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LSU.1.00.0802141917420.30505@racer.site>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73910>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Finally!
> 
> I updated to newest git+patches (git version 1.5.4.1.1353.g0d5dd), reset 
> windowMemory to 512m and restarted the process:
 
> A little over 6 hours, with one core (of the four available).  Not bad, I 
> say.
> 
> The result is:
> 
> $ ls -la objects/pack/pack-e4dc6da0a10888ec4345490575efc587b7523b45.pack
> -rwxrwxrwx 1 root root 1638490531 2008-02-14 17:51 
> objects/pack/pack-e4dc6da0a10888ec4345490575efc587b7523b45.pack
> 
> 1.6G looks much better than 2.4G, wouldn't you say?  Jan, if you want it, 
> please give me a place to upload it to.

Brandon Casey wrote:

> I have successfully repacked this repo a few times on a 2.1GHz
> system with 16G.
> 
> The smallest attained pack was about 1.45G (1556569742B).

Do you perchance know why OOo needs so large pack? Perhaps you could
try running contrib/stats/packinfo.pl on this pack to examine it to
get to know what takes most space.

What is the size of checkout, by the way?

Hmmm... I wonder if packv4 would help...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
