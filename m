From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 0/5] Fix 'url.*.insteadOf' for submodule URLs
Date: Mon, 04 Aug 2008 01:47:16 +0200
Message-ID: <200808040147.16797.johan@herland.net>
References: <200808040057.00221.johan@herland.net>
 <alpine.DEB.1.00.0808040126170.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 04 01:48:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPnJc-0003Ye-6v
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 01:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbYHCXrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 19:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753255AbYHCXrm
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 19:47:42 -0400
Received: from smtp.getmail.no ([84.208.20.33]:53731 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbYHCXrl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 19:47:41 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K510001DU3G6D00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 01:47:40 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K5100HY0U2YZ350@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 01:47:22 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K5100CR8U2YU3DM@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 01:47:22 +0200 (CEST)
In-reply-to: <alpine.DEB.1.00.0808040126170.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91294>

On Monday 04 August 2008, Johannes Schindelin wrote:
> On Mon, 4 Aug 2008, Johan Herland wrote:
> > As suggested in a thread some time ago, one could redefine the URL used
> > to fetch submodules by adding a 'url.*.insteadOf' rule prior to the
> > first invocation of 'git submodule update'.
>
> If I suggested it, but forgot the "--global" flag to "git config", I
> apologize.

Does this mean that you don't agree with the rationale for this patch? I.e. 
that submodule URLs should not be rewritten according to the rules in the 
super-repo (but instead require such rules to be set in the user's global 
config)?

There are (at least) two reasons for why I think this should work without 
having to use '--global':

1. Consistency: Other git commands in the supermodule does _not_ require the 
URL rewriting rule to reside in the global config. Why should 'git 
submodule' be different.

2. I believe there are valid use cases for adding URL rewriting rules to the 
repo config instead of the global config. You may want to check out Fred's 
version of project X (including submodules), without making your other 
clones of project X start cloning/fetching from Fred.


Puzzled,
...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
