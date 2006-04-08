From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: blame now knows -S
Date: Sat, 8 Apr 2006 13:42:40 +0200
Message-ID: <20060408114240.GA10137@c165.ib.student.liu.se>
References: <7v1ww9loon.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@catalyst.net.nz>, git@vger.kernel.org,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Apr 08 13:43:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSBqF-0001wb-0D
	for gcvg-git@gmane.org; Sat, 08 Apr 2006 13:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWDHLmv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 07:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWDHLmv
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 07:42:51 -0400
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:61630 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S964918AbWDHLmu
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 8 Apr 2006 07:42:50 -0400
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 6F7614119; Sat,  8 Apr 2006 14:00:01 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FSBpw-0003JX-00; Sat, 08 Apr 2006 13:42:40 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1ww9loon.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18516>

On Fri, Apr 07, 2006 at 02:28:40AM -0700, Junio C Hamano wrote:
> I've made a few changes to "git blame" myself:
> 
>  - fix breakage caused by recent revision walker reorganization;
>  - use built-in xdiff instead of spawning GNU diff;
>  - implement -S <ancestry-file> like annotate does.
> 
> Depending on the density of changes, it now appears that blame
> is 10%-30% faster than annotate.  I thought CVS emulator might
> be interested to give it a whirl..
> 

Nice work!

There is another possible optimisation with respect to xdiff. Instead
of producing the diff on the xdiff side and parsing the diff in
blame.c, we could add another call back which just gets the relevant
information from the hunk header. I don't know how much we would gain
from this, but it might be worth a try.

- Fredrik
