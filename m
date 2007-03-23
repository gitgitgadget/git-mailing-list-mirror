From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git / Subversion Interoperability
Date: Fri, 23 Mar 2007 01:36:11 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0703230128330.4001@beast.quantumfyre.co.uk>
References: <20070322224829.GA7048@c3sl.ufpr.br> <20070323004335.GA17773@spearce.org>
 <Pine.LNX.4.64.0703230052570.2746@beast.quantumfyre.co.uk>
 <20070323012422.GC17773@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 23 02:36:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUYi3-0002TJ-Ka
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 02:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422641AbXCWBgO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 21:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422651AbXCWBgO
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 21:36:14 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:45667 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422641AbXCWBgN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2007 21:36:13 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id EEA1EC60D3
	for <git@vger.kernel.org>; Fri, 23 Mar 2007 01:36:11 +0000 (GMT)
Received: (qmail 31049 invoked by uid 103); 23 Mar 2007 01:36:11 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/2896. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.034701 secs); 23 Mar 2007 01:36:11 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 23 Mar 2007 01:36:11 +0000
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <20070323012422.GC17773@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42896>

On Thu, 22 Mar 2007, Shawn O. Pearce wrote:

> Julian Phillips <julian@quantumfyre.co.uk> wrote:
>> That would probably be good enough for the majority of
>> one-project-per-repo Subversion projects at least.  Though there is still
>> the issue that Subversion will actually let you create a "tag" simply by
>> committing whatever you currently have in your working copy (including
>> localally modified files ... yeuch).
>
> Heh.  People do weird things.  ;-)

Well, I don't think there would be too many complaints if a git-based 
Subversion server didn't support such methods of creating tags ... ;)

>
>>> That's all I can think of right now.  But I'm sure there are more.
>>
>> Properties are probably the next biggest headache.  Subversion allows you
>> to associate arbitrary keyword value pairs with files (which are
>> versioned) and with revisions (which are not versioned).  You would need
>> to find someway to support this in git.  Since revision properties are
>> disabled by default in Subversion you may be able to simply disallow them
>> permanently - but I don't know anything about the Subversion protocol ...
>
> I thought about the properties, but didn't bother to write anything
> on that subject as we may just be able to say "look, properties
> are not supported in git-svnserver, so don't try to use them".

Indeed.  That's what I was aiming at with the the last sentence (not very 
clearly unfortunately).  It would be nice if the server could tell the 
client that properties are not supported ... but I doubt that it can, 
since they are fundamental part of Subversion.

In particular it's how the client finds out about things like symlinks and 
line ending conversion.  It may be necessary to provide some basic support 
for some of the properties in the svn:... namespace in order for the 
Subversion repo access library not to refuse to talk to the git server.

>
> The git-svnserver is meant to help users migrate to Git, not to offer
> up all of SVNs features and warts.  A big part of this project may
> just be deciding what features we are willing to try to emulate.

Indeed.  It sounds like an interesting idea.  Anything that increases the 
possibilty of my convincing the appropriate people to migrate my work 
project ... ;)

-- 
Julian

  ---
"From there to here, from here to there, funny things are everywhere."
-- Dr. Seuss
