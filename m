From: Johan Herland <johan@herland.net>
Subject: Re: Refactoring the tag object; Introducing soft references
 (softrefs); Git 'notes' (take 2)
Date: Sun, 10 Jun 2007 16:31:27 +0200
Message-ID: <200706101631.27600.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706100116.46062.johan@herland.net> <20070610082935.GD2951@artemis>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Jun 10 16:31:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxOSJ-0001d3-JZ
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 16:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756086AbXFJObb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 10:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755586AbXFJObb
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 10:31:31 -0400
Received: from smtp.getmail.no ([84.208.20.33]:55736 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754612AbXFJOba (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 10:31:30 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJF00M05CCH5100@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 16:31:29 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF00EC1CCG1120@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 16:31:28 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF00DYMCCF0DE0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 16:31:28 +0200 (CEST)
In-reply-to: <20070610082935.GD2951@artemis>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49742>

On Sunday 10 June 2007, Pierre Habouzit wrote:
> On Sun, Jun 10, 2007 at 01:16:45AM +0200, Johan Herland wrote:
> > On Sunday 10 June 2007, Steven Grimm wrote:
> > > Being able to specify relationships between commits after the fact seems 
> > > like a very useful facility.
> > > 
> > > Does it make sense to have type information to record what the 
> > > relationship between two objects means? Without that, it seems like 
> > > it'll be hard to build much of a tool set on top of this feature, since 
> > > no two tools that made use of it could unambiguously query just their 
> > > own softrefs.
> > 
> > Actually MadCoder/Pierre had a similar idea on IRC. He wanted to separate 
> > softrefs into namespaces, so that softrefs for tags could live in a 
> > different place than softrefs associated with his "gits" bug tracker.
> > 
> > I haven't thought very much about this, but it's certainly possible to do 
> > something like this. What do the rest of y'all think?
> 
>   Well, if we're two with the same idea, it's a good one, no ? :)
> 
>   In fact, the namespace idea like I told you on IRC isn't _that_
> brilliant. But I'm sure recording a softref with:
> 
>   <from_sha> <to_sha> <token>
> 
>   token would help classify the softref. And I'm sure we'll end up with:
> 
>   <from_sha> <to_sha> <token> <flags>
> 
>   with the flags to say what behaviour (e.g.) the reachability resolver
> should have wrt that link ?

Interesting. But I'm not sure I want to give up the fixed-length softref
records as I imagine it makes the lookup and processing _much_ faster.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
