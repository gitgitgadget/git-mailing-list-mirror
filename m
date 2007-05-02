From: Jan Holesovsky <kendy@suse.cz>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Wed, 2 May 2007 16:37:01 +0200
Message-ID: <200705021637.02057.kendy@suse.cz>
References: <200705012346.14997.jnareb@gmail.com> <Pine.LNX.4.64.0705021046230.2425@reaper.quantumfyre.co.uk> <200705021158.04481.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Julian Phillips <julian@quantumfyre.co.uk>,
	Jakub Narebski <jnareb@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 16:37:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjFx7-0004L1-Fc
	for gcvg-git@gmane.org; Wed, 02 May 2007 16:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993264AbXEBOhG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 10:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993265AbXEBOhF
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 10:37:05 -0400
Received: from styx.suse.cz ([82.119.242.94]:55163 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S2993264AbXEBOhE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 10:37:04 -0400
Received: from one.suse.cz (one.suse.cz [10.20.1.79])
	by mail.suse.cz (SUSE LINUX ESMTP Mailer) with ESMTP id 9D9396280FC;
	Wed,  2 May 2007 16:37:02 +0200 (CEST)
User-Agent: KMail/1.9.1
In-Reply-To: <200705021158.04481.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46024>

Hi Andy,

On Wednesday 02 May 2007 12:58, Andy Parkins wrote:

> On Wednesday 2007 May 02, Julian Phillips wrote:
> > A fully packed clone of the OOo git repo was indeed 1.3G, and the entrire
> > checkout + repo was indeed 8.5G (using git 1.5.1.2).
>
> I'm more confused now then.  I assumed the figures were accurate, but they
> cannot be:
>
>                                CVS      git      SVN
> Size of data on the server     8.5G     1.3G     n/a
> Size of checkout               1.4G     2.8G     1.5G
>
> I don't doubt the 1.3G on the server - and assume that is fully packed. 
> The checkout sizes are suspicious though.  Is that 2.8G packed?
>  - If it is, then we can deduce that this is a repo+source size, since the
>    server is packed size+0 therefore the size of the source tree is
>     2.8G - 1.3G = 1.5G
>    In which case the other figures are wrong:
>     - CVS checkout is 1.4G - impossible, the source tree is 1.5G. And where
> is the overhead of the CVS directories which would make it more than 1.5G?

Unfortunately I don't have the _exact_ numbers here any more so I cannot prove 
it ;-) - but this is a rounding problem [CVS checkout is slightly more than 
1.4G].  Similarly, overhead of of CVS directories is 0 when we count in 
gigabytes.

> - SVN checkout overhead is always _at least_ the size of the source tree
> because it keeps a pristine copy of HEAD.  If the source tree is 1.5G, then
> this figure should be at least 3G.

Yes, this surprises me as well.  I've heard about some improvements in the 
recent SVN, but 0.1M sounds very small.

>  - If it is not, then we're back to "I don't believe that git was packed"

It was, IIRC with 'git-repack -a -d -f'.

> Something smells fishy here - either the source tree size is included in
> some, but not in others or the git repository wasn't packed.

As I wrote, I am looking forward to seeing the SVN tree myself for further 
testing.

Regards,
Jan
