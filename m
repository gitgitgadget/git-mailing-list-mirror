From: Rocco Rutte <pdmef@gmx.net>
Subject: Storage optimization with alternates
Date: Fri, 9 Mar 2007 18:31:01 +0000
Organization: Berlin University of Technology
Message-ID: <20070309183100.GC7052@peter.daprodeges.fqdn.th-h.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 09 19:31:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPjs0-000168-H2
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 19:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767457AbXCISbH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 13:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767460AbXCISbH
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 13:31:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:51070 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1767457AbXCISbG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 13:31:06 -0500
Received: (qmail invoked by alias); 09 Mar 2007 18:31:03 -0000
Received: from cable-62-117-26-170.cust.blue-cable.de (EHLO peter.daprodeges.fqdn.th-h.de) [62.117.26.170]
  by mail.gmx.net (mp046) with SMTP; 09 Mar 2007 19:31:03 +0100
X-Authenticated: #1642131
X-Provags-ID: V01U2FsdGVkX1/4oXRLMoL4DTciVWI9K9ogGP98dpNcvdCZ/ptPJY
	7TnnZFcIYPZ6QH
Received: from peter.daprodeges.fqdn.th-h.de (peter [192.168.0.5])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by peter.daprodeges.fqdn.th-h.de (Postfix) with ESMTP id 94A1920F37
	for <git@vger.kernel.org>; Fri,  9 Mar 2007 18:31:02 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-GnuPG-Key: http://user.cs.tu-berlin.de/~pdmef/rrutte.gpg
X-Blog: http://user.cs.tu-berlin.de/~pdmef/horst.cgi?o
X-System: peter.daprodeges.fqdn.th-h.de (FreeBSD 6.2-STABLE i386)
User-Agent: Mutt/1.5.14 (2007-03-07)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41804>

Hi,

I have a potential problem with my workflow: I mirror several hg 
repositories into git with one git repo per hg repo. Out of these and 
via remotes config, I set up another tree I actually work with having 
the master branch map to the hg HEAD branch of the official repo and 
topic branches for all other git repos.

The git tree for the main one and all other mirrors mostly share the 
same objects as hg2git and git-fast-import fortunately produce stable 
SHA1 checksums.

Is there any way I can clean up the feature repos by saying "remove all 
objects that you can reach via alternates already"?

If there's nothing like that, would git get confused if I simply moved 
the plain binary object files around from one dir to the other and 
setting up alternates?

I cloned the working repo from the main one using alternates and hope 
git doesn't fetch objects again it can already reach via alternates.

Somehow related is another git-fast-import feature request (maybe): when 
it attempts to add objects to the pack file with SHA1s it can already 
reach via alternates, don't add them to the pack. If that worked (I 
didn't check), I would only have the main repo with all the objects and 
the feature repos pretty lightweight...

   bye, Rocco
-- 
:wq!
