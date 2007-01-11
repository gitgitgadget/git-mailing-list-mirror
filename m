From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Restraining git pull/fetch to the current branch
Date: Thu, 11 Jan 2007 21:47:53 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0701112127000.12870@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Thu Jan 11 22:55:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H57tK-00062P-7O
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 22:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbXAKVzT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 16:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbXAKVzT
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 16:55:19 -0500
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:48320 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbXAKVzS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 16:55:18 -0500
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jan 2007 16:55:17 EST
Received: (qmail 25182 invoked by uid 103); 11 Jan 2007 21:48:33 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.88.7/2434. spamassassin: 3.1.3. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.130274 secs); 11 Jan 2007 21:48:33 -0000
Received: from unknown (HELO beast.quantumfyre.co.uk) (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 11 Jan 2007 21:48:33 +0000
X-X-Sender: jp3@beast.quantumfyre.co.uk
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36618>

While trying out git on a large repository (10000s of commits, 1000s of 
branches, ~2.5Gb when packed) at work I noticed that doing a pull was 
taking a long time (longer than I was prepared to wait anyway).

A quick test showed that a small repository (1 commit, 24k .git/objects) 
with 1000 branches took 1m30 to do "git pull" (local xfs partition).  I 
don't know if this is reasonable or not, but all I actually cared 
about was updating the current branch, which "git pull origin 
<branch_name>" did in 0.3s.

So what I would like to know is: is there any way to make a pull/fetch 
with no options default to only fetching the current branch? (other than 
scripting "git pull/fetch origin $(git symbolic-ref HEAD)" that is)

TIA

-- 
Julian

  ---
You can't go home again, unless you set $HOME.
