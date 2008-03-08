From: David Brownell <david-b@pacbell.net>
Subject: Re: warning: no common commits - slow pull
Date: Sat, 8 Mar 2008 14:48:46 -0800
Message-ID: <200803081448.47000.david-b@pacbell.net>
References: <200803061735.47674.david-b@pacbell.net> <alpine.LNX.1.00.0803072006550.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Mar 08 23:56:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY7xn-0005lT-8F
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 23:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbYCHWza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 17:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751883AbYCHWz3
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 17:55:29 -0500
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:22010 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752615AbYCHWz2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Mar 2008 17:55:28 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Mar 2008 17:55:28 EST
Received: (qmail 76587 invoked from network); 8 Mar 2008 22:48:48 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:X-Yahoo-Newman-Property:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=ZRaPHlSQBFMRRwfEFJU68y2C40A3thuw//L2jstqGTPmkQ2C1z+i45s7pMdPq+eoVU9OXRyeDVORwdrboB83FGZ5NNIv37uhxxOMRxPi1Z5aHghELcQj4OF419O6k8Wlgi2KVcEtUp4AHcw6+CjerUakxmE3PQ5GVerm1oW+7Ek=  ;
Received: from unknown (HELO ascent) (david-b@pacbell.net@69.226.243.232 with plain)
  by smtp124.sbc.mail.sp1.yahoo.com with SMTP; 8 Mar 2008 22:48:48 -0000
X-YMail-OSG: UXyIstQVM1mnhn_vquhG2Uvl8swDT2rako2eQvP5hrSIiqgWjqF9cYY0uBOV05aT4R0mieS8Aw--
X-Yahoo-Newman-Property: ymail-3
User-Agent: KMail/1.9.6
In-Reply-To: <alpine.LNX.1.00.0803072006550.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76599>

On Friday 07 March 2008, Daniel Barkalow wrote:
> On Thu, 6 Mar 2008, David Brownell wrote:
> 
> > When I "git pull" it first fetches a bunch of files, then
> > concludes (wrongly) "no common commits", then starts a
> > second fetch of a *HUGE* number of files ... 400 MB is too
> > much to pay when updating from rc3-last-week to rc4.  But
> > if I interrupt that second one with ^C, it seems that the
> > first one fetched enough to make the next "git pull" go
> > pretty quickly.
> 
> Actually, if you can make a tarball of the .git directory of one of those 
> workspaces, and see if the bug is reproducable with that .git directory 
> every time (particularly when pulling a local repository), it would be 
> really helpful to have a reliable test case.

Seems to be.  Let me know where I can stash a ~300 MB tar.bz2 file
for you ...


> There's a debugging thing that would help, but it's not in your version.

So I updated.  :)


> It's in next as
> 
> 49aaddd102aff Teach upload-pack to log the received need lines to an fd
> 
> With that commit, you should be able to do:
> 
> GIT_DEBUG_SEND_PACK=3 git pull 3>UPLOAD_LOG
> 
> and get a file UPLOAD_LOG that will show what it's doing, although there's 
> a reasonable chance that it'll only demonstrate that it's doing nothing 

That file has always been empty.


> helpful, which we already pretty much know.

Oddly, a few times when I tried that the bug didn't reproduce.
One factor may be workspaces cloned a long time ago with early
versions of GIT (or cogito).

- Dave

