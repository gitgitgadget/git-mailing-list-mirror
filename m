From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: CVS -> SVN -> Git
Date: Fri, 20 Jul 2007 06:58:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707200651530.18125@beast.quantumfyre.co.uk>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk>
 <469FB84B.2010909@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Fri Jul 20 07:58:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBlVJ-0000yI-52
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 07:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbXGTF6N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 01:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752696AbXGTF6M
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 01:58:12 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:44141 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752213AbXGTF6L (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2007 01:58:11 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 39097D75E1
	for <git@vger.kernel.org>; Fri, 20 Jul 2007 06:58:10 +0100 (BST)
Received: (qmail 26546 invoked by uid 103); 20 Jul 2007 06:58:09 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3701. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.031438 secs); 20 Jul 2007 05:58:09 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 20 Jul 2007 06:58:09 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <469FB84B.2010909@fs.ei.tum.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53058>

On Thu, 19 Jul 2007, Simon 'corecode' Schubert wrote:

> Julian Phillips wrote:
>>  Has anyone managed to succssfully import a Subversion repository that was
>>  initially imported from CVS using cvs2svn using fast-import?
>>
>>  It looks like cvs2svn has created a rather big mess.   It has created
>>  single commits that change files in more than one branch and/or tag. It
>>  also creates tags using more than one commit.  Now I come to try and
>>  import the Subversion history into git and I'm having trouble creating a
>>  sensible stream to feed into fast-import.
>
> Did you try first converting the old CVS repo to git and then adding the svn 
> changes?  That might give you much better results.

I thought about it, but there are over 20000 commits sitting on top of the 
converted history referring back to it - I'm not convinced that I could 
stitch things back together properly, the svn history now really does 
rely on the import done by cvs2svn.  (btw, I blame CVS for the mess not 
cvs2svn, we should have switched _before_ we started using branches 
heavily ...)

The problem really is that we use branching like it's going out of 
fashion.  We have thousands now, and had at least 10s if not 100s by the 
time we gave up on CVS.  Similarly with tags.

I think I've managed to get things sorted now with fast-import ... just 
need to be able to copy blobs from other commits and I think I'll be done. 
It really is a nice tool.

-- 
Julian

  ---
There is nothing so easy but that it becomes difficult when you do it
reluctantly.
 		-- Publius Terentius Afer (Terence)
