From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] dir: do all size checks before seeking back and fix file closing
Date: Sat, 26 Aug 2006 22:44:49 +0200
Message-ID: <20060826204449.GA19104@diku.dk>
References: <20060826141709.GC11601@diku.dk> <20060826184330.GA34439@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 26 22:45:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH51b-0006fs-R9
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 22:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWHZUpA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 16:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWHZUpA
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 16:45:00 -0400
Received: from [130.225.96.91] ([130.225.96.91]:57296 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1750859AbWHZUo7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 16:44:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 45B9C770007;
	Sat, 26 Aug 2006 22:44:52 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19803-07; Sat, 26 Aug 2006 22:44:50 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id C1612770005;
	Sat, 26 Aug 2006 22:44:50 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 418DE6DF835; Sat, 26 Aug 2006 22:43:30 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 5F59962A02; Sat, 26 Aug 2006 22:44:50 +0200 (CEST)
To: Mitchell Blank Jr <mitch@sfgoth.com>
Content-Disposition: inline
In-Reply-To: <20060826184330.GA34439@gaz.sfgoth.com>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26067>

Mitchell Blank Jr <mitch@sfgoth.com> wrote Sat, Aug 26, 2006:
> Jonas Fonseca wrote:
> >   err:
> > -	if (0 <= fd)
> > +	if (0 >= fd)
> >  		close(fd);
> 
> Could you explain that piece?  You now only close "fd" if it's zero (stdin)
> or negative (invalid).  The old code (close if its >=0) make more sense.

Ah, yes, sorry for the noise. I read the old code as (fd <= 0).

-- 
Jonas Fonseca
