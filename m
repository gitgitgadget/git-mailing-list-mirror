From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] Update the documentation for git-merge-base
Date: Tue, 16 May 2006 08:54:52 +0200
Message-ID: <20060516065452.GA5540@c165.ib.student.liu.se>
References: <20060516055815.GA4572@c165.ib.student.liu.se> <7vhd3qebuv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 08:55:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FftSK-0001b2-MO
	for gcvg-git@gmane.org; Tue, 16 May 2006 08:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbWEPGyy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 02:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbWEPGyy
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 02:54:54 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:30693 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751558AbWEPGyx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 02:54:53 -0400
Received: from c165 ([213.114.27.63] [213.114.27.63])
          by mxfep01.bredband.com with ESMTP
          id <20060516065452.OVIF19930.mxfep01.bredband.com@c165>;
          Tue, 16 May 2006 08:54:52 +0200
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FftSG-0001Rd-00; Tue, 16 May 2006 08:54:52 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhd3qebuv.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20107>

On Mon, May 15, 2006 at 11:13:12PM -0700, Junio C Hamano wrote:
> Fredrik Kuivinen <freku045@student.liu.se> writes:
> 
> > Is the code guaranteed to return a least common ancestor? If that is
> > the case we should probably mention it in the documentation.
> 
> Unfortunately, no, if you mean by "least common" closest to the
> tips.
>

By "least" I mean the following:

C is a least common ancestor of A and B if:

* C is a common ancestor of A and B, and
* for every other common ancestor D (different from C) of A and B, C
  is not reacheable from D.

> See the big illustration at the top of the source for how you
> can construct pathological case to defeat an attempt to
> guarantee such.  --all guarantees that the output contains all
> interesting ones, but does not guarantee the output has no
> suboptimal merge bases.

There are two examples at the top of the source. In the first one a
least common ancestor is returned. As I interpret the second one, it
is an example of how the old algorithm without the postprocessing step
produced a common ancestor which is not least.

Am I wrong? Do we have any cases where the current merge-base
algorithm gives us common ancestors which are not least?

- Fredrik
