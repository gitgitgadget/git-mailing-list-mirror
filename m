From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-push on packed refs via HTTP
Date: Fri, 20 Mar 2009 13:45:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903201341220.6865@intel-tinevez-2-302>
References: <loom.20090320T094550-421@post.gmane.org> <be6fef0d0903200500u4d26d00fm653bc1e708a0c26b@mail.gmail.com> <loom.20090320T123018-838@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steve <shrotty@gmx.ch>
X-From: git-owner@vger.kernel.org Fri Mar 20 13:46:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lke7Z-0005pJ-3t
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 13:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbZCTMpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 08:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbZCTMpN
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 08:45:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:41027 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751974AbZCTMpM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 08:45:12 -0400
Received: (qmail invoked by alias); 20 Mar 2009 12:45:09 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp033) with SMTP; 20 Mar 2009 13:45:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/qilEdeEXqJq12z2JcBdVveI0HGwY/SOavDmc5Pw
	ei7tuin/KmkTHj
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <loom.20090320T123018-838@post.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113950>

Hi,

On Fri, 20 Mar 2009, Steve wrote:

> > could you try running git update-server-info?
> 
> Forgot to mention that: I have tried git update-server-info, yet no 
> luck.

Actually, you have to undo the ref-packing performed by gc.  You can do it 
this way (quick and dirty):

	$ git show-ref |
	  while read sha1 name
	  do
		mkdir -p .git/$(dirname $name) &&
		echo $sha1 > .git/$name
	  done

Hth,
Dscho
