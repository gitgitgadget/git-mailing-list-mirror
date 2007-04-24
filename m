From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: bug with gitweb on kernel.org
Date: Tue, 24 Apr 2007 01:19:48 -0700
Message-ID: <1177402788.5357.30.camel@localhost.localdomain>
References: <alpine.LFD.0.98.0704192255180.4504@xanadu.home>
	 <1177286943.24896.14.camel@localhost.localdomain>
	 <alpine.LFD.0.98.0704222112040.28339@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 10:27:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgGN9-0000Yq-HO
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 10:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031063AbXDXIZL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 04:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754496AbXDXIUX
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 04:20:23 -0400
Received: from shards.monkeyblade.net ([192.83.249.58]:51796 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613AbXDXIUN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 04:20:13 -0400
Received: from [172.19.0.252] (c-76-21-106-12.hsd1.ca.comcast.net [76.21.106.12])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.13.8/8.13.8) with ESMTP id l3O8Jv7m007750
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Tue, 24 Apr 2007 01:19:58 -0700
In-Reply-To: <alpine.LFD.0.98.0704222112040.28339@xanadu.home>
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
X-Virus-Scanned: ClamAV 0.88.7/3153/Mon Apr 23 19:26:21 2007 on shards.monkeyblade.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45428>

Ok the change is out and in the wild it will likely take about 24hrs to
work itself through everything.  I'll check on it tomorrow to see how
things are going.

- John 'Warthog9' Hawley

On Sun, 2007-04-22 at 21:16 -0400, Nicolas Pitre wrote:
> On Sun, 22 Apr 2007, J.H. wrote:
> 
> > On Thu, 2007-04-19 at 23:02 -0400, Nicolas Pitre wrote:
> > > Almost 2 months ago we discussed about gitweb not properly detecting the 
> > > client's ability to deal with application/xhtml+xml, something to do 
> > > with the caching of a previous request from a client which did support 
> > > it and serving the same content to a subsequent client which does not.
> > 
> > I apparently missed that entire conversation, my apologies.
> > 
> > > 
> > > Right now www.kernel.org/git is unusable for me with lynx as it keeps 
> > > prompting:
> > > 
> > > 	application/xhtml+xml  D)ownload, or C)ancel
> > > 
> > > Is there any plan to have that fixed?
> > > 
> > 
> > Well there are a couple of quick thoughts, so far (in my quick testing)
> > lynx and IE are the only two browsers that have issues with this
> > particular bit of code.  Links, konqueror, safari, firefox, mozilla, etc
> > all seem to handle the pages without issue.
> 
> No.  You also missed that links, elinks, and the emacs one (w3m or the 
> like) were also reported to fail.  And sometimes lynx even works.
> 
> >  Taking a quick glance at the code it seems IE claims to be xhtml+xml 
> > compliant but apparently isn't really (any real surprise?) and lynx 
> > just doesn't seem to support that mime type.
> 
> Lynx and many others.  It is just a question of luch whether the served 
> page is acceptable or not.
> 
> > The simplest fix would be to eliminate the distinction between
> > applicatoin/xhtml+xml and application/html in the gitweb code (or at
> > least in the caching gitweb code) and have everything claim a mimetype
> > of application/html and let the browser sort out if it's using xhtml or
> > html from the doctype.  This would solve both the problem your seeing on
> > lynx and would make the caching gitweb usable by more IE users.
> 
> Great.
> 
> 
> Nicolas
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
