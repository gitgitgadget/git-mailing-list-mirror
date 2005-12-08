From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: Wine + GIT
Date: Thu, 8 Dec 2005 10:29:45 +0100
Message-ID: <20051208092945.GA4921@c165.ib.student.liu.se>
References: <20051208073000.7097.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Dec 08 10:31:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkI69-0003ai-I1
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 10:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbVLHJ3y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 04:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbVLHJ3y
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 04:29:54 -0500
Received: from [85.8.31.11] ([85.8.31.11]:24520 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1750966AbVLHJ3y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2005 04:29:54 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id DCEB84117; Thu,  8 Dec 2005 10:39:55 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EkI5x-0001Ja-00; Thu, 08 Dec 2005 10:29:45 +0100
To: linux@horizon.com
Content-Disposition: inline
In-Reply-To: <20051208073000.7097.qmail@science.horizon.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13364>

On Thu, Dec 08, 2005 at 02:30:00AM -0500, linux@horizon.com wrote:
> (Grump... I just noticed that the "recursive" merge stratgy *doesn't*
> generate a merged file containing conflict markers, at least not in
> the case I tried.  Instead I get "a~HEAD" and "a~branch" files.
> Time to fix the docs...)

In the most common case, i.e., when you have a file 'a' in the common
ancestor and 'a' have been modified in both A and B (where A and B are
the branches we are going to merge) then the recursive strategy should
generate a merged file with merge(1), which will produce conflict
markers if there are conflicts. Any other behaviour is a bug.

However, in some other cases such as rename/rename, file/directory and
add/add conflicts "a~A" and "a~B" will be created in the working
directory. The recursive strategy will (or, is supposed to) tell you
about such things, though.


- Fredrik
